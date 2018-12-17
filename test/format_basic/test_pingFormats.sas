
%macro test_pingFormats;
	%local tres;%let tres=%createTempVar;%local &tres;

	%local tl;

	%importLocalLib(l1,l1);
	%importLocalLib(l2,l2);
	%importLocalLib(l3,l3);
	%importLocalLib(l4,l4);

	proc format lib=l1;

		value FMT_A
			1='a'
			2='b'
			other='na';

		invalue $INFMT_A
			'x'='1'
			'y'='2'
			other=.;
	quit;

	proc format lib=l2;

		value FMT_B
			1='c'
			2='d'
			other='na';

		invalue $INFMT_B
			'x'='3'
			'y'='4'
			other=.;
	quit;

	proc format lib=l3;

		value FMT_C
			1='e'
			2='f'
			other='na';

		invalue $INFMT_C
			'x'='5'
			'y'='6'
			other=.;
	quit;

	proc format lib=l4;

		value FMT_D
			1='g'
			2='h'
			other='na';

		invalue $INFMT_D
			'x'='7'
			'y'='8'
			other=.;
	quit;

	%lbreak(IMPORT FORMATS RESULT);
	%put FMTSEARCH=%getOption(FMTSEARCH);
	%importFormats(lib=l1);
	%importFormatLib(lib=l2);
	%importFormatLib(path=%getLibPath(l3),res=&tres);%let tl=&&&tres;
	%put FMTSEARCH=%getOption(FMTSEARCH);

	%lbreak(PING FORMATS RESULT);
	%pingFormat(format=FMT_A FMT_B FMT_C FMT_D,res=&tres);%put FORMATNOTEXIST=&&&tres;
	%pingInformat(format=$INFMT_A $INFMT_B $INFMT_C $INFMT_D,res=&tres);%put INFORMATNOTEXIST=&&&tres;
	
	%lbreak(DATA STEP TEST);
	data _null_;
		length t s $10;
		t = put(1,FMT_A.);put t=;
		t = put(1,FMT_B.);put t=;
		t = put(1,FMT_C.);put t=;
		s = input('x',$INFMT_A.);put s=;
		s = input('x',$INFMT_B.);put s=;
		s = input('x',$INFMT_C.);put s=;
	run;

	%lbreak(DATA STEP ERROR);
	data _null_;
		length t s $10;
		t = put(1,FMT_D.);put t=;
		s = input('x',$INFMT_D.);put s=;
	run;

	%dropFormatLib(l1 l2 l3 l4 &tl);
	%put FMTSEARCH=%getOption(FMTSEARCH);
%mend;

;
%test_pingFormats;

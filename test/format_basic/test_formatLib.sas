
%macro test_importFormatLib;
	%local tres;%let tres=%createTempVar;%local &tres;

	%local tl;

	%importLocalLib(l1,l1);
	%importLocalLib(l2,l2);
	%importLocalLib(l3,l3);

	proc format lib=l1;

		value FMT_L1_
			1='a'
			2='b'
			other='na';

		invalue INFMT_L1_
			'x'=1
			'y'=2
			other=.;
	quit;

	proc format lib=l2;

		value FMT_L2_
			1='c'
			2='d'
			other='na';

		invalue INFMT_L2_
			'x'=3
			'y'=4
			other=.;
	quit;

	proc format lib=l3;

		value FMT_L3_
			1='e'
			2='f'
			other='na';

		invalue INFMT_L3_
			'x'=5
			'y'=6
			other=.;
	quit;

	%lbreak(IMPORT TEST);

	%put FMTSEARCH=%getOption(FMTSEARCH);
	%importFormatLib(lib=l1);
	%put FMTSEARCH=%getOption(FMTSEARCH);
	%importFormatLib(path=%getLibPath(l2),res=&tres);%let tl=&&&tres;
	%put %getOption(FMTSEARCH);

	%lbreak(ACCESSIBILITY);

	data _null_;
		length t $10;
		t = put(1,FMT_L1_.);put t=;
		t = put(1,FMT_L2_.);put t=;	
		s = input('x',INFMT_L1_.);put s=;
		s = input('x',INFMT_L2_.);put s=;
	run;
	
	%put FMTSEARCH=%getOption(FMTSEARCH);
	%dropFormatLib(l1 l2 l3 &tl);
	%put FMTSEARCH=%getOption(FMTSEARCH);
%mend;


%test_importFormatLib;

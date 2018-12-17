


%macro test_reportFormats;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local infmtList fmtList;
	
	%importLocalLib(local,test_reportFormats);
	
	proc format lib=local;

		value FMTA
			1='a'
			2='b'
			other='na';

		value $FMTB
			'1'='a'
			'2'='b'
			other='na';

		invalue FMTC
			'x'=3
			'y'=4
			other=.;

		invalue $FMTD
			'x'='c'
			'y'='d'
			other='na';
	quit;


	%let fmtList=FMTA $FMTB;
	%let inmftList=FMTC $FMTD;

	
	%clearOutput;
	%reportFormats(lib=local,format=,msg=);

	%reportFormats(lib=local,format=FMTA,msg=FMTA);
	%reportFormats(lib=local,format=$FMTB,msg=FMTB);
	%reportInformats(lib=local,formats=FMTC,msg=FMTC);
	%reportInformats(lib=local,formats=$FMTD,msg=FMTD);

	%reportFormats(path=%getLibPath(local),format=FMTA $FMTB,msg=);
	%reportInformats(path=%getLibPath(local),format=FMTC $FMTD,msg=);

	

%mend;


%test_reportFormats;

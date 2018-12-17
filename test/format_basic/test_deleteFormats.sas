


%macro test_deleteFormats;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local infmtList fmtList;
	
	%importLocalLib(local,test_deleteFormats);
	
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
			'x'=1
			'y'=2
			other=.;

		invalue $FMTD
			'x'='a'
			'y'='b'
			other='na';
	quit;


	%let fmtList=FMTA $FMTB;
	%let inmftList=FMTC $FMTD;

	%checkFormat(formats=&fmtList,lib=local,res=&tres);%put NOTEXIST FMT=&&&tres;
	%checkInformat(formats=&infmtList,lib=local,res=&tres);%put NOTEXIST INFMT=&&&tres;

	%deleteFormats(lib=local,format=FMTA);%checkFormat(formats=FMTA,lib=local,res=&tres);%put RES=&&&tres;
	%deleteFormat(lib=local,formats=$FMTB);%checkFormat(formats=$FMTB,lib=local,res=&tres);%put RES=&&&tres;
	%dropInformats(lib=local,format=FMTC);%checkInformat(formats=FMTC,lib=local,res=&tres);%put RES=&&&tres;
	%dropInformat(lib=local,formats=$FMTD);%checkInformat(formats=$FMTD,lib=local,res=&tres);%put RES=&&&tres;
	%dropInformat(lib=local,formats=$FMTD);%checkInformat(formats=$FMTD,lib=local,res=&tres);%put RES=&&&tres;

	%dropFormat(lib=nulllib,formats=nullfmt);%put delete null format;

	%dropLocalLib;

%mend;


%test_deleteFormats;




%macro test_checkFormats;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local checklist;
	
	%importLocalLib(local,test_checkFormats);
	
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

	%lbreak(CHECK LIB LOCAL);

	%let checlist=best $base32x nullFmt FMTA $FMTB FMTC $FMTD;

	%checkFormat(formats=&checlist,lib=local,res=&tres);%put NOTEXIST=&&&tres;
	%checkFormats(format=&checlist,lib=local,res=&tres);%put NOTEXIST=&&&tres;
	%checkInformat(formats=&checlist,lib=local,res=&tres);%put NOTEXIST=&&&tres;
	%checkInformats(format=&checlist,lib=local,res=&tres);%put NOTEXIST=&&&tres;

	%lbreak(CHECK PATH LOCAL);

	%checkFormat(formats=&checlist,path=%getLibPath(local),res=&tres);%put NOTEXIST=&&&tres;
	%checkFormats(formats=&checlist,path=%getLibPath(local),res=&tres);%put NOTEXIST=&&&tres;
	%checkInformat(formats=&checlist,path=%getLibPath(local),res=&tres);%put NOTEXIST=&&&tres;
	%checkInformats(formats=&checlist,path=%getLibPath(local),res=&tres);%put NOTEXIST=&&&tres;

	%lbreak(CHECK LIB WORK);

	%checkFormat(formats=&checlist,res=&tres);%put NOTEXIST=&&&tres;
	%checkFormats(formats=&checlist,res=&tres);%put NOTEXIST=&&&tres;
	%checkInformat(formats=&checlist,res=&tres);%put NOTEXIST=&&&tres;
	%checkInformats(formats=&checlist,res=&tres);%put NOTEXIST=&&&tres;

	%dropFormatLib(local);

%mend;


%test_checkFormats;

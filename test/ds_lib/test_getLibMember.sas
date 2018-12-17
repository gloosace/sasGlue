
%macro test_getLibMember;
	%local tres;%let tres=%createTempVar;%local &tres;

	%importLocalLib(local,test_getLibMember);

	data local.a;
	run;
	data local.b;
	run;
	data local.xc;
	run;
	data local.xd;
	run;

	%getLibMember(lib=local,prefix=x,res=&tres);%put members=&&&tres;
	%getLibDs(lib=local,prefix=x,res=&tres);%put ds=&&&tres;


	%getLibMember(lib=notexist,prefix=x,res=&tres);%put members=&&&tres;
	%getLibDs(lib=notexist,prefix=x,res=&tres);%put ds=&&&tres;
	%dropLocalLib;
%mend;

%test_getLibMember;

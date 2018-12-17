
data test_dsEmptyClone;
	length a 3 b $ 12 d 6;
	a=1;
	b='adb';
	c='fwefwef';
	d=232.323;
run;

%macro test_dsEmptyClone;
	%local tres;%let tres=%createTempVar;%local &tres;
	%importLocalLib;
	%dsEmptyClone(data=test_dsEmptyClone,out=local.test_dsEmptyClone);
	%getDsNumVarList(data=local.test_dsEmptyClone,res=&tres);%put numVarsList=&&&tres;
	%getDsStrVarList(data=local.test_dsEmptyClone,res=&tres);%put strVarsList=&&&tres;
	%dropLocalLib;
%mend;

%test_dsEmptyClone;

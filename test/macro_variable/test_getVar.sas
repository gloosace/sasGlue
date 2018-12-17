

%global test_mG x;
%let test_mG=G;
%let x=G;

%macro test_m3;

	%local test_m3 x;
	%let test_m3=3;
	%let x=3;

	%test_m2;

%mend;


%macro test_m2;

	%local test_m2 x;
	%let test_m2=2;
	%let x=2;

	%test_m1;

%mend;

%macro test_m1;

	%local test_m1 x;
	%let test_m1=1;
	%let x=1;

	%test_m0;

%mend;

%macro test_m0;
	
	%local tres;%let tres=%createTempVar;%local &tres;
	%local i ;
	%local test_m0 x;
	%let test_m0=0;
	%let x=0;

	%do i=0 %to 5;
		%put ---- getVar by LEVEL macro level=&i ----;
		%getVar(macro=,level=&i,var=noexist,res=&tres);%put var=noexist value=&&&tres;
		%getVar(macro=,level=&i,var=x,res=&tres);%put var=x value=&&&tres;
		%getVar(macro=,level=&i,var=test_m&i,res=&tres);%put var=test_m&i value=&&&tres;
	%end;

	%do i=0 %to 3;
		%put ---- getVar by NAME macro name=test_m&i ----;
		%getVar(macro=test_m&i,level=,var=noexist,res=&tres);%put var=noexist value=&&&tres;
		%getVar(macro=test_m&i,level=,var=x,res=&tres);%put var=x value=&&&tres;
		%getVar(macro=test_m&i,level=,var=test_m&i,res=&tres);%put var=test_m&i value=&&&tres;
	%end;

	%put ---- getVar GLOBAL TEST ----;
	%getVar(macro=GLOBAL,level=,var=noexist,res=&tres);%put var=noexist value=&&&tres;
	%getVar(macro=GLOBAL,level=,var=x,res=&tres);%put var=x value=&&&tres;
	%getVar(macro=GLOBAL,level=,var=test_mG,res=&tres);%put var=test_m&i value=&&&tres;
%mend;

%test_m3;


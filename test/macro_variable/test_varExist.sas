
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
	%local test_m0 x;
	%let test_m0=0;
	%let x=0;

	%let v=test_mG;%put &v exist=%varExist(&v) value=&&&v;
	%let v=test_m3;%put &v exist=%varExist(&v) value=&&&v;
	%let v=test_m2;%put &v exist=%varExist(&v) value=&&&v;
	%let v=test_m1;%put &v exist=%varExist(&v) value=&&&v;
	%let v=test_m0;%put &v exist=%varExist(&v) value=&&&v;
	%let v=x;%put &v exist=%varExist(&v) value=&&&v;

	%let v=notexist;%put &v exist=%varExist(&v) value=&&&v;

%mend;


%test_m3;


%global test_mG x;
%let test_mG=G;
%let x=G;

%macro test_m3;

	%local test_m3 x;
	%let test_m3=3;
	%let x=3;
	%global g_m3;
	%test_m2;

%mend;


%macro test_m2;

	%local test_m2 x;
	%let test_m2=2;
	%let x=2;
	%global g_m2;
	%test_m1;

%mend;

%macro test_m1;

	%local test_m1 x;
	%let test_m1=1;
	%let x=1;
	%global g_m1;
	%test_m0;

%mend;


%macro test_m0;
	
	%local tres;%let tres=%createTempVar;%local &tres;
	%local test_m0 x;
	%let test_m0=0;
	%let x=0;
	%global g_m0;

	%let v=test_m3;
	%let e=0;
	%assertEqual(a=&e,b=%globalExist(&v));

	%let v=test_m2;
	%let e=0;
	%assertEqual(a=&e,b=%globalExist(&v));
	
	%let v=test_m1;
	%let e=0;
	%assertEqual(a=&e,b=%globalExist(&v));

	%let v=test_m0;
	%let e=0;
	%assertEqual(a=&e,b=%globalExist(&v));

	%let v=x;
	%let e=1;
	%assertEqual(a=&e,b=%globalExist(&v));

	%let v=notexist;
	%let e=0;
	%assertEqual(a=&e,b=%globalExist(&v));

	%let v=g_m3;
	%let e=1;
	%assertEqual(a=&e,b=%globalExist(&v));

	%let v=g_m2;
	%let e=1;
	%assertEqual(a=&e,b=%globalExist(&v));
	
	%let v=g_m1;
	%let e=1;
	%assertEqual(a=&e,b=%globalExist(&v));

	%let v=g_m0;
	%let e=1;
	%assertEqual(a=&e,b=%globalExist(&v));

	%let v=test_mG;
	%let e=1;
	%assertEqual(a=&e,b=%globalExist(&v));

	%dropGlobals(g_m0 g_m1 g_m2 g_m3);
	
	%let v=g_m3;
	%let e=0;
	%assertEqual(a=&e,b=%globalExist(&v));

	%let v=g_m2;
	%let e=0;
	%assertEqual(a=&e,b=%globalExist(&v));
	
	%let v=g_m1;
	%let e=0;
	%assertEqual(a=&e,b=%globalExist(&v));

	%let v=g_m0;
	%let e=0;
	%assertEqual(a=&e,b=%globalExist(&v));

	%let v=test_mG;
	%let e=1;
	%assertEqual(a=&e,b=%globalExist(&v));

	%let v=x;
	%let e=1;
	%assertEqual(a=&e,b=%globalExist(&v));

%mend;


%test_m3;

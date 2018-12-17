

%macro test_func(res=);

	%resSet(&res);

	%put res name=&res value=&&&res;

%mend;


%macro test_func_default(res=);

	%resSet(&res,0);

	%put res name=&res value=&&&res;

%mend;

%macro test_resSet;

	%local tres;%let tres=%createTempVar;%local &tres;
	%local test_res test_res2;

	%let &tres=100;
	%let test_res=200;


	%test_func(res=&tres);
	%test_func(res=test_res);
	%test_func(res=);
	%test_func(res=notexist);
%mend;

%macro test_resSet_default;

	%local tres;%let tres=%createTempVar;%local &tres;
	%local test_res test_res2;

	%let &tres=100;
	%let test_res=200;


	%test_func_default(res=&tres);
	%test_func_default(res=test_res);
	%test_func_default(res=);
	%test_func_default(res=notexist);
	
%mend;


%test_resSet;
%test_resSet_default;

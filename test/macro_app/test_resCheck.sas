

%macro test_func(res=);

	%resCheck(&res);

	%put res name=&res value=&&&res;

%mend;


%macro test_func_default(res=);

	%resCheck(&res,0);

	%put res name=&res value=&&&res;

%mend;

%macro test_resCheck;

	%local tres;%let tres=%createTempVar;%local &tres;
	%local test_res test_res2;

	%let &tres=100;
	%let test_res=200;


	%test_func(res=&tres);
	%test_func(res=test_res);

%mend;

%macro test_resCheck_default;

	%local tres;%let tres=%createTempVar;%local &tres;
	%local test_res test_res2;

	%let &tres=100;
	%let test_res=200;


	%test_func_default(res=&tres);
	%test_func_default(res=test_res);

%mend;


%macro test_resCheck_error_empty;


	%test_func(res=);


%mend;

%macro test_resCheck_error_undefined;



	%test_func(res=notexist);


%mend;


%test_resCheck;
%test_resCheck_default;
%test_resCheck_error_empty;
%test_resCheck_error_undefined;

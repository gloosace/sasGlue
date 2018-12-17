
%global TEST_GLOBAL_A;
%let TEST_GLOBAL_A=1000;
%global TEST_GLOBAL_B;
%let TEST_GLOBAL_B=;

%macro test_g(a,b);
	%let a=%globalDefault(&a,TEST_GLOBAL_A,9999);
	%let b=%globalDefault(&b,TEST_GLOBAL_B,9999);
	%put a=&a b=&b;
%mend;


%macro test_globalDefault;
	%lbreak(%caller);

	%test_g(abc,def);
	%test_g(abc,);
	%test_g(abc,%str( ));
	%test_g(,def);
	%test_g(%str( ),def);
	
	%test_g;
	
%mend;

%test_globalDefault;

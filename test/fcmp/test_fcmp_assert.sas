

%macro test_fcmp_assertStrEqual;

	data _null_;

		length a $ 10 b $ 20;
		a='test';
		b='test';
		call assertStrEqual(a,b,'pass');

		a='def';
		b='abc';
		call assertStrEqual(a,b,'failed');

		a=' ';
		b='  ';
		call assertStrEqual(a,b,'pass');

		a=' abc ';
		b='abc';
		call assertStrEqual(a,b,'pass');
	run;

%mend;


%macro test_fcmp_assertEqual;

	data _null_;

		a=100;
		b=100;
		call assertEqual(a,b,'pass');

		a=100;
		b=-1;
		call assertEqual(a,b,'failed');

		a=.;
		b=.;
		call assertEqual(a,b,'pass');

	run;

%mend;


%test_fcmp_assertStrEqual;
%test_fcmp_assertEqual;

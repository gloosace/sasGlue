


%macro test_assertEqual;

	%local a b;

	%let a=;
	%let b=;
	%assertEqual(a=&a,b=&b,msg=%quote(a=&a b=&b));

	%let a=abc;
	%let b=;
	%assertEqual(a=&a,b=&b,msg=%quote(a=&a b=&b));

	%let a=;
	%let b=abc;
	%assertEqual(a=&a,b=&b,msg=%quote(a=&a b=&b));

	%let a=abc;
	%let b=abc;
	%assertEqual(a=&a,b=&b,msg=%quote(a=&a b=&b));

	%let a=abc;
	%let b= abc;
	%assertEqual(a=&a,b=&b,msg=%quote(a=&a b=&b));

	%let a=abc;
	%let b=%str( abc);
	%assertEqual(a=&a,b=&b,msg=%quote(a=&a b=&b));

	%let a=1;
	%let b=1;
	%assertEqual(a=&a,b=&b,msg=%quote(a=&a b=&b));

	%let a=1;
	%let b=1.0;
	%assertEqual(a=&a,b=&b,msg=%quote(a=&a b=&b));


%mend;


%test_assertEqual;

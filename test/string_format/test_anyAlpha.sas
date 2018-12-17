%macro test_anyAlpha;

	%let input=%str( );
	%assertEqual(a=0,b=%anyAlpha(&input),msg=%quote(anyAlpha(&input)));

	%let input=1;
	%assertEqual(a=0,b=%anyAlpha(&input),msg=%quote(anyAlpha(&input)));

	%let input=a;
	%assertEqual(a=1,b=%anyAlpha(&input),msg=%quote(anyAlpha(&input)));

	%let input=1234abcdef;
	%assertEqual(a=1,b=%anyAlpha(&input),msg=%quote(anyAlpha(&input)));

	%let input=_123;
	%assertEqual(a=0,b=%anyAlpha(&input),msg=%quote(anyAlpha(&input)));

	%let input=汉abc字;
	%assertEqual(a=1,b=%anyAlpha(&input),msg=%quote(anyAlpha(&input)));

	%let input=汉123字;
	%assertEqual(a=0,b=%anyAlpha(&input),msg=%quote(anyAlpha(&input)));

%mend;

%test_anyAlpha;

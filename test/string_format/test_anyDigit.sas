
%macro test_anyDigit;

	%let input=%str( );
	%assertEqual(a=0,b=%anyDigit(&input),msg=%quote(anyDigit(&input)));

	%let input=1;
	%assertEqual(a=1,b=%anyDigit(&input),msg=%quote(anyDigit(&input)));

	%let input=a;
	%assertEqual(a=0,b=%anyDigit(&input),msg=%quote(anyDigit(&input)));

	%let input=1234abcdef111213;
	%assertEqual(a=1,b=%anyDigit(&input),msg=%quote(anyDigit(&input)));

	%let input=abcdef 89;
	%assertEqual(a=1,b=%anyDigit(&input),msg=%quote(anyDigit(&input)));

	%let input=汉字;
	%assertEqual(a=0,b=%anyDigit(&input),msg=%quote(anyDigit(&input)));

	%let input=汉.字;
	%assertEqual(a=0,b=%anyDigit(&input),msg=%quote(anyDigit(&input)));

	%let input=汉1字;
	%assertEqual(a=1,b=%anyDigit(&input),msg=%quote(anyDigit(&input)));

%mend;

%test_anyDigit;

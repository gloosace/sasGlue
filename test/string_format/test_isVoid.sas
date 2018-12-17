%macro test_isVoid;

	%let input=%str( );
	%assertEqual(a=1,b=%isVoid(&input),msg=%quote(isVoid(&input)));

	%let input=%quote( );
	%assertEqual(a=1,b=%isVoid(&input),msg=%quote(isVoid(&input)));

	%let input=%quote(    );
	%assertEqual(a=1,b=%isVoid(&input),msg=%quote(isVoid(&input)));

	%let input=%quote(	);
	%assertEqual(a=1,b=%isVoid(&input),msg=%quote(isVoid(&input)));

	%let input=123;
	%assertEqual(a=0,b=%isVoid(&input),msg=%quote(isVoid(&input)));

	%let input=abc;
	%assertEqual(a=0,b=%isVoid(&input),msg=%quote(isVoid(&input)));

	%let input=%quote(%();
	%assertEqual(a=0,b=%isVoid(%quote(&input)),msg=%quote(isVoid(&input)));

	%let input=%quote(.);
	%assertEqual(a=0,b=%isVoid(%quote(&input)),msg=%quote(isVoid(&input)));

	%let input=%quote(-);
	%assertEqual(a=0,b=%isVoid(%quote(&input)),msg=%quote(isVoid(&input)));

	%let input= ;
	%assertEqual(a=1,b=%isVoid(%quote(&input)),msg=%quote(isVoid(&input)));

	%let input=;
	%assertEqual(a=1,b=%isVoid(%quote(&input)),msg=%quote(isVoid(&input)));

%mend;

%test_isVoid;

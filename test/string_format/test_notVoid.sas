%macro test_notVoid;

	%let input=%str( );
	%assertEqual(a=0,b=%notVoid(&input),msg=%quote(notVoid(&input)));

	%let input=%quote( );
	%assertEqual(a=0,b=%notVoid(&input),msg=%quote(notVoid(&input)));

	%let input=%quote(    );
	%assertEqual(a=0,b=%notVoid(&input),msg=%quote(notVoid(&input)));

	%let input=%quote(	);
	%assertEqual(a=0,b=%notVoid(&input),msg=%quote(notVoid(&input)));

	%let input=123;
	%assertEqual(a=1,b=%notVoid(&input),msg=%quote(notVoid(&input)));

	%let input=abc;
	%assertEqual(a=1,b=%notVoid(&input),msg=%quote(notVoid(&input)));

	%let input=%quote(%();
	%assertEqual(a=1,b=%notVoid(%quote(&input)),msg=%quote(notVoid(&input)));

	%let input=%quote(.);
	%assertEqual(a=1,b=%notVoid(%quote(&input)),msg=%quote(notVoid(&input)));

	%let input=%quote(-);
	%assertEqual(a=1,b=%notVoid(%quote(&input)),msg=%quote(notVoid(&input)));

	%let input= ;
	%assertEqual(a=0,b=%notVoid(%quote(&input)),msg=%quote(notVoid(&input)));

	%let input=;
	%assertEqual(a=0,b=%notVoid(%quote(&input)),msg=%quote(notVoid(&input)));
%mend;


%test_notVoid;

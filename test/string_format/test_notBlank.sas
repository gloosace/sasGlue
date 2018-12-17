%macro test_notBlank;

	%let input=%str( );
	%assertEqual(a=1,b=%notBlank(&input),msg=%quote(notBlank(&input)));

	%let input=%quote( );
	%assertEqual(a=1,b=%notBlank(&input),msg=%quote(notBlank(&input)));

	%let input=%quote(    );
	%assertEqual(a=1,b=%notBlank(&input),msg=%quote(notBlank(&input)));

	%let input=%quote(	);
	%assertEqual(a=1,b=%notBlank(&input),msg=%quote(notBlank(&input)));

	%let input=123;
	%assertEqual(a=1,b=%notBlank(&input),msg=%quote(notBlank(&input)));

	%let input=abc;
	%assertEqual(a=1,b=%notBlank(&input),msg=%quote(notBlank(&input)));

	%let input=%quote(%();
	%assertEqual(a=1,b=%notBlank(%quote(&input)),msg=%quote(notBlank(&input)));

	%let input=%quote(.);
	%assertEqual(a=1,b=%notBlank(%quote(&input)),msg=%quote(notBlank(&input)));

	%let input=%quote(-);
	%assertEqual(a=1,b=%notBlank(%quote(&input)),msg=%quote(notBlank(&input)));

	%let input= ;
	%assertEqual(a=0,b=%notBlank(%quote(&input)),msg=%quote(notBlank(&input)));

	%let input=;
	%assertEqual(a=0,b=%notBlank(%quote(&input)),msg=%quote(notBlank(&input)));
%mend;


%test_notBlank;

%macro test_isBlank;

	%let input=%str( );
	%assertEqual(a=0,b=%isBlank(&input),msg=%quote(isBlank(&input)));

	%let input=%quote( );
	%assertEqual(a=0,b=%isBlank(&input),msg=%quote(isBlank(&input)));

	%let input=%quote(    );
	%assertEqual(a=0,b=%isBlank(&input),msg=%quote(isBlank(&input)));

	%let input=%quote(	);
	%assertEqual(a=0,b=%isBlank(&input),msg=%quote(isBlank(&input)));

	%let input=123;
	%assertEqual(a=0,b=%isBlank(&input),msg=%quote(isBlank(&input)));

	%let input=abc;
	%assertEqual(a=0,b=%isBlank(&input),msg=%quote(isBlank(&input)));

	%let input=%quote(%();
	%assertEqual(a=0,b=%isBlank(%quote(&input)),msg=%quote(isBlank(&input)));

	%let input=%quote(.);
	%assertEqual(a=0,b=%isBlank(%quote(&input)),msg=%quote(isBlank(&input)));

	%let input=%quote(-);
	%assertEqual(a=0,b=%isBlank(%quote(&input)),msg=%quote(isBlank(&input)));

	%let input= ;
	%assertEqual(a=1,b=%isBlank(%quote(&input)),msg=%quote(isBlank(&input)));

	%let input=;
	%assertEqual(a=1,b=%isBlank(%quote(&input)),msg=%quote(isBlank(&input)));
%mend;

%test_isBlank;

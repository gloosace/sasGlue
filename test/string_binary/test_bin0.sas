
%macro test_bin0;
	%local n;

	%let n=1;
	%assertEqual(a=0,b=%bin0(&n),msg=&n);

	%let n=10;
	%assertEqual(a=0000000000,b=%bin0(&n),msg=&n);

	%let n=0;
	%assertEqual(a=,b=%bin0(&n),msg=&n);

	%let n=;
	%assertEqual(a=,b=%bin0(&n),msg=&n);

%mend;


%test_bin0;

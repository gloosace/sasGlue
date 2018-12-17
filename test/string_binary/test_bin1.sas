
%macro test_bin1;
	%local n;

	%let n=1;
	%assertEqual(a=1,b=%bin1(&n),msg=&n);

	%let n=10;
	%assertEqual(a=1111111111,b=%bin1(&n),msg=&n);

	%let n=0;
	%assertEqual(a=,b=%bin1(&n),msg=&n);

	%let n=;
	%assertEqual(a=,b=%bin1(&n),msg=&n);

%mend;


%test_bin1;

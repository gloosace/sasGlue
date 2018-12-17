
%macro test_bincount1;
	%local n;

	%let n=1010101110;
	%assertEqual(a=6,b=%bincount1(&n),msg=&n);

	%let n=1 1000     1 1;
	%assertEqual(a=4,b=%bincount1(&n),msg=&n);

	%let n=0;
	%assertEqual(a=0,b=%bincount1(&n),msg=&n);

	%let n=;
	%assertEqual(a=0,b=%bincount1(&n),msg=&n);

%mend;


%test_binCount1;

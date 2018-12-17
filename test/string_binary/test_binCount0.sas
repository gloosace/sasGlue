
%macro test_binCount0;
	%local n;

	%let n=1010101110;
	%assertEqual(a=4,b=%binCount0(&n),msg=&n);

	%let n=   1 1000     1 1         ;
	%assertEqual(a=10,b=%binCount0(&n),msg=&n);

	%let n=   01 1000     1 10         ;
	%assertEqual(a=12,b=%binCount0(&n),msg=&n);

	%let n=0;
	%assertEqual(a=1,b=%binCount0(&n),msg=&n);

	%let n=           ;
	%assertEqual(a=0,b=%binCount0(&n),msg=&n);

%mend;


%test_binCount0;

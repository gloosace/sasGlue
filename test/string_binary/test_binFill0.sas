
%macro test_binFill0;
	%local n;

	%let b=1010;
	%let r=1010;
	%assertEqual(a=&r,b=%binFill0(&b),msg=&n);

	%let b=1010            1;
	%let r=10100000000000001;
	%assertEqual(a=&r,b=%binFill0(&b),msg=&n);

	%let b=%str(  1010 1   );
	%let r=101001;
	%assertEqual(a=&r,b=%binFill0(&b),msg=&n);

	%let b=;
	%let r=;
	%assertEqual(a=&r,b=%binFill0(&b),msg=&n);

	
%mend;


%test_binFill0;

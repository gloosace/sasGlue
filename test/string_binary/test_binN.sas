
%macro test_binN;
	%local n;

	%let b=1010;
	%let n=1;
	%let r=1;
	%assertEqual(a=&r,b=%binN(&b,&n),msg=&n);

	%let b=1010;
	%let n=2;
	%let r=0;
	%assertEqual(a=&r,b=%binN(&b,&n),msg=&n);

	%let b=1010;
	%let n=10;
	%let r=;
	%assertEqual(a=&r,b=%binN(&b,&n),msg=&n);


	%let b=1010;
	%let n=0;
	%let r=;
	%assertEqual(a=&r,b=%binN(&b,&n),msg=&n);

	
%mend;


%test_binN;

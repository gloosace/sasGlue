%macro test_binToPos1;
	
	%local b;

	%let b=0001010001;
	%assertEqual(a=%str(4 6 10),b=%binToPos1(&b),msg=&b);

	%let b=100101101;
	%assertEqual(a=%str(1 4 6 7 9),b=%binToPos1(&b),msg=&b);
	
	%let b=00000000;
	%assertEqual(a=%str(),b=%binToPos1(&b),msg=&b);
%mend;

%test_binToPos1;

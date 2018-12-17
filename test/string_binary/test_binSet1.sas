
%macro test_binSet1;
	%local n;

	%let b=1010;
	%let n=0;
	%let r=1010;
	%assertEqual(a=&r,b=%binSet1(&b,&n),msg=&n);

	%let b=1010;
	%let n=1;
	%let r=1010;
	%assertEqual(a=&r,b=%binSet1(&b,&n),msg=&n);

	%let b=1010;
	%let n=2;
	%let r=1110;
	%assertEqual(a=&r,b=%binSet1(&b,&n),msg=&n);

	%let b=1010;
	%let n=4;
	%let r=1011;
	%assertEqual(a=&r,b=%binSet1(&b,&n),msg=&n);

	%let b=1010;
	%let n=5;
	%let r=10101;
	%assertEqual(a=&r,b=%binSet1(&b,&n),msg=&n);

	%let b=1010;
	%let n=6;
	%let r=101001;
	%assertEqual(a=&r,b=%binSet1(&b,&n),msg=&n);

	%let b=1010;
	%let n=7;
	%let r=1010001;
	%assertEqual(a=&r,b=%binSet1(&b,&n),msg=&n);
	
%mend;


%test_binSet1;

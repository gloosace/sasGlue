
%macro test_binAnd;

	%local a b r;

	%let a=0001010001;
	%let b=1001010000;
	%let r=0001010000;
	%assertEqual(a=&r,b=%binAnd(&a,&b),msg=);

	%let a=1001010011;
	%let b=1001010100;
	%let r=1001010000;
	%assertEqual(a=&r,b=%binAnd(&a,&b),msg=);


	%let a=1001010011;
	%let b=1001010;
	%let r=1001010000;
	%assertEqual(a=&r,b=%binAnd(&a,&b),msg=);


	%let a=1001011011;
	%let b=1  101 ;
	%let r=1001010000;
	%assertEqual(a=&r,b=%binAnd(&a,&b),msg=);

	%let a=10000;
	%let b=1001010011;
	%let r=1000000000;
	%assertEqual(a=&r,b=%binAnd(&a,&b),msg=);


	%let a=1111110010;
	%let b=;
	%let r=0000000000;
	%assertEqual(a=&r,b=%binAnd(&a,&b),msg=);



%mend;

%macro test_binOr;

	
	%local a b r;

	%let a=0001010001;
	%let b=1001010000;
	%let r=1001010001;
	%assertEqual(a=&r,b=%binOr(&a,&b),msg=);

	%let a=1001010011;
	%let b=1001010100;
	%let r=1001010111;
	%assertEqual(a=&r,b=%binOr(&a,&b),msg=);


	%let a=1001010011;
	%let b=1001010;
	%let r=1001010011;
	%assertEqual(a=&r,b=%binOr(&a,&b),msg=);

	%let a=1001010011;
	%let b=1 010 0  ;
	%let r=1001010011;
	%assertEqual(a=&r,b=%binOr(&a,&b),msg=);

	%let a=10000;
	%let b=1001010011;
	%let r=1001010011;
	%assertEqual(a=&r,b=%binOr(&a,&b),msg=);


	%let a=1111110010;
	%let b=;
	%let r=1111110010;		  
	%assertEqual(a=&r,b=%binOr(&a,&b),msg=);


%mend;




%macro test_binXOR;

	
	%local a b r;

	%let a=0001010001;
	%let b=1001010000;
	%let r=1000000001;
	%assertEqual(a=&r,b=%binXOR(&a,&b),msg=);

	%let a=1001010011;
	%let b=1001010100;
	%let r=0000000111;
	%assertEqual(a=&r,b=%binXOR(&a,&b),msg=);


	%let a=1001010011;
	%let b=1001010;
	%let r=0000000011;
	%assertEqual(a=&r,b=%binXOR(&a,&b),msg=);

	%let a=10000;
	%let b=1001010011;
	%let r=0001010011;
	%assertEqual(a=&r,b=%binXOR(&a,&b),msg=);

	%let a=10000   1;
	%let b=1001010011;
	%let r=0001010001;
	%assertEqual(a=&r,b=%binXOR(&a,&b),msg=);


	%let a=1111110010;
	%let b=;
	%let r=1111110010;		  
	%assertEqual(a=&r,b=%binXOR(&a,&b),msg=);


%mend;


%macro test_binNOT;

	
	%local a b r;

	%let a=0001010001;
	%let r=1110101110;
	%assertEqual(a=&r,b=%binNOT(&a),msg=);

	%let a=1001010011;
	%let r=0110101100;
	%assertEqual(a=&r,b=%binNOT(&a),msg=);


	%let a=1001010;
	%let r=0110101;
	%assertEqual(a=&r,b=%binNOT(&a),msg=);

	%let a=10000;
	%let r=01111;
	%assertEqual(a=&r,b=%binNOT(&a),msg=);

	%let a=10000   1     0;
	%let r=011111110111111;
	%assertEqual(a=&r,b=%binNOT(&a),msg=);

	%let a=;
	%let r=1;
	%assertEqual(a=&r,b=%binNOT(&a),msg=);


%mend;

%test_binAND;
%test_binOR;
%test_binXOR;
%test_binNOT;




%macro test_paramAlias;

	%local a b c d e f g h;
	%local result;

	%let a=;
	%let b=;
	%let c=;
	%let d=;
	%let e=;
	%let f=;

	%put ;
	%put result=%paramAlias(&a,&b);
	%let result=%paramAlias(&a,&b);
	%put result=&result;

	%let a=;
	%let b=;
	%let c=11 22 33;
	%let d=44 55 66;
	%let e=;
	%let f=;

	%put ;
	%put result=%paramAlias(&a,&b,&c,&d);
	%let result=%paramAlias(&a,&b,&c,&d);
	%put result=&result;

	%let a=;
	%let b=X;
	%let c=YY;
	%let d=ZZZ;
	%let e=;
	%let f=;

	%put ;
	%put result=%paramAlias(&a,&b,&c,&d);
	%let result=%paramAlias(&a,&b,&c,&d);
	%put result=&result;

	%let a=;
	%let b=2;
	%let c=3;
	%let d=4;
	%let e=5;
	%let f=6;

	%put ;
	%put result=%paramAlias(&a,&b,&c,&d,&e,&f);
	%let result=%paramAlias(&a,&b,&c,&d,&e,&f);
	%put result=&result;

	

%mend;

%test_paramAlias;

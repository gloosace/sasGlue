

%macro test_assignsJoin;

	%local tres;%let tres=%createTempVar;%local &tres;
	%local d a b e r;
	
	%let a=%quote(1=a 2=b 3=C 4=D);
	%let b=%quote(a=x B=y);
	%let e=%quote(1=x 2=y 3= 4=);
	%assignsjoin(a=&a,b=&b,res=&tres);%let r=&&&tres;
	%assertEqual(a=&r,b=&e,msg=&d);

	%let a=%quote(1=a 2=b 3=C 4=D);
	%let b=%quote(a=x B=y);
	%let e=%quote(1=x 2= 3= 4=);
	%assignsjoin(a=&a,b=&b,caseSensitive=1,res=&tres);%let r=&&&tres;
	%assertEqual(a=&r,b=&e,msg=&d);

	%let a=%quote(1=a 2=b 3=C 4=D);
	%let b=%quote(a=x B=y B=z);
	%let e=%quote(1=x 2=y 3= 4=);
	%assignsjoin(a=&a,b=&b,caseSensitive=0,res=&tres);%let r=&&&tres;
	%assertEqual(a=&r,b=&e,msg=&d);

	%let a=;
	%let b=%quote(a=x B=y B=z);
	%let e=;
	%assignsjoin(a=&a,b=&b,caseSensitive=0,res=&tres);%let r=&&&tres;
	%assertEqual(a=&r,b=&e,msg=&d);

	%let a=%quote(1=a 2=b 3=C 4=D);
	%let b=;
	%let e=%quote(1= 2= 3= 4=);;
	%assignsjoin(a=&a,b=&b,caseSensitive=0,res=&tres);%let r=&&&tres;
	%assertEqual(a=&r,b=&e,msg=&d);
%mend;

%test_assignsJoin;

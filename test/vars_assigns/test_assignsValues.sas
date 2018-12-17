

%macro test_assignsValues;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local prefix suffix cmd a r e;

	%let a=%quote(A='abc' B=123.234 C='ABC' d=ABCDFGH D=111111);
	%let e='abc' 123.234 'ABC' ABCDFGH 111111;
	%assignsValues(assigns=&a,res=&tres);%let r=&&&tres;
	%assertEqual(a=&r,b=&e);

	%let a=%quote( );
	%let e=;
	%assignsValues(assigns=&a,res=&tres);%let r=&&&tres;
	%assertEqual(a=&r,b=&e);
	
%mend;

%test_assignsValues;

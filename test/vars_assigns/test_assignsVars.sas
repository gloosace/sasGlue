

%macro test_assignsVars;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local prefix suffix cmd a r e;

	%let a=%quote(A='abc' B=123.234 C='ABC汉字测试' d=ABCDFGH D=111111);
	%let e=A B C d D;
	%assignsVars(assigns=&a,res=&tres);%let r=&&&tres;
	%assertEqual(a=&r,b=&e,msg=&cmd);

	%let a=%quote( );
	%let e=;
	%assignsVars(assigns=&a,res=&tres);%let r=&&&tres;
	%assertEqual(a=&r,b=&e,msg=&cmd);
	
%mend;

%test_assignsVars;

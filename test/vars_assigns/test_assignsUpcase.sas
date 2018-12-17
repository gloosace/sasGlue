
%macro test_assignsUpcase;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local prefix suffix cmd a r e;

	%let a=%quote(a='abc' b=123.234 C='ABC' d=ABCDFGH D=111111);
	%let e=%quote(A='abc' B=123.234 C='ABC' D=ABCDFGH D=111111);
	%assignsUpcase(assigns=&a,res=&tres);%let r=&&&tres;
	%assertEqual(a=&r,b=&e,msg=&cmd);
	
%mend;


%test_assignsUpcase;

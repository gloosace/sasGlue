
%macro test_assignsEqual;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local prefix suffix cmd a b r e;

	%let a=%quote(a='abc' b=123.234 C='ABC');
	%let b=%quote(A='abc' B=123.234 C='ABC');
	%let e=1;
	%assignsEqual(a=&a,b=&b,res=&tres);%let r=&&&tres;
	%assertEqual(a=&r,b=&e);

	%let a=%quote(a='abc' b=123.234 C='ABC' d=ABCDFGH D=111111);
	%let b=%quote(A='abc' B=123.234 C='ABC' D=ABCDFGH D=111111);
	%let e=1;
	%assignsEqual(a=&a,b=&b,res=&tres);%let r=&&&tres;
	%assertEqual(a=&r,b=&e);
	
	%let a=%quote(a='abc' b=123.234 C='ABC' D=111111 D=111111);
	%let b=%quote(A='abc' B=123.234 C='ABC' D=111111);
	%let e=1;
	%assignsEqual(a=&a,b=&b,res=&tres);%let r=&&&tres;
	%assertEqual(a=&r,b=&e);

	%let a=%quote(a='abc' b=123.234 C='ABC' D=111111 D=111112);
	%let b=%quote(A='abc' B=123.234 C='ABC' D=111111);
	%let e=0;
	%assignsEqual(a=&a,b=&b,res=&tres);%let r=&&&tres;
	%assertEqual(a=&r,b=&e);

	%let a=%quote(a='abc' b=123.234 C='ABC' d=ABCDFGH D=111111);
	%let b=%quote(A='abc' B=123.234 C='ABC' D=ABCDFGH D=111111);
	%let e=0;
	%assignsEqual(a=&a,b=&b,caseSensitive=1,res=&tres);%let r=&&&tres;
	%assertEqual(a=&r,b=&e);
	
%mend;

%test_assignsEqual;

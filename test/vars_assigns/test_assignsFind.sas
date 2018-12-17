
%macro test_assignsFind;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local prefix suffix cmd a r e;

	%let a=%quote(A='abc' B=123.234 C='ABC' d=ABCDFGH D=111111);
	%let var=a;
	%let e='abc';
	%assignsFind(assigns=&a,var=&var,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);

	%let a=%quote(A='abc' B=123.234 C='ABC' d=ABCDFGH D=111111);
	%let var=C;
	%let e='ABC';
	%assignsFind(assigns=&a,var=&var,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);


	%let a=%quote(A='abc' B=123.234 C='ABC' d=ABCDFGH D=111111);
	%let var=a;
	%let e=;
	%assignsFind(assigns=&a,var=&var,res=&tres,caseSensitive=1);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);

%mend;


%test_assignsFind;

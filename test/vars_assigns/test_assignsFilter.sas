
%macro test_assignsFilter;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local d a v r e;

	%let a=%quote(A='abc' B=123.234 C='dfoef' d=sdfwefwef D=111111);
	%let v=A D;
	%let e=%quote(A='abc' d=sdfwefwef D=111111);
	%assignsFilter(assigns=&a,vars=&v,isBlacklist=0,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);


	%let a=%quote(A='abc' B=123.234 C='dfoef' d=sdfwefwef D=111111);
	%let v=A D;
	%let e=%quote(A='abc' D=111111);
	%assignsFilter(assigns=&a,vars=&v,caseSensitive=1,isBlacklist=0,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);


	%let a=%quote(A='abc' B=123.234 C='dfoef' d=sdfwefwef D=111111);
	%let v=A D;
	%let e=%quote(B=123.234 C='dfoef');
	%assignsFilter(assigns=&a,vars=&v,caseSensitive=0,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);


	%let a=%quote(A='abc' B=123.234 C='dfoef' d=sdfwefwef D=111111);
	%let v=A D;
	%let e=%quote(B=123.234 C='dfoef' d=sdfwefwef);
	%assignsFilter(assigns=&a,vars=&v,caseSensitive=1,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);
%mend;


%test_assignsFilter;

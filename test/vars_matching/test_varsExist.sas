
%macro test_varsExist;

	%lbreak(%getInvoker);
	%local a b exp case;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let a=%str(A);
	%let b=%str(a b c);
	%let case=0;
	%let exp=1;
	%varsExist(var=&a,vars=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsExist(target=&a,source=&b,caseSensitive=&case,res=&tres)));

	%let a=%str(A);
	%let b=%str(a b c);
	%let case=1;
	%let exp=0;
	%varsExist(var=&a,vars=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsExist(target=&a,source=&b,caseSensitive=&case,res=&tres)));

	%let a=%str(A);
	%let b=%str(aa bb cc);
	%let case=0;
	%let exp=0;
	%varsExist(target=&a,vars=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsExist(target=&a,source=&b,caseSensitive=&case,res=&tres)));

	%let a=%str( a );
	%let b=%str(bb a cc);
	%let case=0;
	%let exp=1;
	%varsExist(target=&a,source=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsExist(target=&a,source=&b,caseSensitive=&case,res=&tres)));

	%let a=%str( a );
	%let b=%str(bb " a " cc);
	%let case=0;
	%let exp=0;
	%varsExist(var=&a,vars=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsExist(target=&a,source=&b,caseSensitive=&case,res=&tres)));

	%let a=%str('a');
	%let b=%str(bb 'a' cc);
	%let case=0;
	%let exp=1;
	%varsExist(target=&a,source=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsExist(target=&a,source=&b,caseSensitive=&case,res=&tres)));

%mend;

%test_varsExist;

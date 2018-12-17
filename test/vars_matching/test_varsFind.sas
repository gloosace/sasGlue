
%macro test_varsFind;

	%lbreak(%getInvoker);
	%local a b exp case;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let a=%str(B);
	%let b=%str(a b c);
	%let case=0;
	%let exp=2;
	%varsFind(var=&a,vars=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsFind(target=&a,source=&b,caseSensitive=&case,res=&tres)));

	%let a=%str(B);
	%let b=%str(a a b b b c);
	%let case=0;
	%let exp=3;
	%varsFind(var=&a,vars=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsFind(target=&a,source=&b,caseSensitive=&case,res=&tres)));

	%let a=%str(B);
	%let b=%str(a b c);
	%let case=1;
	%let exp=0;
	%varsFind(var=&a,vars=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsFind(target=&a,source=&b,caseSensitive=&case,res=&tres)));

	%let a=%str(A);
	%let b=%str(aa bb cc);
	%let case=0;
	%let exp=0;
	%varsFind(target=&a,vars=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsFind(target=&a,source=&b,caseSensitive=&case,res=&tres)));

	%let a=%str( a );
	%let b=%str(bb a cc);
	%let case=0;
	%let exp=2;
	%varsFind(target=&a,source=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsFind(target=&a,source=&b,caseSensitive=&case,res=&tres)));

	%let a=%str( a );
	%let b=%str(bb " a " cc);
	%let case=0;
	%let exp=0;
	%varsFind(var=&a,vars=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsFind(target=&a,source=&b,caseSensitive=&case,res=&tres)));

	%let a=%str('a');
	%let b=%str(bb 'a' cc);
	%let case=0;
	%let exp=2;
	%varsFind(target=&a,source=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsFind(target=&a,source=&b,caseSensitive=&case,res=&tres)));


	%let a=%str(汉字测试);
	%let b=%str(aaa bbb 汉字 汉字测试 测试 xxx);
	%let case=0;
	%let exp=4;
	%varsFind(target=&a,source=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsFind(target=&a,source=&b,caseSensitive=&case,res=&tres)));

%mend;

%test_varsFind;

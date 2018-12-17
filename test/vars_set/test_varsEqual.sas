
%macro test_varsEqual;
	%lbreak(%getInvoker);
	%local a b exp case;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let a=%str(a b c);
	%let b=%str(b c a);
	%let case=0;
	%let exp=1;
	%varsEqual(a=&a,b=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsEqual(a=&a,b=&b,caseSensitive=&case,res=&tres)));

	%let a=%str(a b);
	%let b=%str(a b c);
	%let case=0;
	%let exp=0;
	%varsEqual(a=&a,b=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsEqual(a=&a,b=&b,caseSensitive=&case,res=&tres)));


	%let a=%str(aaa bb ccC);
	%let b=%str(AaA cCc BB);
	%let case=0;
	%let exp=1;
	%varsEqual(a=&a,b=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsEqual(a=&a,b=&b,caseSensitive=&case,res=&tres)));


	%let a=%str(aaa bb ccC);
	%let b=%str(AaA cCc BB);
	%let case=1;
	%let exp=0;
	%varsEqual(a=&a,b=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsEqual(a=&a,b=&b,caseSensitive=&case,res=&tres)));

%mend;

%test_varsEqual;



%macro test_varsIn;
	%lbreak(%getInvoker);
	%local a b exp case;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let a=%str(a b c);
	%let b=%str(b d f);
	%let case=0;
	%let exp=0;
	%varsIn(target=&a,source=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsIn(target=&a,source=&b,caseSensitive=&case,res=&tres)));

	%let a=%str(a b);
	%let b=%str(a b c);
	%let case=0;
	%let exp=1;
	%varsIn(target=&a,source=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsIn(target=&a,source=&b,caseSensitive=&case,res=&tres)));


	%let a=%str(aa 22);
	%let b=%str(33 22 11 aa cc xx yy);
	%let case=0;
	%let exp=1;
	%varsIn(target=&a,source=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsIn(target=&a,source=&b,caseSensitive=&case,res=&tres)));


	%let a=%str(a='1' b='aBc' c='456');
	%let b=%str(c='777' A='1' C='456' B='Abc');
	%let case=0;
	%let exp=1;
	%varsIn(target=&a,source=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsIn(target=&a,source=&b,caseSensitive=&case,res=&tres)));

%mend;

%test_varsIn;

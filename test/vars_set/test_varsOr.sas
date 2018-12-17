
%macro test_varsOr;
	%lbreak(%getInvoker);
	%local a b exp case;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let a=%str(a b c);
	%let b=%str(b d f);
	%let case=0;
	%let exp=%str(A B C D F);
	%varsOr(a=&a,b=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsOr(a=&a,b=&b,caseSensitive=&case,res=&tres)));

	%let a=%str(a a c d a);
	%let b=%str(b e f c a);
	%let case=0;
	%let exp=%str(A B C D E F);
	%varsOr(a=&a,b=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsOr(a=&a,b=&b,caseSensitive=&case,res=&tres)));

	%let a=%str(aa bb cc 11 22);
	%let b=%str(33 22 11 cc xx yy);
	%let case=0;
	%let exp=%str(11 22 33 AA BB CC XX YY);
	%varsOr(a=&a,b=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsOr(a=&a,b=&b,caseSensitive=&case,res=&tres)));

	%let a=%str(a='1' b='aBc' c='456');
	%let b=%str(c='777' A='1' B='Abc');
	%let case=0;
	%let exp=%str(A='1' B='ABC' C='456' C='777');
	%varsOr(a=&a,b=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsOr(a=&a,b=&b,caseSensitive=&case,res=&tres)));

	%let a=%str(a='1' b='aBc' c='456');
	%let b=%str(c='777' A='1' B='Abc');
	%let case=1;
	%let exp=%str(A='1' B='Abc' a='1' b='aBc' c='456' c='777');
	%varsOr(a=&a,b=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsOr(a=&a,b=&b,caseSensitive=&case,res=&tres)));
%mend;

%test_varsOr;

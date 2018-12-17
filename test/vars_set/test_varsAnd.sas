
%macro test_varsAnd;
	%lbreak(%getInvoker);

	%local a b exp case;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let a=%str(a b c);
	%let b=%str(b d f);
	%let case=0;
	%let exp=B;
	%varsAnd(a=&a,b=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres);

	%let a=%str(a b c d a);
	%let b=%str(b a d c c a);
	%let case=0;
	%let exp=%str(A B C D);
	%varsAnd(a=&a,b=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres);

	%let a=%str(aa bb cc 11 22);
	%let b=%str(33 22 11 cc xx yy);
	%let case=0;
	%let exp=%str(11 22 CC);
	%varsAnd(a=&a,b=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres);

	%let a=%str(a='1' b='aBc' c='456');
	%let b=%str(c='777' A='1' B='Abc');
	%let case=0;
	%let exp=%str(A='1' B='ABC');
	%varsAnd(a=&a,b=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres);

	%let a=%str(a='1' b='aBc' c='456');
	%let b=%str(c='777' A='1' B='Abc');
	%let case=1;
	%let exp=%str();
	%varsAnd(a=&a,b=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres);

%mend;

%test_varsAnd;

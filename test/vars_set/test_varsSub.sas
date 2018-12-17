
%macro test_varsSub;
	%lbreak(%getInvoker);
	%local a b exp case;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let a=%str(a b c);
	%let b=%str(b d f);
	%let case=0;
	%let exp=%str(A C);
	%varsSub(a=&a,b=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsSub(a=&a,b=&b,caseSensitive=&case,res=&tres)));

	%let a=%str(a a c d a);
	%let b=%str(b e f c a);
	%let case=0;
	%let exp=%str(D);
	%varsSub(a=&a,b=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsSub(a=&a,b=&b,caseSensitive=&case,res=&tres)));

	%let a=%str(aa bb cc 11 22);
	%let b=%str(33 22 11 cc xx yy);
	%let case=0;
	%let exp=%str(AA BB);
	%varsSub(a=&a,b=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsSub(a=&a,b=&b,caseSensitive=&case,res=&tres)));

	%let a=%str(a='1' b='aBc' c='456');
	%let b=%str(c='777' A='1' B='Abc');
	%let case=0;
	%let exp=%str(C='456');
	%varsSub(a=&a,b=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsSub(a=&a,b=&b,caseSensitive=&case,res=&tres)));

	%let a=%str(a='1' b='aBc' c='456');
	%let b=%str(c='777' A='1' B='Abc');
	%let case=1;
	%let exp=%str(a='1' b='aBc' c='456');
	%varsSub(a=&a,b=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsSub(a=&a,b=&b,caseSensitive=&case,res=&tres)));

	%let a=%str();
	%let b=%str(c='777' A='1' B='Abc');
	%let case=0;
	%let exp=%str();
	%varsSub(a=&a,b=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsSub(a=&a,b=&b,caseSensitive=&case,res=&tres)));

	%let a=%str(a='1' b='aBc' c='456' B='Abc');
	%let b=%str();
	%let case=0;
	%let exp=%str(A='1' B='ABC' C='456');
	%varsSub(a=&a,b=&b,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsSub(a=&a,b=&b,caseSensitive=&case,res=&tres)));

%mend;

%test_varsSub;

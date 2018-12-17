

%macro test_varsN;

	%local vars exp n;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let vars=%str(a b c);
	%let n=2;
	%let exp=%str(b);
	%varsN(vars=&vars,n=&n,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsN(vars=&vars,n=&n,res=&tres)));

	%let vars=%str(a=1 b=-2 c=3);
	%let n=3;
	%let exp=%str(c=3);
	%varsN(vars=&vars,n=&n,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsN(vars=&vars,n=&n,res=&tres)));

	%let vars=%str(a='1'  c=' 3 ');
	%let n=2;
	%let exp=%str(c=' 3 ');
	%varsN(vars=&vars,n=&n,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsN(vars=&vars,n=&n,res=&tres)));

	%let vars=%str(a='1' b='abc def' c='3');
	%let n=2;
	%let exp=%str(b='abc def');
	%varsN(vars=&vars,n=&n,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsN(vars=&vars,n=&n,res=&tres)));

	%let vars=%str(a='1' b='abc def' c='3' d='bbb');
	%let n=-2;
	%let exp=%str(c='3');
	%varsN(vars=&vars,n=&n,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsN(vars=&vars,n=&n,res=&tres)));

	%let vars=%str(a b c);
	%let n=4;
	%let exp=%str();
	%varsN(vars=&vars,n=&n,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsN(vars=&vars,n=&n,res=&tres)));

	%let vars=%str();
	%let n=4;
	%let exp=%str();
	%varsN(vars=&vars,n=&n,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsN(vars=&vars,n=&n,res=&tres)));

	%let vars=%str(a b c);
	%let n=0;
	%let exp=%str();
	%varsN(vars=&vars,n=&n,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsN(vars=&vars,n=&n,res=&tres)));

%mend;


%test_varsN;

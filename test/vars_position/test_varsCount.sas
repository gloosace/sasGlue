
%macro test_varsCount;

	%local vars exp;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let vars=%str();
	%let exp=0;
	%varsCount(vars=&vars,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsCount(vars=&vars,res=&tres)));

	%let vars=%str(a=1 b=-2 c=3);
	%let exp=3;
	%varsCount(vars=&vars,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsCount(vars=&vars,res=&tres)));

	%let vars=%str(a='1'  c=' 3 ');
	%let exp=2;
	%varsCount(vars=&vars,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsCount(vars=&vars,res=&tres)));

	%let vars=%str(a='1' b='abc def' c='3');
	%let exp=3;
	%varsCount(vars=&vars,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsCount(vars=&vars,res=&tres)));

	%let vars=%str(a='1' b="abc def" c='3');
	%let exp=3;
	%varsCount(vars=&vars,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsCount(vars=&vars,res=&tres)));

%mend;

%test_varsCount;

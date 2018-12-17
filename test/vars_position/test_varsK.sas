

%macro test_varsK;

	%local vars exp n;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let vars=%str(a b c);
	%let n=2;
	%let exp=%str(b);
	%let r=%varsK(&vars,&n);
	%assertEqual(a=&exp,b=&r);

	%let vars=%str(a=1 b=-2 c=3);
	%let n=3;
	%let exp=%str(c=3);
	%let r=%varsK(&vars,&n);
	%assertEqual(a=&exp,b=&r);

	%let vars=%str(a='1'  c=' 3 ');
	%let n=2;
	%let exp=%str(c=' 3 ');
	%let r=%varsK(&vars,&n);
	%assertEqual(a=&exp,b=&r);

	%let vars=%str(a='1' b='abc def' c='3');
	%let n=2;
	%let exp=%str(b='abc def');
	%let r=%varsK(&vars,&n);
	%assertEqual(a=&exp,b=&r);

	%let vars=%str(a='1' b='abc def' c='3' d='bbb');
	%let n=-2;
	%let exp=%str(c='3');
	%let r=%varsK(&vars,&n);
	%assertEqual(a=&exp,b=&r);

	%let vars=%str(a b c);
	%let n=4;
	%let exp=%str();
	%let r=%varsK(&vars,&n);
	%assertEqual(a=&exp,b=&r);

	%let vars=%str();
	%let n=4;
	%let exp=%str();
	%let r=%varsK(&vars,&n);
	%assertEqual(a=&exp,b=&r);

	%let vars=%str(a b c);
	%let n=0;
	%let exp=%str();
	%let r=%varsK(&vars,&n);
	%assertEqual(a=&exp,b=&r);


	%let vars=%str(a b c);
	%let n=3 2 1;
	%let exp=%str(c b a);
	%let r=%varsK(&vars,&n);
	%assertEqual(a=&exp,b=&r);


	%let vars=%str(a b c);
	%let n=3 2 1 1 -1;
	%let exp=%str(c b a a c);
	%let r=%varsK(&vars,&n);
	%assertEqual(a=&exp,b=&r);


	%let vars=%str(a b c);
	%let n=4 2 1 1 -4;
	%let exp=%str(b a a);
	%let r=%varsK(&vars,&n);
	%assertEqual(a=&exp,b=&r);

%mend;


%test_varsK;

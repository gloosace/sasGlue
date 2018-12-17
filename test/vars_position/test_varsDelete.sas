

%macro test_varsDelete;

	%local vars exp n c;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let vars=%str(a b c d e);
	%let n=2;
	%let exp=%str(a c d e);
	%let r=%varsDelete(&vars,&n);
	%assertEqual(a=&exp,b=&r);

	%let vars=%str(a b c d e);
	%let n=100;
	%let exp=%str(a b c d e);
	%let r=%varsDelete(&vars,&n);
	%assertEqual(a=&exp,b=&r);

	%let vars=%str(a b c d e);
	%let n=-100;
	%let exp=%str(a b c d e);
	%let r=%varsDelete(&vars,&n);
	%assertEqual(a=&exp,b=&r);

	%let vars=%str(a b c d e);
	%let n=0;
	%let exp=%str(a b c d e);
	%let r=%varsDelete(&vars,&n);
	%assertEqual(a=&exp,b=&r);

	%let vars=%str(a b c d e);
	%let n=1;
	%let exp=%str(b c d e);
	%let r=%varsDelete(&vars,&n);
	%assertEqual(a=&exp,b=&r);

	%let vars=%str(a b c d e);
	%let n=-1;
	%let exp=%str(a b c d);
	%let r=%varsDelete(&vars,&n);
	%assertEqual(a=&exp,b=&r);

	%let vars=%str(a b c d e);
	%let n=-2;
	%let exp=%str(a b c e);
	%let r=%varsDelete(&vars,&n);
	%assertEqual(a=&exp,b=&r);
	
	%let vars=%str(a=1 b=-2 c=3);
	%let n=3;
	%let exp=%str(a=1 b=-2);
	%let r=%varsDelete(&vars,&n);
	%assertEqual(a=&exp,b=&r);

	%let vars=%str();
	%let n=4;
	%let exp=%str();
	%let r=%varsDelete(&vars,&n);
	%assertEqual(a=&exp,b=&r);

	%let vars=;
	%let n=4;
	%let exp=;
	%let r=%varsDelete(&vars,&n);
	%assertEqual(a=&exp,b=&r);

	
	%let vars=%str(a b c);
	%let n=;
	%let exp=%str(a b c);
	%let r=%varsDelete(&vars,&n);
	%assertEqual(a=&exp,b=&r);


	%let vars=;
	%let n=;
	%let exp=;
	%let r=%varsDelete(&vars,&n);
	%assertEqual(a=&exp,b=&r);

%mend;


%test_varsDelete;

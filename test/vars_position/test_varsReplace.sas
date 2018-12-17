

%macro test_varsReplace;

	%local vars exp n c;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let vars=%str(a b c);
	%let n=2;
	%let c=x;
	%let exp=%str(a x c);
	%let r=%varsReplace(&vars,&n,&c);
	%assertEqual(a=&exp,b=&r);

	%let vars=%str(a=1 b=-2 c=3);
	%let n=3;
	%let c=%str(d=100);
	%let exp=%str(a=1 b=-2 d=100);
	%let r=%varsReplace(&vars,&n,&c);
	%assertEqual(a=&exp,b=&r);

	%let vars=%str(a b c);
	%let n=4;
	%let c=X;
	%let exp=%str(a b c X);
	%let r=%varsReplace(&vars,&n,&c);
	%assertEqual(a=&exp,b=&r);

	%let vars=%str();
	%let n=4;
	%let c=X;
	%let exp=%str(X);
	%let r=%varsReplace(&vars,&n,&c);
	%assertEqual(a=&exp,b=&r);

	%let vars=%str(a b c);
	%let n=0;
	%let c=X;
	%let exp=%str(X a b c);
	%let r=%varsReplace(&vars,&n,&c);
	%assertEqual(a=&exp,b=&r);

	
	%let vars=%str(a b c);
	%let n=-1;
	%let c=X;
	%let exp=%str(a b X);
	%let r=%varsReplace(&vars,&n,&c);
	%assertEqual(a=&exp,b=&r);

%mend;


%test_varsReplace;

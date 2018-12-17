

%macro test_subVars;

	%local vars a b e r;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let vars=%str(a b c d e f g h);
	%let a=2;
	%let b=4;
	%let e=%str(b c d);
	%assertEqual(a=&e,b=%subVars(&vars,&a,&b));

	%let vars=%str(a b c d e f g h);
	%let a=2;
	%let b=100;
	%let e=%str(b c d e f g h);
	%assertEqual(a=&e,b=%subVars(&vars,&a,&b));

	%let vars=%str(a b c d e f g h);
	%let a=0;
	%let b=0;
	%let e=;
	%assertEqual(a=&e,b=%subVars(&vars,&a,&b));


	%let vars=%str(a b c d e f g h);
	%let a=2;
	%let b=;
	%let e=%str(b c d e f g h);
	%assertEqual(a=&e,b=%subVars(&vars,&a,&b));


	%let vars=%str(a b c d e f g h);
	%let a=;
	%let b=4;
	%let e=%str(a b c d);
	%assertEqual(a=&e,b=%subVars(&vars,&a,&b));


	%let vars=%str(a b c d e f g h);
	%let a=;
	%let b=;
	%let e=%str(a b c d e f g h);
	%assertEqual(a=&e,b=%subVars(&vars,&a,&b));


	%let vars=%str(a b c d e f g h);
	%let a=-4;
	%let b=-2;
	%let e=%str(e f g);
	%assertEqual(a=&e,b=%subVars(&vars,&a,&b));

	%let vars=%str(a b c d e f g h);
	%let a=-2;
	%let b=2;
	%let e=%str(g f e d c b);
	%assertEqual(a=&e,b=%subVars(&vars,&a,&b));

	%let vars=%str(a b c d e f g h);
	%let a=-2;
	%let b=;
	%let e=%str(g h);
	%assertEqual(a=&e,b=%subVars(&vars,&a,&b));

	%let vars=%str(a b c d e f g h);
	%let a=;
	%let b=-10;
	%let e=%str();
	%assertEqual(a=&e,b=%subVars(&vars,&a,&b));


	%let vars=%str(a b c d e f g h);
	%let a=;
	%let b=-2;
	%let e=%str(a b c d e f g);
	%assertEqual(a=&e,b=%subVars(&vars,&a,&b));


	%let vars=%str(a b c d e f g h);
	%let a=10;
	%let b=;
	%let e=%str();
	%assertEqual(a=&e,b=%subVars(&vars,&a,&b));


	%let vars=%str(a b c d e f g h);
	%let a=-10;
	%let b=;
	%let e=%str(a b c d e f g h);
	%assertEqual(a=&e,b=%subVars(&vars,&a,&b));


	%let vars=%str(a b c);
	%let a=4;
	%let b=2;
	%let e=%str(c b);
	%assertEqual(a=&e,b=%subVars(&vars,&a,&b));


	%let vars=%str(a b c);
	%let a=4;
	%let b=;
	%let e=%str();
	%assertEqual(a=&e,b=%subVars(&vars,&a,&b));

	%let vars=%str(a b c d);
	%let a=2;
	%let b=;
	%let e=%str(b c d);
	%assertEqual(a=&e,b=%subVars(&vars,&a,&b));

	%let vars=%str(a b c d);
	%let a=;
	%let b=2;
	%let e=%str(a b);
	%assertEqual(a=&e,b=%subVars(&vars,&a,&b));

	%let vars=%str(a b c d);
	%let a=2;
	%let b=1;
	%let e=%str(b a);
	%assertEqual(a=&e,b=%subVars(&vars,&a,&b));


	%let vars=;
	%let a=1;
	%let b=1;
	%let e=;
	%assertEqual(a=&e,b=%subVars(&vars,&a,&b));


	%let vars=;
	%let a=;
	%let b=;
	%let e=;
	%assertEqual(a=&e,b=%subVars(&vars,&a,&b));

	%let vars=;
	%let a=0;
	%let b=0;
	%let e=;
	%assertEqual(a=&e,b=%subVars(&vars,&a,&b));

%mend;


%test_subVars;



%macro test_varsReverse;

	%local vars e r;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let vars=%str(a b c);
	%let e=%str(c b a);
	%let r=%varsReverse(&vars);
	%assertEqual(a=&e,b=&r,msg=);

	%let vars=%str(a b c d e);
	%let e=%str(e d c b a);
	%let r=%varsReverse(&vars);
	%assertEqual(a=&e,b=&r,msg=);


	%let vars=%str(a   c);
	%let e=%str(c a);
	%let r=%varsReverse(&vars);
	%assertEqual(a=&e,b=&r,msg=);


	%let vars=%str();
	%let e=%str();
	%let r=%varsReverse(&vars);
	%assertEqual(a=&e,b=&r,msg=);

	
%mend;

%test_varsReverse;

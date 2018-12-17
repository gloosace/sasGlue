
%macro test_varsLength;

	%local vars exp r;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let vars=%str();
	%let exp=0;
	%let r=%varsLength(&vars);
	%assertEqual(a=&exp,b=&r);

	%let vars=%str(a=1 b=-2 c=3);
	%let exp=3;
	%let r=%varsLength(&vars);
	%assertEqual(a=&exp,b=&r);

	%let vars=%str(a='1'  c=' 3 ');
	%let exp=2;
	%let r=%varsLength(&vars);
	%assertEqual(a=&exp,b=&r);

	%let vars=%str(a='1' b='abc def' c='3');
	%let exp=3;
	%let r=%varsLength(&vars);
	%assertEqual(a=&exp,b=&r);

	%let vars=%str(a='1' b="abc def" c='3');
	%let exp=3;
	%let r=%varsLength(&vars);
	%assertEqual(a=&exp,b=&r);

%mend;

%test_varsLength;

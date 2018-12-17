
%macro test_sqlVarsToSas;

	%local vars;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let vars=%str();
	%assertEqual(a=%str(),b=%sqlVarsToSas(&vars),msg=%quote(sqlVarsToSas(&vars)));

	%let vars=%str(a,b,c);
	%assertEqual(a=%str(a b c),b=%sqlVarsToSas(&vars),msg=%quote(sqlVarsToSas(&vars)));

	%let vars=%str(a,,b,c);
	%assertEqual(a=%str(a b c),b=%sqlVarsToSas(&vars),msg=%quote(sqlVarsToSas(&vars)));

	%let vars=%str(a=1,b=-2,c=3);
	%assertEqual(a=%str(a=1 b=-2 c=3),b=%sqlVarsToSas(&vars),msg=%quote(sqlVarsToSas(&vars)));

	%let vars=%str(a='1',b='-2',c='3');
	%assertEqual(a=%str(a='1' b='-2' c='3'),b=%sqlVarsToSas(&vars),msg=%quote(sqlVarsToSas(&vars)));

	%let vars=%str(a='1',b='abc def',c='3');
	%assertEqual(a=%str(a='1' b='abc def' c='3'),b=%sqlVarsToSas(&vars),msg=%quote(sqlVarsToSas(&vars)));

	%let vars=%str(a='1',b="abc,def",c='3');
	%assertEqual(a=%str(a='1' b="abc,def" c='3'),b=%sqlVarsToSas(&vars),msg=%quote(sqlVarsToSas(&vars)));

%mend;


%test_sqlVarsToSas;

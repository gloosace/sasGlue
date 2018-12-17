
%macro test_assignsToWhere;

	%local vars result;
	%local tres;%let tres=%createTempVar;%local &tres;
	
	%let vars=%str(a=1 b='str' c=100);
	%let result=%str(a=1 and b='str' and c=100);
	%assertEqual(a=&result,b=%assignsToWhere(&vars));

	%let vars=%str(a=1    b='str' );
	%let result=%str(a=1 and b='str');
	%assertEqual(a=&result,b=%assignsToWhere(&vars));

	%let vars=%str(a= b= );
	%let result=%str(a= and b=);
	%assertEqual(a=&result,b=%assignsToWhere(&vars));

	%let vars=%str(a b c);
	%let result=%str(a and b and c);
	%assertEqual(a=&result,b=%assignsToWhere(&vars));

%mend;


%test_assignsToWhere;

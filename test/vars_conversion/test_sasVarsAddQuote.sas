
%macro test_sasVarsAddQuote;

	%local vars result;
	%local tres;%let tres=%createTempVar;%local &tres;
	
	%let vars=%str(a b c);
	%let result=%str(%'a%' %'b%' %'c%');
	%assertEqual(a=&result,b=%sasVarsAddQuote(&vars));

	%let vars=%str(a=1 b=-2 c=3);
	%let result=%str(%'a=1%' %'b=-2%' %'c=3%');
	%assertEqual(a=&result,b=%sasVarsAddQuote(&vars));

	%let vars=%str(a='1' b='-2' c='3');
	%let result=%str(%'a=%'1%'%' %'b=%'-2%'%' %'c=%'3%'%');
	%assertEqual(a=&result,b=%sasVarsAddQuote(&vars));

%mend;


%test_sasVarsAddQuote;

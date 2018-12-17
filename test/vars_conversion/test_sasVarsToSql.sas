
%macro test_sasVarsToSql;

	%local vars;
	%local tres;%let tres=%createTempVar;%local &tres;

	
	%let vars=%str(a b c);
	%assertEqual(a=%str(a,b,c),b=%sasVarsToSql(&vars),msg=%quote(sasVarsToSql(&vars)));

	%let vars=%str(a=1 b=-2 c=3);
	%assertEqual(a=%str(a=1,b=-2,c=3),b=%sasVarsToSql(&vars),msg=%quote(sasVarsToSql(&vars)));

	%let vars=%str(a='1' b='-2' c='3');
	%assertEqual(a=%str(a='1',b='-2',c='3'),b=%sasVarsToSql(&vars),msg=%quote(sasVarsToSql(&vars)));

	%let vars=%str(a='1' b='abc def' c='3');
	%assertEqual(a=%str(a='1',b='abc def',c='3'),b=%sasVarsToSql(&vars),msg=%quote(sasVarsToSql(&vars)));

	%let vars=%str(a='1' b="abc def" c='3');
	%assertEqual(a=%str(a='1',b="abc def",c='3'),b=%sasVarsToSql(&vars),msg=%quote(sasVarsToSql(&vars)));

	%let vars=%str(a='1' b="汉字" c='测试');
	%assertEqual(a=%str(a='1',b="汉字",c='测试'),b=%sasVarsToSql(&vars),msg=%quote(sasVarsToSql(&vars)));

%mend;

%test_sasVarsToSql;

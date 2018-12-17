
%macro test_varsFilter;

	%local tres;%let tres=%createTempVar;%local &tres;
	%local vars filter caseSensitive isBlacklist;


	%let vars=aaa bbb ccc ddd eee;
	%let filter=BBB DDD XXX YYY;
	%let isBlacklist=0;
	%let caseSensitive=0;
	%let result=bbb ddd;
	%varsFilter(vars=&vars,filter=&filter,caseSensitive=&caseSensitive,isBlacklist=&isBlacklist,res=&tres);
	%assertEqual(a=&result,b=&&&tres,msg=%quote(vars=&vars filter=&filter isBlacklist=&isBlacklist caseSensitive=&caseSensitive));

	%let vars=aaa bbb ccc ddd eee;
	%let filter=BBB DDD XXX YYY;
	%let isBlacklist=;
	%let caseSensitive=0;
	%let result=aaa ccc eee;
	%varsFilter(vars=&vars,filter=&filter,caseSensitive=&caseSensitive,isBlacklist=&isBlacklist,res=&tres);
	%assertEqual(a=&result,b=&&&tres,msg=%quote(vars=&vars filter=&filter isBlacklist=&isBlacklist caseSensitive=&caseSensitive));

	%let vars=aaa bbb ccc ddd eee;
	%let filter=BBB ddd XXX YYY;
	%let isBlacklist=0;
	%let caseSensitive=1;
	%let result=ddd;
	%varsFilter(vars=&vars,filter=&filter,caseSensitive=&caseSensitive,isBlacklist=&isBlacklist,res=&tres);
	%assertEqual(a=&result,b=&&&tres,msg=%quote(vars=&vars filter=&filter isBlacklist=&isBlacklist caseSensitive=&caseSensitive));

	%let vars=aaa bbb ccc ddd eee;
	%let filter=BBB ddd XXX YYY;
	%let isBlacklist=;
	%let caseSensitive=1;
	%let result=aaa bbb ccc eee;
	%varsFilter(vars=&vars,filter=&filter,caseSensitive=&caseSensitive,isBlacklist=&isBlacklist,res=&tres);
	%assertEqual(a=&result,b=&&&tres,msg=%quote(vars=&vars filter=&filter isBlacklist=&isBlacklist caseSensitive=&caseSensitive));

	
	%let vars=aaa bbb ccc ddd eee;
	%let filter=;
	%let isBlacklist=;
	%let caseSensitive=0;
	%let result=aaa bbb ccc ddd eee;
	%varsFilter(vars=&vars,filter=&filter,caseSensitive=&caseSensitive,isBlacklist=&isBlacklist,res=&tres);
	%assertEqual(a=&result,b=&&&tres,msg=%quote(vars=&vars filter=&filter isBlacklist=&isBlacklist caseSensitive=&caseSensitive));

	%let vars=aaa bbb ccc ddd eee;
	%let filter=;
	%let isBlacklist=0;
	%let caseSensitive=0;
	%let result=;
	%varsFilter(vars=&vars,filter=&filter,caseSensitive=&caseSensitive,isBlacklist=&isBlacklist,res=&tres);
	%assertEqual(a=&result,b=&&&tres,msg=%quote(vars=&vars filter=&filter isBlacklist=&isBlacklist caseSensitive=&caseSensitive));

	%let vars=;
	%let filter=BBB ddd XXX YYY;
	%let isBlacklist=0;
	%let caseSensitive=0;
	%let result=;
	%varsFilter(vars=&vars,filter=&filter,caseSensitive=&caseSensitive,isBlacklist=&isBlacklist,res=&tres);
	%assertEqual(a=&result,b=&&&tres,msg=%quote(vars=&vars filter=&filter isBlacklist=&isBlacklist caseSensitive=&caseSensitive));

%mend;

%test_varsFilter;

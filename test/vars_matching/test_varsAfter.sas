

%macro test_varsAfter;

	%local tres;%let tres=%createTempVar;%local &tres;
	%local vars after result desc e;

	%let vars=a b c d e;
	%let after=c;
	%let caseSensitive=0;
	%let e=d e;
	%varsAfter(vars=&vars,after=&after,caseSensitive=&caseSensitive,res=&tres);%let result=&&&tres;
	%assertEqual(a=&e,b=&result);

	%let vars=a b c d e;
	%let after=%str( c );
	%let caseSensitive=0;
	%let e=d e;
	%varsAfter(vars=&vars,after=&after,caseSensitive=&caseSensitive,res=&tres);%let result=&&&tres;
	%assertEqual(a=&e,b=&result);

	%let vars=a b B C c c D e;
	%let after=c;
	%let caseSensitive=1;
	%let e=c D e;
	%varsAfter(vars=&vars,after=&after,caseSensitive=&caseSensitive,res=&tres);%let result=&&&tres;
	%assertEqual(a=&e,b=&result);


	%let vars=a b B C c c D e;
	%let after=c;
	%let caseSensitive=0;
	%let e=c c D e;
	%varsAfter(vars=&vars,after=&after,caseSensitive=&caseSensitive,res=&tres);%let result=&&&tres;
	%assertEqual(a=&e,b=&result);


	%let vars=;
	%let after=c;
	%let caseSensitive=0;
	%let e=;
	%varsAfter(vars=&vars,after=&after,caseSensitive=&caseSensitive,res=&tres);%let result=&&&tres;
	%assertEqual(a=&e,b=&result);

	
	%let vars=a b c d e f;
	%let after=;
	%let caseSensitive=0;
	%let e=;
	%varsAfter(vars=&vars,after=&after,caseSensitive=&caseSensitive,res=&tres);%let result=&&&tres;
	%assertEqual(a=&e,b=&result);


	%let vars=a b c d e f;
	%let after=x;
	%let caseSensitive=0;
	%let e=;
	%varsAfter(vars=&vars,after=&after,caseSensitive=&caseSensitive,res=&tres);%let result=&&&tres;
	%assertEqual(a=&e,b=&result);


	%let vars=a b c d e f;
	%let after=D;
	%let caseSensitive=1;
	%let e=;
	%varsAfter(vars=&vars,after=&after,caseSensitive=&caseSensitive,res=&tres);%let result=&&&tres;
	%assertEqual(a=&e,b=&result);

%mend;

%test_varsAfter;

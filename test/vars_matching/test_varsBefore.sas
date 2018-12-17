

%macro test_varsbefore;

	%local tres;%let tres=%createTempVar;%local &tres;
	%local vars before result desc e;

	%let vars=a b c d e;
	%let before=c;
	%let caseSensitive=0;
	%let e=a b;
	%varsbefore(vars=&vars,before=&before,caseSensitive=&caseSensitive,res=&tres);%let result=&&&tres;
	%assertEqual(a=&e,b=&result);

	%let vars=a b c d e;
	%let before=%str( c );
	%let caseSensitive=0;
	%let e=a b;
	%varsbefore(vars=&vars,before=&before,caseSensitive=&caseSensitive,res=&tres);%let result=&&&tres;
	%assertEqual(a=&e,b=&result);

	%let vars=a b B C c c D e;
	%let before=c;
	%let caseSensitive=1;
	%let e=a b B C;
	%varsbefore(vars=&vars,before=&before,caseSensitive=&caseSensitive,res=&tres);%let result=&&&tres;
	%assertEqual(a=&e,b=&result);


	%let vars=a b B C c c D e;
	%let before=c;
	%let caseSensitive=0;
	%let e=a b B;
	%varsbefore(vars=&vars,before=&before,caseSensitive=&caseSensitive,res=&tres);%let result=&&&tres;
	%assertEqual(a=&e,b=&result);


	%let vars=;
	%let before=c;
	%let caseSensitive=0;
	%let e=;
	%varsbefore(vars=&vars,before=&before,caseSensitive=&caseSensitive,res=&tres);%let result=&&&tres;
	%assertEqual(a=&e,b=&result);

	
	%let vars=a b c d e f;
	%let before=;
	%let caseSensitive=0;
	%let e=;
	%varsbefore(vars=&vars,before=&before,caseSensitive=&caseSensitive,res=&tres);%let result=&&&tres;
	%assertEqual(a=&e,b=&result);


	%let vars=a b c d e f;
	%let before=x;
	%let caseSensitive=0;
	%let e=;
	%varsbefore(vars=&vars,before=&before,caseSensitive=&caseSensitive,res=&tres);%let result=&&&tres;
	%assertEqual(a=&e,b=&result);


	%let vars=a b c d e f;
	%let before=D;
	%let caseSensitive=1;
	%let e=;
	%varsbefore(vars=&vars,before=&before,caseSensitive=&caseSensitive,res=&tres);%let result=&&&tres;
	%assertEqual(a=&e,b=&result);

%mend;

%test_varsbefore;

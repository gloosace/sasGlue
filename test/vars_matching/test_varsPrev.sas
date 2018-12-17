

%macro test_varsPrev;

	%local tres;%let tres=%createTempVar;%local &tres;
	%local vars var result desc e;

	%let vars=a b c d e;
	%let var=c;
	%let caseSensitive=0;
	%let e=b;
	%varsPrev(vars=&vars,var=&var,caseSensitive=&caseSensitive,res=&tres);%let result=&&&tres;
	%assertEqual(a=&e,b=&result);

	%let vars=a b c d e;
	%let var=%str( c );
	%let caseSensitive=0;
	%let e=b;
	%varsPrev(vars=&vars,var=&var,caseSensitive=&caseSensitive,res=&tres);%let result=&&&tres;
	%assertEqual(a=&e,b=&result);

	%let vars=a b B C c c D e;
	%let var=c;
	%let caseSensitive=1;
	%let e=C;
	%varsPrev(vars=&vars,var=&var,caseSensitive=&caseSensitive,res=&tres);%let result=&&&tres;
	%assertEqual(a=&e,b=&result);


	%let vars=a b B C c c D e;
	%let var=c;
	%let caseSensitive=0;
	%let e=B;
	%varsPrev(vars=&vars,var=&var,caseSensitive=&caseSensitive,res=&tres);%let result=&&&tres;
	%assertEqual(a=&e,b=&result);


	%let vars=;
	%let var=c;
	%let caseSensitive=0;
	%let e=;
	%varsPrev(vars=&vars,var=&var,caseSensitive=&caseSensitive,res=&tres);%let result=&&&tres;
	%assertEqual(a=&e,b=&result);

	
	%let vars=a b c d e f;
	%let var=;
	%let caseSensitive=0;
	%let e=;
	%varsPrev(vars=&vars,var=&var,caseSensitive=&caseSensitive,res=&tres);%let result=&&&tres;
	%assertEqual(a=&e,b=&result);


	%let vars=a b c d e f;
	%let var=x;
	%let caseSensitive=0;
	%let e=;
	%varsPrev(vars=&vars,var=&var,caseSensitive=&caseSensitive,res=&tres);%let result=&&&tres;
	%assertEqual(a=&e,b=&result);


	%let vars=a b c d e f;
	%let var=D;
	%let caseSensitive=1;
	%let e=;
	%varsPrev(vars=&vars,var=&var,caseSensitive=&caseSensitive,res=&tres);%let result=&&&tres;
	%assertEqual(a=&e,b=&result);

%mend;

%test_varsPrev;

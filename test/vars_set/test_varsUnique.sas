

%macro test_varsUnique;
	%lbreak(%getInvoker);
	%local a b exp case;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let a=%str(a b c);
	%let case=0;
	%let exp=%str(A B C);
	%varsUnique(vars=&a,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsUnique(vars=&a,caseSensitive=&case,res=&tres)));

	%let a=%str(a b c d a b a b);
	%let case=0;
	%let exp=%str(A B C D);
	%varsUnique(vars=&a,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsUnique(vars=&a,caseSensitive=&case,res=&tres)));

	%let a=%quote(a=1 b=2 c=3 a=-1 b=2 c=3);
	%let case=0;
	%let exp=%quote(A=-1 A=1 B=2 C=3);
	%varsUnique(vars=&a,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsUnique(vars=&a,caseSensitive=&case,res=&tres)));

	%let a=%str(a=1 b=2 c=3 A=1 A=-1 B=3);
	%let case=0;
	%let exp=%str(A=-1 A=1 B=2 B=3 C=3);
	%varsUnique(vars=&a,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsUnique(vars=&a,caseSensitive=&case,res=&tres)));

	%let a=%str(a=1 b=2 c=3 A=1 A=-1 B=3);
	%let case=1;
	%let exp=%str(A=-1 A=1 B=3 a=1 b=2 c=3);
	%varsUnique(vars=&a,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsUnique(vars=&a,caseSensitive=&case,res=&tres)));

	%let a=%str(a='1' b=2 B=' abc ' b=' ABC ');
	%let case=0;
	%let exp=%str(A='1' B=' ABC ' B=2);
	%varsUnique(vars=&a,caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsUnique(vars=&a,caseSensitive=&case,res=&tres)));

	%let a=abc a;
	%let case=0;
	%let exp=A ABC;
	%varsUnique(vars=%quote(&a),caseSensitive=&case,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsUnique(vars=&a,caseSensitive=&case,res=&tres)));

%mend;

%macro test_varsUnique_performance;

	%lbreak(%getInvoker);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local i;
	%local var vars;


	%do i=1 %to 100;
		%let var=var&i;
		%let vars=&vars &var;
	%end;

	%linfo(&vars);

	%linfo(start);
	%varsUnique(vars=&vars,res=&tres);
	%linfo(finish);

%mend;

%test_varsUnique;
%test_varsUnique_performance;

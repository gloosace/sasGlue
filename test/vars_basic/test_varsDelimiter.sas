
%macro test_varsDelimiter;

	%local tres;%let tres=%createTempVar;%local &tres;
	%local vars new old modifier;

	%let vars=%str(a b c);
	%let new=%str(,);
	%let old=;
	%let modifier=;
	%let e=%str(a,b,c);
	%varsDelimiter(vars=&vars,new=&new,old=&old,modifier=&modifier,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);

	%let vars=%str(a b  c);
	%let new=%str(,);
	%let old=;
	%let modifier=QMS;
	%let e=%str(a,b,,c);
	%varsDelimiter(vars=&vars,new=&new,old=&old,modifier=&modifier,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);

	%let vars=%str(a b   c);
	%let new=%str(|);
	%let old=;
	%let modifier=QS;
	%let e=%str(a|b|c);
	%varsDelimiter(vars=&vars,new=&new,old=&old,modifier=&modifier,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);

	%let vars=%str(a_b___c);
	%let new=%str(|);
	%let old=%str(_);
	%let modifier=;
	%let e=%str(a|b|c);
	%varsDelimiter(vars=&vars,new=&new,old=&old,modifier=&modifier,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);

	%let vars=%str(a b c);
	%let new=;
	%let old=;
	%let modifier=;
	%let e=%str(abc);
	%varsDelimiter(vars=&vars,new=&new,old=&old,modifier=&modifier,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);

	%let vars=%str(a_b__c);
	%let new=%str(,);
	%let old=%str(_);
	%let modifier=QMS;
	%let e=%str(a,b,,c);
	%varsDelimiter(vars=&vars,delimiter=&new,oldDelimiter=&old,oldModifier=&modifier,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r)

%mend;

%test_varsDelimiter;

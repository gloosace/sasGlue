
data t;
	a=1;b=2;c=3;d=4;
run;

%macro test_dsVarExist;
	%local run res;

	%let run=%nrquote(%%dsVarExist(t,a));
	%let res=%unquote(&run);
	%assertEqual(a=1,b=&res,msg=&run);

	%let run=%nrquote(%%dsVarExist(t,b));
	%let res=%unquote(&run);
	%assertEqual(a=1,b=&res,msg=&run);

	%let run=%nrquote(%%dsVarExist(t,xxxxx));
	%let res=%unquote(&run);
	%assertEqual(a=0,b=&res,msg=&run);


	%let run=%nrquote(%%dsVarExist(t,yyyyy));
	%let res=%unquote(&run);
	%assertEqual(a=0,b=&res,msg=&run);

%mend;

%test_dsVarExist;


data t;
		infile datalines dsd; 
		input id $ type $ dateStr $ state $ value;
		date=input(dateStr,B8601DA8.);
		datalines;
	101,A,20150101,ok,101
	101,A,20150221,pastdue,101
	101,A,20150221,pastdue,101
	101,B,20150223,pastdue,101
	102,A,20150216,pastdue,101
	102,B,20150216,pastdue,102
	102,B,20150217,pastdue,103
	;
run;


%macro test_dsExist;
	%local input r;

	%let input=t;
	%let r=%dsExist(&input);
	%assertEqual(a=1,b=&r,msg=input:&input);

	%let input=work.t;
	%let r=%dsExist(&input);
	%assertEqual(a=1,b=&r,msg=input:&input);

	%let input=work.abc;
	%let r=%dsExist(&input);
	%assertEqual(a=0,b=&r,msg=input:&input);

	%let input=notexistlib.t;
	%let r=%dsExist(&input);
	%assertEqual(a=0,b=&r,msg=input:&input);

%mend;

%macro test_getDsObs;
	%local input r;

	%let input=%str(id='101');
	%getDsObs(ds=t,where=%str(id='101'),res=r);
	%assertEqual(a=4,b=&r,msg=getDsObs where:&input);

	%let input=%str(type='A');
	%getDsObs(ds=t,where=%str(type='A'),res=r);
	%assertEqual(a=4,b=&r,msg=getDsObs where:&input);

	%let input=%str(id='333');
	%getDsObs(ds=t,where=%str(id='333'),res=r);
	%assertEqual(a=0,b=&r,msg=getDsObs where:&input);
%mend;




%test_dsExist;
%test_getDsObs;



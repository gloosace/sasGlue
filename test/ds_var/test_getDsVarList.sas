
data t;
		infile datalines dsd; 
		input name $ type $ dateStr $ state $;
		date=input(dateStr,B8601DA8.);
		datalines;
	100,A,20150101,ok
	100,A,20150221,error
	100,A,20150406,ok
	100,A,20150611,ok
	;
run;

%macro test_getDsVarList;
	%local tres;%let tres=%createTempVar;%local &tres;
	
	%local data cmd r;

	%let data=t;
	%let cmd=%nrquote(%%getDsVarList(ds=&data,res=&tres));
	%unquote(&cmd);
	%let r=&&&tres;
	%put  [&cmd] 	[result=&r];

	%let data=t;
	%let cmd=%nrquote(%%getDsVarList(data=&data,res=&tres));
	%unquote(&cmd);
	%let r=&&&tres;
	%put  [&cmd] 	[result=&r];

	%let data=t;
	%let cmd=%nrquote(%%getDsNumVarList(ds=&data,res=&tres));
	%unquote(&cmd);
	%let r=&&&tres;
	%put  [&cmd] 	[result=&r];

	%let data=t;
	%let cmd=%nrquote(%%getDsNumVarList(data=&data,res=&tres));
	%unquote(&cmd);
	%let r=&&&tres;
	%put  [&cmd] 	[result=&r];


	%let data=t;
	%let cmd=%nrquote(%%getDsStrVarList(ds=&data,res=&tres));
	%unquote(&cmd);
	%let r=&&&tres;
	%put  [&cmd] 	[result=&r];

	%let data=t;
	%let cmd=%nrquote(%%getDsStrVarList(data=&data,res=&tres));
	%unquote(&cmd);
	%let r=&&&tres;
	%put  [&cmd] 	[result=&r];


	%let data=t;
	%let cmd=%nrquote(%%getDsVarType(data=&data,var=dateStr,res=&tres));
	%unquote(&cmd);
	%let r=&&&tres;
	%put  [&cmd] 	[result=&r];


	%let data=t;
	%let cmd=%nrquote(%%getDsVarType(data=&data,var=date,res=&tres));
	%unquote(&cmd);
	%let r=&&&tres;
	%put  [&cmd] 	[result=&r];

	%let data=t;
	%let cmd=%nrquote(%%getDsVarType(data=&data,var=notexist,res=&tres));
	%unquote(&cmd);
	%let r=&&&tres;
	%put  [&cmd] 	[result=&r];

%mend;


%test_getDsVarList;

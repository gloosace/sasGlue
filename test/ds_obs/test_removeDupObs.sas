
data t;
		infile datalines dsd; 
		input id $ type $ dateStr $ state $ value;
		date=input(dateStr,B8601DA8.);
		datalines;
	101,A,20150101,ok,101
	101,A,20150221,pastdue,101
	101,A,20150216,pastdue,101
	102,A,20150216,pastdue,102
	103,A,20150216,pastdue,103
	;
run;

data r;
		infile datalines dsd; 
		input id $ type $ dateStr $ state $ value;
		date=input(dateStr,B8601DA8.);
		datalines;
	101,A,20150101,ok,101
	102,A,20150216,pastdue,102
	103,A,20150216,pastdue,103
	;
run;

data dr;
		infile datalines dsd; 
		input id $ type $ dateStr $ state $ value;
		date=input(dateStr,B8601DA8.);
		datalines;
	101,A,20150221,pastdue,101
	101,A,20150216,pastdue,101
	;
run;

data t;
		infile datalines dsd; 
		input id $ type $ dateStr $ state $ value;
		date=input(dateStr,B8601DA8.);
		datalines;
	101,A,20150101,ok,101
	101,A,20150221,pastdue,101
	101,A,20150216,pastdue,101
	102,A,20150216,pastdue,102
	103,A,20150216,pastdue,103
	;
run;

data r2;
		infile datalines dsd; 
		input id $ type $ dateStr $ state $ value;
		date=input(dateStr,B8601DA8.);
		datalines;
	101,A,20150221,pastdue,101
	102,A,20150216,pastdue,102
	103,A,20150216,pastdue,103
	;
run;

data dr2;
		infile datalines dsd; 
		input id $ type $ dateStr $ state $ value;
		date=input(dateStr,B8601DA8.);
		datalines;
	101,A,20150101,ok,101
	101,A,20150216,pastdue,101
	;
run;

data t;
		infile datalines dsd; 
		input id $ type $ dateStr $ state $ value;
		date=input(dateStr,B8601DA8.);
		datalines;
	101,A,20150101,ok,101
	101,A,20150221,pastdue,101
	101,A,20150216,pastdue,101
	102,A,20150216,pastdue,102
	103,A,20150216,pastdue,103
	;
run;

data r3;
		infile datalines dsd; 
		input id $ type $ dateStr $ state $ value;
		date=input(dateStr,B8601DA8.);
		datalines;
	102,A,20150216,pastdue,102
	103,A,20150216,pastdue,103
	;
run;

data dr3;
		infile datalines dsd; 
		input id $ type $ dateStr $ state $ value;
		date=input(dateStr,B8601DA8.);
		datalines;
	101,A,20150101,ok,101
	101,A,20150221,pastdue,101
	101,A,20150216,pastdue,101
	;
run;

%macro test_removeDupObs;
	%local tres;%let tres=%createTempVar;%local &tres;
	
	%local e r cmd desc;
	%local data out dupOut targetOut keySort dupSort keep;

	%let out=%createTempDs;
	%let dupOut=%createTempDs;

	%let data=t;
	%let targetOut=r;
	%let targetDupOut=dr;
	%let keySort=id type;
	%let dupSort=date;
	%let cmd=%nrquote(%%removeDupObs(data=&data,out=&out,dupOut=&dupOut,key=&keySort,dupSort=&dupSort));
	%let desc=;
	%unquote(&cmd);
	%assertDsEqual(a=&out,b=&targetOut,msg=&cmd &desc);
	%assertDsEqual(a=&dupOut,b=&targetDupOut,msg=&cmd &desc);

	%let data=t;
	%let targetOut=r2;
	%let targetDupOut=dr2;
	%let keySort=id type;
	%let dupSort=descending date;
	%let cmd=%nrquote(%%removeDupObs(data=&data,out=&out,dupOut=&dupOut,keySort=&keySort,dup=&dupSort));
	%let desc=;
	%unquote(&cmd);
	%assertDsEqual(a=&out,b=&targetOut,msg=&cmd &desc);
	%assertDsEqual(a=&dupOut,b=&targetDupOut,msg=&cmd &desc);

	%let data=t;
	%let targetOut=r;
	%let targetDupOut=dr;
	%let keySort=id type;
	%let dupSort=descending date;
	%let keep=LAST;
	%let cmd=%nrquote(%%removeDupObs(data=&data,out=&out,dupOut=&dupOut,key=&keySort,dupSort=&dupSort,keep=&keep));
	%let desc=;
	%unquote(&cmd);
	%assertDsEqual(a=&out,b=&targetOut,msg=&cmd &desc);
	%assertDsEqual(a=&dupOut,b=&targetDupOut,msg=&cmd &desc);

	%let data=t;
	%let targetOut=r3;
	%let targetDupOut=dr3;
	%let keySort=id type;
	%let dupSort=descending date;
	%let keep=NONE;
	%let cmd=%nrquote(%%removeDupObs(data=&data,out=&out,dupOut=&dupOut,keySort=&keySort,dup=&dupSort,keep=&keep));
	%let desc=;
	%unquote(&cmd);
	%assertDsEqual(a=&out,b=&targetOut,msg=&cmd &desc);
	%assertDsEqual(a=&dupOut,b=&targetDupOut,msg=&cmd &desc);

	%dropDs(&data);
	%dropDs(&dupOut);

%mend;

%test_removeDupObs;


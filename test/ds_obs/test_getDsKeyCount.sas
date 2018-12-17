
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


%macro test_getDsKeyCount;
	%local tres;%let tres=%createTempVar;%local &tres;
	
	%local e r cmd desc;
	%local data key;

	%let out=%createTempDs;
	%let dupOut=%createTempDs;

	%let data=t;
	%let e=4;
	%let key=id type;
	%let cmd=%nrquote(%%getDsKeyCount(data=&data,key=&key,res=&tres));
	%let desc=;
	%unquote(&cmd);
	%let r=&&&tres;
	%assertEqual(a=&e,b=&r,msg=&cmd &desc);
	

	%let data=t;
	%let e=5;
	%let key=date;
	%let cmd=%nrquote(%%getDsKeyCount(data=&data,key=&key,res=&tres));
	%let desc=;
	%unquote(&cmd);
	%let r=&&&tres;
	%assertEqual(a=&e,b=&r,msg=&cmd &desc);
%mend;

%test_getDsKeyCount;

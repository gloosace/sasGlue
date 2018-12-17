

data t;
	infile datalines dsd; 
	input id $ type $ dateStr $ state $ value;
	startTime=input(dateStr,B8601DA8.);
	datalines;
101,A,20150101,ok,1
102,A,20150221,pastdue,2
103,A,20150406,ok,3
104,A,20150611,ok,4
105,B,20150101,ok,1
106,B,20150221,pastdue,2
107,B,20150406,ok,3
108,B,20150611,ok,4
109,C,20140201,ok,1
110,C,20150721,ok,2
111,C,20160406,ok,3
;
run;

data f;
	infile datalines dsd; 
	input type $ ;
	datalines;
B
C
;
run;


data e_o;
	infile datalines dsd; 
	input id $ type $ dateStr $ state $ value;
	startTime=input(dateStr,B8601DA8.);
	datalines;
101,A,20150101,ok,1
102,A,20150221,pastdue,2
103,A,20150406,ok,3
104,A,20150611,ok,4
;
run;

data e_oc;
	infile datalines dsd; 
	input id $ type $ dateStr $ state $ value;
	startTime=input(dateStr,B8601DA8.);
	datalines;
105,B,20150101,ok,1
106,B,20150221,pastdue,2
107,B,20150406,ok,3
108,B,20150611,ok,4
109,C,20140201,ok,1
110,C,20150721,ok,2
111,C,20160406,ok,3
;
run;



data f2;
	infile datalines dsd; 
	input dateStr $ ;
	startTime=input(dateStr,B8601DA8.);
	datalines;
20150101
20150221
;
run;

data e_o2;
	infile datalines dsd; 
	input id $ type $ dateStr $ state $ value;
	startTime=input(dateStr,B8601DA8.);
	datalines;
103,A,20150406,ok,3
104,A,20150611,ok,4
107,B,20150406,ok,3
108,B,20150611,ok,4
109,C,20140201,ok,1
110,C,20150721,ok,2
111,C,20160406,ok,3
;
run;

data e_oc2;
	infile datalines dsd; 
	input id $ type $ dateStr $ state $ value;
	startTime=input(dateStr,B8601DA8.);
	datalines;
101,A,20150101,ok,1
102,A,20150221,pastdue,2
105,B,20150101,ok,1
106,B,20150221,pastdue,2
;
run;


data f3;
	infile datalines dsd; 
	input type $ dateStr $ ;
	startTime=input(dateStr,B8601DA8.);
	datalines;
A,20150101
B,20150221
;
run;

data e_o3;
	infile datalines dsd; 
	input id $ type $ dateStr $ state $ value;
	startTime=input(dateStr,B8601DA8.);
	datalines;
102,A,20150221,pastdue,2
103,A,20150406,ok,3
104,A,20150611,ok,4
105,B,20150101,ok,1
107,B,20150406,ok,3
108,B,20150611,ok,4
109,C,20140201,ok,1
110,C,20150721,ok,2
111,C,20160406,ok,3
;
run;

data e_oc3;
	infile datalines dsd; 
	input id $ type $ dateStr $ state $ value;
	startTime=input(dateStr,B8601DA8.);
	datalines;
101,A,20150101,ok,1
106,B,20150221,pastdue,2
;
run;

data f4;
	infile datalines dsd; 
	input type $ dateStr $ ;
	startTime=input(dateStr,B8601DA8.);
	datalines;
A,20150101
B,20150221
;
run;

data f5;
	infile datalines dsd; 
	input type $ dateStr $ desc $;
	startTime=input(dateStr,B8601DA8.);
	datalines;
A,20150101,hahaha
B,20150221,desc
;
run;

data e_o5;
	infile datalines dsd; 
	input id $ type $ dateStr $ state $ value desc $;
	startTime=input(dateStr,B8601DA8.);
	datalines;
101,A,20150101,ok,1,hahaha
106,B,20150221,pastdue,2,desc
;
run;

data e_oc5;
	infile datalines dsd; 
	input id $ type $ dateStr $ state $ value desc $;
	startTime=input(dateStr,B8601DA8.);
	datalines;
102,A,20150221,pastdue,2,
103,A,20150406,ok,3,
104,A,20150611,ok,4,
105,B,20150101,ok,1,
107,B,20150406,ok,3,
108,B,20150611,ok,4,
109,C,20140201,ok,1,
110,C,20150721,ok,2,
111,C,20160406,ok,3,
;
run;
proc sql;
	create index _INDEX_ on f4 (startTime,type);
quit;


%macro test_filter;
	%local tres;%let tres=%createTempVar;%local &tres;

	%clearOutput;

	%let cmd=%nrquote(%%filter(data=t,filter=f,out=o,outComp=oc,indexVar=type));
	%unquote(&cmd);

	%let desc=%quote(BLACKLIST KEY=STRING VAR);
	%assertDsEqual(a=o,b=e_o,msg=out &desc &cmd);
	%assertDsEqual(a=oc,b=e_oc,msg=outComp &desc &cmd);

	%let cmd=%nrquote(%%filter(data=t,filter=f,out=o,outComp=oc,indexVar=type,isBlacklist=0));
	%unquote(&cmd);
	%let desc=%quote(WHITELIST KEY=STRING VAR);
	%assertDsEqual(a=o,b=e_oc,msg=out &desc &cmd);
	%assertDsEqual(a=oc,b=e_o,msg=outComp &desc &cmd);

	%let cmd=%nrquote(%%filter(data=t,filter=f2,out=o,outComp=oc,indexVar=startTime));
	%unquote(&cmd);
	%let desc=%quote(BLACKLIST KEY=NUMERIC VAR);
	%assertDsEqual(a=o,b=e_o2,msg=out &desc &cmd);
	%assertDsEqual(a=oc,b=e_oc2,msg=outComp &desc &cmd);

	%let cmd=%nrquote(%%filter(data=t,filter=f2,out=o,outComp=oc,indexVar=startTime,isBlackList=0));
	%unquote(&cmd);
	%let desc=%quote(WHITELIST KEY=NUMERIC VAR);
	%assertDsEqual(a=o,b=e_oc2,msg=out &desc &cmd);
	%assertDsEqual(a=oc,b=e_o2,msg=outComp &desc &cmd);

	%let cmd=%nrquote(%%filter(data=t,filter=f3,out=o,outComp=oc,indexVar=type startTime));
	%unquote(&cmd);
	%let desc=%quote(BLACKLIST KEY=MULTI VARS);
	%assertDsEqual(a=o,b=e_o3,msg=out &desc &cmd);
	%assertDsEqual(a=oc,b=e_oc3,msg=outComp &desc &cmd);

	%let cmd=%nrquote(%%filter(data=t,filter=f3,out=o,outComp=oc,indexVar=startTime type,isBlackList=0));
	%unquote(&cmd);
	%let desc=%quote(WHITELIST KEY=MULTI VARS);
	%assertDsEqual(a=o,b=e_oc3,msg=out &desc &cmd);
	%assertDsEqual(a=oc,b=e_o3,msg=outComp &desc &cmd);

	%let cmd=%nrquote(%%filter(data=t,filter=f4,out=o,outComp=oc,indexVar=startTime type));
	%unquote(&cmd);
	%let desc=%quote(WHITELIST KEY=MULTI VARS NOKEEP);
	%assertDsEqual(a=o,b=e_o3,msg=out &desc &cmd);
	%assertDsEqual(a=oc,b=e_oc3,msg=outComp &desc &cmd);

	%let cmd=%nrquote(%%filter(data=t,filter=f5,out=o,outComp=oc,indexVar=startTime type,keep=desc,isBlacklist=0));
	%unquote(&cmd);
	%let desc=%quote(WHITELIST KEY=MULTI VARS KEEP=DESC);
	%assertDsEqual(a=o,b=e_o5,msg=out &desc &cmd);
	%assertDsEqual(a=oc,b=e_oc5,msg=outComp &desc &cmd);

%mend;

data t2;
	infile datalines dsd; 
	input id $ type $ dateStr $ state $ value;
	startTime=input(dateStr,B8601DA8.);
	datalines;
101,A,20150101,ok,1
102,A,20150221,pastdue,2
103,A,20150221,ok,6
104,A,20150406,ok,3
105,A,20150611,ok,4
106,B,20150101,ok,1
107,B,20150221,pastdue,2
108,B,20150406,ok,3
109,B,20150611,ok,4
110,C,20140201,ok,1
111,C,20150721,ok,2
112,C,20160406,ok,3
;
run;

data f6;
	infile datalines dsd; 
	input id $ type $ dateStr $ state $ value desc $;
	startTime=input(dateStr,B8601DA8.);
	datalines;
F1,A,20150101,xxx,888,obs f1
F2,A,20150221,xxx,999,obs f2
F3,B,20150221,xxx,666,obs f3
F4,C,20160406,xxx,777,obs f4
;
run;

data e_o6;
	infile datalines dsd; 
	input id $ type $ dateStr $ state $ value desc $;
	startTime=input(dateStr,B8601DA8.);
	datalines;
101,A,20150101,ok,888,obs f1
102,A,20150221,pastdue,999,obs f2
103,A,20150221,ok,999,obs f2
107,B,20150221,pastdue,666,obs f3
112,C,20160406,ok,777,obs f4
;
run;

data e_oc6;
	infile datalines dsd; 
	input id $ type $ dateStr $ state $ value desc $;
	startTime=input(dateStr,B8601DA8.);
	datalines;
104,A,20150406,ok,3,
105,A,20150611,ok,4,
106,B,20150101,ok,1,
108,B,20150406,ok,3,
109,B,20150611,ok,4,
110,C,20140201,ok,1,
111,C,20150721,ok,2,
;
run;

data f7;
	infile datalines dsd; 
	input id $ type $ dateStr $ state $ value desc $;
	startTime=input(dateStr,B8601DA8.);
	datalines;
F0,A,20150101,ok,888,obs f100
F1,A,20150221,xxx,333,obs f101
F2,A,20150221,xxx,999,obs f102
F3,B,20150221,xxx,666,obs f103
F4,C,20160406,xxx,777,obs f104
;
run;


data e_o7;
	infile datalines dsd; 
	input id $ type $ dateStr $ state $ value desc $;
	startTime=input(dateStr,B8601DA8.);
	datalines;
101,A,20150101,ok,888,obs f100
102,A,20150221,pastdue,333,obs f101
103,A,20150221,ok,333,obs f101
107,B,20150221,pastdue,666,obs f103
112,C,20160406,ok,777,obs f104
;
run;

data e_oc7;
	infile datalines dsd; 
	input id $ type $ dateStr $ state $ value desc $;
	startTime=input(dateStr,B8601DA8.);
	datalines;
104,A,20150406,ok,3,
105,A,20150611,ok,4,
106,B,20150101,ok,1,
108,B,20150406,ok,3,
109,B,20150611,ok,4,
110,C,20140201,ok,1,
111,C,20150721,ok,2,
;
run;

%macro test_filter_matchMulti;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local cmd desc;

	%let cmd=%nrquote(%%filter(data=t2,filter=f6,out=o,outComp=oc,key=startTime type,keep=value desc,isBlacklist=0));
	%unquote(&cmd);
	%let desc=%quote(WHITELIST ONLY 1 OBS MATCHED);
	%assertDsEqual(a=o,b=e_o6,msg=out &desc &cmd);
	%assertDsEqual(a=oc,b=e_oc6,msg=outComp &desc &cmd);

	%let cmd=%nrquote(%%filter(data=t2,filter=f7,out=o,outComp=oc,key=startTime type,keep=value desc,isBlacklist=0));
	%unquote(&cmd);
	%let desc=%quote(WHITELIST 2 OBS MATCHED);
	%assertDsEqual(a=o,b=e_o7,msg=out &desc &cmd);
	%assertDsEqual(a=oc,b=e_oc7,msg=outComp &desc &cmd);
%mend;

data main_stmt;
	infile datalines dsd; 
	input id $ type $ dateStr $ state $ value;
	startTime=input(dateStr,B8601DA8.);
	datalines;
101,A,20150101,ok,1
102,A,20150221,pastdue,2
103,A,20150406,ok,3
104,A,20150611,ok,4
105,B,20150101,ok,1
106,B,20150221,pastdue,2
107,B,20150406,ok,3
108,B,20150611,ok,4
109,C,20140201,ok,1
110,C,20150721,ok,2
111,C,20160406,ok,3
;
run;

data filter_stmt;
	infile datalines dsd; 
	input type $ desc $;
	datalines;
B,BBB
C,CCC
;
run;


data expect_stmt;
	infile datalines dsd; 
	input id $ type $ dateStr $ state $ value desc $;
	startTime=input(dateStr,B8601DA8.);
	datalines;
101,A,20150101,ok,1,UNMATCHED
102,A,20150221,pastdue,2,UNMATCHED
103,A,20150406,ok,3,UNMATCHED
104,A,20150611,ok,4,UNMATCHED
105,B,20150101,ok,1,MATCHED
106,B,20150221,pastdue,2,MATCHED
107,B,20150406,ok,3,MATCHED
108,B,20150611,ok,4,MATCHED
109,C,20140201,ok,1,MATCHED
110,C,20150721,ok,2,MATCHED
111,C,20160406,ok,3,MATCHED
;
run;

%macro test_filter_matchStmt;

	%filter(data=main_stmt,filter=filter_stmt,key=type,
		keep=desc,
		isBlacklist=0,
		matchStmt=%quote(desc='MATCHED'),
		unmatchStmt=%quote(desc='UNMATCHED'),
		outAll=outAll_stmt);
	%assertDsEqual(a=expect_stmt,b=outAll_stmt,msg=TEST MATCH STMT);

%mend;


%test_filter;
%test_filter_matchMulti;
%test_filter_matchStmt;





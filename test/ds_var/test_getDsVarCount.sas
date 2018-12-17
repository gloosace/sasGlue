


data t;
		infile datalines dsd; 
		input name $ type $ dateStr $ state $;
		date=input(dateStr,B8601DA8.);
		datalines;
	JAME,A,20150101,ok
	NICK,A,20150221,error
	nick, ,20150406, 
	tom , ,20160611,
	    ,X,		   ,ok
	;
run;


%macro test_getDsVarCount;
	%local tres;%let tres=%createTempVar;%local &tres;
	
	%local data cmd r;
	%local vars var varsN i; 


	%let vars=name type dateStr state;
	%let data=t;

	%varsCount(vars=&vars,res=&tres);%let varsN=&&&tres;

	%do i=1 %to &varsN;

		%varsN(vars=&vars,n=&i,res=&tres);%let var=%unquote(&&&tres);

		%put ;
		%put ----------- var=&var ---------;

		%let cmd=%nrquote(%%getDsVarCount(data=&data,var=&var,noNull=0,res=&tres));
		%unquote(&cmd);
		%let r=&&&tres;
		%put  [&cmd] 	[result=&r];


		%let cmd=%nrquote(%%getDsVarCount(data=&data,var=&var,res=&tres));
		%unquote(&cmd);
		%let r=&&&tres;
		%put  [&cmd] 	[result=&r];


		%let cmd=%nrquote(%%getDsVarMax(data=&data,var=&var,res=&tres));
		%unquote(&cmd);
		%let r=&&&tres;
		%put  [&cmd] 	[result=&r];


		%let cmd=%nrquote(%%getDsVarMin(data=&data,var=&var,res=&tres));
		%unquote(&cmd);
		%let r=&&&tres;
		%put  [&cmd] 	[result=&r];
	%end;


	
%mend;

%macro test_getDsVarCount_error;

	%local tres;%let tres=%createTempVar;%local &tres;
	%getDsVarCount(data=t,var=notexist,res=&tres);

%mend;

%macro test_getDsVarMax_error;

	%local tres;%let tres=%createTempVar;%local &tres;
	%getDsVarMax(data=notexist,var=notexist,res=&tres);

%mend;


%macro test_getDsVarMin_error;

	%local tres;%let tres=%createTempVar;%local &tres;
	%getDsVarMin(data=t,var=notexist,res=&tres);

%mend;



%test_getDsVarCount;
%test_getDsVarCount_error;
%test_getDsVarMax_error;
%test_getDsVarMin_error;

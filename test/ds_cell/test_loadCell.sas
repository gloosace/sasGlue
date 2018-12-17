data t;
		infile datalines dsd; 
		input id $ type $ dateStr $ state $ value;
		date=input(dateStr,B8601DA8.);
		datalines;
	101,A,20150101,ok,101
	101,A,20150221,pastdue,102
	101,A,20150221,pastdue,103
	101,B,20150223,pastdue,104
	102,A,20150216,pastdue,105
	102,B,20150216,pastdue,106
	102, ,20150217,ok,107
	;
run;


%macro test_loadCell;

	%local tres;%let tres=%createTempVar;%local &tres;

	%local keyVar keyValue var where result;

	%put load by id;
	%let keyVar=id;
	%let keyValue=102;
	%let where=;

	%lbreak(%quote(key=id));

	%let var=date;
	%loadCell(data=t,keyVar=&keyVar,keyValue=&keyValue,var=&var,where=&where,res=&tres);%let result=&&&tres;
	%put keyVar=&keyVar keyValue=&keyValue : &var=&result;

	%let var=dateStr;
	%loadCell(data=t,keyVar=&keyVar,keyValue=&keyValue,var=&var,where=&where,res=&tres);%let result=&&&tres;
	%put keyVar=&keyVar keyValue=&keyValue : &var=&result;

	%let var=value;
	%loadCell(data=t,keyVar=&keyVar,keyValue=&keyValue,var=&var,where=&where,res=&tres);%let result=&&&tres;
	%put keyVar=&keyVar keyValue=&keyValue : &var=&result;

	%lbreak(%quote(key=null));
	%let keyVar=;
	%let keyValue=;
	%let where=;

	%let var=date;
	%loadCell(data=t,keyVar=&keyVar,keyValue=&keyValue,var=&var,where=&where,res=&tres);%let result=&&&tres;
	%put keyVar=&keyVar keyValue=&keyValue : &var=&result;

	%let var=dateStr;
	%loadCell(data=t,keyVar=&keyVar,keyValue=&keyValue,var=&var,where=&where,res=&tres);%let result=&&&tres;
	%put keyVar=&keyVar keyValue=&keyValue : &var=&result;

	%let var=value;
	%loadCell(data=t,keyVar=&keyVar,keyValue=&keyValue,var=&var,where=&where,res=&tres);%let result=&&&tres;
	%put keyVar=&keyVar keyValue=&keyValue : &var=&result;

	
	%lbreak(%quote(where));;
	%let keyVar=;
	%let keyValue=;
	%let where=%quote(state='pastdue');

	%let var=date;
	%loadCell(data=t,keyVar=&keyVar,keyValue=&keyValue,var=&var,where=&where,res=&tres);%let result=&&&tres;
	%put keyVar=&keyVar keyValue=&keyValue : &var=&result;

	%let var=dateStr;
	%loadCell(data=t,keyVar=&keyVar,keyValue=&keyValue,var=&var,where=&where,res=&tres);%let result=&&&tres;
	%put keyVar=&keyVar keyValue=&keyValue : &var=&result;

	%let var=value;
	%loadCell(data=t,keyVar=&keyVar,keyValue=&keyValue,var=&var,where=&where,res=&tres);%let result=&&&tres;
	%put keyVar=&keyVar keyValue=&keyValue : &var=&result;


	%lbreak(%quote(key + where));
	%let keyVar=id;
	%let keyValue=102;
	%let where=%quote(state='ok');

	%let var=date;
	%loadCell(data=t,keyVar=&keyVar,keyValue=&keyValue,var=&var,where=&where,res=&tres);%let result=&&&tres;
	%put keyVar=&keyVar keyValue=&keyValue : &var=&result;

	%let var=dateStr;
	%loadCell(data=t,keyVar=&keyVar,keyValue=&keyValue,var=&var,where=&where,res=&tres);%let result=&&&tres;
	%put keyVar=&keyVar keyValue=&keyValue : &var=&result;

	%let var=value;
	%loadCell(data=t,keyVar=&keyVar,keyValue=&keyValue,var=&var,where=&where,res=&tres);%let result=&&&tres;
	%put keyVar=&keyVar keyValue=&keyValue : &var=&result;

	%lbreak(%quote(multi keys));
	%let keyVar=id type;
	%let keyValue=102 A;
	%let where=;

	%let var=date;
	%loadCell(data=t,keyVar=&keyVar,keyValue=&keyValue,var=&var,where=&where,res=&tres);%let result=&&&tres;
	%put keyVar=&keyVar keyValue=&keyValue : &var=&result;

	%let var=dateStr;
	%loadCell(data=t,keyVar=&keyVar,keyValue=&keyValue,var=&var,where=&where,res=&tres);%let result=&&&tres;
	%put keyVar=&keyVar keyValue=&keyValue : &var=&result;

	%let var=value;
	%loadCell(data=t,keyVar=&keyVar,keyValue=&keyValue,var=&var,where=&where,res=&tres);%let result=&&&tres;
	%put keyVar=&keyVar keyValue=&keyValue : &var=&result;


%mend;


%test_loadCell;

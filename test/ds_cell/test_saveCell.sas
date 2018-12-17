data t;
		infile datalines dsd; 
		input id $ type $ dateStr $ state $ value;
		date=input(dateStr,B8601DA8.);
		drop date;
		datalines;
	101,A,20150101,ok,101
	101,A,20150221,pastdue,102
	101,A,20150221,pastdue,103
	101,B,20150223,pastdue,104
	102,A,20150216,pastdue,105
	102,B,20150216,pastdue,106
	102,B,20150217,ok,107
	;
run;


%macro test_saveCell;

	%local tres;%let tres=%createTempVar;%local &tres;

	%local keyVar keyValue var where result;

	%print(data=t,title=%quote(RAW DATA));

	%let desc=batch update string;
	%let keyVar=id;
	%let keyValue=102;
	%let var=state;
	%let value=new;
	%let where=;

	%copyDs(data=t,out=tt);
	%saveCell(data=tt,keyVar=&keyVar,keyValue=&keyValue,var=&var,value=&value,where=&where,res=&tres);%let result=&&&tres;
	%print(data=tt,title=%quote(&desc result=&result));


	%let desc=batch update number;
	%let keyVar=id;
	%let keyValue=102;
	%let var=state value;
	%let value=new 6666;
	%let where=;

	%copyDs(data=t,out=tt);
	%saveCell(data=tt,keyVar=&keyVar,keyValue=&keyValue,var=&var,value=&value,where=&where,res=&tres);%let result=&&&tres;
	%print(data=tt,title=%quote(&desc result=&result));


	%let desc=set null;
	%let keyVar=id;
	%let keyValue=102;
	%let var=value ;
	%let value=.;
	%let where=;

	%copyDs(data=t,out=tt);
	%saveCell(data=tt,keyVar=&keyVar,keyValue=&keyValue,var=&var,value=&value,where=&where,res=&tres);%let result=&&&tres;
	%print(data=tt,title=%quote(&desc result=&result));

	
	%let desc=set empty string ;
	%let keyVar=id;
	%let keyValue=102;
	%let var=state;
	%let value=;
	%let where=;

	%copyDs(data=t,out=tt);
	%saveCell(data=tt,keyVar=&keyVar,keyValue=&keyValue,var=&var,value=&value,where=&where,res=&tres);%let result=&&&tres;
	%print(data=tt,title=%quote(&desc result=&result));


	%let desc=where stmt;
	%let keyVar=id;
	%let keyValue=102;
	%let var=state;
	%let value=new;
	%let where=%quote(datestr='20150217');

	%copyDs(data=t,out=tt);
	%saveCell(data=tt,keyVar=&keyVar,keyValue=&keyValue,var=&var,value=&value,where=&where,res=&tres);%let result=&&&tres;
	%print(data=tt,title=%quote(&desc result=&result));

	%let desc=multi key update;
	%let keyVar=id type;
	%let keyValue=102 B;
	%let var=state;
	%let value=new;
	%let where=;

	%copyDs(data=t,out=tt);
	%saveCell(data=tt,keyVar=&keyVar,keyValue=&keyValue,var=&var,value=&value,where=&where,res=&tres);%let result=&&&tres;
	%print(data=tt,title=%quote(&desc result=&result));

	%let desc=multi key insert;
	%let keyVar=id type;
	%let keyValue=103 A;
	%let var=state;
	%let value=new;
	%let where=;

	%copyDs(data=t,out=tt);
	%saveCell(data=tt,keyVar=&keyVar,keyValue=&keyValue,var=&var,value=&value,where=&where,res=&tres);%let result=&&&tres;
	%print(data=tt,title=%quote(&desc result=&result));

	%let desc=multi keys insert multi vars;
	%let keyVar=id type;
	%let keyValue=104 A;
	%let var=state value;
	%let value=MULTI 9999;
	%let where=;

	%copyDs(data=t,out=tt);
	%saveCell(data=tt,keyVar=&keyVar,keyValue=&keyValue,var=&var,value=&value,where=&where,res=&tres);%let result=&&&tres;
	%print(data=tt,title=%quote(&desc result=&result));

	%let desc=all obs matched;
	%let keyVar=;
	%let keyValue=;
	%let var=state;
	%let value=ALL;
	%let where=;

	%copyDs(data=t,out=tt);
	%saveCell(data=tt,keyVar=&keyVar,keyValue=&keyValue,var=&var,value=&value,where=&where,res=&tres);%let result=&&&tres;
	%print(data=tt,title=%quote(&desc result=&result));


	%let desc=multi key update exceed length limit;
	%let keyVar=id type;
	%let keyValue=102 B;
	%let var=state;
	%let value=12345678901234567890;
	%let where=;

	%copyDs(data=t,out=tt);
	%saveCell(data=tt,keyVar=&keyVar,keyValue=&keyValue,var=&var,value=&value,where=&where,res=&tres);%let result=&&&tres;
	%print(data=tt,title=%quote(&desc result=&result));


%mend;


%macro test_saveCell_err; 

	%local tres;%let tres=%createTempVar;%local &tres;

	%local keyVar keyValue var where result;

	%let desc=err nonexist var;
	%let keyVar=id varnotexist;
	%let keyValue=102 B;
	%let var=state;
	%let value=new;
	%let where=;

	%copyDs(data=t,out=tt);
	%saveCell(data=tt,keyVar=&keyVar,keyValue=&keyValue,var=&var,value=&value,where=&where,res=&tres);%let result=&&&tres;
	%print(data=tt,title=%quote(&desc result=&result));

%mend;

%clearOutput;
%test_saveCell;
%test_saveCell_err;



%clearOutput;

options nonotes;

data t;
		infile datalines dsd; 
		input id $ type $ dateStr $ state $ value;
		date=input(dateStr,B8601DA8.);
		datalines;
	101,A,20150101,ok,1
	102,A,20150221,pastdue,2
	103,A,20150406,ok,3
	104,A,20150611,ok,4
	;
run;

* 顺序不同;
data t2;
		infile datalines dsd; 
		input id $ type $ dateStr $ state $ value;
		date=input(dateStr,B8601DA8.);
		datalines;
	104,A,20150611,ok,4
	101,A,20150101,ok,1
	103,A,20150406,ok,3
	102,A,20150221,pastdue,2
	;
run;

* 变量名称不同但不在比较范围内;
data t3;
		infile datalines dsd; 
		input class $ type $ dateStr $ state $ value;
		date=input(dateStr,B8601DA8.);
		datalines;
	101,A,20150101,ok,1
	102,A,20150221,pastdue,2
	103,A,20150406,ok,3
	104,A,20150611,ok,4
	;
run;

* 观测数量不同;
data t31;
		infile datalines dsd; 
		input id $ type $ dateStr $ state $ value;
		date=input(dateStr,B8601DA8.);
		datalines;
	101,A,20150101,ok,1
	102,A,20150221,pastdue,2
	103,A,20150406,ok,3
	;
run;

* 观测值不同;
data t4;
		infile datalines dsd; 
		input id $ type $ dateStr $ state $ value;
		date=input(dateStr,B8601DA8.);
		datalines;
	101,A,20150101,ok,1
	102,A,20150221,pastdue,2
	103,A,20150406,ok,3
	104,A,20150611,ok,5
	;
run;

data t5;
	do i=1 to 1000000;
		value=i;
		output;
	end;
run;

data t6;
	do i=1 to 1000000;
		value=i;
		output;
	end;
run;

data t7;
	do i=1 to 999999;
		value=i;
		output;
	end;
	i=1000000;
	value=0;
	output;
run;

data t8;
	i=1;
	value=999;
	output;
	do i=2 to 1000000;
		value=i;
		output;
	end;
run;


%macro test_dsSame;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local tres2;%let tres2=%createTempVar;%local &tres2;
	%local a b e r cmd desc;
	

	%let a=t;
	%let b=t2;
	%let e=1;
	%let desc=仅顺序不同;
	%linfo(%quote(----&a vs &b &desc----));
	%dsSame(a=&a,b=&b,res=&tres,err=&tres2,noprint=0);
	%put &e/&&&tres err=&&&tres2;

	
	%let a=t;
	%let b=t3;
	%let e=1;
	%let desc=变量名称不同但不在比较范围内;
	%linfo(%quote(----&a vs &b &desc----));
	%dsSame(a=&a,b=&b,res=&tres,err=&tres2,noprint=0);
	%put &e/&&&tres err=&&&tres2;


	%let a=t;
	%let b=t31;
	%let e=0;
	%let desc=观测数量不同;
	%linfo(%quote(----&a vs &b &desc----));
	%dsSame(a=&a,b=&b,res=&tres,err=&tres2,noprint=0);
	%put &e/&&&tres err=&&&tres2;

	%let a=t;
	%let b=t31;
	%let e=0;
	%let desc=观测数量不同 NOPRINT;
	%linfo(%quote(----&a vs &b &desc----));
	%dsSame(a=&a,b=&b,res=&tres,err=&tres2,noprint=1);
	%put &e/&&&tres err=&&&tres2;

	%let a=t;
	%let b=t4;
	%let e=0;
	%let desc=观测值不同;
	%linfo(%quote(----&a vs &b &desc----));
	%dsSame(a=&a,b=&b,res=&tres,err=&tres2,noprint=0);
	%put &e/&&&tres err=&&&tres2;

	%let a=t;
	%let b=t4;
	%let e=1;
	%let desc=观测值不同但未纳入比较范围;
	%linfo(%quote(----&a vs &b &desc----));
	%dsSame(a=&a,b=&b,res=&tres,vars=id type dateStr state,err=&tres2);
	%put &e/&&&tres err=&&&tres2;

	

	%let a=t5;
	%let b=t6;
	%let e=1;
	%let desc=大数据量比较;
	%linfo(%quote(----&a vs &b &desc----));
	%dsSame(a=&a,b=&b,res=&tres,err=&tres2,noprint=0);
	%put &e/&&&tres err=&&&tres2;
	

	%let a=t5;
	%let b=t7;
	%let e=0;
	%let desc=大数据量比较 最后观测不同;
	%linfo(%quote(----&a vs &b &desc----));
	%dsSame(a=&a,b=&b,res=&tres,err=&tres2,noprint=0);
	%put &e/&&&tres err=&&&tres2;
	

	%let a=t5;
	%let b=t8;
	%let e=0;
	%let desc=大数据量比较 首个观测不同;
	%linfo(%quote(----&a vs &b &desc----));
	%dsSame(a=&a,b=&b,res=&tres,err=&tres2,noprint=0);
	%put &e/&&&tres err=&&&tres2;



%mend;


%test_dsSame;


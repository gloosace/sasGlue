

data test_quoteObj;
	a="a=1 b=2 c='c'";
	b="a=1 b=2 c='c'";
run;


%macro test_quoteObj_err;

	%local tres;%let tres=%createTempVar;%local &tres;
	%local obj;
	
	%lbreak(test_quoteObj_err);
	%loadObj(data=test_quoteObj,res=&tres);%let obj=&&&tres;
	%linfo(&&&obj.a);
	%linfo(&&&obj.b);
	%dropObj(&obj);
%mend;

%macro test_quoteObj_a;

	%local tres;%let tres=%createTempVar;%local &tres;
	%local obj;

	%lbreak(test_quoteObj_a);
	%loadObj(data=test_quoteObj,res=&tres);%let obj=&&&tres;
	%quoteObj(obj=&obj,members=a);
	%linfo(&&&obj.a);
	%linfo(&&&obj.b);
	%dropObj(&obj);
%mend;


%macro test_quoteObj_all;

	%local tres;%let tres=%createTempVar;%local &tres;
	%local obj;

	%lbreak(test_quoteObj_all);
	%loadObj(data=test_quoteObj,res=&tres);%let obj=&&&tres;
	%quoteObj(obj=&obj);
	%linfo(&&&obj.a);
	%linfo(&&&obj.b);
	%dropObj(&obj);
%mend;



%test_quoteObj_err;
%test_quoteObj_a;
%test_quoteObj_all;

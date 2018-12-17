
data t;
	infile datalines dsd; 
	input a b c;
	datalines;
1,10,100
2,20,200
3,30,300
;
run;

data t2;
	infile datalines dsd; 
	input a b d;
	datalines;
4,40,4000
5,50,5000
6,60,6000
;
run;

data t3;
	infile datalines dsd; 
	input a d;
	datalines;
7,7000
8,8000
9,9000
;
run;

data t0;
	infile datalines dsd; 
	input a b c d e f;
	datalines;
;
run;


%clearOutput;


%macro test_concate;
	
	%local cmd;

	%dropDs(tx);

	%let cmd=%nrquote(%%concate(data=t t2 t3,out=temp,mode=ALL));
	%unquote(&cmd);
	%print(data=temp,title=&cmd);

	%let cmd=%nrquote(%%concate(data=t t2 t3,out=temp,mode=ALL,vars=a d));
	%unquote(&cmd);
	%print(data=temp,title=&cmd);

	%let cmd=%nrquote(%%concate(data=t t2 t0 t3,out=temp,mode=ALL));
	%unquote(&cmd);
	%print(data=temp,title=&cmd);

	%let cmd=%nrquote(%%concate(data=t t2 t3,out=temp,mode=FIRST));
	%unquote(&cmd);
	%print(data=temp,title=&cmd);

	%let cmd=%nrquote(%%concate(data=t0 t t2 t3,out=temp,mode=FIRST));
	%unquote(&cmd);
	%print(data=temp,title=&cmd);

	%let cmd=%nrquote(%%concate(data=t t0 t2 t3,out=temp,mode=FIRST));
	%unquote(&cmd);
	%print(data=temp,title=&cmd);

	%let cmd=%nrquote(%%concate(data=t tx t2 t3,out=temp,mode=FIRST));
	%unquote(&cmd);
	%print(data=temp,title=&cmd);

	%let cmd=%nrquote(%%concate(data=t tx t2 t3,out=temp,mode=FIRST,vars=a d));
	%unquote(&cmd);
	%print(data=temp,title=&cmd);
	
	%let cmd=%nrquote(%%concate(data=t t2 t3,out=temp,mode=SAFE));
	%unquote(&cmd);
	%print(data=temp,title=&cmd);

	%let cmd=%nrquote(%%concate(data=t t0 t2 t3,out=temp,mode=SAFE));
	%unquote(&cmd);
	%print(data=temp,title=&cmd);

	%let cmd=%nrquote(%%concate(data=tx t t2 t3,out=temp,mode=SAFE));
	%unquote(&cmd);
	%print(data=temp,title=&cmd);

	%let cmd=%nrquote(%%concate(data=t0 t2 t3,out=temp,mode=SAFE));
	%unquote(&cmd);
	%print(data=temp,title=&cmd);

	%let cmd=%nrquote(%%concate(data=t2 t3 t0,out=temp,mode=SAFE));
	%unquote(&cmd);
	%print(data=temp,title=&cmd);
%mend;

%macro test_concate_dup;

	%let cmd=%nrquote(%%concate(tables=t2 t2 t2,out=temp,mode=SAFE));
	%unquote(&cmd);
	%print(data=temp,title=&cmd);

	%let cmd=%nrquote(%%concate(tables=t t2 t2 t3 t3,out=temp,mode=FIRST));
	%unquote(&cmd);
	%print(data=temp,title=&cmd);
%mend;


data s1;
	a='1234567890';b=1001;output;
	a='1234567890';b=1002;output;
run;

data s2;
	a='123456789012345678901234567890';b=2001;output;
	a='123456789012345678901234567890';b=2002;output;
run;


data s3;
	c='1234567890123456789012345678901234567890';b=3001;output;
	c='1234567890123456789012345678901234567890';b=3002;output;
run;

%macro test_concate_string;

	%concate(data=s1 s2 s3,out=s_out,mode=all);
	%print(data=s_out,title=test_concate_string);
%mend;

%macro test_concate_err;
	%let cmd=%nrquote(%%concate(data=tx t t2 t3,out=temp,mode=FIRST));
	%unquote(&cmd);
	%print(data=temp,title=&cmd);
%mend;


%test_concate;
%test_concate_dup;
%test_concate_string;
%test_concate_err;

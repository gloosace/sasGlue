
data t;
	 a=1;b=2;c=3;d=4;
run;



data t2(index=(a));
	 a=1;b=2;c=3;d=4;
run;


data t3(index=(a b));
	 a=1;b=2;c=3;d=4;
run;


data t4(index=(a b c));
	 a=1;b=2;c=3;d=4;
run;


data t5;
	 a=1;b=2;c=3;d=4;
run;


proc sql;
	create index i1 on t5(a,b);
	create index i2 on t5(a,b,c);
	create index i3 on t5(a,b,c,d);
quit;

%macro test_countIndex;

	%local tres;%let tres=%createTempVar;%local &tres;

	%countIndex(data=t,res=&tres);%put t1 index = &&&tres;
	%countIndex(data=t2,res=&tres);%put t2 index = &&&tres;
	%countIndex(data=t3,res=&tres);%put t3 index = &&&tres;
	%countIndex(data=t4,res=&tres);%put t4 index = &&&tres;
	%countIndex(data=t5,res=&tres);%put t5 index = &&&tres;
%mend;

%test_countIndex;

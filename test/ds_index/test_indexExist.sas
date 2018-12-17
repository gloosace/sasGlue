
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

%macro test_indexExist;

	%local tres;%let tres=%createTempVar;%local &tres;

	%indexExist(data=t,index=a,res=&tres);%put t index a = &&&tres;
	%indexExist(data=t,index=a,res=&tres);%put t index d = &&&tres;

	%indexExist(data=t2,index=a,res=&tres);%put t2 index a= &&&tres;
	%indexExist(data=t2,index=d,res=&tres);%put t2 index d= &&&tres;

	%indexExist(data=t3,index=a,res=&tres);%put t3 index a= &&&tres;
	%indexExist(data=t3,index=d,res=&tres);%put t3 index a= &&&tres;

	%indexExist(data=t4,index=a,res=&tres);%put t4 index a= &&&tres;
	%indexExist(data=t4,index=d,res=&tres);%put t4 index d= &&&tres;

	%indexExist(data=t5,index=i1,res=&tres);%put t5 index i1= &&&tres;
	%indexExist(data=t5,index=i2,res=&tres);%put t5 index i2= &&&tres;
	%indexExist(data=t5,index=i3,res=&tres);%put t5 index i3= &&&tres;
	%indexExist(data=t5,index=i4,res=&tres);%put t5 index i4= &&&tres;

	%indexExist(data=t5,index=a,res=&tres);%put t5 index a= &&&tres;

%mend;

%test_indexExist;

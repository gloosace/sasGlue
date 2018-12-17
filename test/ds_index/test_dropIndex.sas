

data test;
	a=1;b=2;c=3;d=4;
run;

%macro test_dropIndex;

	%local tres;%let tres=%createTempVar;%local &tres;
	
	%local indexA indexAB;

	%createIndex(data=test,vars=a,res=&tres);%let indexA=&&&tres;
	%createIndex(data=test,vars=a b,res=&tres);%let indexAB=&&&tres;


	%indexExist(data=test,index=&indexA,res=&tres);%put indexA exist=&&&tres;
	%indexExist(data=test,index=&indexAB,res=&tres);%put indexAB exist=&&&tres;


	%dropIndex(data=test,index=&indexA,vars=a b);

	%indexExist(data=test,index=&indexA,res=&tres);%put indexA exist=&&&tres;
	%indexExist(data=test,index=&indexAB,res=&tres);%put indexAB exist=&&&tres;
%mend;

%test_dropIndex;

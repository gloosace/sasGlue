
data t;
	a=1;b=2;c=3;d=4;
run;

%macro test_renameDsVar;

	%local tres;%let tres=%createTempVar;%local &tres;

	%getDsVarList(data=t,res=&tres);%put BEFORE=&&&tres;
	%renameDsVar(data=t,old=a b,new=X Y,out=out);
	%getDsVarList(data=out,res=&tres);%put AFTER=&&&tres;
	

	%getDsVarList(data=t,res=&tres);%put BEFORE=&&&tres;
	%renameDsVar(data=t,old=e f a b ,new=W U X Y,out=out2);
	%getDsVarList(data=out2,res=&tres);%put AFTER=&&&tres;

	%getDsVarList(data=t,res=&tres);%put BEFORE=&&&tres;
	%renameDsVar(data=t,old=e f a b ,new=W U X Y);
	%getDsVarList(data=t,res=&tres);%put AFTER=&&&tres;

	
%mend;


%test_renameDsVar;

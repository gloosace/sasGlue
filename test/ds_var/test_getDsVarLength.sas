data t;
	length c $100 d $1000;
	a=1;b=2;
run;

%macro test_getDsVarLen;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local cmd var vars varsN i;

	%let vars=a b c d e f g;

	%varsCount(vars=&vars,res=&tres);%let varsN=&&&tres;

	%do i=1 %to &varsN;
		%varsN(vars=&vars,n=&i,res=&tres);%let var=&&&tres;
		%let cmd=%nrquote(%%getDsVarLen(ds=t,var=&var,res=&tres));
		%unquote(&cmd);
		%put &var 	LENGTH=&&&tres;
	%end;
%mend;

%test_getDsVarLen;


data test_plan;
	group='A';seq=1;macro='test_core';param="x=1,y=2";out="local.res1";obs=.;output;
	group='A';seq=2;macro='test_core';param="x=3,y=4";out="local.res2";obs=.;output;
	group='B';seq=1;macro='test_core';param="x=5,y=6";out="local.res3";obs=.;output;
	group='B';seq=2;macro='test_core';param="x=9,y=8";out="local.res4";obs=.;output;
	group='B';seq=3;macro='test_core';param="x=2,y=7";out="local.res5";obs=.;output;
run;


%macro test_core(x=,y=,out=);
	%local rowN;
	%let rowN=%sysevalf(&x * &y);
	data %unquote(&out);
		do id=1 to %unquote(&rowN);
			value=rand('uniform');
			output;
		end;
	run;
%mend;


%macro test_plan;

	%local tres;%let tres=%createTempVar;%local &tres;
	%local tres2;%let tres2=%createTempVar;%local &tres2;
	%local planId sw;
	%local step;
	%let sw=1;

	%importLocalLib(local,test_plan);
	%dropDs(local.result);
	%dropDs(local.res1 local.res2 local.res3 local.res4 local.res5);

	%planInit(data=test_plan,vars=group seq,by=group seq,where=%quote(out ne 'local.res3'),res=&tres,resTotal=&tres2);
	%let planId=&&&tres;%let stepN=&&&tres2;
	%put planId=&planId stepN=&stepN;

	%do %while(&sw);
		%planNext(planId=&planId,res=&tres);%let step=&&&tres;
		%if %isBlank(&step) %then %let sw=0;
		%else %do;
			%put run &&&step.macro(&&&step.param,out=&&&step.out);
			%unquote(%&&&step.macro(&&&step.param,out=&&&step.out));
			%getDsObs(data=&&&step.out,res=&tres);%let &step.obs=&&&tres;
			%saveObj(obj=&step,data=local.result);
			%dropObj(&step);
		%end;
	%end;

	%dsToXlsx(data=local.result);
	%dropLocalLib;

	%showAllTemp;
%mend;


%dropAllGlobals;
%test_plan;

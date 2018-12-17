* name		test_string.sas;
* ver 		1.0;
* use		formatϵ�к굥Ԫ���Դ���;
* author	xk;
* src		utili.sas;
* macro		;

%include "D:\server\git_pulu\kalli\code\core\init.sas";

proc format;
	value fa 0='NONE' 1='A' 2='B' 3='C' ;
	value $fb 'dict'=1 'gender'=2 other=0;
	invalue fb 'dict'=1 'gender'=2 ;
	invalue $fd 1='a' 2='b';
run;

data t;
	infile datalines dsd;
	input dict $ type $ value amount desc $;
	datalines;
	dict,d,0,2,empty
	dict,d,1,1,fruit
	dict,d,2,2,fruit
	dict,d,3,1,fruit
	gender,g,0,3,empty
	gender,g,1,2,man
	gender,g,2,4,women
	test,g,100,4,women
	;
run;

%macro test_formats;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local fa fb; 
	%formatExist(fmt=fb,isInformat=1,res=&tres);%let fb=&&&tres;
	%put isStrFormat(fa)=%isStrFormat(fa) isStrFormat(fb)=%isStrFormat(fb) fmtExist(fb)=&fb; 
	%importFormatLib(path=E:\WORK\DATASET\performance_sampling\info,lib=fmtlib);
	%getFmt(date7.);
	data ts;
		label x='gogogo' y='pokemon';
		x=1;y=2;
	run;
	title 'before clearlabel';
	proc print data=ts label;run;
	%clearLabel(ts);
	title 'after clearlabel';
	proc print data=ts label;run;
	data ts; 
		set t;
		format dict fb.;
	run;
	title 'before clearformat';
	proc print data=ts;run;
	%clearFormat(ts);
	title 'after clearlabel';
	proc print data=ts;run;
	%dropDs(ts);
%mend;

%macro test_changeFormat;

	title 'before change format';
	proc print data=t;run;
	%changeFormat(data=t,var=value,format=fa.);
	title 'after change format';
	proc print data=t;run;

	title 'before change format';
	proc print data=t;run;
	%changeFormat(data=t,var=value amount,format=fa.);
	title 'after change format';
	proc print data=t;run;

	title 'before change format';
	proc print data=t;run;
	%changeFormat(data=t,stmt=value fa. dict $fb.);
	title 'after change format';
	proc print data=t;run;

%mend;

%macro test_formatChange;

	title 'before format change: modify old var';
	proc print data=t;run;
	%formatChange(data=t,out=out,vars=dict value,formats=fb. fa.,specVars=value);
	title 'after format change: modify old var';
	proc print data=out;run;

	title 'before format change: create new var';
	proc print data=t;run;
	%formatChange(data=t,out=out,vars=dict value,formats=fb. fa.,specVars=value,outVars=NEW_DICT NEW_VALUE);
	title 'after format change: create new var';
	proc print data=out;run;
%mend;

/*
data test;
	a=11231.156481515;
	c=strip(a);
	put c=;
	b=input(strip(a),$fd.);
	put b=;
run;
*/
%macro test_genGlobalFormatNMaps;

	%genGlobalFormatNMaps;
	%put _FORMATNMAPS_=&_FORMATNMAPS_;

%mend;

%macro test_showFormat;
	
	%showFormat(lib=work,format=Accountstat);
	
	%importLocalLib;

	proc format library=local;
		invalue testformat 1=1 2=2 3=3;
		invalue testformatB 1=4 2=2 3=3;
	quit;

	proc format library=local;
		value testformat 4=4 5=5 6=6;
	quit;

	%showFormat(lib=local,format=testformat);
	%showInFormat(lib=local,format=testformat testformatB testformatC);

%mend;
/*
%test_formats;
%test_changeFormat;
%test_formatChange;
%test_genGlobalFormatNMaps;

*/
%clearOutput(pdf=0);
%test_showFormat;

%odsclose;

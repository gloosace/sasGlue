

proc format;
	value fa 0='A' 1='B' 2='C' 3='D' other='NA';
	value $fb '001'='male' '002'='female' other='NA';
run;

data d;
	infile datalines dsd;
	length gender $ 3;
	format gender $fb. value fa.;
	label gender='SEX' value='$M';
	input gender $ value;
	datalines;
	000,0
	001,1
	002,2
	003,3
	,
	;
run;




%macro test_clearFormat;
	
	%clearOutput;

	%print(data=d,title=BEFORE);

	%clearFormat(d);
	%copyDs(data=d,out=out_label);
	%clearLabel(d);

	%print(data=d,title=AFTER);

%mend;

%test_clearFormat;

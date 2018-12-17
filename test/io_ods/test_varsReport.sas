

%macro test_varsReport;
	%local i vars1 vars2;

	%do i=1 %to 20;
		%local m&i;
		%let m&i=&i;
		%if &i<=10 %then %let vars1=&vars1 m&i;
		%let vars2=&vars2 m&i;
	%end;

	%setODSAutoNavigateOn;
	%varsReport(vars=&vars1,title=HORIZONTAL REPORT);
	%varsReport(vars=&vars2,title=VERTICAL REPORT);
	%setODSAutoNavigateOff;

%mend;



%test_varsReport;



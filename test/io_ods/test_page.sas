

data t;
	do i=1 to 5;
		a=1;b=2;c=3;output;
	end;
run;


%macro test_A;
	%pageStart(file=A1);
	%report(PART A1);
	%pageEnd;

	%pageStart(file=A2);
	%report(PART A2);
	%pageEnd;
%mend;

%macro test_B;
	%pageStart(file=B);
	%local i;

	%report(PART B1);

	%do i=1 %to 10;
		%test_core(&i);
	%end;

	%report(PART B2);

	%pageEnd;
%mend;

%macro test_core(i);
	%pageStart(file=CORE&i);
	%print(data=t);
	%pageEnd;
%mend;

%macro test_run;
	%clearOutput(file=MAIN);
	%report(test start);
	%test_A;
	%test_B;
	%report(test end);
	%pageEnd;
	%odsClose;
%mend;

%macro test_page;
	
	%setODSAutoNavigateOff

	%local path;

	%let path=%getPath;


	%let GLUE_PAGE_DEFAULT_NOTIMESTAMP=1;
	%let GLUE_PAGE_DEFAULT_P1=0;
	%let GLUE_PAGE_DEFAULT_TYPE=HTML;
	%let GLUE_PAGE_DEFAULT_PATH=&path.test_base\;
	%test_run;

	%let GLUE_PAGE_DEFAULT_NOTIMESTAMP=0;
	%let GLUE_PAGE_DEFAULT_P1=0;
	%let GLUE_PAGE_DEFAULT_TYPE=HTML;
	%let GLUE_PAGE_DEFAULT_PATH=&path.test_timestamp\;
	%test_run;

	%let GLUE_PAGE_DEFAULT_NOTIMESTAMP=1;
	%let GLUE_PAGE_DEFAULT_P1=1;
	%let GLUE_PAGE_DEFAULT_TYPE=HTML;
	%let GLUE_PAGE_DEFAULT_PATH=&path.test_p1\;
	%test_run;

	%let GLUE_PAGE_DEFAULT_NOTIMESTAMP=1;
	%let GLUE_PAGE_DEFAULT_P1=0;
	%let GLUE_PAGE_DEFAULT_TYPE=PDF;
	%let GLUE_PAGE_DEFAULT_PATH=&path.test_pdf\;
	%test_run;

%mend;



%test_page;

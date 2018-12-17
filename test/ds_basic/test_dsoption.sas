
%macro test_getDataOption;

	%let data=%str(work.test(where=A>1 and B<2 and C='ABC' keep=A B C));
	%put ;
	%put data=&data;
	%put data main=%getDataMain(&data);
	%put data option=%getDataOption(&data);
		
	data %getDataMain(&data);
		a=1;b=2;
	run;
	
	%let data=%str(work.test);
	%put ;
	%put data=&data;
	%put data main=%getDataMain(&data);
	%put data option=%getDataOption(&data);
	
%mend;


%macro test_mergeDataOption;

	%local data option;
	%let data=%str(work.test(where=(A>1 and B<2 and C='ABC') keep=A B C));
	%let option=%str(drop=D E F);

	%put ;
	%put data=&data;
	%put option=&option;
	%put %mergeDataOption(data=&data,option=&option);
	
	
%mend;

%test_getDataOption;
%test_mergeDataOption;

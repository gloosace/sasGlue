
%macro test_dropView_prepare;

	%importLocalLib;

	data temp;
	run;
	
	proc sql;
		create view local.a as select * from temp;
		create view local.b as select * from temp;
		create view local.c as select * from temp;
	quit;

	%dropLocalLib;
%mend;


%macro test_dropView;
	%importLocalLib;
	%dropView(local.a local.b local.c);
	%dropLocalLib;
%mend;

%test_dropView_prepare;
%test_dropView;



data t(index=(name));
		infile datalines dsd; 
		input name $ type $ dateStr $ state $;
		date=input(dateStr,B8601DA8.);
		datalines;
	101,A,20150101,ok
	102,A,20150221,pastdue
	103,A,20150406,ok
	104,A,20150611,ok
	;
run;



%macro test_importLocalLib;

	%importLocalLib;
	%importLocalLib(l1,sub1);
	%importLocalLib(l2,sub2);

	data local.test;
		set t;
	run;

	data l1.test;
		set t;
	run;

	data l2.test;
		set t;
	run;

	
%mend;

%test_importLocalLib;

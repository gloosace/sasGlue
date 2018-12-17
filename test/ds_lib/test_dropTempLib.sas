%macro makeTestFolder;


	%importLocalLib(l1,sub1);
	

	data l1.test;
		a=1;
	run;

	%dsToXlsx(data=l1.test);

%mend;

%makeTestFolder;

%dropTempLib(l1);

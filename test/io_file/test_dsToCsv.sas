

data test;
	input x $ y;
	cards;
	a 1
	b 2
	c 3
	;



run;

data test2;
	do i=1 to 100;
		value=rand('uniform');
		output;
	end;
run;


%macro test_dsToCsv;

	%local path csv;
	%let path=%getPath;
	

	%importLocalLib(local,test_dsToCsv);
	%resetLib(local);

	%copyDs(data=test,out=local.test_local);
	%dsToCsv(data=local.test_local);

	%dsToCsv(data=test,out=local.test_out);

	%dsToCsv(data=test,out=local.test_overwrite);
	%dsToCsv(data=test2,out=local.test_overwrite);

	%let csv=&path.test_dsToCsv\TEST_PATH.csv;
	%dsToCsv(data=test,csv=&csv);

	%dropLocalLib;
%mend;


%test_dsToCsv;

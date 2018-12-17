

data test;
	input x $ y;
	cards;
	a 1
	b 2
	c 3
	;
run;

data test2;
	do i=1 to 10000;
		value=rand('uniform');
		output;
	end;
run;


%macro test_csvToDs;

	%local path csv;


	* make test data;
	%importLocalLib(local,test_csvToDs);
	%resetLib(local);
	%dsTocsv(data=test,out=local.test_small);
	%dsTocsv(data=test2,out=local.test_big);

	* test;	
	%csvToDs(data=local.test_small);
	%csvToDs(data=local.test_small,out=local.test_out);

	%csvToDs(data=local.test_small,out=local.test_overwrite);
	%csvToDs(data=local.test_big,out=local.test_overwrite);

	%csvToDs(data=local.test_big,out=local.test_where,where=%quote(i>50));
	
	%let path=%getLibPath(local);
	%let csv=&path.test_small.csv;
	%csvToDs(csv=&csv,out=local.test_path);
		

	%csvToDs(data=local.test_small,out=local.test_nonames,getnames=0);
	%dropLocalLib;
%mend;


%test_csvToDs;


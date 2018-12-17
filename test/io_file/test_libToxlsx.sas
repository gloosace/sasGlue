data test1;
	input x $ y;
	cards;
	a 1
	b 2
	c 3
	;
run;

data test2;
	input x $ y;
	cards;
	a 1
	b 2
	c 3
	d 4
	;
run;

data test3;
	do i=1 to 1000;
		output;
	end;
run;

%macro test_libToXlsx;


	%importLocalLib(local,test_libToXlsx);


	%libToXlsx(lib=WORK,outlib=local);



	%dropLocalLib;
	
%mend;


%test_libToXlsx;

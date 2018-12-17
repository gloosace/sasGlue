

data test;
	a=100;
run;

%macro test_setODSAutoNavigateOn;


	
	%setODSAutoNavigateOn;

	%print(data=test);

%mend;



%macro test_setODSAutoNavigateOff;


	
	%setODSAutoNavigateOff;

	%print(data=test);

%mend;


%test_setODSAutoNavigateOn;
%test_setODSAutoNavigateOff;

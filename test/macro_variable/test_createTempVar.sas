

%macro test_createTempVar;

	%local var;


	%do i=1 %to 10;
		%let var=%createTempVar;
		%put var=&var;
	%end;
	
	%do i=1 %to 10;
		%let var=%createTempVar(TEMP);
		%put var=&var;
	%end;

%mend;

%test_createTempVar;


data t;
	a=1;b=2;c=3;d=4;
run;

%macro test_checkVars;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local run;

	%let run=%nrquote(%%checkVars(data=t,vars=a b,res=&tres));
	%unquote(&run);
	%put RUN:		&run;
	%put RESULT:	&&&tres;

	%let run=%nrquote(%%checkVars(data=t,vars=a b c d,res=&tres));
	%unquote(&run);
	%put RUN:		&run;
	%put RESULT:	&&&tres;

	%let run=%nrquote(%%checkVars(data=t,vars=a b x y ,res=&tres));
	%unquote(&run);
	%put RUN:		&run;
	%put RESULT:	&&&tres;


	%let run=%nrquote(%%checkVars(data=t,vars=,res=&tres));
	%unquote(&run);
	%put RUN:		&run;
	%put RESULT:	&&&tres;


%mend;

%test_checkVars;

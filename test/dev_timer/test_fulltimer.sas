

%macro test_fullTimer;


	%lbreak(no log);
	data _null_;
		do i=1 to 10000;
			c=log(rand('uniform'));
		end;
	run;

	%lbreak(fulltimer ON);
	%fulltimerOn;
	data _null_;
		do i=1 to 10000;
			c=log(rand('uniform'));
		end;
	run;

	%lbreak(fulltimer OFF);
	%fulltimerOff;
	data _null_;
		do i=1 to 10000;
			c=log(rand('uniform'));
		end;
	run;

%mend;

%test_fullTimer;

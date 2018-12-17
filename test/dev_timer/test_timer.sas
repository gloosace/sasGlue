
%macro test_timer;
	%local i x;

	%dropAllTimers;

	%put A timerId=%genTimerId(A);
	%put a timerId=%genTimerId(a);
	%put B timerId=%genTimerId(B);

	%lbreak(timer init);
	%let x=%stepTimer(a);
	%let x=%stepTimer(b);


	%do i=1 %to 15;

		data _null_;
			do i=1 to 10000;
				c=log(rand('uniform'));
			end;
		run;
		%put timer A %quote(step=%stepTimer(A) life=%lifeTimer(A));
		%if &i=7 %then %do;
			%lbreak(resetTimer)
			%resetTimer(a);
		%end; 
	%end;


	%lbreak(timer id test);
	%put timer A %quote(step=%stepTimer(A) life=%lifeTimer(A));
	%put timer a %quote(step=%stepTimer(a) life=%lifeTimer(a));
	%put timer B %quote(step=%stepTimer(B) life=%lifeTimer(B));

	%*dropAllTimers;
%mend;

%test_timer;

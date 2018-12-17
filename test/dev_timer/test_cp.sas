
%macro test_cp;
	%local i;

	%dropAllTimers;
	%put timer A and B start;

	%do i=1 %to 15;

		data _null_;
			do i=1 to 10000;
				c=log(rand('uniform'));
			end;
		run;
		%cp(time cost);
		%if &i=7 %then %do;
			%lbreak(resetTimer)
			%cp0;
		%end; 
	%end;
	%dropAllTimers;
%mend;

%test_cp;



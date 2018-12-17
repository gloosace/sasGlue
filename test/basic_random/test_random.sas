%macro test_random;

	%local r unit;
	%let t=%createTempDs;

	%lbreak(test_random);
	%linfo(%quote(expected=(0,1) real=%random));
	%linfo(%quote(expected=(0,1) real=%random));
	%linfo(%quote(expected=(0,1) real=%random));

	data &t;
		%do i=1 %to 10000;
			value=%random;
			output;
		%end;
	run;

	proc means data=&t;
	run;

	proc univariate data=&t;
		HISTOGRAM value;
	run;

	%dropDs(&t);

%mend;

%test_random;


%macro test_dsToDtv;

	%local raw dtv ds;
	%let raw=%date;
	%let dtv=%dsToDtv(&raw);
	%let ds=%dtvToDs(&dtv);
	%put raw=&raw;
	%put dsToDtv=&dtv;
	%put dsToDtv=&ds;

%mend;



%test_dsToDtv;

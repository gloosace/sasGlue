%macro test_fullFormat;

	%local fmt;

	%let fmt=abc;
	%put fmt=&fmt fullFormat=%fullFormat(&fmt);

	%let fmt=best12.3;
	%put fmt=&fmt fullFormat=%fullFormat(&fmt);

	%let fmt=$best12;
	%put fmt=&fmt fullFormat=%fullFormat(&fmt);

%mend;

%test_fullFormat;

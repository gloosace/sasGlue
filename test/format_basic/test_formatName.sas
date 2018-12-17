%macro test_formatName;

	%local fmt;

	%let fmt=abc;
	%put fmt=&fmt formatName=%formatName(&fmt);

	%let fmt=best12.3;
	%put fmt=&fmt formatName=%formatName(&fmt);

	%let fmt=$best12.;
	%put fmt=&fmt formatName=%formatName(&fmt);

	%put %getFmt(&fmt);
%mend;

%test_formatName;

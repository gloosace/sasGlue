
%macro test_report;


	%setODSDefault;
	%clearOutput;
	%report(this is a message);


%mend;

%test_report;




%macro test_logToFile;

	%put log to window;
	%logOff;
	data _null_;
		x=funcnotexit(0);
	run;
	%put log muted;
	%logOn;

	%logToFile(path=%getPath,file=test_logToFile);
	%put log to file;
	data _null_;
		x=funcnotexit(0);
	run;

	%logReset;
	%put log to window;
	data _null_;
		x=funcnotexit(0);
	run;

%mend;

%test_logToFile;

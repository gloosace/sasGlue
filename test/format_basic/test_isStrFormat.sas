
%macro test_isStrFormat;
	%put %isStrFormat($abc12.3);
	%put %isStrFormat(abc.6);
	%put %isStrFormat();
%mend;

%test_isStrFormat;


%macro test_genId;

	%local i;
	
	%put 12345678901234567890123456789012345678901234567890;
	%do i=1 %to 20;
		%put %genId;
	%end;

	%put 12345678901234567890123456789012345678901234567890;
	%do i=1 %to 20;
		%put %genId(prefix=TEST,len=40);
	%end;

	%put 12345678901234567890123456789012345678901234567890;
	%do i=1 %to 20;
		%put %genId(prefix=TEST,len=50);
	%end;

%mend;

%macro test_genId_error;

	%put %genId(prefix=TOOLONGPREFIX,len=10);

%mend;

%test_genId;
%*test_genId_error;

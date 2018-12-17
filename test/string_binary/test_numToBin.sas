%macro test_numToBin;
	%local i n;

	%lbreak(1 to 256 test);
	%do i=0 %to 256;
		%put &i -> %numToBin(&i);
	%end;
	
	%lbreak(Large number test);
	%do i=1 %to 53;
		%let n=%sysevalf(2**&i);
		%put i=&i -1 %sysevalf(&n-1) -> %numToBin(%sysevalf(&n-1));
		%put i=&i  0 &n -> %numToBin(&n);
	%end;
	
	%lbreak(Fixed length text);
	%let n=1234567890;
	%do i=1 %to 52;
		%put &i -> %numToBin(&n,&i);
	%end;
	
%mend;

%test_numToBin;

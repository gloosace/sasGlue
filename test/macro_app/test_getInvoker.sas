
options nosource;
options notes nomprint;

%macro test_m4;
	%test_m3;
%mend;

%macro test_m3;
	%test_m2;
%mend;

%macro test_m2;
	%test_m1;
%mend;

%macro test_m1;
	
	%do i=-1 %to 5;
		%put level=&i invoker=%getInvoker(&i);
	%end;
	
%mend;

%test_m4;

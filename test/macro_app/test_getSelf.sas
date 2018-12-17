
%macro test_m4;
	%put test_m4 %getSelf;
	%test_m3;
%mend;

%macro test_m3;
	%put test_m3 %getSelf;
	%test_m2;
%mend;

%macro test_m2;
	%put test_m2 %getSelf;
	%test_m1;
%mend;

%macro test_m1;
	%put test_m1 %getSelf;
%mend;

%test_m4;

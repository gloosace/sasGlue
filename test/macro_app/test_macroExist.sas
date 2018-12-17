

%macro test_macroExist_m1;
	%put test_m4 %getSelf;
	%test_m3;
%mend;

%macro test_macroExist;

	%put  test_macroExist_m1 %macroExist(test_macroExist_m1);
	%put  test_macroExist %macroExist(test_macroExist);
	%put  notexist %macroExist(notexist);

%mend;

%test_macroExist;

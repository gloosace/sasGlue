

%macro test_createTempLib;
	%local tres;%let tres=%createTempVar;%local &tres;
    %createTempLib(res=&tres);%let tl=&&&tres;
	%put lib=&tl;
	%put lib path=%getLibPath(&tl);
	%showAllTempLib;
	%dropTempLib(&tl);
	%showAllTempLib;
%mend;


%test_createTempLib;



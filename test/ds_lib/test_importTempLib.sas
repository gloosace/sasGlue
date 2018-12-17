%macro test_importTempLib;

	%local path p1 p2 p3 p4 l1 l2;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let path=%getPath;
	%let p1=&path.sub1\;
	%let p2=&path.sub2\;
	%let p3=&path.sub3\;
	%let p4=&path.sub4\;

	%createFolder(&p1);
	%createFolder(&p2);

	%importTempLib(&p1,&tres);%let l1=&&&tres;
	%importTempLib(&p2,&tres);%let l2=&&&tres;

	libname test "p3";
	libname L1234567 "p4";

	%showAllTempLib;


	%dropLib(&l1);
	%dropLib(&l2);
	%dropLib(test);
	%dropLib(L1234567);

	%showAllTempLib;

%mend;

%test_importTempLib;


%macro test_showAllTemp;

	%local tres;%let tres=%createTempVar;%local &tres;
	%local obj lib;

	%showAllTemp;

	%newObj(members=a b c,res=&tres);%let obj=&&&tres;
	%importTempLib(%getPath,&tres);%let lib=&&&tres;
	
	%showAllTemp;

	%dropObj(&obj);
	%dropLib(&lib);

	%showAllTemp;
%mend;

%test_showAllTemp;

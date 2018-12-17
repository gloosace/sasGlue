
%macro test_checkObj;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local obj;

	%newObj(members=a b c d,res=&tres);%let obj=&&&tres;

	%let &obj.a=1;
	%let &obj.b=%str( );
	%let &obj.c=%str();

	
	%checkObj(obj=&obj,res=&tres);%put &&&tres;


	%checkObj(obj=&obj,members=a c d,res=&tres);%put &&&tres;

	%dropObj(&obj);
%mend;


%test_checkObj;

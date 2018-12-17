

%macro test_clearObj;

	%local tres;%let tres=%createTempVar;%local &tres;
	%local obj;
	
	%newObj(members=a b c d e,res=&tres);%let obj=&&&tres;

	%let &obj.a=123;
	%let &obj.b='111 222 333';
	%let &obj.c=0.2345;
	%let &obj.d=-2123;
	%let &obj.e=abc;

	%showObj(&obj);

	%clearObj(obj=&obj,members=a);
	%showObj(&obj);

	%clearObj(obj=&obj,members=b c);
	%showObj(&obj);

	
	%clearObj(obj=&obj);
	%showObj(&obj);

	%dropObj(&obj);

%mend;


%test_clearObj;

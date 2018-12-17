
%macro test_stdObjVars;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local obj;

	%newObj(members=a b c,res=&tres);%let obj=&&&tres;
	%let &obj.a=1     3     2;
	%let &obj.b=%str(    a AA aa  bbb ccc    ddd);
	%let &obj.c=%str(  x y z x y z);
	%lbreak(TEST 1);
	%stdObjVars(obj=&obj,members=b);
	%showObj(&obj);
	%dropObj(&obj);


	%lbreak(TEST 2);
	%newObj(members=a b c,res=&tres);%let obj=&&&tres;
	%let &obj.a=1     3     2;
	%let &obj.b=%str(    a AA aa  bbb ccc    ddd);
	%let &obj.c=%str(  x y z x y z);
	%stdObjVars(obj=&obj);
	%showObj(&obj);
	%dropObj(&obj);

	%lbreak(TEST 3);
	%newObj(members=a b c,res=&tres);%let obj=&&&tres;
	%let &obj.a=1     3     2;
	%let &obj.b=%str(    a AA aa  bbb ccc    ddd);
	%let &obj.c=%str(  x y z x y z);
	%stdObjVars(obj=&obj,unique=0);
	%showObj(&obj);
	%dropObj(&obj);

%mend;


%test_stdObjVars;

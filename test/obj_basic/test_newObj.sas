

%macro test_newObj;
	%local tres;%let tres=%createTempVar;%local &tres;

	%local prefix members r r2;
	%local i;

	%dropAllGlobals;

	%lbreak(newObj TEST START);
	%showAllObj;
	%let members=%str(a b c);
	%newObj(members=&members,res=&tres);%let r=&&&tres;
	%assertEqual(a=1,b=%symglobl(&r.a),msg=member a exisit check);
	%assertEqual(a=1,b=%symglobl(&r.b),msg=member b exisit check);
	%assertEqual(a=1,b=%symglobl(&r.c),msg=member c exisit check);

	%let &r.a=123;
	%let &r.b='abc';
	%let &r.c=%quote(a=1 b=2 c='2c');

	%showObj(&r);
	%showAllObjs;

	%lbreak(dropObj TEST START);
	%linfo(obj dropped);
	%showAllObj;
	%showObj(&r);


%mend;

/*
%test_newObj;
*/



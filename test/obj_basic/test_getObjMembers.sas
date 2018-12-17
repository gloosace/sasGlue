

%macro test_getObjMembers;
	%local tres;%let tres=%createTempVar;%local &tres;

	%local members obj ;

	%dropAllGlobals;

	%lbreak(newObj TEST START);
	%let members=%str(a b c);
	%newObj(members=&members,res=&tres);%let obj=&&&tres;

	%let &obj.a=123;
	%let &obj.b='abc';
	%let &obj.c=%quote(a=1 b=2 c='2c');

	%getObjMembers(obj=&obj,res=&tres);%put getObjMembers = &&&tres;


	%dropObjMember(obj=&obj,member=c d);
	%showObj(&obj);


	%dropObjMember(obj=&obj,member=b c d);
	%showObj(&obj);

	%lbreak;
	%lbreak(addObjMember);
	%addObjMember(obj=&obj,member=x y z);
	%showObj(&obj);

	%dropObj(&obj);
%mend;


%test_getObjMembers;

%macro test_reportObj;
	%local tres;%let tres=%createTempVar;%local &tres;

	%local members obj;

	%dropAllGlobals;

	%let members=%str(a b c d e f);
	%newObj(members=&members,res=&tres);%let obj=&&&tres;

	%let &obj.a=123;
	%let &obj.b='abc';
	%let &obj.c=%quote(a=1 b=2 c='2c');
	%let &obj.d=123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890;
	%let &obj.e='123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
	%let &obj.f=%quote(a=1 b=2 c='2c');


	%reportObj(obj=&obj,members=a b c d e x,title=test_reportObj);
	%dropObj(&obj);
%mend;


%test_reportObj;

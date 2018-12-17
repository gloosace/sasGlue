

%macro test_copyObj;
	
	%local tres;%let tres=%createTempVar;%local &tres;

	%local members;
	%local x y;

	%lbreak(TEST 1);

	%let members=%str(a b c d);
	%newObj(members=&members,res=&tres);%let x=&&&tres;
	%let &x.a=%quote(FROM.a);
	%let &x.b=%quote(FROM.b);
	%let &x.c=%quote(FROM.c);
	%let &x.d=%quote(FROM.d);

	%newObj(members=&members ,res=&tres);%let y=&&&tres;
	%let &y.a=%quote(TO.a);
	%let &y.b=%quote();
	%let &y.c=%quote( );

	%copyObj(from=&x,to=&y,overwrite=0);
	
	%showObj(&y);

	%dropObj(&x &y);

%mend;



%macro test_copyObj_2;
	
	%local tres;%let tres=%createTempVar;%local &tres;

	%local members;
	%local x y;

	%lbreak(TEST 2);

	%let members=%str(a b c);
	%newObj(members=&members,res=&tres);%let x=&&&tres;
	%let &x.a=%quote(FROM.a);
	%let &x.b=%quote();
	%let &x.c=%quote( );

	%newObj(members=&members d,res=&tres);%let y=&&&tres;
	%let &y.a=%quote(TO.a);
	%let &y.b=%quote(TO.b);
	%let &y.c=%quote(TO.c);
	%let &y.d=%quote(TO.d);

	%copyObj(from=&x,to=&y,overwrite=1);
	
	%showObj(&y);


	%dropObj(&x &y);

%mend;


%test_copyObj;
%test_copyObj_2;

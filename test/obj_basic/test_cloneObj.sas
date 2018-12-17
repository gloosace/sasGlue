
%macro test_cloneObj;
	
	%local tres;%let tres=%createTempVar;%local &tres;

	%local members;
	%local x y;


	%let members=%str(a b c d);
	%newObj(members=&members,res=&tres);%let x=&&&tres;
	%let &x.a=A;
	%let &x.b=B;
	%let &x.c=C;
	%let &x.d=D;

	%cloneObj(obj=&x,res=&tres);%let y=&&&tres;
	
	%showObj(&x);
	%showObj(&y);

	%dropObj(&x &y);

%mend;

%test_cloneObj;

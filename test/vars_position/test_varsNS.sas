
%macro test_varsNS;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local vars pos e r;

	%let vars=a b c;
	%let pos=1 3;
	%let e=a c;
	%varsNS(vars=&vars,pos=&pos,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);


	%let vars=abc def xxx yyy;
	%let pos=2 3 5;
	%let e=def xxx;
	%varsNS(vars=&vars,pos=&pos,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);


	%let vars=abc def xxx yyy;
	%let pos=3 2 2 2 4;
	%let e=xxx def def def yyy;
	%varsNS(vars=&vars,pos=&pos,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);

%mend;


%test_varsNS;

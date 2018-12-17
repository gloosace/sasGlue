

%macro test_varsBatch;

	%local tres;%let tres=%createTempVar;%local &tres;
	%local vars macro p p2 e r;

	%let vars=a b c;
	%let macro=upcase;
	%let p=;
	%let p2=;
	%let e=A B C;
	%varsBatch(vars=&vars,macro=&macro,p=&p,p2=&p2,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);

	%let vars='a' 'b' 'c';
	%let macro=dequote;
	%let p=;
	%let p2=;
	%let e=a b c;
	%varsBatch(vars=&vars,macro=&macro,p=&p,p2=&p2,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);

	%let vars=1 10 100;
	%let macro=padding;
	%let p=str;
	%let p2=%quote(mode=LEFT len=6 char=0);
	%let e=000001 000010 000100;
	%varsBatch(vars=&vars,macro=&macro,p=&p,p2=&p2,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);


%mend;

%test_varsBatch;




%macro test_count;

	%let s=;
	%let c=;
	%let m=;
	%let e=0;
	%assertEqual(a=&e,b=%count(&s,&c,&m),msg=&s);

	%let s=abcabc;
	%let c=a;
	%let m=;
	%let e=2;
	%assertEqual(a=&e,b=%count(&s,&c,&m),msg=&s);

	%let s=汉字测试汉字测试;
	%let c=字;
	%let m=;
	%let e=2;
	%assertEqual(a=&e,b=%count(&s,&c,&m),msg=&s);

	%let s=%str(1 2 3 4);
	%let c=%str( );
	%let m=;
	%let e=3;
	%assertEqual(a=&e,b=%count(&s,&c,&m),msg=&s);

	%let s=%str(boobooboo);
	%let c=%str(booboo);
	%let m=;
	%let e=1;
	%assertEqual(a=&e,b=%count(&s,&c,&m),msg=&s);
%mend;



%test_count;


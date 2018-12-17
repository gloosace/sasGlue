
%macro test_countw;

	%let s=abc abc;
	%let c=;
	%let m=;
	%let e=1;
	%assertEqual(a=&e,b=%countw(&s,&c,&m),msg=&s);

	%let s=abc abc abc;
	%let c=;
	%let m=;
	%let e=1;
	%assertEqual(a=&e,b=%countw(&s,&c,&m),msg=&s);

	%let s=abc abc;
	%let c=%str( );
	%let m=;
	%let e=2;
	%assertEqual(a=&e,b=%countw(&s,&c,&m),msg=&s);

	%let s=abc abc abc;
	%let c=%str( );
	%let m=;
	%let e=3;
	%assertEqual(a=&e,b=%countw(&s,&c,&m),msg=&s);

	%let s=abc abc abc;
	%let c=;
	%let m=s;
	%let e=3;
	%assertEqual(a=&e,b=%countw(&s,&c,&m),msg=&s);

	%let s=%str( abc abc abc   );
	%let c=;
	%let m=s;
	%let e=3;
	%assertEqual(a=&e,b=%countw(&s,&c,&m),msg=&s);

	%let s=%str(abc abc  abc);
	%let c=;
	%let m=sm;
	%let e=4;
	%assertEqual(a=&e,b=%countw(&s,&c,&m),msg=&s);

	%let s=%str("abc " ' abc' abc);
	%let c=;
	%let m=s;
	%let e=5;
	%assertEqual(a=&e,b=%countw(&s,&c,&m),msg=&s);

	%let s=%str("abc " ' abc' abc);
	%let c=;
	%let m=qs;
	%let e=3;
	%assertEqual(a=&e,b=%countw(&s,&c,&m),msg=&s);

	%let s=%str(汉字 测试 用例);
	%let c=;
	%let m=qs;
	%let e=3;
	%assertEqual(a=&e,b=%countw(&s,&c,&m),msg=&s);

%mend;

%test_countw;

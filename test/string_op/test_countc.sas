
%macro test_countc;

	%let s=abc abc;
	%let c=;
	%let m=;
	%let e=0;
	%assertEqual(a=&e,b=%countc(&s,&c,&m),msg=&s);

	%let s=abc abc abc;
	%let c=a;
	%let m=;
	%let e=3;
	%assertEqual(a=&e,b=%countc(&s,&c,&m),msg=&s);

	%let s=abc abc;
	%let c=%str( );
	%let m=;
	%let e=1;
	%assertEqual(a=&e,b=%countc(&s,&c,&m),msg=&s);

	%let s=abc abc abc;
	%let c=%str( );
	%let m=;
	%let e=2;
	%assertEqual(a=&e,b=%countc(&s,&c,&m),msg=&s);

	%let s=abc abc abc;
	%let c=;
	%let m=s;
	%let e=2;
	%assertEqual(a=&e,b=%countc(&s,&c,&m),msg=&s);

	%let s=%str( abc abc abc   );
	%let c=;
	%let m=s;
	%let e=6;
	%assertEqual(a=&e,b=%countc(&s,&c,&m),msg=&s);

%mend;

%macro test_countc_err;

	%let s=%str(汉字汉字汉字);
	%let c=字;
	%let m=;
	%let e=3;
	%assertEqual(a=&e,b=%countc(&s,&c,&m),msg=&s);

%mend;


%test_countc;
%test_countc_err;

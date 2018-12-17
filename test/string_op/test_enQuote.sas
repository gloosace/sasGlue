

data _null_;


	a='"abc';
	b=quote(a);
	put b=;

run;

%macro test_enQuote;

	%local s e;	

	%let s=%str(a);
	%let e=%str("a");
	%assertEqual(a=&e,b=%enQuote(&s),msg=&s);
	
	%let s=%str(a=1 b=2 c='3');
	%let e=%str(%"a=1 b=2 c=%'3%'%");
	%assertEqual(a=&e,b=%enquote(&s),msg=&s);

	%let s=%nrstr(%"abc);
	%let e=%nrstr(%"%"abc%");
	%assertEqual(a=&e,b=%enQuote(&s),msg=&s);

	%let s=%str(汉字测试);
	%let e=%str("汉字测试");
	%assertEqual(a=&e,b=%enQuote(&s),msg=&s);

%mend;

%test_enQuote;

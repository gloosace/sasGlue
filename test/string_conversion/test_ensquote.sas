

%macro test_ensquote;
	%local s e;	

	%let s=a;
	%let e=%str('a');
	%assertEqual(a=&e,b=%enSquote(&s),msg=);

	%let s=%str(a=1 b=2 c='3');
	%let e=%str(%'a=1 b=2 c=%'3%'%');
	%assertEqual(a=&e,b=%enSquote(&s),msg=);

	%let s=%nrstr(%'abc);
	%let e=%nrstr(%'%'abc%');
	%put s=&s e=&e;
	%assertEqual(a=&e,b=%enSquote(&s),msg=);

	%let s=%str(汉字测试);
	%let e=%str('汉字测试');
	%assertEqual(a=&e,b=%enSquote(&s),msg=);
	
%mend;

%test_ensquote;

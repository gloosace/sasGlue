
%macro test_debracket;

	%local s;	

	%let s=%str((abc));
	%assertEqual(a=abc,b=%debracket(&s),msg=%quote(debracket(&s)));
	
	%let s=%str(abc);
	%assertEqual(a=abc,b=%debracket(&s),msg=%quote(debracket(&s)));

	%let s=%str(((abc)));
	%assertEqual(a=%str((abc)),b=%debracket(&s),msg=%quote(debracket(&s)));

	%let s=%str(( abc ));
	%assertEqual(a=%str( abc ),b=%debracket(&s),msg=%quote(debracket(&s)));

	%let s=%str(%(HALFBRACKET);
	%assertEqual(a=%str(%(HALFBRACKET),b=%debracket(&s),msg=%quote(debracket(&s)));

	%let s=%str(( 汉字 测试));
	%assertEqual(a=%str( 汉字 测试),b=%debracket(&s),msg=%quote(debracket(&s)));

	
%mend;


%test_debracket;

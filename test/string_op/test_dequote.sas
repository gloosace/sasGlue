

%macro test_dequote;

	%local s;

	%let s=%str('abc');
	%assertEqual(a=abc,b=%dequote(&s),msg=%quote(dequote(&s)));
	
	%let s=%str("abc");
	%assertEqual(a=abc,b=%dequote(&s),msg=%quote(dequote(&s)));
	
	%let s=%str("'abc'");
	%assertEqual(a='abc',b=%dequote(&s),msg=%quote(dequote(&s)));

	%let s=%str( "abc"	);
	%assertEqual(a=abc,b=%dequote(&s),msg=%quote(dequote(&s)));

	%let s=%str( %"abc  );
	%assertEqual(a=%str( %"abc  ),b=%dequote(&s),msg=%quote(dequote(&s)));

	%let s=%str(1234abc	);
	%assertEqual(a=1234abc,b=%dequote(&s),msg=%quote(dequote(&s)));

	%let s=%str( 152 );
	%assertEqual(a=%str( 152 ),b=%dequote(&s),msg=%quote(dequote(&s)));

	%let s=%str("汉字测试");
	%assertEqual(a=%str(汉字测试),b=%dequote(&s),msg=%quote(dequote(&s)));

	%let s=%str(“汉字测试”);
	%assertEqual(a=%str(“汉字测试”),b=%dequote(&s),msg=%quote(dequote(&s)));

%mend;


%test_dequote;

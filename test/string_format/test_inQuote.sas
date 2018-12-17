
%macro test_inQuote;

	%local s;	

	%let s=%str('abc');
	%assertEqual(a=1,b=%inQuote(&s),msg=%quote(inQuote(&s)));
	
	%let s=%str("abc");
	%assertEqual(a=1,b=%inQuote(&s),msg=%quote(inQuote(&s)));
	
	%let s=%str(abc);
	%assertEqual(a=0,b=%inQuote(&s),msg=%quote(inQuote(&s)));

	%let s=%str();
	%assertEqual(a=0,b=%inQuote(&s),msg=%quote(inQuote(&s)));

	%let s=%str( 'abc' );
	%assertEqual(a=1,b=%inQuote(&s),msg=%quote(inQuote(&s)));

	%let s=%str(	'abc'	);
	%assertEqual(a=1,b=%inQuote(&s),msg=%quote(inQuote(&s)));

	%let s=%str(	%'abc%"	);
	%assertEqual(a=0,b=%inQuote(&s),msg=%quote(inQuote(&s)));

%mend;

%test_inQuote;

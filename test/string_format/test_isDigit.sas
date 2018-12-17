
%macro test_isDigit;

	%local s;	

	%let s=%str(123);
	%assertEqual(a=1,b=%isDigit(&s),msg=%quote(isDigit(&s)));
	
	%let s=%str(123.456);
	%assertEqual(a=1,b=%isDigit(&s),msg=%quote(isDigit(&s)));

	%let s=%str(-123.456);
	%assertEqual(a=1,b=%isDigit(&s),msg=%quote(isDigit(&s)));

	%let s=%str(-123.000);
	%assertEqual(a=1,b=%isDigit(&s),msg=%quote(isDigit(&s)));

	%let s=%str( 123);
	%assertEqual(a=1,b=%isDigit(&s),msg=%quote(isDigit(&s)));

	%let s=%str(123 );
	%assertEqual(a=1,b=%isDigit(&s),msg=%quote(isDigit(&s)));

	%let s=%str(123. );
	%assertEqual(a=1,b=%isDigit(&s),msg=%quote(isDigit(&s)));

	%let s=%str(123 . );
	%assertEqual(a=0,b=%isDigit(&s),msg=%quote(isDigit(&s)));

	%let s=%str(abc);
	%assertEqual(a=0,b=%isDigit(&s),msg=%quote(isDigit(&s)));	

	%let s=%str( _);
	%assertEqual(a=0,b=%isDigit(&s),msg=%quote(isDigit(&s)));

	%let s=%str( );
	%assertEqual(a=0,b=%isDigit(&s),msg=%quote(isDigit(&s)));

	%let s=%str(.);
	%assertEqual(a=1,b=%isDigit(&s),msg=%quote(isDigit(&s)));

	%let s=%str( . );
	%assertEqual(a=1,b=%isDigit(&s),msg=%quote(isDigit(&s)));

	%let s=%str(2.4514550611515E-6);
	%assertEqual(a=1,b=%isDigit(&s),msg=%quote(isDigit(&s)));
	
	%let s=%str(2.4514550611515E6);
	%assertEqual(a=1,b=%isDigit(&s),msg=%quote(isDigit(&s)));

	%let s=%str(-2.4514550611515E6);
	%assertEqual(a=1,b=%isDigit(&s),msg=%quote(isDigit(&s)));

	%let s=%str(2.4514550611515EE6);
	%assertEqual(a=0,b=%isDigit(&s),msg=%quote(isDigit(&s)));
	
%mend;


%test_isDigit;


%macro test_isUINT;

	%local s;	

	%let s=%str(123);
	%assertEqual(a=1,b=%isUINT(&s),msg=%quote(isUINT(&s)));
	
	%let s=%str( 0);
	%assertEqual(a=1,b=%isUINT(&s),msg=%quote(isUINT(&s)));

	%let s=%str(01);
	%assertEqual(a=0,b=%isUINT(&s),msg=%quote(isUINT(&s)));

	%let s=%str(-123);
	%assertEqual(a=0,b=%isUINT(&s),msg=%quote(isUINT(&s)));

	%let s=%str(123.456);
	%assertEqual(a=0,b=%isUINT(&s),msg=%quote(isUINT(&s)));

	%let s=%str(-123.456);
	%assertEqual(a=0,b=%isUINT(&s),msg=%quote(isUINT(&s)));

	%let s=%str(-123.000);
	%assertEqual(a=0,b=%isUINT(&s),msg=%quote(isUINT(&s)));

	%let s=%str( 123);
	%assertEqual(a=1,b=%isUINT(&s),msg=%quote(isUINT(&s)));

	%let s=%str(123 );
	%assertEqual(a=1,b=%isUINT(&s),msg=%quote(isUINT(&s)));

	%let s=%str(123. );
	%assertEqual(a=0,b=%isUINT(&s),msg=%quote(isUINT(&s)));

	%let s=%str(123 . );
	%assertEqual(a=0,b=%isUINT(&s),msg=%quote(isUINT(&s)));

	%let s=%str(abc);
	%assertEqual(a=0,b=%isUINT(&s),msg=%quote(isUINT(&s)));	

	%let s=%str( _);
	%assertEqual(a=0,b=%isUINT(&s),msg=%quote(isUINT(&s)));

	%let s=%str( );
	%assertEqual(a=0,b=%isUINT(&s),msg=%quote(isUINT(&s)));

	%let s=%str(.);
	%assertEqual(a=0,b=%isUINT(&s),msg=%quote(isUINT(&s)));

	%let s=%str( . );
	%assertEqual(a=0,b=%isUINT(&s),msg=%quote(isUINT(&s)));

	%let s=%str(2.4514550611515E-6);
	%assertEqual(a=0,b=%isUINT(&s),msg=%quote(isUINT(&s)));
	
	%let s=%str(2.4514550611515E6);
	%assertEqual(a=0,b=%isUINT(&s),msg=%quote(isUINT(&s)));

	
%mend;


%test_isUINT;

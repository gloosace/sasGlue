
%macro test_isVar;

	%local s;	

	%lbreak(%getInvoker);

	%let s=%str();
	%assertEqual(a=0,b=%isVar(&s),msg=%quote(isVar(&s)));

	%let s=%str( );
	%assertEqual(a=0,b=%isVar(&s),msg=%quote(isVar(&s)));

	%let s=%str(123);
	%assertEqual(a=0,b=%isVar(&s),msg=%quote(isVar(&s)));
		
	%let s=%str(A123);
	%assertEqual(a=1,b=%isVar(&s),msg=%quote(isVar(&s)));

	%let s=%str(a123);
	%assertEqual(a=1,b=%isVar(&s),msg=%quote(isVar(&s)));
	
	%let s=%str(_123);
	%assertEqual(a=1,b=%isVar(&s),msg=%quote(isVar(&s)));

	%let s=%str(abc);
	%assertEqual(a=1,b=%isVar(&s),msg=%quote(isVar(&s)));

	%let s=%str( abc);
	%assertEqual(a=1,b=%isVar(&s),msg=%quote(isVar(&s)));

	%let s=%str( abc abc);
	%assertEqual(a=0,b=%isVar(&s),msg=%quote(isVar(&s)));

	%let s=%str(!abc);
	%assertEqual(a=0,b=%isVar(&s),msg=%quote(isVar(&s)));

	%let s=%str(@abc);
	%assertEqual(a=0,b=%isVar(&s),msg=%quote(isVar(&s)));

	%let s=%str(3abc);
	%assertEqual(a=0,b=%isVar(&s),msg=%quote(isVar(&s)));

	%let s=%str(_abc12345);
	%assertEqual(a=1,b=%isVar(&s),msg=%quote(isVar(&s)));

	%let s=%str(_1234567890123456789012345678901);
	%assertEqual(a=1,b=%isVar(&s),msg=%quote(isVar(&s)));

	%let s=%str(_12345678901234567890123456789012);
	%assertEqual(a=0,b=%isVar(&s),msg=%quote(isVar(&s)));

%mend;


%test_isVar;

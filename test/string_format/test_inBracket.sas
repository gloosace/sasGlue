

%macro test_inBracket;

	%local s;	

	%let s=%str((abc));
	%assertEqual(a=1,b=%inBracket(&s),msg=%quote(inBracket(&s)));
	
	%let s=%str();
	%assertEqual(a=0,b=%inBracket(&s),msg=%quote(inBracket(&s)));

	%let s=%str(%(a);
	%assertEqual(a=0,b=%inBracket(&s),msg=%quote(inBracket(&s)));

	%let s=%str(( ));
	%assertEqual(a=1,b=%inBracket(&s),msg=%quote(inBracket(&s)));

	%let s=%str(%( %( %));
	%assertEqual(a=1,b=%inBracket(&s),msg=%quote(inBracket(&s)));


%mend;


%test_inBracket;

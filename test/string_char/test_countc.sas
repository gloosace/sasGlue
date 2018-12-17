
%macro test_count;
	%local s c m;
	
	%let s=0101010101;
	%let c=1;
	%assertEqual(a=5,b=%count(&s,&c));

	%let s=%quote( 1 1 1);
	%let c=%quote( );
	%assertEqual(a=3,b=%count(&s,&c));

	%let s=%quote(booboobooboo);
	%let c=%quote(booboo);
	%assertEqual(a=2,b=%count(&s,&c));

	%let s=%quote(   );
	%let c=%quote( );
	%assertEqual(a=3,b=%count(&s,&c));

	%let s=%quote(   );
	%let c=%quote(  );
	%assertEqual(a=1,b=%count(&s,&c));

	%let s=%quote(xxbb);
	%let c=%quote(ab);
	%assertEqual(a=0,b=%count(&s,&c));



%mend;

%test_count;

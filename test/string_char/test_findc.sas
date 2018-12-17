

%macro test_findc;
	%local s c m;
	
	%let s=0101010101;
	%let c=1;
	%assertEqual(a=2,b=%findc(&s,&c));

	%let s=%quote(1234 1);
	%let c=%quote( );
	%assertEqual(a=5,b=%findc(&s,&c));

	%let s=%quote(   );
	%let c=%quote( );
	%assertEqual(a=1,b=%findc(&s,&c));

	%let s=%quote(   );
	%let c=%quote(  );
	%assertEqual(a=1,b=%findc(&s,&c));

	%let s=%quote(xxyyzzab);
	%let c=%quote(ab);
	%assertEqual(a=7,b=%findc(&s,&c));

	%let s=%quote(汉字测试);
	%let c=%quote(字);
	%assertEqual(a=2,b=%findc(&s,&c));
%mend;

%test_findc;


%macro test_fcmp_test;
	data _null_;
		a=22;
		b=22;
		c=assertEqual(a,b,'a=b');
		
		a=22;
		b=23;
		c=assertEqual(a,b,'a^=b');

		a=.;
		b=.;
		c=assertEqual(a,b,'null');

	run;

	data _null_;
		length a b $ 100;
		a='22';
		b='22';
		c=assertStrEqual(a,b,'a=b');
		
		a='22';
		b='23';
		c=assertStrEqual(a,b,'a^=b');

		a=' ';
		b=' ';
		c=assertStrEqual(a,b,'a=NULL');

		a=' ';
		b='    ';
		c=assertStrEqual(a,b,'a=NULL');
	run;

%mend;

%test_fcmp_test;

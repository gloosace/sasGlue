


%macro test_fcmp_substring;
	
	data test_fcmp_substring;
		length s r $ 100;
		
		
		s='12345678901234567890';
		a=1;
		b=4;
		r=substring(s,a,b);
		put a= b= r=;

		s='12345678901234567890';
		a=1;
		b=10;
		r=substring(s,a,b);
		put a= b= r=;

		s='12345678901234567890';
		a=-1;
		b=1;
		r=substring(s,a,b);
		put a= b= r=;

		s='12345678901234567890';
		a=5;
		b=15;
		r=substring(s,a,b);
		put a= b= r=;
		
		s='12345678901234567890';
		a=-6;
		b=-2;
		r=substring(s,a,b);
		put a= b= r=;

		s='12345678901234567890';
		a=0;
		b=30;
		r=substring(s,a,b);
		put a= b= r=;

		s='12345678901234567890';
		a=0;
		b=0;
		r=substring(s,a,b);
		put a= b= r=;

		s='12345678901234567890';
		a=15;
		b=30;
		r=substring(s,a,b);
		put a= b= r=;

		s='12345678901234567890';
		a=30;
		b=40;
		r=substring(s,a,b);
		put a= b= r=;

		s='12345678901234567890';
		a=1.2;
		b=3.5;
		r=substring(s,a,b);
		put a= b= r=;
	run;

%mend;

%test_fcmp_substring;



data test_fcmp_strcode;

	length a b c d $ 1000;

	a=strcode('abc');
	l = length(a);
	put l= a=;

	b=strcode('12345678901234567890');
	l = length(b);
	put l= b=;

	c=strcode('1234567890123456789012345678901234567890');
	l = length(c);
	put l= c= ;

	d=strcode('123456789012345678901234567890123456789012345678901234567890');
	l = length(d);
	put l= d= ;

run;

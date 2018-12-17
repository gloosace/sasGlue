

/*
benchmark http://www.miraclesalad.com/webtools/md5.php;
*/

%macro test_fcmp_md5hex;
	data test_fcmp_md5hex;
		length a  $ 100;
		a='a   d  b c d   e';
		b=md5hex(a);
		put a=;
		put b=;

		a='a    d    b c d   e';
		b=md5hex(a);
		put a= ;
		put b=;

		a='ABC';
		b=md5hex(a);
		put a= ;
		put b=;

		a='abc';
		b=md5hex(a);
		put a= ;
		put b=;

		a='        abc     ';
		b=md5hex(a);
		put a= ;
		put b=;

		a='        a bc     ';
		b=md5hex(a);
		put a= ;
		put b=;

	run;
%mend;

%macro test_fcmp_md5hex_len;


	%lbreak(test_fcmp_md5hex_len);
	data test_fcmp_md5hex_len;
		length a $ 100 b $ 10 x y z $ 100;
	
		a='1';
		b='1';

		x=md5hex(a);
		y=putc(md5(a),'hex32.');
		z=putc(md5(strip(a)),'hex32.');
		put x= y= z=;

		x=md5hex(b);
		y=putc(md5(b),'hex32.');
		z=putc(md5(strip(b)),'hex32.');
		put x= y= z=;

	run;
%mend;

%test_fcmp_md5hex;
%test_fcmp_md5hex_len;

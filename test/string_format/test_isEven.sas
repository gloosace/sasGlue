
%macro test_isEven;

	%local s i;	


	%do i=1 %to 10;
		%let s=%eval(&i*2);
		%assertEqual(a=1,b=%isEven(&s),msg=%quote(isEven(&s)));
		%let s=%eval(&i*2-1);
		%assertEqual(a=0,b=%isEven(&s),msg=%quote(isEven(&s)));
		%let s=%eval(-&i*2);
		%assertEqual(a=1,b=%isEven(&s),msg=%quote(isEven(&s)));
		%let s=%eval(-&i*2-1);
		%assertEqual(a=0,b=%isEven(&s),msg=%quote(isEven(&s)));
	%end;
	

	%let s=%str(123);
	%assertEqual(a=0,b=%isEven(&s),msg=%quote(isEven(&s)));
	
	%let s=%str(123456);
	%assertEqual(a=1,b=%isEven(&s),msg=%quote(isEven(&s)));

	%let s=%str(-123456);
	%assertEqual(a=1,b=%isEven(&s),msg=%quote(isEven(&s)));

	%let s=%str(-123);
	%assertEqual(a=0,b=%isEven(&s),msg=%quote(isEven(&s)));

	%let s=%str(0);
	%assertEqual(a=1,b=%isEven(&s),msg=%quote(isEven(&s)));

	%let s=%str(00004);
	%assertEqual(a=1,b=%isEven(&s),msg=%quote(isEven(&s)));

	%let s=%str(  24  );
	%assertEqual(a=1,b=%isEven(&s),msg=%quote(isEven(&s)));

	%let s=%str(.);
	%assertEqual(a=0,b=%isEven(&s),msg=%quote(isEven(&s)));

	%let s=%str();
	%assertEqual(a=0,b=%isEven(&s),msg=%quote(isEven(&s)));

	%let s=%str(        );
	%assertEqual(a=0,b=%isEven(&s),msg=%quote(isEven(&s)));

	%let s=%str(abc);
	%assertEqual(a=0,b=%isEven(&s),msg=%quote(isEven(&s)));

%mend;


%test_isEven;

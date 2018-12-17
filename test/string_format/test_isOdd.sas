
%macro test_isOdd;

	%local s i;	

	%do i=1 %to 10;
		%let s=%eval(&i*2);
		%assertEqual(a=0,b=%isOdd(&s),msg=%quote(isOdd(&s)));
		%let s=%eval(&i*2-1);
		%assertEqual(a=1,b=%isOdd(&s),msg=%quote(isOdd(&s)));
		%let s=%eval(-&i*2);
		%assertEqual(a=0,b=%isOdd(&s),msg=%quote(isOdd(&s)));
		%let s=%eval(-&i*2-1);
		%assertEqual(a=1,b=%isOdd(&s),msg=%quote(isOdd(&s)));
	%end;
	
	%let s=%str(123);
	%assertEqual(a=1,b=%isOdd(&s),msg=%quote(isOdd(&s)));
	
	%let s=%str(123456);
	%assertEqual(a=0,b=%isOdd(&s),msg=%quote(isOdd(&s)));

	%let s=%str(-123456);
	%assertEqual(a=0,b=%isOdd(&s),msg=%quote(isOdd(&s)));

	%let s=%str(-123);
	%assertEqual(a=1,b=%isOdd(&s),msg=%quote(isOdd(&s)));

	%let s=%str(0);
	%assertEqual(a=0,b=%isOdd(&s),msg=%quote(isOdd(&s)));

	%let s=%str(  23  );
	%assertEqual(a=1,b=%isOdd(&s),msg=%quote(isEven(&s)));

	%let s=%str(.);
	%assertEqual(a=0,b=%isOdd(&s),msg=%quote(isOdd(&s)));

	%let s=%str();
	%assertEqual(a=0,b=%isOdd(&s),msg=%quote(isOdd(&s)));

	%let s=%str(        );
	%assertEqual(a=0,b=%isOdd(&s),msg=%quote(isEven(&s)));

	%let s=%str(abc);
	%assertEqual(a=0,b=%isOdd(&s),msg=%quote(isOdd(&s)));

%mend;


%test_isOdd;

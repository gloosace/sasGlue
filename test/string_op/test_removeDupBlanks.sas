
%macro test_removeDupBlanks;
	%local s out;


	%let s=%quote(a     b c d   e);
	%let out=%quote(a b c d e);
	%assertEqual(a=&out,b=%removeDupBlanks(&s));

	%let s=%quote(a  b 			c);
	%let out=%quote(a b c);
	%assertEqual(a=&out,b=%removeDupBlanks(&s));

	%let s=%quote( abc  );
	%let out=%quote( abc );
	%assertEqual(a=&out,b=%removeDupBlanks(&s));


	%let s=%quote(    a=' ' b='abc' d='   abc');
	%let out=%quote( a=' ' b='abc' d=' abc');
	%assertEqual(a=&out,b=%removeDupBlanks(&s));


	%let s=%quote(  汉字     测试		空格  	);
	%let out=%quote( 汉字 测试 空格 );
	%assertEqual(a=&out,b=%removeDupBlanks(&s));

%mend;


%test_removeDupBlanks;

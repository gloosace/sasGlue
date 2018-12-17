
%macro test_findStr;

	%let source=%str(cba);
	%let target=%str(x);
	%assertEqual(a=,b=%findStr(&source,&target),msg=%quote(findStr(&source,&target)));

	%let source=%str(cba);
	%let target=%str(a);
	%assertEqual(a=3,b=%findStr(&source,&target),msg=%quote(findStr(&source,&target)));

	%let source=%str( a);
	%let target=%str(a);
	%assertEqual(a=2,b=%findStr(&source,&target),msg=%quote(findStr(&source,&target)));

	%let source=%str(a);
	%let target=%str(A);
	%assertEqual(a=,b=%findStr(&source,&target),msg=%quote(findStr(&source,&target)));

	%let source=%str(def abc jkl abc);
	%let target=%str(abc);
	%assertEqual(a=5 13,b=%findStr(&source,&target),msg=%quote(findStr(&source,&target)));


	%let source=%str(汉字aaaaa);
	%let target=%str(aa);
	%assertEqual(a=3 5,b=%findStr(&source,&target),msg=%quote(findStr(&source,&target)));

	%let source=%str(测试字符串字);
	%let target=%str(字);
	%assertEqual(a=3 6,b=%findStr(&source,&target),msg=%quote(findStr(&source,&target)));

	%let source=%str(a=测试 b=汉字 c=字符);
	%let target=%str(c=字符);
	%assertEqual(a=11,b=%findStr(&source,&target),msg=%quote(findStr(&source,&target)));

	%let source=%str(a=123 b=-2 c=-1 b=-2);
	%let target=%str(b=-2);
	%assertEqual(a=7 17,b=%findStr(&source,&target),msg=%quote(findStr(&source,&target)));

	%let source=%str( a b c );
	%let target=%str( );
	%assertEqual(a=1 3 5 7,b=%findStr(&source,&target),msg=%quote(findStr(&source,&target)));
%mend;


%test_findStr;

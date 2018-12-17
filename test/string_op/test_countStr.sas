

%macro test_countStr;

	%let source=%str(a=1);
	%let target=%str(b=-2);
	%assertEqual(a=0,b=%countStr(&source,&target),msg=%quote(countStr(&source,&target)));

	%let source=%str(a bc aa);
	%let target=%str(a);
	%assertEqual(a=3,b=%countStr(&source,&target),msg=%quote(countStr(&source,&target)));

	%let source=%str( a a);
	%let target=%str(a);
	%assertEqual(a=2,b=%countStr(&source,&target),msg=%quote(countStr(&source,&target)));

	%let source=%str(def abc jkl abc);
	%let target=%str(abc);
	%assertEqual(a=2,b=%countStr(&source,&target),msg=%quote(countStr(&source,&target)));

	%let source=%str(boobooboo);
	%let target=%str(booboo);
	%assertEqual(a=1,b=%countStr(&source,&target),msg=%quote(countStr(&source,&target)));

	%let source=%str(a=123 b=-2 c=-1 b=-2);
	%let target=%str(b=-2);
	%assertEqual(a=2,b=%countStr(&source,&target),msg=%quote(countStr(&source,&target)));

	%let source=%str(a b c d e f g h i j k l m n o p a);
	%let target=%str(a);
	%assertEqual(a=2,b=%countStr(&source,&target),msg=%quote(countStr(&source,&target)));

	%let source=%str(汉字测试aaaaa);
	%let target=%str(aa);
	%assertEqual(a=2,b=%countStr(&source,&target),msg=%quote(countStr(&source,&target)));

	%let source=%str(汉字测试汉字测试汉);
	%let target=%str(字);
	%assertEqual(a=2,b=%countStr(&source,&target),msg=%quote(countStr(&source,&target)));

	%let source=%str(a=汉字 b=测试 c=用例);
	%let target=%str(c=用例);
	%assertEqual(a=1,b=%countStr(&source,&target),msg=%quote(countStr(&source,&target)));


%mend;

%test_countStr;


%macro test_transtrn;

	%local source target replacement;

	%let replacement=%str(REP);

	%let source=%str(a=1);
	%let target=%str(b=-2);
	%assertEqual(a=%str(a=1),b=%transtrn(&source,&target,&replacement),msg=%quote(transtrn(&source,&target,&replacement)));
	
	%let source=%str(a bc aa);
	%let target=%str(a);
	%assertEqual(a=%str(REP bc REPREP),b=%transtrn(&source,&target,&replacement),msg=%quote(transtrn(&source,&target,&replacement)));

	%let source=%str( a a);
	%let target=%str(a);
	%assertEqual(a=%str( REP REP),b=%transtrn(&source,&target,&replacement),msg=%quote(transtrn(&source,&target,&replacement)));

	%let source=%str(def abc jkl abc);
	%let target=%str(abc);
	%assertEqual(a=%str(def REP jkl REP),b=%transtrn(&source,&target,&replacement),msg=%quote(transtrn(&source,&target,&replacement)));

	%let source=%str(汉字测试aaaaa);
	%let target=%str(aa);
	%assertEqual(a=%str(汉字测试REPREPa),b=%transtrn(&source,&target,&replacement),msg=%quote(transtrn(&source,&target,&replacement)));

	%let source=%str(汉字测试汉字测试);
	%let target=%str(字);
	%assertEqual(a=%str(汉REP测试汉REP测试),b=%transtrn(&source,&target,&replacement),msg=%quote(transtrn(&source,&target,&replacement)));

	%let source=%str(a=汉字 b=测试 c=用例);
	%let target=%str(c=用例);
	%assertEqual(a=%str(a=汉字 b=测试 REP),b=%transtrn(&source,&target,&replacement),msg=%quote(transtrn(&source,&target,&replacement)));

	%let source=%str(a=123 b=-2 c=-1 b=-2);
	%let target=%str(b=-2);
	%assertEqual(a=%str(a=123 REP c=-1 REP),b=%transtrn(&source,&target,&replacement),msg=%quote(transtrn(&source,&target,&replacement)));

	%let source=%str(a=123 b=-2 c=-1 b=-2);
	%let target=%str( );
	%assertEqual(a=%str(a=123REPb=-2REPc=-1REPb=-2),b=%transtrn(&source,&target,&replacement),msg=%quote(transtrn(&source,&target,&replacement)));
	
	%let source=%str(a=123 b=-2 c=-1 b=-2);
	%let target=%str();
	%assertEqual(a=%str(a=123 b=-2 c=-1 b=-2),b=%transtrn(&source,&target,&replacement),msg=%quote(transtrn(&source,&target,&replacement)));

	%let source=%str(abcdeabcd);
	%let target=%str(a);
	%let replacement=%str();
	%assertEqual(a=%str(bcdebcd),b=%transtrn(&source,&target,&replacement),msg=%quote(transtrn(&source,&target,&replacement)));

	%let source=%str("def" "abc" "jkl" "abc");
	%let target=%str(%");
	%let replacement=%str(%');
	%let e=%str('def' 'abc' 'jkl' 'abc');
	%assertEqual(a=&e,b=%transtrn(&source,&target,&replacement),msg=%quote(transtrn(&source,&target,&replacement)));

	%let source=%str(%"%"%");
	%let target=%str(%");
	%let replacement=%str(%');
	%let e=%str(%'%'%');
	%assertEqual(a=&e,b=%transtrn(&source,&target,&replacement),msg=%quote(transtrn(&source,&target,&replacement)));

	%let source=%str(booboobooboo);
	%let target=%str(boobooboo);
	%let replacement=%str(X);
	%assertEqual(a=%str(Xboo),b=%transtrn(&source,&target,&replacement),msg=%quote(replaceStr(&source,&target,&replacement)));

	%let source=%str(aaaaaaaa);
	%let target=%str(aaa);
	%let replacement=%str(X);
	%assertEqual(a=%str(XXaa),b=%transtrn(&source,&target,&replacement),msg=%quote(replaceStr(&source,&target,&replacement)));
%mend;

%test_transtrn;


%macro test_varsToAssigns;
	%lbreak(%getInvoker);
	%local a b exp case;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let a=%str(a b c);
	%let b=%str(1 2 3);
	%let exp=%str(a=1 b=2 c=3);
	%varsToAssigns(a=&a,b=&b,res=&tres);
	%assertEqual(a=&exp,b=&&&tres);

	%let a=%str(a b    c  d);
	%let b=%str('1' '2' '3   '    '4');
	%let exp=%str(a='1' b='2' c='3   ' d='4');
	%varsToAssigns(a=&a,b=&b,res=&tres);
	%assertEqual(a=&exp,b=&&&tres);

	%let a=%nrstr(a b c d);
	%let b=%nrstr(汉字 测试 用例 汉字);
	%let exp=%str(a=汉字 b=测试 c=用例 d=汉字);
	%varsToAssigns(a=&a,b=&b,res=&tres);
	%assertEqual(a=&exp,b=&&&tres);

%mend;


%macro test_varsToAssigns_err;
	%lbreak(%getInvoker);
	%local a b exp case;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let a=%str(a b c);
	%let b=%str(1 2 );
	%let exp=%str(a=1 b=2 c=3);
	%varsToAssigns(a=&a,b=&b,res=&tres);
	%assertEqual(a=&exp,b=&&&tres);

%mend;

%test_varsToAssigns;
%test_varsToAssigns_err;

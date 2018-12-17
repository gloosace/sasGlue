
%macro test_varsCompress;
	%local a b exp case;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let a=%str(   a        b          c );
	%let exp=%str(a b c);
	%varsCompress(vars=&a,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsCompress(vars=&a,res=&tres)));

	%let a=%str();
	%let exp=%str();
	%varsCompress(vars=&a,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsCompress(vars=&a,res=&tres)));

	%let a=%str(   汉字         测试  用例           );
	%let exp=%str(汉字 测试 用例);
	%varsCompress(vars=&a,res=&tres);
	%assertEqual(a=&exp,b=&&&tres,msg=%nrquote(%%varsCompress(vars=&a,res=&tres)));

	
%mend;

%test_varsCompress;

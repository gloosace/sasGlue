
%macro test_compress;

	%local source;

	%let source=%str( a b c );
	%assertEqual(a=%str(abc),b=%compress(&source),msg=%quote(compress(&source)));

	%let source=%str( a=1 );
	%assertEqual(a=%str(a=1),b=%compress(&source),msg=%quote(compress(&source)));

	%let source=%str(a=1  	b=-2);
	%assertEqual(a=%str(a=1b=-2),b=%compress(&source),msg=%quote(compress(&source)));

	%let source=%str(abc			 	def);
	%assertEqual(a=%str(abcdef),b=%compress(&source),msg=%quote(compress(&source)));

	%let source=%str();
	%assertEqual(a=,b=%compress(&source),msg=%quote(compress(&source)));

	%let source=%str( a=-2 b=dbc c=-23	);
	%assertEqual(a=%str(a=-2b=dbcc=-23),b=%compress(&source),msg=%quote(compress(&source)));

	%let source=%str( a='a' b='b'	);
	%assertEqual(a=%str(a='a'b='b'),b=%compress(&source),msg=%quote(compress(&source)));

	%let source=%str( a=-2 b='dbc     ' c=-23	);;
	%assertEqual(a=%str(a=-2b=%'dbc%'c=-23),b=%compress(&source),msg=%quote(compress(&source)));

	%let source=%str(汉字 测试 删除);
	%assertEqual(a=%str(汉字测试删除),b=%compress(&source),msg=%quote(compress(&source)));

	%let source=%str(	汉字  		);
	%assertEqual(a=%str(汉字),b=%compress(&source),msg=%quote(compress(&source)));

	%let source=%str( 汉字 测试 	);;
	%assertEqual(a=%str(汉字测试),b=%compress(&source),msg=%quote(compress(&source)));
	
%mend;

%test_compress;

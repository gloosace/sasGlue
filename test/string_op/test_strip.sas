
%macro test_strip;

	%local source;

	%let source=%str(a=1);
	%assertEqual(a=%str(a=1),b=%strip(&source),msg=%quote(strip(&source)));

	%let source=%str( a=1 );
	%assertEqual(a=%str(a=1),b=%strip(&source),msg=%quote(strip(&source)));

	%let source=%str(a=1 );
	%assertEqual(a=%str(a=1),b=%strip(&source),msg=%quote(strip(&source)));

	%let source=%str( a=1);
	%assertEqual(a=%str(a=1),b=%strip(&source),msg=%quote(strip(&source)));

	%let source=%str();
	%assertEqual(a=,b=%strip(&source),msg=%quote(strip(&source)));

	%let source=%str( a=-2 b='dbc' c=-23	);
	%assertEqual(a=%str(a=-2 b='dbc' c=-23),b=%strip(&source),msg=%quote(strip(&source)));

	
	%let source=%str( 汉字 测试   );
	%assertEqual(a=%str(汉字 测试),b=%strip(&source),msg=%quote(strip(&source)));

	%let source=%str(	汉字  		);
	%assertEqual(a=%str(汉字),b=%strip(&source),msg=%quote(strip(&source)));

	%let source=%str(  汉字 abc d 测试	);
	%assertEqual(a=%str(汉字 abc d 测试),b=%strip(&source),msg=%quote(strip(&source)));

%mend;

%test_strip;

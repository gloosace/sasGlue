%macro test_reverse;

	%local source;

	%let source=%str( a b c );
	%assertEqual(a=%str( c b a ),b=%reverse(&source),msg=%quote(reverse(&source)));

	%let source=%str( a=1 );
	%assertEqual(a=%str( 1=a ),b=%reverse(&source),msg=%quote(reverse(&source)));

	%let source=%str();
	%assertEqual(a=,b=%reverse(&source),msg=%quote(reverse(&source)));

	%let source=%str(a=b,x=y);
	%assertEqual(a=%str(y=x,b=a),b=%reverse(&source),msg=%quote(reverse(&source)));

	%let source=%str(汉字 测试);
	%assertEqual(a=%str(试测 字汉),b=%reverse(&source),msg=%quote(reverse(&source)));

	%let source=%str( 汉字  );
	%assertEqual(a=%str(  字汉 ),b=%reverse(&source),msg=%quote(reverse(&source)));

	
%mend;

%test_reverse;

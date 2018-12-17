
%macro test_repeat;

	%local source n;

	%let source=%str(abc);
	%let n=3;
	%assertEqual(a=%str(abcabcabc),b=%repeat(&source,&n),msg=%quote(repeat(&source,&n)));

	%let source=%str();
	%let n=3;
	%assertEqual(a=%str(),b=%repeat(&source,&n),msg=%quote(repeat(&source,&n)));

	%let source=%str(abc);
	%let n=1;
	%assertEqual(a=%str(abc),b=%repeat(&source,&n),msg=%quote(repeat(&source,&n)));

	%let source=%str(abc);
	%let n=0;
	%assertEqual(a=%str(),b=%repeat(&source,&n),msg=%quote(repeat(&source,&n)));

	%let source=%str( 汉字);
	%let n=2;
	%assertEqual(a=%str( 汉字 汉字),b=%repeat(&source,&n),msg=%quote(repeat(&source,&n)));

	%let source=%str(汉字测试 );
	%let n=3;
	%assertEqual(a=%str(汉字测试 汉字测试 汉字测试 ),b=%repeat(&source,&n),msg=%quote(repeat(&source,&n)));

	%let source=%str(abc);
	%let n=-1.4;
	%assertEqual(a=%str(),b=%repeat(&source,&n),msg=%quote(repeat(&source,&n)));

	%let source=%str(abc);
	%let n=2.4;
	%assertEqual(a=%str(abcabc),b=%repeat(&source,&n),msg=%quote(repeat(&source,&n)));

	%let source=%str(abc);
	%let n=2.6;
	%assertEqual(a=%str(abcabc),b=%repeat(&source,&n),msg=%quote(repeat(&source,&n)));

	%let source=%str(abc);
	%let n=3.1;
	%assertEqual(a=%str(abcabcabc),b=%repeat(&source,&n),msg=%quote(repeat(&source,&n)));


%mend;

%test_repeat;

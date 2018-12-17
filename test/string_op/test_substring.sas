

%macro test_substring;

	%let source=abc;
	%let start=1;
	%let end=2;
	%assertEqual(a=%str(ab),b=%substring(&source,&start,&end),msg=%quote(substring(&source,&start,&end)));

	%let source=%str(abcdefghijk); 
	%let start=3;
	%let end=6;
	%assertEqual(a=%str(cdef),b=%substring(&source,&start,&end),msg=%quote(substring(&source,&start,&end)));

	%let source=%str(abcdefghijk); 
	%let start=0;
	%let end=0;
	%assertEqual(a=%str(),b=%substring(&source,&start,&end),msg=%quote(substring(&source,&start,&end)));

	%let source=%str(abcdefghijk); 
	%let start=0;
	%let end=1;
	%assertEqual(a=%str(a),b=%substring(&source,&start,&end),msg=%quote(substring(&source,&start,&end)));

	%let source=%str(abcdefghijk); 
	%let start=;
	%let end=-2;
	%assertEqual(a=%str(abcdefghij),b=%substring(&source,&start,&end),msg=%quote(substring(&source,&start,&end)));

	%let source=%str(abcdefghijk); 
	%let start=-4;
	%let end=-2;
	%assertEqual(a=%str(hij),b=%substring(&source,&start,&end),msg=%quote(substring(&source,&start,&end)));

	%let source=%str(abcdefghijk); 
	%let start=4;
	%let end=2;
	%assertEqual(a=%str(dcb),b=%substring(&source,&start,&end),msg=%quote(substring(&source,&start,&end)));

	%let source=%str(abcdefghijk); 
	%let start=-2;
	%let end=2;
	%assertEqual(a=%str(jihgfedcb),b=%substring(&source,&start,&end),msg=%quote(substring(&source,&start,&end)));

	%let source=%str(ab cd ef gh ij k); 
	%let start=3;
	%let end=7;
	%assertEqual(a=%str( cd e),b=%substring(&source,&start,&end),msg=%quote(substring(&source,&start,&end)));

	%let source=%str(abcdef); 
	%let start=0;
	%let end=0;
	%assertEqual(a=%str(),b=%substring(&source,&start,&end),msg=%quote(substring(&source,&start,&end)));

	%let source=%str(ab 汉字 cdef 测试); 
	%let start=4;
	%let end=5;
	%assertEqual(a=%str(汉字),b=%substring(&source,&start,&end),msg=%quote(substring(&source,&start,&end)));

	%let source=%str(ab 汉字 cdef 测试); 
	%let start=5;
	%let end=4;
	%assertEqual(a=%str(字汉),b=%substring(&source,&start,&end),msg=%quote(substring(&source,&start,&end)));

	%let source=%str(ab 汉字 cdef 测试); 
	%let start=-1;
	%let end=1;
	%assertEqual(a=%str(试测 fedc 字汉 ba),b=%substring(&source,&start,&end),msg=%quote(substring(&source,&start,&end)));

%mend;


%test_substring;

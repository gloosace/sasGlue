

%macro test_padding;


	%local str char len fixed mode result newLen;

	%let str=abc;
	%let char=X;
	%let len=10;
	%let fixed=1;
	%let mode=RIGHT;
	%let result=abcXXXXXXX;
	%assertEqual(a=&result,b=%padding(str=&str,mode=&mode,char=&char,len=&len,fixed=&fixed));

	
	%let str=abc;
	%let char=123;
	%let len=10;
	%let fixed=1;
	%let mode=RIGHT;
	%let result=abc1231231;
	%assertEqual(a=&result,b=%padding(str=&str,mode=&mode,char=&char,len=&len,fixed=&fixed));

	%let str=abc;
	%let char=123;
	%let len=10;
	%let fixed=0;
	%let mode=RIGHT;
	%let result=abc123123123;
	%assertEqual(a=&result,b=%padding(str=&str,mode=&mode,char=&char,len=&len,fixed=&fixed));

	%let str=abc;
	%let char=123;
	%let len=10;
	%let fixed=1;
	%let mode=LEFT;
	%let result=3123123abc;
	%assertEqual(a=&result,b=%padding(str=&str,mode=&mode,char=&char,len=&len,fixed=&fixed));

	%let str=abc;
	%let char=123;
	%let len=10;
	%let fixed=0;
	%let mode=LEFT;
	%let result=123123123abc;
	%assertEqual(a=&result,b=%padding(str=&str,mode=&mode,char=&char,len=&len,fixed=&fixed));


	%let str=%str( a b c );
	%let char=%str( 123 );
	%let len=20;
	%let fixed=1;
	%let mode=RIGHT;
	%let result=%str( a b c  123  123  12);
	%assertEqual(a=&result,b=%padding(str=&str,mode=&mode,char=&char,len=&len,fixed=&fixed));

	%let str=abc;
	%let char=%str(,);
	%let len=10;
	%let fixed=0;
	%let mode=RIGHT;
	%let result=%str(abc,,,,,,,);
	%assertEqual(a=&result,b=%padding(str=&str,mode=&mode,char=&char,len=&len,fixed=&fixed));


	%let str=abc;
	%let char=汉字;
	%let len=10;
	%let fixed=1;
	%let mode=RIGHT;
	%let result=abc汉字汉字汉字汉;
	%assertEqual(a=&result,b=%padding(str=&str,mode=&mode,char=&char,len=&len,fixed=&fixed));

	%let str=abc;
	%let char=汉字;
	%let len=10;
	%let fixed=0;
	%let mode=RIGHT;
	%let result=abc汉字汉字汉字汉字;
	%assertEqual(a=&result,b=%padding(str=&str,mode=&mode,char=&char,len=&len,fixed=&fixed));


%mend;


%test_padding;

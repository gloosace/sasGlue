

%macro test_replaceStr;
	%local source target replacement cmd result expect; 

	%let source=%str(abc def);
	%let target=%str(abc);
	%let replacement=%str(xy);
	%let expect=%str(xy def);
	%assertEqual(a=&expect,b=%replaceStr(&source,&target,&replacement),msg=&cmd);

	%let source=%str(a b c d);
	%let target=%str(b);
	%let replacement=%str(x);
	%let expect=%str(a x c d);
	%assertEqual(a=&expect,b=%replaceStr(&source,&target,&replacement),msg=&cmd);

	%let source=%str(aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa);
	%let target=%str(a);
	%let replacement=%str(x);
	%let expect=%str(xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
	%assertEqual(a=&expect,b=%replaceStr(&source,&target,&replacement),msg=&cmd);
	

	%let source=%str(abc def acb dff);
	%let target=%str(a);
	%let replacement=%str(xy);
	%let expect=%str(xybc def xycb dff);
	%assertEqual(a=&expect,b=%replaceStr(&source,&target,&replacement),msg=&cmd);
	%put %replaceStr(&source,&target,&replacement);

	%let source=%str(abc def acb dff);
	%let target=%str(a);
	%let replacement=%str();
	%let expect=%str(bc def cb dff);
	%assertEqual(a=&expect,b=%replaceStr(&source,&target,&replacement),msg=&cmd);


	%let source=%str(汉字 def acb dff);
	%let target=%str(a);
	%let replacement=%str();
	%let expect=%str(汉字 def cb dff);
	%let cmd=%nrquote(%%replaceStr(&source,&target,&replacement));
	%assertEqual(a=&expect,b=%replaceStr(&source,&target,&replacement),msg=&cmd);

	%let source=%str(汉字 def 测试 dff);
	%let target=%str(字);
	%let replacement=%str(语);
	%let expect=%str(汉语 def 测试 dff);
	%assertEqual(a=&expect,b=%replaceStr(&source,&target,&replacement),msg=&cmd);

	%let source=%str(汉字 def 测试 字符 dff);
	%let target=%str(字);
	%let replacement=%str(X);
	%let expect=%str(汉X def 测试 X符 dff);
	%assertEqual(a=&expect,b=%replaceStr(&source,&target,&replacement),msg=&cmd);

	%let source=%str(汉字 def 测试 字符 dff);
	%let target=%str(d);
	%let replacement=%str(替换);
	%let expect=%str(汉字 替换ef 测试 字符 替换ff);
	%assertEqual(a=&expect,b=%replaceStr(&source,&target,&replacement),msg=&cmd);

	%let source=%str(a b c d e);
	%let target=%quote( );
	%let replacement=%str(_);
	%let expect=%str(a_b_c_d_e);
	%assertEqual(a=&expect,b=%replaceStr(&source,&target,&replacement),msg=&cmd);

	
%mend;


%test_replaceStr;

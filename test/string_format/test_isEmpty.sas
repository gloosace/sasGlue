%global CODE_PATH;
%let CODE_PATH=%str(D:\server\git_pulu\kalli\code\core\);
%include "&CODE_PATH.utili.sas";
options nosource;
%macro test_isEmpty;

	%local varname;

	%let varname=abC;
	%local &varname;
	%let &varname=%quote(content abc);
	%assertEqual(a=0,b=%isEmpty(&varname),msg=一般非空测试);

	%let varname=;
	%assertEqual(a=1,b=%isEmpty(&varname),msg=varname为空测试);

	%let varname=def;
	%assertEqual(a=1,b=%isEmpty(&varname),msg=变量未声明);

	%let varname=def;
	%local &varname;
	%let &varname=;
	%assertEqual(a=1,b=%isEmpty(&varname),msg=内容为空测试);

	%let varname=def;
	%local &varname;
	%let &varname=%quote(     );
	%assertEqual(a=0,b=%isEmpty(&varname),msg=内容为转义空格测试);

%mend;

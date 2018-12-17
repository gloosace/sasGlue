
data test_useDefaultValue;

	length a $ 8;
	a=' ';
	b=.;
	c=9999;
	d=1000;
	output;

	a='STR';
	b=123;
	c=.;
	d=.;
	output;

	a=' ';
	b=.;
	c=.;
	d=.;
	output;
run;

%macro test_defaultValueToScript;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local defaultValue s;
	%let defaultValue=%quote(a='abcdefghijiklmnopq' b=100 c=1234.56 d=5);
	%defaultValueToScript(defaultValue=&defaultValue,res=&tres);
	%put script=&&&tres;
%mend;



%macro test_useDefaultValue;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local defaultValue s;
	%let defaultValue=%quote(a='abcdefghijiklmnopq' b=100 c=1234.56 d=5);
	

	%print(data=test_useDefaultValue,title=RAW);
	%report(%quote(Default Value = &defaultValue));

	%useDefaultValue(data=test_useDefaultValue,defaultValue=&defaultValue,out=out_useDefaultValue);
	%print(data=out_useDefaultValue,title=USE DEFAULT VALUE TO ALL);

	%useDefaultValue(data=test_useDefaultValue,defaultValue=&defaultValue,vars=a b,out=out_useDefaultValue);
	%print(data=out_useDefaultValue,title=USE DEFAULT VALUE TO A & B);

%mend;

%test_defaultValueToScript;
%test_useDefaultValue;

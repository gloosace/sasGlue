


%macro test_assignsUpdate;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local desc a b target result;

	%let a=%quote(A=1 B=2 C=3);
	%let b=%quote(B=3 C=4 D=5);
	%let target=%quote(A=1 B=3 C=4 D=5);
	%assignsUpdate(a=&a,b=&b,res=&tres);%let result=&&&tres;
	%lbreak(%quote(&desc));
	%linfo(%quote(a=&a));
	%linfo(%quote(b=&b));
	%linfo(%quote(target=&target));
	%linfo(%quote(result=&result));
	%assertEqual(a=&target,b=&result);

	%let a=%quote(A='123' B=abc C=def);
	%let b=%quote(B=0.354 C=' def ' D=new_value);
	%let target=%quote(A='123' B=0.354 C=' def ' D=new_value);
	%assignsUpdate(a=&a,b=&b,res=&tres);%let result=&&&tres;
	%lbreak(%quote(&desc));
	%linfo(%quote(a=&a));
	%linfo(%quote(b=&b));
	%linfo(%quote(target=&target));
	%linfo(%quote(result=&result));
	%assertEqual(a=&target,b=&result);

	%let a=%quote(A='123' B=abc C=def);
	%let b=%quote(b=0.354 C=' def ' D=new_value);
	%let target=%quote(A='123' B=abc b=0.354 C=' def ' D=new_value);
	%assignsUpdate(a=&a,b=&b,caseSensitive=1,res=&tres);%let result=&&&tres;
	%lbreak(%quote(&desc));
	%linfo(%quote(a=&a));
	%linfo(%quote(b=&b));
	%linfo(%quote(target=&target));
	%linfo(%quote(result=&result));
	%assertEqual(a=&target,b=&result);

	%let a=;
	%let b=%quote(b=0.354 C=' def ' D=new_value);
	%let target=&b;
	%assignsUpdate(a=&a,b=&b,caseSensitive=1,res=&tres);%let result=&&&tres;
	%lbreak(%quote(&desc));
	%linfo(%quote(a=&a));
	%linfo(%quote(b=&b));
	%linfo(%quote(target=&target));
	%linfo(%quote(result=&result));
	%assertEqual(a=&target,b=&result);

	%let a=%quote(A='123' B=abc C=def);
	%let b=;
	%let target=&a;
	%assignsUpdate(a=&a,b=&b,caseSensitive=1,res=&tres);%let result=&&&tres;
	%lbreak(%quote(&desc));
	%linfo(%quote(a=&a));
	%linfo(%quote(b=&b));
	%linfo(%quote(target=&target));
	%linfo(%quote(result=&result));
	%assertEqual(a=&target,b=&result);

	%let a=%quote(A='123' B=abc C=def);
	%let b=%quote(A= B=0.321 D=new_value);
	%let target=%quote(C=def A= B=0.321 D=new_value);
	%assignsUpdate(a=&a,b=&b,caseSensitive=1,res=&tres);%let result=&&&tres;
	%lbreak(%quote(&desc));
	%linfo(%quote(a=&a));
	%linfo(%quote(b=&b));
	%linfo(%quote(target=&target));
	%linfo(%quote(result=&result));
	%assertEqual(a=&target,b=&result);
%mend;


%test_assignsUpdate;


%macro test_getAssignValue;
  	%local a e r;

  	%let a=%quote(A='abc');
  	%let e='abc';
  	%let r=%getAssignValue(&a);
  	%assertEqual(a=&e,b=&r);

  	%let a=%quote(A='abc'=b);
  	%let e=%str('abc'=b);
  	%let r=%getAssignValue(&a);
	%assertEqual(a=&e,b=&r);

 	%let a=%quote( ='abc');
	%let e='abc';
	%let r=%getAssignValue(&a);
	%assertEqual(a=&e,b=&r);

  	%let a=%quote(A='abc' B=123.234 C='汉字测试' d=string D=111111);
  	%let e=%quote('abc' B=123.234 C='汉字测试' d=string D=111111);
  	%let r=%getAssignValue(&a);
  	%assertEqual(a=&e,b=&r);

	%let a=;
  	%let e=;
  	%let r=%getAssignValue(&a);
  	%assertEqual(a=&e,b=&r);
%mend;

%test_getAssignValue;

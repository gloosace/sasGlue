

%macro test_getAssignVar;
  	%local a e r;

  	%let a=%quote(A='abc');
  	%let e=A;
  	%let r=%getAssignVar(&a);
  	%assertEqual(a=&e,b=&r);

  	%let a=%quote(A='abc'=b);
  	%let e=A;
  	%let r=%getAssignVar(&a);
	%assertEqual(a=&e,b=&r);

 	%let a=%quote( ='abc');
	%let e=;
	%let r=%getAssignVar(&a);
	%assertEqual(a=&e,b=&r);

  	%let a=%quote(A='abc' B=123.234 C='汉字测试' d=string D=111111);
  	%let e=A;
  	%let r=%getAssignVar(&a);
  	%assertEqual(a=&e,b=&r);

	%let a=;
  	%let e=;
  	%let r=%getAssignVar(&a);
  	%assertEqual(a=&e,b=&r);
%mend;

%test_getAssignVar;

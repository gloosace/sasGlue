
%macro test_assignsSuffix;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local prefix suffix cmd a r e;

	%let a=%quote(A='abc' B=123.234 C='ABC' d=ABCDFGH D=111111);
	%let prefix=PA_;
	%let suffix=_SX;
	%let e=%quote(PA_A_SX='abc' PA_B_SX=123.234 PA_C_SX='ABC' PA_d_SX=ABCDFGH PA_D_SX=111111);
	%assignsSuffix(assigns=&a,prefix=&prefix,suffix=&suffix,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);

%mend;

%test_assignsSuffix;

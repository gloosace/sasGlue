
%macro test_varsSort;
	%local a b exp case;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let a=%str(c b a);
	%let exp=%str(a b c);
	%varsSort(vars=&a,res=&tres);
	%assertEqual(a=&exp,b=&&&tres);

	%let a=%str(A b bb aa BB);
	%let exp=%str(A BB aa b bb);
	%varsSort(vars=&a,res=&tres);
	%assertEqual(a=&exp,b=&&&tres);

	%let a=%str(a=1    b=2    3=4);
	%let exp=%str(3=4 a=1 b=2);
	%varsSort(vars=&a,res=&tres);
	%assertEqual(a=&exp,b=&&&tres);

	%let a=%str(id='value'  id=' value ' value=123.55 class=A);
	%let exp=%str(class=A id=' value ' id='value' value=123.55);
	%varsSort(vars=&a,res=&tres);
	%assertEqual(a=&exp,b=&&&tres);

	%let a=%str(流 浀 浃 浂);
	* \u6d41 \u6d40 \u6d43 \u6d42;
	%let exp=%str(浀 流 浂 浃);
	* \u6d40 \u6d41 \u6d42 \u6d43;
	%varsSort(vars=&a,res=&tres);
	%assertEqual(a=&exp,b=&&&tres);

%mend;

%test_varsSort;



%macro test_varsMatch;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local v regexp e r;

	%let v=a_a d a_b abc a_c;
	%let regexp=%str(/^a_.*$/);
	%let e=a_a a_b a_c;
	%varsMatch(vars=&v,regexp=&regexp,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);

	%let v=abc def cde;
	%let regexp=%str(/^a_.*$/);
	%let e=;
	%varsMatch(vars=&v,regexp=&regexp,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);

	%let v=;
	%let regexp=%str(/^a_.*$/);
	%let e=;
	%varsMatch(vars=&v,regexp=&regexp,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);
%mend;

%test_varsMatch;

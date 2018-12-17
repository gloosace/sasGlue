

%macro test_macro(a=,b=,c=,d=,e=) /parmbuff;

	%put SYSPBUFF &syspbuff;
	%paramRequired4(&a,&b,&c,&d);
	%put PASS;
%mend;



%test_macro(a=1);

%test_macro(a=1,b=2);

%test_macro(a=1,b=2,c=%str( ),d=4);

%test_macro(a=1,b=2,c=3);

%test_macro(a=1,b=2,c=3,d=4);



data a;

	x=1;y='a';output;
	x=2;y='b';output;
run;


data b;

	x=2;y='b';output;
	x=1;y='a';output;
run;

data c;

	x=3;y='b';output;
	x=1;y='a';output;
run;

%macro test_assertDsEqual;


	%assertDsEqual(a=a,b=b,msg=%quote(EXPECTED=PASS));
	%assertDsEqual(a=a,b=c,msg=%quote(EXPECTED=FAILED));

%mend;

%test_assertDsEqual;



data t;
	x=1;y='a';output;
	x=2;y='b';output;
run;


data t2;
	length x 8 y $ 100;
run;

%setDsVarLen(data=t3,var=x,len=100);
%setDsVarLen(data=t3,var=y,len=100);


%macro test_assertDsNotExist;

	%lbreak(test_assertDsNotExist);
	%assertDsNotExist(data=nonexistdata,msg=%quote(EXPECTED=PASS));
	%assertDsNotExist(data=t,msg=%quote(EXPECTED=FAILED));
	%assertDsNotExist(data=t2,msg=%quote(EXPECTED=FAILED));
	%assertDsNotExist(data=t3,msg=%quote(EXPECTED=FAILED));
%mend;


%macro test_assertDsNoObs;

	%lbreak(test_assertDsNoObs);
	%assertDsNoObs(data=nonexistdata,msg=%quote(EXPECTED=PASS));
	%assertDsNoObs(data=t,msg=%quote(EXPECTED=FAILED));
	%assertDsNoObs(data=t2,msg=%quote(EXPECTED=FAILED));
	%assertDsNoObs(data=t3,msg=%quote(EXPECTED=PASS));
%mend;

%test_assertDsNotExist;
%test_assertDsNoObs;

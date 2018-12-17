
%macro test_arrayExtend;

	%local tres;%let tres=%createTempVar;%local &tres;
	%local arr;
	%arrayInit(5,&tres);
	%let arr=&&&tres;
	
	%getMacroVars(prefix=&arr,scope=GLOBAL,res=&tres);
	%lbreak(BASE);
	%put LENGTH=&&&arr.length;
	%put &&&tres;
	
	%arrayExtend(&arr,10);
	%getMacroVars(prefix=&arr,scope=GLOBAL,res=&tres);
	%lbreak(EXTEND TO 10);
	%put LENGTH=&&&arr.length;
	%put &&&tres;

	%arrayExtend(&arr,15);
	%getMacroVars(prefix=&arr,scope=GLOBAL,res=&tres);
	%lbreak(EXTEND TO 15);
	%put LENGTH=&&&arr.length;
	%put &&&tres;


	%arrayExtend(&arr,8);
	%getMacroVars(prefix=&arr,scope=GLOBAL,res=&tres);
	%lbreak(EXTEND TO 8);
	%put LENGTH=&&&arr.length;
	%put &&&tres;

	%dropArray(&arr);
%mend;


%test_arrayExtend;

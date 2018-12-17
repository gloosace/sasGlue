

%macro test_arrayInit;

	%local tres;%let tres=%createTempVar;%local &tres;
	%local arr;

	%arrayInit(10,&tres);
	%let arr=&&&tres;

	%put array=&arr;
	%getMacroVars(prefix=&arr,scope=GLOBAL,res=&tres);

	%lbreak(AFTER INIT);
	%put &&&tres;

	%arrayDelete(&arr);

	%lbreak(AFTER DELETE);
	
	%getMacroVars(prefix=&arr,scope=GLOBAL,res=&tres);
	%put &&&tres;
%mend;


%test_arrayInit;



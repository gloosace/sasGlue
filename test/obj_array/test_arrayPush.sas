

%macro test_arrayPush;

	%local tres;%let tres=%createTempVar;%local &tres;
	%local arr;
	%local i r;

	%arrayInit(,&tres);
	%let arr=&&&tres;

	%lbreak(%quote(array=&arr));
	%getMacroVars(prefix=&arr,scope=GLOBAL,res=&tres);


	%do i=1 %to 5;
		%lbreak(%quote(push step &i));
		%arrayPush(&arr,&i);
		%put &&&arr.&i;
		%getMacroVars(prefix=&arr,scope=GLOBAL,res=&tres);
		%put &&&tres;
	%end;

	%do i=1 %to 5;
		%lbreak(%quote(pop step &i));
		%let r=%arrayPop(&arr);
		%assertEqual(a=%eval(6-&i),b=&r);
		%getMacroVars(prefix=&arr,scope=GLOBAL,res=&tres);
		%put &&&tres;
	%end;

	%do i=1 %to 5;
		%lbreak(%quote(pop empty array step &i));
		%let r=%arrayPop(&arr);
		%assertEqual(a=&arr,b=&r);
	%end;

	%arrayDelete(&arr);

%mend;


%test_arrayPush;



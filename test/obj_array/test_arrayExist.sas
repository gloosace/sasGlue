
%macro test_arrayExist;

	%local tres;%let tres=%createTempVar;%local &tres;
	%local arr;

	%arrayInit(10,&tres);%let arr=&&&tres;
	%assertEqual(a=1,b=%arrayExist(&arr));

	%let &arr.length=0;
	%assertEqual(a=1,b=%arrayExist(&arr));

	%let &arr.length=;
	%assertEqual(a=0,b=%arrayExist(&arr));

	%symdel &&&arr.length;
	%assertEqual(a=0,b=%arrayExist(&arr));

	%global &&&arr.length;
	%let &arr.length=10;
	%assertEqual(a=1,b=%arrayExist(&arr));

	%arrayDelete(&arr);
	%assertEqual(a=0,b=%arrayExist(&arr));

%mend;

%test_arrayExist;


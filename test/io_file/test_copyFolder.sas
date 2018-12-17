
data small;
	do i=1 to 100;
		output;
	end;
run;

data big;
	do i=1 to 1000000;
		output;
	end;
run;

data others;
	do i=1 to 1000;
		output;
	end;
run;

%macro makeTestFolder;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local path tl;

	%let path=%getPath;


	%importLocalLib(l1,test_copyFolder_from);
	%checkFolder(&path.test_copyFolder_from\sub_folder\);
	%importTempLib(&path.test_copyFolder_from\sub_folder\,&tres);%let tl=&&&tres;

	%importLocalLib(l3,test_copyFolder_to_clean);
	%importLocalLib(l4,test_copyFolder_to_notClean);
	%importLocalLib(l5,test_copyFolder_to_lib);
	
	%copyDs(data=big,out=l1.data);
	%copyDs(data=small,out=l3.data);
	%copyDs(data=small,out=l4.data);
	%copyDs(data=small,out=l5.data);

	%dsToXlsx(data=others,out=l3.others);
	%dsToXlsx(data=others,out=l4.others);	
	%dsToXlsx(data=others,out=l5.others);

	%dsToXlsx(data=others,out=&tl..others);

	%dropLib(l1 l3 l4 l5 &tl);
%mend;


%macro test_copyFolder;
	
	%local path;

	%let path=%getPath;

	%let from=&path.test_copyFolder_from\;
	%importLocalLib(libFrom,test_copyFolder_from);
	%importLocalLib(libTo,test_copyFolder_to_lib);
	
	%copyFolder(from=&from,to=&path.test_copyFolder_new\);
	%copyFolder(from=&from,to=&path.test_copyFolder_to_clean\,clean=1);
	%copyFolder(from=&from,to=&path.test_copyFolder_to_notClean\);
	%copyFolder(inlib=libFrom,outlib=libTo);

	%dropLib(libFrom libTo);
%mend;

* step 1 删除所有测试文件夹;
* step 2 %makeTestFolder 确认创建正确;
* step 3 %test_copyFolder 检查复制正确;

%makeTestFolder;
%test_copyFolder;

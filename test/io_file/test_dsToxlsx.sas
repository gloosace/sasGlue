
data test;
	input x $ y;
	cards;
	a 1
	b 2
	c 3
	;
run;

data test2;
	do i=1 to 100;
		value=rand('uniform');
		output;
	end;
run;


%macro test_dsToXlsx;

	%local path xlsx;
	%let path=%getPath;
	

	%importLocalLib(local,test_dsToXlsx);
	%resetLib(local);

	%copyDs(data=test,out=local.test_local);
	%dsToXlsx(data=local.test_local);

	%dsToXlsx(data=test,out=local.test_out);

	%dsToXlsx(data=test,out=local.test_sheet);
	%dsToXlsx(data=test2,out=local.test_sheet,sheet=new_sheet);
	%dsToXlsx(data=test,out=local.test_sheet,sheet=new_sheet2);

	%dsToXlsx(data=test,out=local.test_sheet_overwrite,sheet=same);
	%dsToXlsx(data=test2,out=local.test_sheet_overwrite,sheet=same);


	%dsToXlsx(data=test,out=local.test_file_overwrite,newFile=1);
	%dsToXlsx(data=test,out=local.test_file_overwrite,sheet=new_sheet,newFile=1);
	%dsToXlsx(data=test,out=local.test_file_overwrite,sheet=new_sheet2,newFile=1);

	%let xlsx=&path.test_dsToXlsx\TEST_PATH.xlsx;
	%dsToXlsx(data=test,xlsx=&xlsx);

	%dropLocalLib;
%mend;


%test_dsToXlsx;

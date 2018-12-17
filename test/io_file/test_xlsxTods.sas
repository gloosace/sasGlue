

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


%macro test_xlsxToDs;

	%local path xlsx;


	%importLocalLib(local,test_xlsxToDs);
	%resetLib(local);

	%dsToXlsx(data=test,out=local.test,sheet=sheetA);
	%dsToXlsx(data=test2,out=local.test,sheet=sheetB);
	

	%xlsxToDs(data=local.test);
	%xlsxToDs(data=local.test,out=local.test_out);

	%xlsxToDs(data=local.test,out=local.test_sheet_A,sheet=sheetA);
	%xlsxToDs(data=local.test,out=local.test_sheet_B,sheet=sheetB);
	
	%xlsxToDs(data=local.test,out=local.test_where,sheet=sheetB,where=%quote(i>50));

	%let path=%getLibPath(local);
	%let xlsx=&path.test.xlsx;
	%xlsxToDs(xlsx=&xlsx,out=local.test_path);

	%xlsxToDs(xlsx=&xlsx,out=local.test_getnames,getnames=0);

	%dropLocalLib;
%mend;


%test_xlsxToDs;

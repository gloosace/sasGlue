
data temp;
	do i=1 to 100;
		output;
	end;
run;


%macro test_file;

	%local path;

	%importLocalLib(local,test_file);

	%resetLib(local);
	%let path=%getLibPath(local);

	%assertEqual(a=0,b=%fileExist(&path.table.xlsx));
	%assertEqual(a=0,b=%fileExist(&path.table2.xlsx));

	%dsToXlsx(data=temp,out=local.table);

	%assertEqual(a=1,b=%fileExist(&path.table.xlsx));
	%assertEqual(a=0,b=%fileExist(&path.table2.xlsx));

	%dropLib(local);
%mend;

%test_file;

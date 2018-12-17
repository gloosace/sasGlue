
%macro test_folder;

	%local path newFolder newFolder2;

	%let path=%getPath;
	%put path=&path;

	%let newFolder=&path.test_folder\;
	%let newFolder2=&path.test_folder2\;


	%deleteFolder(&newFolder);
	%deleteFolder(&newFolder2);

	%assertEqual(a=0,b=%folderExist(&newFolder));
	%assertEqual(a=0,b=%folderExist(&newFolder2));

	%checkFolder(&newFolder);
	%checkFolder(&newFolder2);

	%assertEqual(a=1,b=%folderExist(&newFolder));
	%assertEqual(a=1,b=%folderExist(&newFolder2));

	%deleteFolder(&newFolder)
	%assertEqual(a=0,b=%folderExist(&newFolder));
	%assertEqual(a=1,b=%folderExist(&newFolder2));


%mend;

%test_folder;

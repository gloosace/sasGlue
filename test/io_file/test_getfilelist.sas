

%macro create_testGetFileList;


	%local tres;%let tres=%createTempVar;%local &tres;

	%local files;

	%getFileList(res=&tres);%let files=&&&tres;
	%put test default=&files;

	%getFileList(onlyFolder=1,res=&tres);%let files=&&&tres;
	%put test onlyFolder=&files;

	%getFileList(onlyFile=1,res=&tres);%let files=&&&tres;
	%put test onlyFile=&files;

	%getFileList(path=%getLibPath(WORK),res=&tres);%let files=&&&tres;
	%put test path=&files;
	
%mend;

%create_testGetFileList;

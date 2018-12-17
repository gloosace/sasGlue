%macro test_getPath;

	%local i;


	%do i=1 %to 10;
		%put level=&i %getPath(,&i);
	%end;

	%do i=1 %to 10;
		%put level=-&i %getPath(,-&i);
	%end;

	%do i=1 %to 10;
		%put level=&i %getPath(%quote(C:\a\b\c\d\e\f\g\test.sas),&i);
	%end;

	%do i=1 %to 10;
		%put level=-&i %getPath(%quote(C:\a\b\c\d\e\f\g\test.sas),-&i);
	%end;

	%do i=1 %to 10;
		%put level=&i %getPath(%quote(C:\汉字\文件夹\测试\d\e\f\g\test.sas),&i);
	%end;
%mend;

%test_getPath;

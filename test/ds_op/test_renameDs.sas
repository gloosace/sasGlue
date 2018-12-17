



%macro test_renameDs;

	data test_renameDs_old;
		a=1;b=2;c=3;
	run;
	data test_renameDs_new;
		c=4;d=5;e=6;
	run;
	%renameDs(data=test_renameDs_old,new=notexist.test_renameDs_new);

%mend;

%test_renameDs;

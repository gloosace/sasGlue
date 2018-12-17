

%macro test_dropDs_prepare;

	%importLocalLib;

	data local.t1;
	run;

	data local.t2;
		a=1;b=2;c=3;
	run;
	%createIndex(data=local.t2,vars=a b);

	%dropLocalLib;
	
%mend;


%macro test_dropDs;
	%importLocalLib;

	%put local.t1 exsit=%dsExist(local.t1);
	%put local.t2 exsit=%dsExist(local.t2);

	%dropDs(local.t1 local.t2);

	%put local.t1 exsit=%dsExist(local.t1);
	%put local.t2 exsit=%dsExist(local.t2);


	%dropLocalLib;
%mend;

%test_dropDs_prepare;
%test_dropDs;

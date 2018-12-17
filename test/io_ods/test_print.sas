
data t;
	set sashelp.Vmacro;
run;

%macro test_print;


	%setODSDefault;
	%clearOutput;
	%print(data=t,vars=scope name value,title=%quote(MACRO VARIABLE LIST));
	

	%print(data=dsnotexist,title=%quote(DS NOT EXIST));

	%odsClose;
%mend;

%test_print;

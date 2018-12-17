

proc format;
	value fa 0='A0' 1='A1' 2='A2' 3='A3' other='NA';
	value $fb 'male'=1 'female'=2 other=99;
run;


data d;
	infile datalines dsd;
	drop type amount desc;
	input gender $ type $ value amount desc $;
	datalines;
	female,d,0,2,empty
	female,d,1,1,fruit
	female,d,2,2,fruit
	female,d,3,1,fruit
	male,g,0,3,empty
	male,g,1,2,man
	male,g,2,4,women
	 ,g,100,4,women
	;
run;


%macro test_changeFormat;
	
	%clearOutput;

	%copyDs(data=d,out=t);
	%print(data=t,title=%quote(value + FA BEFORE));
	%changeFormat(data=t,var=value,format=fa);
	%print(data=t,title=%quote(value + FA AFTER));
	
	%copyDs(data=d,out=t);
	%print(data=t,title=%quote(value + FA. BEFORE));
	%changeFormat(data=t,var=value,format=fa.);
	%print(data=t,title=%quote(value + FA. AFTER));

	%copyDs(data=d,out=t);
	%print(data=t,title=%quote(value gender BEFORE));
	%changeFormat(data=t,vars=value gender,formats=fa $fb);
	%print(data=t,title=%quote(value gender AFTER));
	

	%copyDs(data=d,out=t);
	%print(data=t,title=%quote(STMT BEFORE));
	%changeFormat(data=t,stmt=value fa. gender $fb.);
	%print(data=t,title=%quote(STMT AFTER));


%mend;

%test_changeFormat;

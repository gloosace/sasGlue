
proc format;
	value fa 
		0='A' 
		1='B' 
		2='C' 
		3='D' 
		other='NA';
	
	value $fb 
		'male'=1
		'female'=2 
		other=99;

	invalue $fa 
		0='A' 
		1='B' 
		2='C' 
		3='D' 
		other='NA';

	invalue fb 
		'male'=1 
		'female'=2 
		other=99;
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


%macro test_formatChange;
	
	%clearOutput;

	%copyDs(data=d,out=t);
	%print(data=t,title=%quote(value + FA BEFORE));
	%formatChange(data=t,vars=value,formats=$fa);
	%print(data=t,title=%quote(value + FA AFTER));
	
	%copyDs(data=d,out=t);
	%print(data=t,title=%quote(value + FA. BEFORE));
	%formatChange(data=t,vars=value,formats=$fa.);
	%print(data=t,title=%quote(value + FA. AFTER));

	%copyDs(data=d,out=t);
	%print(data=t,title=%quote(value gender BEFORE));
	%formatChange(data=t,vars=value gender,formats=$fa fb);
	%print(data=t,title=%quote(value gender AFTER));
	
	%copyDs(data=d,out=t);
	%print(data=t,title=%quote(value gender PUT BEFORE));
	%formatChange(data=t,vars=value gender,formats=fa fb,putVars=value);
	%print(data=t,title=%quote(value gender PUT AFTER));
	
	%copyDs(data=d,out=t);
	%print(data=t,title=%quote(value gender NEWVAR BEFORE));
	%formatChange(data=t,vars=value gender,outVars=newValue newGender,formats=$fa fb);
	%print(data=t,title=%quote(value gender NEWVAR AFTER));

	%copyDs(data=d,out=t);
	%print(data=t,title=%quote(value gender EXCHANGE BEFORE));
	%formatChange(data=t,vars=value gender,outVars=gender value,formats=$fa fb);
	%print(data=t,title=%quote(value gender EXCHANGE AFTER));
	
%mend;

%test_formatChange;

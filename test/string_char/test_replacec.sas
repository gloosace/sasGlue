

%macro test_replacec;
	%local source c pos;

	%lbreak(%quote(TEST 1));
	%let source=123456;
	%let c=x;
	%do pos=0 %to 7;
		%put source=&source c=&c pos=&pos result=%replacec(&source,&c,&pos);	
	%end;

	%lbreak(%quote(TEST 2));
	%let source=123456;
	%let c=C;
	%do pos=0 %to 7;
		%put source=&source c=&c pos=&pos result=%replacec(&source,&c,&pos);	
	%end;

	%lbreak(%quote(SOURCE=NULL));
	%let source=;
	%let c=x;
	%do pos=0 %to 7;
		%put source=&source c=&c pos=&pos result=%replacec(&source,&c,&pos);	
	%end;

	%lbreak(%quote(NEW=NULL));
	%let source=123456;
	%let c=;
	%do pos=0 %to 7;
		%put source=&source c=&c pos=&pos result=%replacec(&source,&c,&pos);	
	%end;

	%lbreak(%quote(NEW=XY));
	%let source=123456;
	%let c=xx;
	%do pos=0 %to 7;
		%put source=&source c=&c pos=&pos result=%replacec(&source,&c,&pos);	
	%end;

	%lbreak(%quote(POS=20));
	%let source=123456;
	%let c=C;
	%do pos=0 %to 20;
		%put source=&source c=&c pos=&pos result=%replacec(&source,&c,&pos);	
	%end;


	%lbreak(%quote(POS=-5));
	%let source=123456;
	%let c=C;
	%let pos=-5;
	%put source=&source c=&c pos=&pos result=%replacec(&source,&c,&pos);	
%mend;

%test_replacec;

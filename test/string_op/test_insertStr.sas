

%macro test_insertStr;
	%local source c pos;

	%lbreak(%quote(TEST 1));
	%let source=123456;
	%let c=X;
	%do pos=0 %to 7;
		%put source=&source c=&c pos=&pos result=%insertStr(&source,&c,&pos);	
	%end;

	%lbreak(%quote(TEST 2));
	%let source=123456;
	%let c=C;
	%do pos=0 %to 7;
		%put source=&source c=&c pos=&pos result=%insertStr(&source,&c,&pos);	
	%end;

	%lbreak(%quote(SOURCE=NULL));
	%let source=;
	%let c=x;
	%do pos=0 %to 7;
		%put source=&source c=&c pos=&pos result=%insertStr(&source,&c,&pos);	
	%end;

	%lbreak(%quote(NEW=NULL));
	%let source=123456;
	%let c=;
	%do pos=0 %to 7;
		%put source=&source c=&c pos=&pos result=%insertStr(&source,&c,&pos);	
	%end;

	%lbreak(%quote(NEW=_));
	%let source=123456;
	%let c=%str( );
	%do pos=0 %to 7;
		%put source=&source c=&c pos=&pos result=%insertStr(&source,&c,&pos);	
	%end;

	%lbreak(%quote(NEW=XY));
	%let source=123456;
	%let c=XY;
	%do pos=0 %to 7;
		%put source=&source c=&c pos=&pos result=%insertStr(&source,&c,&pos);	
	%end;

	%lbreak(%quote(POS=20));
	%let source=123456;
	%let c=C;
	%do pos=0 %to 20;
		%put source=&source c=&c pos=&pos result=%insertStr(&source,&c,&pos);	
	%end;

	%lbreak(%quote(TEST 汉字));
	%let source=一二三四五六;
	%let c=汉字;
	%do pos=0 %to 7;
		%put source=&source c=&c pos=&pos result=%insertStr(&source,&c,&pos);	
	%end;

%mend;

%test_insertStr;


%global test_mG xGlobal;
%let test_mG=G;
%let xGlobal=G;

%macro test_m3;

	%local test_m3 x3 y;
	%test_m2;

%mend;


%macro test_m2;

	%local test_m2 x2 y;
	%test_m1;

%mend;

%macro test_m1;

	%local test_m1 x1 y;
	%test_m0;

%mend;

%macro test_m0;
	
	%local tres;%let tres=%createTempVar;%local &tres;
	%local test_m0 x0 y i;
	%local prefix macro scope noprefix noduplicate;


	%let prefix=;
	%let macro=;
	%let scope=;
	%let noprefix=;
	%let noduplicate=;

	%put MACRO NAME TEST;
	%do i=0 %to 4;
		%let macro=test_m&i;
		%getMacroVars(prefix=&prefix,macro=&macro,scope=&scope,noPrefix=&noPrefix,noDuplicate=&noDuplicate,res=&tres);
		%put;
		%put prefix=&prefix macro=&macro scope=&scope noprefix=&noprefix noduplicate=&noduplicate;
		%put &&&tres;
	%end;
	

	%let prefix=;
	%let macro=;
	%let scope=USER;
	%let noprefix=;
	%let noduplicate=;
	%getMacroVars(prefix=&prefix,macro=&macro,scope=&scope,noPrefix=&noPrefix,noDuplicate=&noDuplicate,res=&tres);
	%put;
	%put SCOPE TEST;
	%put prefix=&prefix macro=&macro scope=&scope noprefix=&noprefix noduplicate=&noduplicate;
	%put &&&tres;


	%let prefix=test_;
	%let macro=;
	%let scope=USER;
	%let noprefix=;
	%let noduplicate=;
	%getMacroVars(prefix=&prefix,macro=&macro,scope=&scope,noPrefix=&noPrefix,noDuplicate=&noDuplicate,res=&tres);
	%put;
	%put PREFIX TEST;
	%put prefix=&prefix macro=&macro scope=&scope noprefix=&noprefix noduplicate=&noduplicate;
	%put &&&tres;


	%let prefix=;
	%let macro=;
	%let scope=LOCAL;
	%let noprefix=;
	%let noduplicate=;
	%getMacroVars(prefix=&prefix,macro=&macro,scope=&scope,noPrefix=&noPrefix,noDuplicate=&noDuplicate,res=&tres);
	%put;
	%put LOCAL TEST;
	%put prefix=&prefix macro=&macro scope=&scope noprefix=&noprefix noduplicate=&noduplicate;
	%put &&&tres;


	%let prefix=;
	%let macro=;
	%let scope=USER;
	%let noprefix=;
	%let noduplicate=0;
	%getMacroVars(prefix=&prefix,macro=&macro,scope=&scope,noPrefix=&noPrefix,noDuplicate=&noDuplicate,res=&tres);
	%put;
	%put DUPLICATE TEST;
	%put prefix=&prefix macro=&macro scope=&scope noprefix=&noprefix noduplicate=&noduplicate;
	%put &&&tres;

%mend;

%test_m3;


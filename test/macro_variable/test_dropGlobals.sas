
%macro test_dropGlobals;
	
	%local tres;%let tres=%createTempVar;%local &tres;

	%getMacroVars(scope=GLOBAL,res=&tres);%put &&&tres;

	%dropAllGlobals;
	%getMacroVars(scope=GLOBAL,res=&tres);%put &&&tres;


	%global g1 g2 g3 g4 k1 k2 k3 k4 l1 l2 l3 l4 m1 m2 m3 m4 m5;
	%getMacroVars(scope=GLOBAL,res=&tres);%put &&&tres;


	%dropGlobals(g1 g3 k1 k3 l1 l3);
	%getMacroVars(scope=GLOBAL,res=&tres);%put drop g1 g3 k1 k3 l1 l3 ---- &&&tres;


	%dropGlobals;
	%getMacroVars(scope=GLOBAL,res=&tres);%put drop nothing &&&tres;


	%dropGlobalsByPrefix(g);
	%getMacroVars(scope=GLOBAL,res=&tres);%put drop g ---- &&&tres;


	%dropGlobalsByPrefix(k l);
	%getMacroVars(scope=GLOBAL,res=&tres);%put drop k l ---- &&&tres;

	%dropGlobalsByPrefix;
	%getMacroVars(scope=GLOBAL,res=&tres);%put drop nothing ---- &&&tres;
%mend;


%test_dropGlobals;

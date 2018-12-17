%macro test_getDsVarTypes;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local tres2;%let tres2=%createTempVar;%local &tres2;

	%local data cmd vars;	
 
	%let data=t;
	%let cmd=%nrquote(%%getDsVarTypes(ds=t,resTypes=&tres,resVars=&tres2));

	%unquote(&cmd);
	%put dsVarType=&&&tres dsVars=&&&tres2;


	%local data cmd;	

	%let data=t;
	%let vars=tyPe date dateStr STATE nonexist;
	%let cmd=%nrquote(%%getDsVarTypes(ds=t,vars=&vars,resTypes=&tres,resVars=&tres2));

	%unquote(&cmd);
	%put dsVarType=&&&tres dsVars=&&&tres2;


%mend;

%test_getDsVarTypes;




%macro test_varsPadding;
	%local vars;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let vars=1234567890123456789012345678901234567890 1234567890123456789012345678901234567890 1234567890123456789012345678901234567890;
	%varsPadding(vars=&vars,mode=right,char=,len=32,fixed=1,res=&tres);
	%put vars=&vars;
	%put result=&&&tres;


	%let vars=a b c;
	%varsPadding(vars=&vars,mode=right,char=123,len=32,fixed=1,res=&tres);
	%put vars=&vars;
	%put result=&&&tres;


	%let vars=a b c;
	%varsPadding(vars=&vars,mode=right,char=,len=32,fixed=1,res=&tres);
	%put vars=&vars;
	%put result=&&&tres;

%mend;



%test_varsPadding;

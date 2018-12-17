
%macro test_varsSuffix;
	%local tres;%let tres=%createTempVar;%local &tres;

	%local vars e r;

	%let vars=A B C;
	%let e=P_A_S P_B_S P_C_S;
	%varsSuffix(vars=&vars,suffix=_S,prefix=P_,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);

	%let vars=A B C;
	%let e=A_S B_S C_S;
	%varsSuffix(vars=&vars,suffix=_S,prefix=,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);

	%let vars=A B C;
	%let e=P_A P_B P_C;
	%varsSuffix(vars=&vars,suffix=,prefix=P_,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);

	%let vars=A B C;
	%let e=A B C;
	%varsSuffix(vars=&vars,suffix=,prefix=,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);

	%let vars=A B C;
	%let e=%str((sampleId like '%A%') or (sampleId like '%B%') or (sampleId like '%C%'));
	%varsPrefix(vars=&vars,prefix=%nrstr(%(sampleId like %'%%),suffix=%nrstr(%%%'%)),delimiter=%str( or ),res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);

	%let vars=123456789012345678901234567890 123456789012345678901234567890;
	%let e=AAAAA123456789012345678901234567890BBBBB AAAAA123456789012345678901234567890BBBBB;
	%varsPrefix(vars=&vars,suffix=BBBBB,prefix=AAAAA,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);

	%let vars=123456789012345678901234567890 123456789012345678901234567890;
	%let e=AAAAA1234567890123456789012345 AAAAA1234567890123456789012345;
	%varsPrefix(vars=&vars,prefix=AAAAA,len=30,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);


	%let vars=123456789012345678901234567890 123456789012345678901234567890;
	%let e=AAAAA6789012345678901234567890 AAAAA6789012345678901234567890;
	%varsPrefix(vars=&vars,prefix=AAAAA,len=30,cut=left,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);


%mend;


%test_varsSuffix;

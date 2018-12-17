

%macro test_varname;

	%local var newvar cmd prefix;

	%assertEqual(a=varsuf,b=%suffixVar(var,suf),msg=&cmd);

	%assertEqual(a=prevar,b=%prefixVar(var,pre),msg=&cmd);

	%assertEqual(a=var,b=%dePrefixVar(newvar,new),msg=&cmd);
;
	%assertEqual(a=new,b=%deSuffixVar(newvar,var),msg=&cmd);

	%put %hashVar(abc);
	%put %hashVar(abc,8);
%mend;

%test_varname;

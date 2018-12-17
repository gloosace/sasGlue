
data t;
	a=1;b=2;c=3;d=4;
run;

%dsVarsRequired(data=,vars=);
%dsVarsRequired(data=t,vars=);
%dsVarsRequired(data=t,vars=a);
%dsVarsRequired(data=t,vars=a b);
%dsVarsRequired(data=t,vars=a b c);
%dsVarsRequired(data=t,vars=a b c d);
%dsVarsRequired(data=t,vars=a b c d e);
%dsVarsRequired(data=t,vars=a b c d e f);

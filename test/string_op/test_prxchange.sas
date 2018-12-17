
%macro test_prxchange;

	%local reg source times;
	
	%let reg=%str(s/a/x/);
	%let source=%str(abc);
	%let times=-1;
	%assertEqual(a=%str(xbc),b=%prxchange(&reg,&times,&source),msg=%quote(prxchagne(&reg,&times,&source)));

	%let reg=%str(s/a/x/);
	%let source=%str(abcadea);
	%let times=-1;
	%assertEqual(a=%str(xbcxdex),b=%prxchange(&reg,&times,&source),msg=%quote(prxchagne(&reg,&times,&source)));

	%let reg=%str(s/a/x/);
	%let source=%str(abcadea);
	%let times=1;
	%assertEqual(a=%str(xbcadea),b=%prxchange(&reg,&times,&source),msg=%quote(prxchagne(&reg,&times,&source)));

	%let reg=%str(s/(\w)/\U$1/);
	%let source=%str(abcadea);
	%let times=-1;
	%assertEqual(a=%str(ABCADEA),b=%prxchange(&reg,&times,&source),msg=%quote(prxchagne(&reg,&times,&source)));

	%let reg=%str(s/(\w)/\U$1/);
	%let source=%str(abcadea);
	%let times=0;
	%assertEqual(a=&source,b=%prxchange(&reg,&times,&source),msg=%quote(prxchagne(&reg,&times,&source)));
	
	%let reg=%str(s/(\w)/\U$1/);
	%let source=%str(abcadea);
	%let times=100;
	%assertEqual(a=%str(ABCADEA),b=%prxchange(&reg,&times,&source),msg=%quote(prxchagne(&reg,&times,&source)));

%mend;

%macro test_prxchange_err;

	%local reg source times res;	

	%let reg=%str();
	%let source=%str(abcadea);
	%let times=1;
	%lbreak(%quote(prxchange(&reg,&times,&source)) ERROR);
	%let res=%prxchange(&reg,&times,&source);
	
%mend;


%macro test_prxchange_err2;

	%local reg source times res;	

	%let reg=%str(s/(\w)/\U$1/);
	%let source=%str(abcadea);
	%let times=-3;
	%lbreak(%quote(prxchange(&reg,&times,&source)) ERROR);
	%let res=%prxchange(&reg,&times,&source);
	
%mend;

%test_prxchange;
%test_prxchange_err;
%test_prxchange_err2;

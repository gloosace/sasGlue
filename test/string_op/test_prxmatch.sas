
%macro test_prxmatch;

	%local reg source;
	
	%let reg=%str(/e/);
	%let source=abc def;
	%assertEqual(a=6,b=%prxmatch(&reg,&source),msg=%quote(prxmatch(&reg,&source)));

	%let reg=%str(/def/);
	%let source=abc def jkl;
	%assertEqual(a=5,b=%prxmatch(&reg,&source),msg=%quote(prxmatch(&reg,&source)));

	%let reg=%str(/^def$/);
	%let source=def;
	%assertEqual(a=1,b=%prxmatch(&reg,&source),msg=%quote(prxmatch(&reg,&source)));

	%let reg=%str(/^def$/);
	%let source=%str( def );
	%assertEqual(a=0,b=%prxmatch(&reg,&source),msg=%quote(prxmatch(&reg,&source)));

	%let reg=%str(/^def$/);
	%let source=%str();
	%assertEqual(a=0,b=%prxmatch(&reg,&source),msg=%quote(prxmatch(&reg,&source)));

%mend;

%macro test_prxmatch_err;

	%let reg=%str();
	%let source=%str(abc);
	%lbreak(%quote(prxmatch(&reg,&source)) ERROR);
	%prxmatch(&reg,&source);
	
%mend;

%test_prxmatch;
%test_prxmatch_err;

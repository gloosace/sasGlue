
%macro test_unsafequote;
	

	%local a i;

	%lbreak(unsafe quote quote 12);
	%let a=;
	%do i=1 %to 12;
		%let a=%quote(&a &i);
	  	%put i=&i &a;
	%end;

%mend;

%macro test_safequote;
	

	%local a i;

	%lbreak(safe quote 30);
	%let a=;
	%do i=1 %to 30;
		%let a=%safequote(&a &i);
	  	%put i=&i &a;
	%end;

	%lbreak(safequote cut in);
	%let a=;
	%do i=1 %to 30;
		%let a=%quote(&a &i);
	  	%put i=&i &a;
		%if &i=9 or &i=18 or &i=27 %then %let a=%safequote(&a);
	%end;

	%lbreak(safequote content test);
	%let a=%squote(a=b c='abc' d='.');
	%put &a;

	%let a=%squote(a=b c="abc" 汉字测试 d='.');
	%put &a;

	%let a=%squote(a=b , c='abc' d='.');
	%put &a;

	
	%let a=%squote(   a=b , c='abc' d='.'    );
	%put &a;


%mend;

%macro test_safequote_alternatives;

	%local a i;

	%lbreak(safe quote alternative qsysfunc);
	%let a=;
	%do i=1 %to 30;
		%let a=%quote(&a &i);
	  	%put &a;
		%if &i=9 or &i=18 or &i=27 %then %let a=%strip(&a);
	%end;

	%lbreak(safe quote alternative qupcase);
	%let a=;
	%do i=1 %to 30;
		%let a=%quote(&a &i);
	  	%put &a;
		%if &i=9 or &i=18 or &i=27 %then %let a=%qupcase(&a);
	%end;

	%lbreak(safe quote alternative qsubstr);
	%let a=;
	%do i=1 %to 30;
		%let a=%quote(&a &i);
	  	%put &a;
		%if &i=9 or &i=18 or &i=27 %then %let a=%qsubstr(&a,1);
	%end;


%mend;

/*

%test_unsafequote;
%test_safequote;
%test_safequote_alternatives;

*/


%test_safequote;

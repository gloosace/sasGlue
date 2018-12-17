

%macro test_unicodecParen;

	%local s;	

	%let s=%str(1);
	%assertEqual(a=%str(<u0031>),b=%unicodecParen(&s),msg=%quote(unicodecParen(&s)));
	
	%let s=%str(A);
	%assertEqual(a=%str(<u0041>),b=%unicodecParen(&s),msg=%quote(unicodecParen(&s)));

	%let s=%str(AB);
	%assertEqual(a=%str(<u0041><u0042>),b=%unicodecParen(&s),msg=%quote(unicodecParen(&s)));

%mend;

%macro test_unicodeParen;

	%local s;	

	%let s=%str(<u0031>);
	%assertEqual(a=1,b=%unicodeParen(&s),msg=%quote(unicodeParen(&s)));
	
	%let s=%str(<u0041>);
	%assertEqual(a=A,b=%unicodeParen(&s),msg=%quote(unicodeParen(&s)));

	%let s=%str(<u0041><u0042>);
	%assertEqual(a=%str(AB),b=%unicodeParen(&s),msg=%quote(unicodeParen(&s)));

%mend;



%test_unicodecParen;
%test_unicodeParen;

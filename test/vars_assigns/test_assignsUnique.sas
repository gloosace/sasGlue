

%macro test_assignsUnique;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local assigns caseSensitive e r;

    %let assigns=%quote(a='abc' a='e');
	%let caseSensitive=1;
	%let e=%str(a='e');
	%assignsUnique(assigns=&assigns,caseSensitive=&caseSensitive,res=&tres);%let r=&&&tres;
    %assertEqual(a=&e,b=&r);

	%let assigns=%quote( a='e' ='abc' );
	%let caseSensitive=1;
	%let e=%str(a='e');
	%assignsUnique(assigns=&assigns,caseSensitive=&caseSensitive,res=&tres);%let r=&&&tres;
    %assertEqual(a=&e,b=&r);

	%let assigns=%quote( a='abc' b='e');
	%let caseSensitive=1;
	%let e=%str(a='abc' b='e');
	%assignsUnique(assigns=&assigns,caseSensitive=&caseSensitive,res=&tres);%let r=&&&tres;
    %assertEqual(a=&e,b=&r);

	%let assigns=%quote( a='abc' A='e');
	%let caseSensitive=0;
	%let e=%quote(A='e');
	%assignsUnique(assigns=&assigns,caseSensitive=&caseSensitive,res=&tres);%let r=&&&tres;
    %assertEqual(a=&e,b=&r);

	%let assigns=%quote(a='xyz' A='abc' a='abc');
	%let caseSensitive=1;
	%let e=%quote(A='abc' a='abc');
	%assignsUnique(assigns=&assigns,caseSensitive=&caseSensitive,res=&tres);%let r=&&&tres;
    %assertEqual(a=&e,b=&r);

%mend;

%test_assignsUnique;

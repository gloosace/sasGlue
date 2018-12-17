
%macro test_sasVarsToVar;
	%local vars;
	%local tres;%let tres=%createTempVar;%local &tres;
	
	%let vars=%str(a b c);
	%assertEqual(a=%str(A_B_C),b=%sasVarsToVar(&vars),msg=%quote(sasVarsToVar(&vars)));

	%let vars=%str(X Y );
	%assertEqual(a=%str(X_Y),b=%sasVarsToVar(&vars),msg=%quote(sasVarsToVar(&vars)));
%mend;

%test_sasVarsToVar;

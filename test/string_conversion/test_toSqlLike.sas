
%macro test_toSqlLike;

	%local var;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let var=%str( abcdef );
	%put DEFAULT=%toSqlLike(&var);
	%put LEFT   =%toSqlLike(&var,left);
	%put RIGHT  =%toSqlLike(&var,right);
	%put EMPTY  =%toSqlLike();
	
%mend;


%test_toSqlLike;

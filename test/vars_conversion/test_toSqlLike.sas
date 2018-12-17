options nonotes;
%include "D:\server\git_pulu\kalli\code\core\init.sas";

%macro test_toSqlLike;


	%local var;
	%local tres;%let tres=%createTempVar;%local &tres;

	%let var=%str( abcdef );

	%put %toSqlLike(&var);

	%put %toSqlLike(&var,left);

	%put %toSqlLike(&var,right);
	%put %toSqlLike();
	

%mend;


%test_toSqlLike;

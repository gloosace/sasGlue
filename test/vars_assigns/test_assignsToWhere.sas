options nonotes;
%include "D:\server\git_pulu\kalli\code\core\init.sas";

%macro test_assignsToWhere;

	%local assigns;
	%let assigns=%quote(a=1 b=2 c='3');
	%put %assignsToWhere(&assigns);

%mend;

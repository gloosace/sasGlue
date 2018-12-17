options nonotes;
%include "D:\server\git_pulu\kalli\code\core\init.sas";

%macro test_varsPrefix;

	%local tres;%let tres=%createTempVar;%local &tres;
	%local vars result;

	%let vars=A B C;

	%varsPrefix(vars=&vars,prefix=%nrstr(%(sampleId like %'%%),suffix=%nrstr(%%%'%)),delimiter=%str( or ),res=&tres);%let result=&&&tres;
	%put result=&result;

%mend;

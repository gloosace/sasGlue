

data test;
	 a=1;b=2;c=3;d=4;
run;


%macro test_createIndex;
	%local tres;%let tres=%createTempVar;%local &tres;

	%local vars index;

	%let vars=a b;
	%let index=;
	%createIndex(data=test,vars=&vars,index=&index,res=&tres);%put createIndex vars=&vars input_index=&index output_index=&&&tres;

	
	%findIndex(data=test,vars=&vars,res=&tres);%put findIndex vars=&vars output_index=&&&tres;
	%let vars=A b;
	%findIndex(data=test,vars=&vars,res=&tres);%put findIndex vars=&vars output_index=&&&tres;
	%let vars=b a;
	%findIndex(data=test,vars=&vars,res=&tres);%put findIndex vars=&vars output_index=&&&tres;

	%let vars=a b;
	%let index=NEWINDEX;
	%createIndex(data=test,vars=&vars,index=&index,res=&tres);%put createIndex vars=&vars input_index=&index output_index=&&&tres;


	%put ;

	%let vars=a b c;
	%let index=INDEX_ABC;
	%createIndex(data=test,vars=&vars,index=&index,res=&tres);%put createIndex vars=&vars input_index=&index output_index=&&&tres;
	%findIndex(data=test,vars=&vars,res=&tres);%put findIndex vars=&vars output_index=&&&tres;


	%let vars=a b c;
	%let index=;
	%createIndex(data=test,vars=&vars,index=&index,res=&tres);%put createIndex vars=&vars input_index=&index output_index=&&&tres;
	
%mend;


%test_createIndex;

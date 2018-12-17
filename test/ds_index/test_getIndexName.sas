

%macro test_getIndexName;


		%local tres;%let tres=%createTempVar;%local &tres;

		%getIndexName(vars=a,res=&tres);%put vars=a index=&&&tres;
		%getIndexName(vars=a,res=&tres);%put vars=a index=&&&tres;

		%getIndexName(vars=a b,res=&tres);%put vars=a b index=&&&tres;
		%getIndexName(vars=A b,res=&tres);%put vars=A b index=&&&tres;
		%getIndexName(vars=b a,res=&tres);%put vars=b a index=&&&tres;

%mend;

%test_getIndexName;



%macro test_varsMaxLength;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local vars maxlength;

	%let vars=a bb ccc dddd;
	%varsMaxLength(vars=&vars,res=&tres);%let maxLength=&&&tres;
	%assertEqual(a=4,b=&maxLength,msg=%quote(vars=&vars));

	%let vars=a bb ' ' ' abcd ';
	%varsMaxLength(vars=&vars,res=&tres);%let maxLength=&&&tres;
	%assertEqual(a=8,b=&maxLength,msg=%quote(vars=&vars));

	%let vars=%quote(a bb d='abc' 'a=b');
	%varsMaxLength(vars=&vars,res=&tres);%let maxLength=&&&tres;
	%assertEqual(a=7,b=&maxLength,msg=%quote(vars=&vars));

	%let vars=%quote(   );
	%varsMaxLength(vars=&vars,res=&tres);%let maxLength=&&&tres;
	%assertEqual(a=0,b=&maxLength,msg=%quote(vars=&vars));

%mend;

%test_varsMaxLength;

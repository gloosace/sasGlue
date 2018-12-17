
%macro test_varsCat;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local x y;

	%let x=a b c d;
	%let y='1' '2' '3' '4';
	
	%varsCat(a=&x,b=&y,delimiter=,res=&tres);%put &&&tres;
	%varsCat(a=&x,b=&y,delimiter=%str(_),res=&tres);%put &&&tres;
	%varsCat(a=&x,b=&y,delimiter=%str(=),res=&tres);%put &&&tres;

	%varsCat(a=&y,b=&x,delimiter=%str(->),res=&tres);%put &&&tres;
%mend;


%macro test_varsCat_error;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local x y;

	%let x=a b c d;
	%let y='1' '2' '3';
	
	%varsCat(a=&x,b=&y,delimiter=,res=&tres);%put &&&tres;
	
%mend;

%test_varsCat;
%test_varsCat_error;

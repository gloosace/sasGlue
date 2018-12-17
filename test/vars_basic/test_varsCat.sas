
%macro test_varsCat;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local x y r;

	%let x=a b c d;
	%let y='1' '2' '3' '4';
	
	%varsCat(a=&x,b=&y,delimiter=,res=&tres);%let r=&&&tres;
	%assertEqual(a=%str(a'1' b'2' c'3' d'4'),b=&r);

	%varsCat(a=&x,b=&y,delimiter=%str(_),res=&tres);%let r=&&&tres;
	%assertEqual(a=%str(a_'1' b_'2' c_'3' d_'4'),b=&r);

	%varsCat(a=&x,b=&y,delimiter=%str(=),res=&tres);%let r=&&&tres;
	%assertEqual(a=%str(a='1' b='2' c='3' d='4'),b=&r);

	%varsCat(a=&x,b=&y,delimiter=%str(->),res=&tres);%let r=&&&tres;
	%assertEqual(a=%str(a->'1' b->'2' c->'3' d->'4'),b=&r);
%mend;


%macro test_varsCat_error;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local x y;

	%let x=a b c d;
	%let y='1' '2' '3';
	%lbreak(test_varsCat_error);
	%varsCat(a=&x,b=&y,delimiter=,res=&tres);%put &&&tres;
	
%mend;

%test_varsCat;
%test_varsCat_error;

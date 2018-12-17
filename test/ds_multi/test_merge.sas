
data X;
	length group C $ 100;
	infile datalines dsd;
	input id group $ seq A B C $;
	datalines;
1,A,1,10,100,A
2,A,1,20,200,B
3,A,2,30,300,C
;
run;

data Y;
	length group C $ 20;
	infile datalines dsd;
	input id group $ seq A B C $;
	datalines;
1,A,1,99,999,Y1 desc
2,A,1,88,777,Y2 desc
3,A,2,66,666,Y3 desc
4,A,2,77,888,Y4 desc
5,B,1,55,555,Y5 desc
6,X,1,.,555,Y6 desc
;
run;

data Z;
	length group D $ 100;
	infile datalines dsd;
	input id group $ seq A B D $;
	datalines;
1,A,1,7,0,Zzzz
2,A,1,6,0,Zzz
3,A,1,5,0,Zz
4,A,2,4,0,Zz
5,C,10,3,0,Zz
;
run;


data result;
	length group D $ 100;
	infile datalines dsd;
	input id group seq A B C $ D $;
	datalines;
	1,A,1,7,0,Y1 desc,Zzzz
	2,A,1,6,0,Y2 desc,Zzz
	3,A,1,5,0,Y3 desc,Zz
	4,A,2,4,0,Y4 desc,Zz
	5,B,1,55,555,Y5 desc,
	5,C,10,3,0, 	,Zz
	6,X,1,.,555,Y6 desc,
;
run;

data result_defaultValue;
	length group C D $ 100;
	infile datalines dsd;
	input id group seq A B C $ D $;
	datalines;
	1,A,1,7,0,Y1 desc,Zzzz
	2,A,1,6,0,Y2 desc,Zzz
	3,A,1,5,0,Y3 desc,Zz
	4,A,2,4,0,Y4 desc,Zz
	5,B,1,55,555,Y5 desc,DEFAULT D
	5,C,10,3,0,DEFAULT VALUE,Zz
	6,X,1,9999,555,Y6 desc,DEFAULT D
;
run;



%macro test_merge;

	%merge(tables=X Y Z,key=group id,out=out_merge);
	%assertDsEqual(a=result,b=out_merge);


	%merge(tables=X Y Z,key=group id,out=out_merge_defaultValue,defaultValue=%quote(A=9999 B=1234 C='DEFAULT VALUE' D='DEFAULT D'));
	%assertDsEqual(a=result_defaultValue,b=out_merge_defaultValue);




%mend;

%test_merge;

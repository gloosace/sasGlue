data temp;
	infile datalines dsd;
	input id type $ value desc $;
	length desc $ 20;
	datalines;
1,A,123,some desc
1,B,200,some desc
1,C,300,some desc
2,A,400,some desc
2,B,500,some desc
2,B,600,some desc
2,C,300,some desc
3,A,400,some desc
3,B,300,some desc
4,D,666,some desc
;
run;



%macro test_loadObj;
	%local tres;%let tres=%createTempVar;%local &tres;

	%local obj;

	%lbreak(FIRST OBS);
	%loadObj(ds=temp,res=&tres);%let obj=&&&tres;
	%showObj(&obj);
	%dropObj(&obj);

	%lbreak(TEST WHERE);
	%loadObj(data=temp,where=%str(id=1 and type='B'),res=&tres);%let obj=&&&tres;
	%showObj(&obj);
	%dropObj(&obj);

	%lbreak(TEST WHERE 2);
	%loadObj(data=temp,where=%str(id=2 and type='B'),res=&tres);%let obj=&&&tres;
	%showObj(&obj);
	%dropObj(&obj);

	%lbreak(TEST NOT EXIST);
	%loadObj(ds=temp,where=%str(id=100 and type='B'),res=&tres);%let obj=&&&tres;
	%showObj(&obj);
	%dropObj(&obj);
		
%mend;

%test_loadObj;

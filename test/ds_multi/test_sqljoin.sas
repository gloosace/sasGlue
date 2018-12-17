
data X;
	infile datalines dsd;
	input id seq A B C $;
	datalines;
1,1,.,100,C1
2,.,20,.,C2
3,2,30,300,C3
;
run;

data Y;
	infile datalines dsd;
	input id seq D $;
	datalines;
1,1,D1
2,.,D2
2,.,D3
4,3,D4
5,3,D5
;
run;

data Z;	
	infile datalines dsd;
	input id seq D $ E $;
	datalines;
1,1,DX,E1
1,3,,E2
2,2,,E3
4,5,,E4
;
run;


%macro test_innerjoin;

	%local defaultValue;
	%let defaultValue=%str(A=0 B=0 C='N' D='NULL');

	%print(data=X,title=X);
	%print(data=Y,title=Y);
	%print(data=Z,title=Z);

	%innerjoin(tables=X Y,key=id seq,out=out);
	%print(data=out,title=INNERJOIN XY);


	%innerjoin(tables=X Y,key=id seq,out=out,defaultValue=&defaultValue);
	%print(data=out,title=INNERJOIN XY DEFAULTVALUE);

	%copyDs(data=X,out=X1);
	%copyDs(data=Y,out=Y1);
	%innerjoin(tables=X1 Y1,key=id seq,out=X1);
	%print(data=X1,title=INNERJOIN XY OUTPUT TO X);

	%copyDs(data=X,out=X2);
	%copyDs(data=Y,out=Y2);
	%innerjoin(tables=X2 Y2,key=id seq,out=Y2);
	%print(data=Y2,title=INNERJOIN XY OUTPUT TO Y);

	%innerjoin(tables=X Y Z,key=id seq,out=out);
	%print(data=out,title=INNERJOIN XYZ);

	%innerjoin(tables=X Z Y,key=id seq,out=out);
	%print(data=out,title=INNERJOIN XZY);

%mend;



%macro test_leftjoin;

	%local defaultValue;
	%let defaultValue=%str(A=0 B=0 C='N' D='NULL');

	%print(data=X,title=X);
	%print(data=Y,title=Y);
	%print(data=Z,title=Z);

	%leftjoin(tables=X Y,key=id seq,out=out);
	%print(data=out,title=LEFTJOIN XY);


	%leftjoin(tables=X Y,key=id seq,out=out,defaultValue=&defaultValue);
	%print(data=out,title=LEFTJOIN XY DEFAULTVALUE);

	%copyDs(data=X,out=X1);
	%copyDs(data=Y,out=Y1);
	%leftjoin(tables=X1 Y1,key=id seq,out=X1);
	%print(data=X1,title=LEFTJOIN XY OUTPUT TO X);

	%copyDs(data=X,out=X2);
	%copyDs(data=Y,out=Y2);
	%leftjoin(tables=X2 Y2,key=id seq,out=Y2);
	%print(data=Y2,title=LEFTJOIN XY OUTPUT TO Y);

	%leftjoin(tables=X Y Z,key=id seq,out=out);
	%print(data=out,title=LEFTJOIN XYZ);

	%leftjoin(tables=X Z Y,key=id seq,out=out);
	%print(data=out,title=LEFTJOIN XZY);


%mend;


%macro test_outerjoin;

	%local defaultValue;
	%let defaultValue=%str(A=0 B=0 C='N' D='NULL');

	%print(data=X,title=X);
	%print(data=Y,title=Y);
	%print(data=Z,title=Z);

	%outerjoin(tables=X Y,key=id seq,out=out);
	%print(data=out,title=OUTERJOIN XY);


	%outerjoin(tables=X Y,key=id seq,out=out,defaultValue=&defaultValue);
	%print(data=out,title=OUTERJOIN XY DEFAULTVALUE);

	%copyDs(data=X,out=X1);
	%copyDs(data=Y,out=Y1);
	%outerjoin(tables=X1 Y1,key=id seq,out=X1);
	%print(data=X1,title=OUTERJOIN XY OUTPUT TO X);

	%copyDs(data=X,out=X2);
	%copyDs(data=Y,out=Y2);
	%outerjoin(tables=X2 Y2,key=id seq,out=Y2);
	%print(data=Y2,title=OUTERJOIN XY OUTPUT TO Y);

	%outerjoin(tables=X Y Z,key=id seq,out=out);
	%print(data=out,title=OUTERJOIN XYZ);

	%outerjoin(tables=X Z Y,key=id seq,out=out);
	%print(data=out,title=OUTERJOIN XZY);


%mend;

%clearOutput;
%test_innerjoin;
%test_leftjoin;
%test_outerjoin;

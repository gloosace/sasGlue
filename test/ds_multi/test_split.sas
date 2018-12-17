
data test_split;
	infile datalines dsd;
	input id group $ seq value;
	datalines;
1,A,1,10
2,A,1,20
3,A,1,30
4,A,2,40
5,A,2,50
6,B,1,60
7,B,1,70
8,B,2,80
9,B,2,90
10,B,2,100
;
run;


data out_simple_group_a;
	infile datalines dsd;
	input id group $ seq value;
	datalines;
1,A,1,10
2,A,1,20
3,A,1,30
4,A,2,40
5,A,2,50
;
run;

data out_simple_group_b;
	infile datalines dsd;
	input id group $ seq value;
	datalines;
6,B,1,60
7,B,1,70
8,B,2,80
9,B,2,90
10,B,2,100
;
run;

data out_simple_multi_group_a_seq_1;
	infile datalines dsd;
	input id group $ seq value;
	datalines;
1,A,1,10
2,A,1,20
3,A,1,30
;
run;

data out_simple_multi_group_a_seq_2;
	infile datalines dsd;
	input id group $ seq value;
	datalines;
4,A,2,40
5,A,2,50
;
run;

data out_simple_multi_group_b_seq_1;
	infile datalines dsd;
	input id group $ seq value;
	datalines;
6,B,1,60
7,B,1,70
;
run;

data out_simple_multi_group_b_seq_2;
	infile datalines dsd;
	input id group $ seq value;
	datalines;
8,B,2,80
9,B,2,90
10,B,2,100
;
run;

data test_split_longname;
	infile datalines dsd;
	input id group12345678901234567890group $ seq value;
	datalines;
1,A,1,10
2,A,1,20
3,A,1,30
4,A,2,40
5,A,2,50
6,B,1,60
7,B,1,70
8,B,2,80
9,B,2,90
10,B,2,100
;
run;

data test_split_setting;
	infile datalines dsd;
	input id group $ seq _out_ $;
	datalines;
1,A,1,local.A1
2,A,2,work.A2
3,B,1,local.B1
;
run;

data result_split_direct;
	infile datalines dsd;
	input group $ seq _out_ $ _count_;
	datalines;
A,1,local.A1,3
A,2,work.A2,2
B,1,local.B1,2
;
run;
data test_split_obs;
	infile datalines dsd;
	input id group $ seq value _out_ $;
	datalines;
1,A,1,10,local.X
2,A,1,20,local.Y
3,A,1,30,local.Y
4,A,2,40,local.Z
5,A,2,50,local.Z
6,B,1,60,local.X
7,B,1,70,local.Y
8,B,2,80,local.Z
9,B,2,90,local.Z
10,B,2,100,local.X
;
run;


data out_obs_X;
	infile datalines dsd;
	input id group $ seq value _out_ $;
	datalines;
1,A,1,10,local.X
6,B,1,60,local.X
10,B,2,100,local.X
;
run;

data out_obs_Y;
	infile datalines dsd;
	input id group $ seq value _out_ $;
	datalines;
2,A,1,20,local.Y
3,A,1,30,local.Y
7,B,1,70,local.Y
;
run;

data out_obs_Z;
	infile datalines dsd;
	input id group $ seq value _out_ $;
	datalines;
4,A,2,40,local.Z
5,A,2,50,local.Z
8,B,2,80,local.Z
9,B,2,90,local.Z
;
run;

data out_keepByVar_a;
	infile datalines dsd;
	input id seq value;
	datalines;
1,1,10
2,1,20
3,1,30
4,2,40
5,2,50
;
run;

data out_keepByVar_b;
	infile datalines dsd;
	input id seq value;
	datalines;
6,1,60
7,1,70
8,2,80
9,2,90
10,2,100
;
run;


%macro test_split_simple;

	
	%importLocalLib(local,test_split_simple);
	%split(data=test_split,by=group,outlib=local);
	%assertDsEqual(a=local.group_a,b=out_simple_group_a,msg=test_split_simple);
	%assertDsEqual(a=local.group_b,b=out_simple_group_b,msg=test_split_simple);
	
	
	%importLocalLib(local,test_split_simple_suffix);
	%split(data=test_split,by=group,outTableSuffix=_SUF,outTablePrefix=PRE_,outlib=local);
	%assertDsEqual(a=local.pre_group_a_suf,b=out_simple_group_a,msg=test_split_simple_suffix);
	%assertDsEqual(a=local.pre_group_b_suf,b=out_simple_group_b,msg=test_split_simple_suffix);
	
	%importLocalLib(local,test_split_simple_outPrefix);
	%split(data=test_split,by=group,outTableSuffix=,outTablePrefix=PRE_,outlib=local,outPrefix=%str(WORK.));
	%assertDsEqual(a=work.group_a,b=out_simple_group_a,msg=test_split_simple_outPrefix);
	%assertDsEqual(a=work.group_b,b=out_simple_group_b,msg=test_split_simple_outPrefix);

	%dropLocalLib;
%mend;


%macro test_split_simple_multi;

	%importLocalLib(local,test_split_simple_multi);
	%split(data=test_split,by=group seq,outlib=local);

	%assertDsEqual(a=local.group_a_seq_1,b=out_simple_multi_group_a_seq_1,msg=test_split_simple_multi);
	%assertDsEqual(a=local.group_a_seq_2,b=out_simple_multi_group_a_seq_2,msg=test_split_simple_multi);
	%assertDsEqual(a=local.group_b_seq_1,b=out_simple_multi_group_b_seq_1,msg=test_split_simple_multi);
	%assertDsEqual(a=local.group_b_seq_2,b=out_simple_multi_group_b_seq_2,msg=test_split_simple_multi);	
	
	%dropLocalLib;
%mend;


* test_split_hash;
%macro test_split_hash;
	%importLocalLib(local,test_split_hash);
	%split(data=test_split,by=group seq,outLib=local,method=HASH);
	%assertDsEqual(a=local.S%md5base32(GROUP_A_SEQ_1),b=out_simple_multi_group_a_seq_1,msg=test_split_hash);
	%assertDsEqual(a=local.S%md5base32(GROUP_A_SEQ_2),b=out_simple_multi_group_a_seq_2,msg=test_split_hash);
	%assertDsEqual(a=local.S%md5base32(GROUP_B_SEQ_1),b=out_simple_multi_group_b_seq_1,msg=test_split_hash);
	%assertDsEqual(a=local.S%md5base32(GROUP_B_SEQ_2),b=out_simple_multi_group_b_seq_2,msg=test_split_hash);	
%mend;


* test_split_direct;
%macro test_split_direct;
	%importLocalLib(local,test_split_direct);
	%split(data=test_split,by=group seq,method=DIRECT,outSetting=test_split_setting,result=result);
	%assertDsEqual(a=local.a1,b=out_simple_multi_group_a_seq_1,msg=test_split_direct);
	%assertDsEqual(a=work.a2,b=out_simple_multi_group_a_seq_2,msg=test_split_direct);
	%assertDsEqual(a=local.b1,b=out_simple_multi_group_b_seq_1,msg=test_split_direct);
	%assertDsEqual(a=result,b=result_split_direct,msg=test_split_direct);
	%dropLocalLib;
%mend;


%macro test_split_obs;
	%importLocalLib(local,test_split_obs);
	%split(data=test_split_obs,by=group seq,method=OBS,outSetting=test_split_setting,outLib=work);
	%assertDsEqual(a=local.X,b=out_obs_X,msg=test_split_obs);
	%assertDsEqual(a=local.Y,b=out_obs_Y,msg=test_split_obs);
	%assertDsEqual(a=local.Z,b=out_obs_Z,msg=test_split_obs);
	%dropLocalLib;
%mend;



* test_split_useVarName;
%macro test_split_useVarName;

	%importLocalLib(local,test_split_useVarName);
	%split(data=test_split,outlib=local,by=group,useVarName=0);

	%assertDsEqual(a=local.a,b=out_simple_group_a,msg=test_split_useVarName);
	%assertDsEqual(a=local.b,b=out_simple_group_b,msg=test_split_useVarName);

	%dropLocalLib;
%mend;

* test_split_keepByVar;
%macro test_split_keepByVar;

	%importLocalLib(local,test_split_keepByVar);
	%split(data=test_split,outlib=local,by=group,keepByVar=0);
	%assertDsEqual(a=local.group_a,b=out_keepByVar_a,msg=test_split_useVarName);
	%assertDsEqual(a=local.group_b,b=out_keepByVar_b,msg=test_split_useVarName);
	%dropLocalLib;
%mend;


* test_split_longname;
%macro test_split_longVarName_err;
	%split(data=test_split_longname,by=group12345678901234567890group seq);
%mend;


%test_split_simple;
%test_split_simple_multi;
%test_split_hash;
%test_split_direct;
%test_split_obs;
%test_split_useVarName;
%test_split_keepByVar;
%test_split_longVarname_err;


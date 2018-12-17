

* 从0开始创建4个变量,5个表;

%macro test_setDsVarLen_create;

    %linfo(test_setDsVarLen_create);
 
    %dropDs(test);

    %setDsVarLen(ds=test,var=var1,len=10);

    %copyDs(data=test,out=test_setDsVarLen_create_1);

    %setDsVarLen(ds=test,var=var2,len=20);

    %copyDs(data=test,out=test_setDsVarLen_create_2);

    %setDsVarLen(ds=test,var=var3,len=30);

    %copyDs(data=test,out=test_setDsVarLen_create_3);

    %setDsVarLen(ds=test,var=var4,len=0);

    %copyDs(data=test,out=test_setDsVarLen_create_4);

%mend;

data test_setDsVarLen_change;

    length a $ 10 b $ 10;
    a='aaa';
    b='bbb';
    x=123;
    output;
    a='aaaaaa';
    b='bbbbbb';
    x=999;
    output;
run;


%macro test_setDsVarLen_change;

    %linfo(test_setDsVarLen_change);
    %setDsVarLen(data=test_setDsVarLen_change,var=a,len=100);
    %setDsVarLen(data=test_setDsVarLen_change,var=b,len=5);

	 %setDsVarLen(ds=test_setDsVarLen_change,var=x,len=100);
%mend;




/*
%test_setDsVarLen_create;
%test_setDsVarLen_change;

*/


%test_setDsVarLen_change;

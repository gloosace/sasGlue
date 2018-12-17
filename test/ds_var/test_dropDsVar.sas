
data test_dropDsVar;
	keep a b c d;
	do i=1 to 100;
		a=i;
		b=i+1;
		c=i+2;
		d='test';
		output;
	end;
run;

%macro test_dropDsVar;
	%local tres;%let tres=%createTempVar;%local &tres;	
	%local e r;

	* 创建测试数据;
	%importLocalLib(local,test_dropDsVar);
	%copyDs(data=test_dropDsVar,out=local.drop_A);
	%createIndex(data=local.drop_A,vars=a b);

	%copyDs(data=test_dropDsVar,out=local.drop_B);
	%createIndex(data=local.drop_B,vars=a b);

	%copyDs(data=test_dropDsVar,out=local.drop_BC);
	%createIndex(data=local.drop_BC,vars=a b);

	
	%linfo(Drop A);
	%let e=b c d;
	%dropDsVar(data=local.drop_A,var=a);
	%getDsVarList(data=local.drop_A,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);

	%linfo(Drop B);
	%let e=a c d;
	%dropDsVar(ds=local.drop_B,var=B);
	%getDsVarList(data=local.drop_B,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);

	%linfo(Drop BC);
	%let e=a d;
	%dropDsVar(ds=local.drop_BC,vars=B C);
	%getDsVarList(data=local.drop_BC,res=&tres);%let r=&&&tres;
	%assertEqual(a=&e,b=&r);

	%dropLib(local);
	
%mend;

%test_dropDsVar;

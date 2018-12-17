

%macro test_g;

	%local L1 L2 L3 L4;
	%local tres;%let tres=%createTempVar;%local &tres;

	%newObj(members=a b c,res=&tres);%let L1=&&&tres;
	%arrayInit(10,&tres);%let L2=&&&tres;
	%newObj(members=x y z,res=&tres);%let L3=&&&tres;
	%arrayInit(20,&tres);%let L4=&&&tres;

	%put L1=&L1;
	%put L2=&L2;
	%put L3=&L3;
	%put L4=&L4;
	
	%let &L1.a=&L2;
	%let &L2.5=&L3;
	%let &L3.y=&L4;
	%let &L4.16=666666;

	%assertEqual(a=%g(&L1.a),b=&L2);
	%assertEqual(a=%g(&L1.a.5),b=&L3);
	%assertEqual(a=%g(&L1.a.5.y),b=&L4);
	%assertEqual(a=%g(&L1.a.5.y.16),b=666666);

	%assertEqual(a=%g(&L2.5),b=&L3);
	%assertEqual(a=%g(&L2.5.y),b=&L4);
	%assertEqual(a=%g(&L2.5.y.16),b=666666);

	%assertEqual(a=%g(&L3.y),b=&L4);
	%assertEqual(a=%g(&L3.y.16),b=666666);
	
	%assertEqual(a=%g(&L4.16),b=666666);

	%L(&L1.a.5.y.16,7777777);

	%assertEqual(a=%g(&L4.16),b=7777777);

	%dropObj(&L1 &L3);
	%arrayDelete(&L2 &L4);
%mend;


%macro test_g_err;
	%lbreak(%getInvoker);
	%local L1 L2 L3 L4;
	%local tres;%let tres=%createTempVar;%local &tres;

	%newObj(members=a b c,res=&tres);%let L1=&&&tres;
	%arrayInit(10,&tres);%let L2=&&&tres;
	%newObj(members=x y z,res=&tres);%let L3=&&&tres;
	%arrayInit(20,&tres);%let L4=&&&tres;

	%put L1=&L1;
	%put L2=&L2;
	%put L3=&L3;
	%put L4=&L4;
	
	%let &L1.a=&L2;
	%let &L2.5=&L3;
	%let &L3.y=&L4;
	%let &L4.16=666666;

	%put %G(&L1.a.999.y.16);
	
	%dropObj(&L1 &L3);
	%arrayDelete(&L2 &L4);

%mend;


%macro test_g_err2;
	%lbreak(%getInvoker);
	%local L1 L2 L3 L4;
	%local tres;%let tres=%createTempVar;%local &tres;

	%newObj(members=a b c,res=&tres);%let L1=&&&tres;
	%arrayInit(10,&tres);%let L2=&&&tres;
	%newObj(members=x y z,res=&tres);%let L3=&&&tres;
	%arrayInit(20,&tres);%let L4=&&&tres;

	%put L1=&L1;
	%put L2=&L2;
	%put L3=&L3;
	%put L4=&L4;
	
	%let &L1.a=&L2;
	%let &L2.5=&L3;
	%let &L3.y=&L4;
	%let &L4.16=666666;

	%put %G(&L1.b.5.y.16);
	
	%dropObj(&L1 &L3);
	%arrayDelete(&L2 &L4);

%mend;


%macro test_l_err;
	%lbreak(%getInvoker);
	%local L1 L2 L3 L4;
	%local tres;%let tres=%createTempVar;%local &tres;

	%newObj(members=a b c,res=&tres);%let L1=&&&tres;
	%arrayInit(10,&tres);%let L2=&&&tres;
	%newObj(members=x y z,res=&tres);%let L3=&&&tres;
	%arrayInit(20,&tres);%let L4=&&&tres;

	%put L1=&L1;
	%put L2=&L2;
	%put L3=&L3;
	%put L4=&L4;
	
	%let &L1.a=&L2;
	%let &L2.5=&L3;
	%let &L3.y=&L4;
	%let &L4.16=666666;

	%L(&L1.a.5.y.21,1000);
	
	%dropObj(&L1 &L3);
	%arrayDelete(&L2 &L4);

%mend;



%macro test_l_err2;
	%lbreak(%getInvoker);
	%local L1 L2 L3 L4;
	%local tres;%let tres=%createTempVar;%local &tres;

	%newObj(members=a b c,res=&tres);%let L1=&&&tres;
	%arrayInit(10,&tres);%let L2=&&&tres;
	%newObj(members=x y z,res=&tres);%let L3=&&&tres;
	%arrayInit(20,&tres);%let L4=&&&tres;

	%put L1=&L1;
	%put L2=&L2;
	%put L3=&L3;
	%put L4=&L4;
	
	%let &L1.a=&L2;
	%let &L2.5=&L3;
	%let &L3.y=&L4;
	%let &L4.16=666666;

	%L(&L1.a.5.q.16,1000);
	
	%dropObj(&L1 &L3);
	%arrayDelete(&L2 &L4);

%mend;

%macro test_l_err3;
	%lbreak(%getInvoker);
	%local L1 L2 L3 L4;
	%local tres;%let tres=%createTempVar;%local &tres;

	%newObj(members=a b c,res=&tres);%let L1=&&&tres;
	%arrayInit(10,&tres);%let L2=&&&tres;
	%newObj(members=x y z,res=&tres);%let L3=&&&tres;
	%arrayInit(20,&tres);%let L4=&&&tres;

	%put L1=&L1;
	%put L2=&L2;
	%put L3=&L3;
	%put L4=&L4;
	
	%let &L1.a=&L2;
	%let &L2.5=&L3;
	%let &L3.y=&L4;
	%let &L4.16=666666;

	%L(&L1.a.1000.q.16,1000);
	
	%dropObj(&L1 &L3);
	%arrayDelete(&L2 &L4);

%mend;

%macro test_l_err4;
	%lbreak(%getInvoker);
	%local L1 L2 L3 L4;
	%local tres;%let tres=%createTempVar;%local &tres;

	%newObj(members=a b c,res=&tres);%let L1=&&&tres;
	%arrayInit(10,&tres);%let L2=&&&tres;
	%newObj(members=x y z,res=&tres);%let L3=&&&tres;
	%arrayInit(20,&tres);%let L4=&&&tres;

	%put L1=&L1;
	%put L2=&L2;
	%put L3=&L3;
	%put L4=&L4;
	
	%let &L1.a=&L2;
	%let &L2.5=&L3;
	%let &L3.y=&L4;
	%let &L4.16=666666;

	%L(&L1.d.1000.q.16,1000);
	
	%dropObj(&L1 &L3);
	%arrayDelete(&L2 &L4);

%mend;

%macro test_l_err5;
	%lbreak(%getInvoker);
	%local L1 L2 L3 L4 L5;
	%local tres;%let tres=%createTempVar;%local &tres;

	%newObj(members=a b c,res=&tres);%let L1=&&&tres;
	%arrayInit(10,&tres);%let L2=&&&tres;
	%newObj(members=x y z,res=&tres);%let L3=&&&tres;
	%arrayInit(20,&tres);%let L4=&&&tres;

	%let L5=NOTEXIST;
	%put L1=&L1;
	%put L2=&L2;
	%put L3=&L3;
	%put L4=&L4;
	
	%let &L1.a=&L2;
	%let &L2.5=&L3;
	%let &L3.y=&L4;
	%let &L4.16=666666;

	%L(&L5.d.1000.q.16,1000);
	
	%dropObj(&L1 &L3);
	%arrayDelete(&L2 &L4);

%mend;


%macro test_nested_vars_obj;
	%lbreak(%getInvoker);

	%local L1 L2 L3 L4 vars var;
	%local tres;%let tres=%createTempVar;%local &tres;

	%newObj(members=a b c,res=&tres);%let L1=&&&tres;
	%arrayInit(10,&tres);%let L2=&&&tres;
	%newObj(members=x y z,res=&tres);%let L3=&&&tres;
	%arrayInit(20,&tres);%let L4=&&&tres;

	%let vars=&L1 &L2 &L3 &L4;
	
	%let &L3.x=XXX;
	%put %varsU(&vars,3);
	%let var= %varsU(&vars,3);
	%put %unquote(&&%varsK(&vars,3)x);

	
	%dropObj(&L1 &L3);
	%arrayDelete(&L2 &L4);

%mend;


/*

	展示多层obj嵌套的效果，即类似myobj.type.class形式的引用;
	如下构建3个嵌套obj，其中;
		obj1.a					obj2
		obj1.a.a				obj3
		obj1.a.a.a				obj3.a = I'm here
		obj2.a.a				obj3.a = I'm here
	
	此测试用例用于展示如果要实现这种引用，在sas语法中需要多少层的&嵌套，实际使用中不建议这样使用;
*/

%macro test_obj_nested;

	%local obj1 obj2;
	%local tres;%let tres=%createTempVar;%local &tres;

	%newObj(members=a b c,res=&tres);%let obj1=&&&tres;
	%newObj(members=a b c,res=&tres);%let obj2=&&&tres;
	%newObj(members=a b c,res=&tres);%let obj3=&&&tres;

	%let &obj3.a=I AM HERE!!!!!!!!!;
	%let &obj2.a=&obj3;
	%let &obj1.a=&obj2;

	%put 1 obj2.a.a=	&obj2.a.a;
	%put 2 obj2.a.a=	&&obj2.a.a;
	%put 3 obj2.a.a=	&&&obj2.a.a;
	%put 4 obj2.a.a=	&&&&obj2.a.a;
	%put 5 obj2.a.a=	&&&&&obj2.a.a;
	%put 6 obj2.a.a=	&&&&&&obj2.a.a;
	%put 7 obj2.a.a=	&&&&&&&obj2.a.a;

	%put 7 obj2.a.a=	&&&&&&&obj2.a.a;

	
	%put 1 obj1.a.a.a=	&obj1.a.a.a;
	%put 2 obj1.a.a.a=	&&obj1.a.a.a;
	%put 3 obj1.a.a.a=	&&&obj1.a.a.a;
	%put 4 obj1.a.a.a=	&&&&obj1.a.a.a;
	%put 5 obj1.a.a.a=	&&&&&obj1.a.a.a;
	%put 6 obj1.a.a.a=	&&&&&&obj1.a.a.a;
	%put 7 obj1.a.a.a=	&&&&&&&obj1.a.a.a;
	%put 8 obj1.a.a.a=	&&&&&&&&obj1.a.a.a;
	%put 9 obj1.a.a.a=	&&&&&&&&&obj1.a.a.a;
	%put 10 obj1.a.a.a=	&&&&&&&&&&obj1.a.a.a;
	%put 11 obj1.a.a.a=	&&&&&&&&&&&obj1.a.a.a;
	%put 12 obj1.a.a.a=	&&&&&&&&&&&&obj1.a.a.a;
	%put 13 obj1.a.a.a=	&&&&&&&&&&&&&obj1.a.a.a;
	%put 14 obj1.a.a.a=	&&&&&&&&&&&&&&obj1.a.a.a;
	%put 15 obj1.a.a.a=	&&&&&&&&&&&&&&&obj1.a.a.a;
	%put 16 obj1.a.a.a=	&&&&&&&&&&&&&&&&obj1.a.a.a;


	%dropObj(&obj1);
	%dropObj(&obj2);
	%dropObj(&obj3);
%mend;


/*
%test_g;
%test_g_err;
%test_g_err2;
%test_l_err;
%test_l_err2;
%test_l_err3;
%test_l_err4;
%test_l_err5;
%test_obj_nested;

*/

%test_nested_vars_obj;

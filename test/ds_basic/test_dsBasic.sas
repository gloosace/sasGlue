

data t;
		infile datalines dsd; 
		input name $ type $ dateStr $ state $;
		date=input(dateStr,B8601DA8.);
		datalines;
	100,A,20150101,ok
	100,A,20150221,pastdue
	100,A,20150406,ok
	100,A,20150611,ok
	;
run;

%macro test_dsBasic;

	%local ds e r f;
	%let ds=test;
	%let e=TEST;
	%let f=%nrquote(%%getTableName(&ds));
	%let r=%unquote(&f);
	%assertEqual(a=&e,b=&r,msg=&f);

	%let ds=test;
	%let e=WORK;
	%let f=%nrquote(%%getLibname(&ds));
	%let r=%unquote(&f);
	%assertEqual(a=&e,b=&r,msg=&f);

	%local lib;
	%let lib=ABC;
	%let e=WORK;
	%let f=%nrquote(%%createTempDs(&lib));
	%let r=%unquote(&f);
	%linfo(&f result: &r);

	%let prefix=TTT;
	%let f=%nrquote(%%createTempTable(&prefix));
	%let r=%unquote(&f);
	%linfo(&f result: &r);

	%local lib;
	%let lib=WORK;
	%let f=%nrquote(%%getLibPath(&lib));
	%let r=%unquote(&f);
	%linfo(&f result: &r);

	%importLocalLib;
	%let lib=LOCAL;
	%let f=%nrquote(%%getLibPath(&lib));
	%let r=%unquote(&f);
	%linfo(&f result: &r);

	%local pa pb;
	%let pa=D:\abc\def\;
	%let pb=D:\abc\Def\;
	%let e=1;
	%let f=%nrquote(%%pathEqual(&pa,&pb));
	%let r=%unquote(&f);
	%assertEqual(a=&e,b=&r,msg=&f);

	%let pa=D:\abc\def\abc;
	%let pb=D:\abc\Def\;
	%let e=0;
	%let f=%nrquote(%%pathEqual(&pa,&pb));
	%let r=%unquote(&f);
	%assertEqual(a=&e,b=&r,msg=&f);

	%let pa=;
	%let pb=D:\abc\Def\;
	%let e=0;
	%let f=%nrquote(%%pathEqual(&pa,&pb));
	%let r=%unquote(&f);
	%assertEqual(a=&e,b=&r,msg=&f);

	%let pa=;
	%let pb=;
	%let e=1;
	%let f=%nrquote(%%pathEqual(&pa,&pb));
	%let r=%unquote(&f);
	%assertEqual(a=&e,b=&r,msg=&f);


	%importLocalLib(l1,t1);
	%importLocalLib(l2,t2);
	%let e=0;
	%let f=%nrquote(%%libEqual(l1,l2));
	%let r=%unquote(&f);
	%assertEqual(a=&e,b=&r,msg=&f);
	%dropTempLib(l1);%dropTempLib(l2);

	%importLocalLib(l1,t1);
	%importLocalLib(l2,t1);
	%let e=1;
	%let f=%nrquote(%%libEqual(l1,l2));
	%let r=%unquote(&f);
	%assertEqual(a=&e,b=&r,msg=&f);
	%dropTempLib(l1);%dropTempLib(l2);

	%let e=0;
	%let f=%nrquote(%%libEqual(l1,));
	%let r=%unquote(&f);
	%assertEqual(a=&e,b=&r,msg=&f);

	%let e=1;
	%let f=%nrquote(%%libEqual(,));
	%let r=%unquote(&f);
	%assertEqual(a=&e,b=&r,msg=&f);

	%local ta tb;
	%let ta=abc;
	%let tb=def;
	%let e=0;
	%let f=%nrquote(%%tableEqual(&ta,&tb));
	%let r=%unquote(&f);
	%assertEqual(a=&e,b=&r,msg=&f);

	%let ta=abc;
	%let tb=aBc ;
	%let e=1;
	%let f=%nrquote(%%tableEqual(&ta,&tb));
	%let r=%unquote(&f);
	%assertEqual(a=&e,b=&r,msg=&f);

	%let ta=;
	%let tb=aBc ;
	%let e=0;
	%let f=%nrquote(%%tableEqual(&ta,&tb));
	%let r=%unquote(&f);
	%assertEqual(a=&e,b=&r,msg=&f);

	%let ta=;
	%let tb= ;
	%let e=1;
	%let f=%nrquote(%%tableEqual(&ta,&tb));
	%let r=%unquote(&f);
	%assertEqual(a=&e,b=&r,msg=&f);

	%local d1 d2;
	%let d1=temp;
	%let d2=abc;
	%let e=0;
	%let f=%nrquote(%%dsEqual(&d1,&d2));
	%let r=%unquote(&f);
	%assertEqual(a=&e,b=&r,msg=&f);

	%let d1=temp;
	%let d2=work.Temp;
	%let e=1;
	%let f=%nrquote(%%dsEqual(&d1,&d2));
	%let r=%unquote(&f);
	%assertEqual(a=&e,b=&r,msg=&f);

	%let d1=temp;
	%let d2=;
	%let e=0;
	%let f=%nrquote(%%dsEqual(&d1,&d2));
	%let r=%unquote(&f);
	%assertEqual(a=&e,b=&r,msg=&f);

	%let d1=;
	%let d2=;
	%let e=1;
	%let f=%nrquote(%%dsEqual(&d1,&d2));
	%let r=%unquote(&f);
	%assertEqual(a=&e,b=&r,msg=&f);

	%importLocalLib(l1,t1);
	%importLocalLib(l2,t1);
	%let d1=l1.abc;
	%let d2=l2.abC;
	%let e=1;
	%let f=%nrquote(%%dsEqual(&d1,&d2));
	%let r=%unquote(&f);
	%assertEqual(a=&e,b=&r,msg=&f);
	%dropTempLib(l1);%dropTempLib(l2);

	%importLocalLib(l1,t1);
	%importLocalLib(l2,t2);
	%let d1=l1.abc;
	%let d2=l2.abc;
	%let e=0;
	%let f=%nrquote(%%dsEqual(&d1,&d2));
	%let r=%unquote(&f);
	%assertEqual(a=&e,b=&r,msg=&f);
	%dropTempLib(l1);%dropTempLib(l2);

%mend;



%test_dsBasic;

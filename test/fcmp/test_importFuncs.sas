

%macro test_prepare;

	%clearCmplib;

	%importLocalLib(local,test_importFuncs);

	proc fcmp outlib=local.myfuncs.aaa;
		function test_func(s $) $;
			put 'AAA.test_func';
			return('AAA');
		endsub;
	quit;

	proc fcmp outlib=local.myfuncs.bbb;
		function test_func(s $) $;
			put 'BBB.test_func';
			return('BBB');
		endsub;
	quit;

	%importFuncs(lib=local,table=myfuncs);

	proc fcmp outlib=local.func.main;
		function test(s $) $;
			x=aaa.test_func(' ');
			x=bbb.test_func(' ');
			return(' ');
		endsub;
		function test2(s $) $;
			x=bbb.test_func(' ');
			x=aaa.test_func(' ');
			return(' ');
		endsub;
	quit;

	%dropLocalLib;
%mend;


%macro test_importFuncs_err;

	%clearCmplib;
	data test;
		s=test('abc');
		s=test2('');
	run;

%mend;


%macro test_importFuncs;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local td;

	%importLocalLib(local,test_importFuncs);
	%clearCmplib;
	
	%put CMPLIB=%getOption(CMPLIB);
	%importFuncs(lib=local,table=myfuncs);
	%importFuncs(path=%getLibPath(local),table=func,res=&tres);%let td=&&&tres;
	%put CMPLIB=%getOption(CMPLIB);
	data test;
		s=test(' ');
		s=test2(' ');
	run;
	%dropFuncs(&td);
	%dropLib(%getLibName(&td));
	%put CMPLIB=%getOption(CMPLIB);
%mend;

%test_prepare;
%test_importFuncs_err;
%test_importFuncs;

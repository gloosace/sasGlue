
proc fcmp outlib=work.funcs.main;

	function self(a $ ) $;
		s=strInit(.);
		s=a;
		return(s);
	endsub;

	function test_strInit(a $) $;
		t=strInit(.);
		t=a;
		do i=10 to 300;
			t=repeat('*',i);
			l=length(t);
			put 'use strInit' i= l=;
		end;
		return(t);
	endsub;

	function test_strInit_compare11(a $) $;
		t=a;
		do i=10 to 300;
			t=repeat('*',i);
			l=length(t);
			put 'not use strInit 1' i= l=;;
		end;
		return(t);
	endsub;

	function test_strInit_compare12(a $) $;
		t=repeat('_',ceil(1+10*rand('uniform')));
		do i=10 to 300;
			t=repeat('*',i);
			l=length(t);
			put 'not use strInit 2' i= l=;;
		end;
		return(t);
	endsub;

	function test_strInit_compare21(a $) $;
		put a=;
		return(a);
	endsub;

	function test_strInit_compare22(a $) $;
		a='1234567890123456789012345678901234567890';
		put a=;
		return(a);
	endsub;

	function test_strInit_compare23(a $) $;
		a=a;
		put a=;
		return(a);
	endsub;

	subroutine test_strInit_compare3(a $,b $);
		outargs b;
		b=a;
		put 'test_strInit_compare3' b=;
	endsub;

	function test_run_4(a);
		o1='1234567890';
		o2='12345678901234567890';
		o3=strInit(.);
		call test_strInit_compare3('1234567890123456789012345678901234567890',o1);
		call test_strInit_compare3('1234567890123456789012345678901234567890',o2);
		call test_strInit_compare3('1234567890123456789012345678901234567890',o3);
		put o1=;
		put o2=;
		put o3=;
		return(.);
	endsub;

	function test_strInit_compare51(a $) $;
		if rand('uniform') > 0.5 then return('X');
		else return(a);
	endsub;

	function test_strInit_compare52(a $) $;
		if rand('uniform') <= 0.5 then return(a);
		else return('X');
	endsub;

	/* 
	* CORRECT IMPLEMENTATION;
	function test_strcode(s $) $;
		uc=strInit(.);
		uc=unicodec(strip(s),'PAREN');
		uc=transtrn(uc, '<u','');
		uc=transtrn(uc, '>','');
		return(uc);
	endsub;
	*/

	* WRONG IMPLEMENTATION;
	function test_strcode_err(s $) $;
		return(transtrn(transtrn(unicodec(strip(s),'PAREN'), '<u',''), '>',''));
	endsub;
 
	function test_cat_1(null) $;
		s=strInit(.);
		s=cats('PREFIX',s,'SUFFIX');
		put s=;
		return(s);
	endsub;

	function test_cat_2(null) $;
		s=strInit(.);
		s=cat('PREFIX','','SUFFIX');
		put s=;
		return(s);
	endsub;

	function test_cat_3(null) $;
		s=strInit(.);
		s=cat('PREFIX',s,'SUFFIX');
		put s=;
		return(s);
	endsub;

	function test_cat_4(null) $;
		length s $ 32767;
		s='';
		s=cat('PREFIX',s,'SUFFIX');
		put s=;
		return(s);
	endsub;

quit;

%macro test_strInit;

	data test_strInit;
		
		length c d p1 $ 100 p2 $ 10;

		x=test_strInit('123456');
		y=test_strInit_compare11('123456');
		z=test_strInit_compare12('123456');

		lx=length(x);
		ly=length(y);
		lz=length(z);
		put lx= ly= lz=;

		put '------------- test 2 --------------';

		put 'a:ARGUMENT';
		put 'c:RETURN defined len=100';
		put 'd:RETURN defined len=100';
		put 'p1:RETURN defined len=100';
		put 'p2:RETURN defined len=10';
		put 'q1:RETURN undefined ';
		put 'q2:RETURN undefined ';
		put 'r1:RETURN undefined ';
		put 'r2:RETURN undefined ';

		put '------------- test 2-1 --------------';
		c=test_strInit_compare21('1234567890123456789012345678901234567890');
		put c=;
		d=test_strInit_compare21('12345678901234567890');
		put d=;

		put '------------- test 2-2 --------------';
		c=test_strInit_compare22('1234567890123456789012345678901234567890');
		put c=;
		d=test_strInit_compare22('12345678901234567890');
		put d=;

		put '------------- test 2-3 --------------';
		c=test_strInit_compare23('1234567890123456789012345678901234567890');
		put c=;
		d=test_strInit_compare23('12345678901234567890');
		put d=;

		put '------------- test 3 --------------';
		call test_strInit_compare3('1234567890123456789012345678901234567890',p1);
		put p1=;
		call test_strInit_compare3('1234567890123456789012345678901234567890',p2);
		put p2=;

		put '------------- test 4 --------------';
		err=test_run_4(.);

		put '------------- test 5-1 --------------';
		do i=1 to 10;
			q1=test_strInit_compare51('1234567890123456789012345678901234567890');
			put q1=;
		end;
		do i=1 to 10;
			q2=test_strInit_compare51('12345678901234567890');
			put q2=;
		end;

		put '------------- test 5-2 --------------';
		do i=1 to 10;
			r1=test_strInit_compare52('1234567890123456789012345678901234567890');
			put r1=;
		end;
		do i=1 to 10;
			r2=test_strInit_compare52('12345678901234567890');
			put r2=;
		end;

	run;

%mend;

%macro test_strInit_strcode;
	data test_strcode;

		length result $ 1000;

		put '---- test_strInit_strcode ----';
		result=strcode('12345678901234567890');
		put result=;

		result=test_strcode_err('12345678901234567890');
		put result=;

	run;
%mend;

%macro test_strInit_cat;
	data test_cat;
		put '---- test_strInit_cat ----';
		result=test_cat_1(.);
		result=test_cat_2(.);
	run;
%mend;

%macro test_strInit_cat_err_3;
	data test_cat;
		put '----test_strInit_cat_err_3 ----';
		result=test_cat_3(.);
	run;
%mend;

%macro test_strInit_cat_err_4;
	data test_cat;
		put '---- test_strInit_cat_err_4 ----';
		result=test_cat_4(.);

	run;
%mend;

%test_strInit;
%test_strInit_strcode;
%test_strInit_cat;

%*test_strInit_cat_err_3;
%*test_strInit_cat_err_4;

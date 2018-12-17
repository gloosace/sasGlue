


data t(index=(name));
		infile datalines dsd; 
		input name $ type $ dateStr $ state $;
		date=input(dateStr,B8601DA8.);
		datalines;
	101,A,20150101,ok
	102,A,20150221,pastdue
	103,A,20150406,ok
	104,A,20150611,ok
	;
run;

data t2(index=(id));
		infile datalines dsd; 
		input id $ type $ dateStr $ state $;
		date=input(dateStr,B8601DA8.);
		datalines;
	101,A,20150101,ok
	102,A,20150221,pastdue
	103,A,20150406,ok
	105,A,20150611,ok
	106,A,20150101,ok
	101,A,20150101,ok
	102,A,20150221,pastdue
	103,A,20150406,ok
	105,A,20150611,ok
	106,A,20150101,ok
	;
run;


%macro test_copyDs;

	%importLocalLib(local1,temp1);
	%importLocalLib(local2,temp2);
	%importLocalLib(local3,temp3);
	%importLocalLib(local4,temp4);
	%importLocalLib(local5,temp5);
	%importLocalLib(local6,temp6);
	%importLocalLib(local7,temp7);
	%importLocalLib(local8,temp8);
	%importLocalLib(local9,temp9);
	%importLocalLib(local10,temp10);
	%importLocalLib(local11,temp11);
	%importLocalLib(local12,temp12);

	%importLocalLib(same1,same);
	%importLocalLib(same2,same);
	
	* step 1 简单copy ->lib1;
	%copyDs(data=t,out=local1.t);

	* step 2 不同lib out参数测试不同名 ->lib2;
	%copyDs(data=t,out=local2.t2);

	* step 3 不同lib outLib参数测试 ->lib3;
	%copyDs(data=t2,outLib=local3);

	* step 4 不同lib outPath参数测试 ->lib4;
	%copyDs(data=t2,outPath=%getLibPath(local4));

	* step 5 不同lib 输出位置参数优先级测试 + out参数测试同名 ->lib5;
	%copyDs(data=t2,out=local5.t2,outLib=local6,outPath=%getLibPath(local7));

	* step 6 不同lib 输出位置参数优先级测试2 outLib ->lib6;
	%copyDs(data=t2,outLib=local6,outPath=%getLibPath(local7));

	* step 7 不同lib 已有ds覆盖测试 lib6->lib8 work->lib8;
	%copyDs(data=t,outLib=local8);
	%copyDs(data=t2,out=local8.t);
	
	* step 8 不同lib 改名移动 lib9->lib10;
	%copyDs(data=t2,out=local9.t_old);
	%copyDs(data=local9.t_old,out=local10.t_new,isMove=1);

	* step 9 同lib 改名移动（重命名）;
	%copyDs(data=t,out=t_toBeMoved);
	%copyDs(data=t2,out=t_moved);
	%copyDs(data=t_toBeMoved,out=t_moved,isMove=1);

	* step 10 同lib 复制 不含索引 ->lib11;
	data t_noindex;
		a=1;b=2;c=3;d=4;
	run;
	%copyDs(data=t_noindex,out=local11.t_noindex);
	%put data set copy;
	options notes;
	%copyDs(data=local11.t_noindex,out=local11.t_noindex_copy);
	options nonotes;

	* step 11 同lib 复制 含索引 ->lib12;
	data t_index(index=(a b));
		a=1;b=2;c=3;d=4;
	run;
	%copyDs(data=t_index,out=local12.t_index);
	%put proc datasets copy;
	options notes;
	%copyDs(data=local12.t_index,out=local12.t_index_copy);
	options nonotes;

	* step 10 同lib（地址同、lib名称不同）复制 含索引 ->same1 ->same2 ;
	%copyDs(data=t,out=same1.t);
	%copyDs(data=same1.t,out=same2.dup);

	%dropLib(local1);
	%dropLib(local2);
	%dropLib(local3);
	%dropLib(local4);
	%dropLib(local5);
	%dropLib(local6);
	%dropLib(local7);
	%dropLib(local8);
	%dropLib(local9);
	%dropLib(local10);
	%dropLib(local11);
	%dropLib(local12);
	%dropLib(same1);
	%dropLib(same2);
%mend;


%test_copyDs;

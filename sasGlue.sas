
* ----------------------------------------------------------------------------------------------------------;
* --------------------------------------------- Introduction -----------------------------------------------;
* ----------------------------------------------------------------------------------------------------------;

* 建议的阅读顺序？;
*	首次使用者，建议按如下顺序阅读：Q&A -> Contents -> Coding Details -> example中的示例或您感兴趣的宏;


* -------------------------------------------------;
* ---------------------- Q&A ----------------------;
* -------------------------------------------------;

* 什么是Glue？;
*	Glue是一个sas宏代码库，提供各种基础性、通用性的sas宏来辅助用户进行sas编程，是一个sas宏层面的utili库;
*	Glue的功能主要包括字符串处理、宏与宏变量管理、各种数据结构、数据集管理、IO控制、日志等;


* 如何使用Glue？;
*	本文件包括所有说明与源代码，只要直接按F3编译本文件后，即可调用所有的宏，当然也可以使用%include调用本文件;
*	所有的宏使用两级分类，具体内容请查看下文的目录，使用文本搜索功能搜索相应的类名，即可跳转到相应章节;
*	每个章节开头为总体性、普适性的介绍，每个宏的源代码前为该宏的具体介绍;
*	每个宏都包含对应的测试用例，说明中的@test_xxxx表示对应的测试用例文件名，可以在test文件下查找;
*	测试用例同时也是功能示例，对于较复杂的宏可先查看测试用例了解使用方法;


* Glue对OS与SAS环境有哪些要求？;
* 	Glue在windows环境开发，如用于其他操作系统请注意重新测试;
*	Glue绝大部分功能适应所有sas9.2以上版本，个别非核心功能可能有更高版本要求（如：sha256要求sas9.4）;
*	Glue所有代码文件基于UTF-8编码;


* 使用Glue的注意事项;
*	请注意不要与您自己编写的宏发生宏名称冲突;
*	请注意不要误操作Glue所使用的全局宏变量（以GLUE_开头）;
*	请注意运行环境（如：options设置）可能与您的使用习惯不同;
*	Glue中的一些宏会使用sas临时工作区（WORK）与当前文件夹（include Glue的文件所在的文件夹）;
*	在使用Glue中的日志功能前，请注意先完成相关sas配置，配置方法可参加测试用例中的说明;


* ----------------------------------------------------------------------------------------------------------;
* ---------------------------------------------- Contents --------------------------------------------------;
* ----------------------------------------------------------------------------------------------------------;


* --------------------------------------------- ENV SETTING ------------------------------------------------;
* 主要为各种option参数、全局宏变量的设定;


* ----------------------------------------------- FORMAT ---------------------------------------------------;
* format definition				各种format/informat定义，所有format将被保存在WORK中并自动引用;
* format basic					format管理宏（不包括format的使用），如：format的检查、载入、复制、卸载、删除等;
* format ds 					使用format进行数据操作的宏，如：对ds进行批量格式转换、改变ds附加的显示format等;


* ------------------------------------------------ FCMP ----------------------------------------------------;
* fcmp definition				各类数据步函数定义，所有fcmp func将被保存在WORK中并自动引用;
* fcmp macros					fcmp的管理宏，主要包括fcmp lib的导入、注销等;


* ---------------------------------------------- DEV TOOLS -------------------------------------------------;
* log macros					日志宏;
* timer macros					计时器类宏;
* debug macros					测试宏，如：断言、临时变量清理情况检查等;
* options macros				sas option管理宏，包括option的增加、删除等;


* ------------------------------------------------ BASIC ---------------------------------------------------;
* math macros					各类算术处理宏;
* time macros					日期与时间宏;
* random macros					随机数、随机字符串生成宏;
* others						其他基本功能，如零星封装的fcmp函数;

* ------------------------------------------------ STRING --------------------------------------------------;
* string format					字符串格式识别，判定字符串是否具有某种格式，例如：数字、引号内、括号内等;
* string conversion				字符串转换，对原字符串进行简单的加工修饰，例如：引用、去除空格、加引号等;
* string operation				字符串一般操作宏，例如：搜索、拆入、替换等;
* string hash					hash相关操作，例如md5，sha256等;
* string binary					二进制字符串操作宏，例如：二进制AND、OR、XOR、转换为base32格式等;


* --------------------------------------------- VARS/ASSIGNS -----------------------------------------------;
* vars conversion				将vars转换为SAS中的不同场景适用的格式，例如：a b c转换为sql中的(a,b,c);
* vars position					基于位置的操作，例如：var计数、提取指定位置var等;
* vars matching					基于内容的操作，例如：查询某个var是否存在、正则表达式识别等;
* vars set						将vars视为集合的操作，例如：集合add、sub、or等;
* vars batch operation			重复对vars所有元素进行相同处理，例如：添加前后缀、padding等;
* vars others					其他vars宏;
* assigns macros				assigns类字符串处理宏，assigns是vars的一个子集，其指元素为A='abc'形式;


* -------------------------------------------------- I/O ---------------------------------------------------;
* file IO macros				文件操作宏，主要包括路径检查、文件夹创建、文件检查、文件删除等;
* ods macros					ODS控制与输出宏，包括page控制、变量批量ods输出等;


* ------------------------------------------------ MACRO ---------------------------------------------------;
* macro app macros				自定义宏管理与编写辅助，主要包括代码引用、获取当前宏名称等;
* macro variable macros			宏变量管理宏,主要包括批量获取宏变量、批量全局宏变量删除等;
* plan macros					macro批处理宏，根据ds参数批量调用宏进行计算，并将结果回写ds;


* ----------------------------------------------- DATASET --------------------------------------------------;
* ds basic macros				ds基础操作宏，如：获取lib名称、检查ds是否相同等、获取观测数量等;
* ds lib macros					ds lib操作宏，主要包括lib的载入、注销等;
* ds operation macros			ds整体操作宏，主要为以ds整体为操作对象的宏，包括拷贝、移动、删除等;
* ds index macros				ds索引操作宏，主要索引创建、删除等;
* ds var operation macros		ds变量操作宏，主要为以ds变量为操作对象的宏，包括获取变量名、变量改名、获取变量最大值等;
* ds obs macros					ds观测批量操作宏，如：obs去重、key计数等;
* ds cell macros				ds单元（即一个观测的一个变量值）操作宏，如：cell写入与读取;
* multi-ds macros 				多个ds操作宏，包括merge,leftjoin，filter等;


* ------------------------------------------------- OBJECT -------------------------------------------------;
* obj basic macros				obj基本宏，包括obj的创建、复制、删除、成员增减等;
* obj member macros				obj成员批量处理宏，对obj所有成员批量进行某一种操作;
* obj ds macros					obj存储宏，主要是obj与数据集间的读写交互;
* obj array macros				数组obj，以obj形式为基础实现的数组;


* --------------------------------------------- INITIALIZATION ---------------------------------------------;
* 运行环境初始化，包括自定义fcmp导入、ODS输出等;



* ----------------------------------------------------------------------------------------------------------;
* --------------------------------------- Coding Details ---------------------------------------------------;
* ----------------------------------------------------------------------------------------------------------;


* -------------------------------------------------;
* --------------- Coding Conventions --------------;
* -------------------------------------------------;

* Glue宏的参数格式;
*	sas宏提供两种参数的书写格式：有名参数与无名参数;
*		有名参数 		%copyDs(data=xxx,out=yyy);
*		无名参数	 		%strip(a); 
*	Glue中根据宏复杂度与使用频率来确定使用哪种模式，一般较复杂（参数个数大于3个、功能较为复杂）的宏使用有名参数模式;

* Glue宏运行结果的返回方式;
*	Glue中的宏主要使用两种方式来返回运行结果：直接返回与RES返回;
*	直接返回指宏运行的结果是一个字符串，使用这种方式的宏，可以直接作为右值进行赋值。例如;
*		%let varsNum=%varsLength(abc);
*	RES返回指宏运行不返回字符串，而是将结果写入一个指定的宏变量，例如;
/*		%local tres;%let tres=%createTempVar;%local &tres; 
		%varsCount(vars=&vars,res=&tres);%let varsNum=&&&tres;	*/
*	直接返回的方式使用简单，但需要调用proc或dataset的宏不能使用这种方式编写，而且一次只能返回一个值，灵活性有限;
*	RES返回的方式语法稍微麻烦，但具有最大程度的灵活性，适合较为复杂的宏;
*	Glue中的宏会根据复杂度、使用习惯来选择相应的返回模式，个别函数还会同时提供两种版本;


* Glue RES返回方式介绍;
*	RES返回方式下，调用宏/caller需要声明用于传递结果的变量，并将该变量名传递给被调用宏/callee，其常见格式如下;
/*		caller 		%macro someMacro;
						%local tres;%let tres=%createTempVar;%local &tres; 
						...;
						%varsCount(vars=&vars,res=&tres);%let varsNum=&&&tres;
						...;
					%mend;

		callee		%macro varsCount(vars=,res=);
						...;
						%let &res=&result;
					%mend;
*/
*	其中第一句的含义是：caller创建一个随机名称的局部变量（名称保存在tres中），做为callee向其返回结果的载体;
*	采用随机名称而不是固定的名称，主要是为了以下几个原因;
*		避免caller/callee命名习惯不同导致的不兼容，例如：caller习惯使用RESULT，而callee习惯使用R;
*		避免无返回需求时的意外修改，例如：callee使用RESULT返回，但caller不需要返回值，因此未声明该变量;
*		避免caller中意外遗忘声明返回变量导致的意外修改;
*	createTempVar创建随机名称的宏变量，并且事先进行变量名的冲突检查，因此可以避免这个问题;
*	该模式除宏参数外，还使用于宏变量与data set（symput）和SQL（select into）的场景;
*	当需要返回多个结果时，设置多个tres变量即可。如果需要返回的结果多于3个变量，则可以考虑使用obj来返回执行结果;


* -------------------------------------------------;
* ---------------------- VARS ---------------------;
* -------------------------------------------------;

* vars格式介绍;
*	vars是Glue中常用的一种数据结构，其形式为以白空格分隔的字符串，例如：A B C，其中A被称为一个元素/单元/var;

* vars的用法;
*	Glue中基于vars格式，配套了大量的宏以实现不同的功能目标;
*		vars position		提供了所有基于位置的操作，可以用于实现对array、queue、stack等数据结构的模拟;
*		vars set			提供了集合操作，可以实现对set的模拟;		
*		vars matching		提供了对元素的各种查找、过滤的支持;
*		vars conversion		提供了对vars转换为其他场景sas格式的支持;
*		vars batch			提供了对按元素进行的相同操作的批处理的支持;
*		vars assigns		提供了基于vars的简单map的模拟;
*	具体使用方式请参加相应宏的使用说明;

* vars的适用场景;
*	vars的优点在于交互便利，便于用户书写与阅读，缺点是容量与访问效率较差;
*	vars适用于元素相对较少、且较简单的场景，一个最常见的使用场景是用来保存变量名列表，这也是vars名称的由来;
*	对于元素个数较多或元素数据量较大的场景，不建议适用vars，可以考虑在dataset中通过sql处理，或者使用后文的array;
*	vars是sas宏变量保存的字符串，因此应注意不应超过65534的长度限制;


* -------------------------------------------------;
* ---------------------- OBJ ----------------------;
* -------------------------------------------------;

* obj格式介绍;
*	obj是Glue中一种模仿struct的数据结构;

* obj的一般使用方式;
*	obj创建			%newObj(members=name type value,res=&tres) %let obj=&&&tres;
* 	obj成员赋值 		%let &obj.type=abc;
* 	obj成员引用 		%let temp=&&&record.type;	
*	obj引用传递		%let obj_new=&obj_old;
*	obj拷贝传递		%cloneObj(obj=&obj_old,res=&tres) %let obj_new=&&&tres; 

* obj的实现方式;
*	obj是通过分区使用变量名称来实现的，obj将一个32位的宏变量名划分为两部分：结构名12位 + 成员名20位;
*	例如：一个包含name，type两个成员的obj是由如下2个全局宏变量组成的;
*		JLZZC21XZ9RZtype;
*		JLZZC21XZ9RZname;
*	由于obj使用全局宏变量，因此可以实现对象的“引用传递”，但也要求使用完后必须使用dropObj来释放相关资源;

* obj与ds的交互操作;
*	Glue的obj ds类宏提供了以obj为载体的，面向数据集的简易操作接口;
*	用户可以通过saveObj直接将一个obj当做一个观测写入数据集，或loadObj来从数据集中读出一个观测到obj;
*	saveObj与loadObj只支持一次操作一个观测，且要求数据集的相关变量必须都是字符串格式;


* -------------------------------------------------;
* --------------------- ARRAY ---------------------;
* -------------------------------------------------;

* array obj格式介绍;
*	array obj是Glue中一种模仿array的数据结构，因为与obj原理相似因此被称为array obj;
*	array obj的实现方式与访问方法与obj大体相同，可以理解为是以数字为成员名的obj;

* array obj（以下简称array）的一般使用方式;
*	array创建		%arrayNew(100,&tres)  %let arr=&&&tres;
* 	array成员赋值 	%let &arr.10=10;
*					%let value=%arrayPush(some thing);
*	array长度		%let v=&arr.length;
* 	array成员引用 	%let value=&&&arr.10;
*					%let value=%arrayPop(&arr);
*	array引用传递	%let arr_new=&arr;
*	array拷贝传递	%arrayClone(&arr,&tres)  %let arr_new=&&&tres; 
/*	array遍历		%do i=1 %to &arr.length;
						%let value=%dosomething(&arr.&i)  
					%end;*/


* -------------------------------------------------;
* ---------------------- Nesting ------------------;
* -------------------------------------------------;

* vars与obj/array间的嵌套;
*	Glue中的vars是字符串，obj、array是字符地址（变量名），因此可以相互嵌套;
*	由于直观性有限，不建议采用表达式直接访问被嵌套的元素;
*	示例1：%varsK(&&&record.names,2) obj内嵌vars，表示提取一个记录对象中的名称列表，取名称中的第二个;
*	示例2：%unquote(&&%varsK(&students,4)name) vars内嵌obj，表示提取一个学生列表中的第4条记录，取其中的名字;

* obj/array之间的嵌套;
*	由于其描述的复杂性，不建议通过表达式直接访问，建议使用Glue提供的G函数与L函数来处理此类场景;
*	示例：对一个由obj与array交替嵌套组成的四级结构，可以按如下方式使用;
*		赋值			%L(&L1.type.5.name.21, 123456);
*		读取			%let temp = %G(&L1.type.5.name.21);
*	注意：L函数仅限于对已经声明并创建好的obj/array的元素进行赋值，L函数不能自动生成数据结构;
*	可以阅读/test/obj_basic/test_nested.sas来进一步了解嵌套的使用方式;



* ----------------------------------------------------------------------------------------------------------;
* ----------------------------------------------- Options  -------------------------------------------------;
* ----------------------------------------------------------------------------------------------------------;

options dlcreatedir;
options nosource;
options nosource2;
options nonotes;
options noxwait;
options xsync;
options minoperator mindelimiter=' ';

* ----------------------------------------------------------------------------------------------------------;
* ----------------------------------------------- Globals  -------------------------------------------------;
* ----------------------------------------------------------------------------------------------------------;

%global GLUE_LOGGER;						%let GLUE_LOGGER=root;

%global GLUE_PAGE_DEFAULT_TYPE;				%let GLUE_PAGE_DEFAULT_TYPE=HTML;
%global GLUE_PAGE_DEFAULT_FILE;				%let GLUE_PAGE_DEFAULT_FILE=REPORT;
%global GLUE_PAGE_DEFAULT_PATH;				%let GLUE_PAGE_DEFAULT_PATH=;
%global GLUE_PAGE_DEFAULT_NOTIMESTAMP;		%let GLUE_PAGE_DEFAULT_NOTIMESTAMP=0;
%global GLUE_PAGE_DEFAULT_P1;				%let GLUE_PAGE_DEFAULT_P1=0;

%global GLUE_GENID_SEED;					%let GLUE_GENID_SEED=;




* -------------------------------------------------;
* --------------- Format Definition ---------------;
* -------------------------------------------------;

* 生成base32 format;
* base32 包含0-9十个数字，A-Z中剔除I、O、M、V,总计5bit，32个字符;

proc format;

	* md5base32使用;
  	invalue $base32x
		'00000'='0'
		'00001'='1'
		'00010'='2'
		'00011'='3'
		'00100'='4'
		'00101'='5'
		'00110'='6'
		'00111'='7'
		'01000'='8'
		'01001'='9'
		'01010'='A'
		'01011'='B'
		'01100'='C'
		'01101'='D'
		'01110'='E'
		'01111'='F'
		'10000'='G'
		'10001'='H'
		'10010'='J'
		'10011'='K'
		'10100'='L'
		'10101'='N'
		'10110'='P'
		'10111'='Q'
		'11000'='R'
		'11001'='S'
		'11010'='T'
		'11011'='U'
		'11100'='W'
		'11101'='X'
		'11110'='Y'
		'11111'='Z';

	* dsSame使用;
	value procCompareErrBits
		1='Data set labels differ'
		2='Data set types differ'
		3='Variable has different informat'
		4='Variable has different format'
		5='Variable has different length'
		6='Variable has different label'
		7='Base data set has observation not in comparison'
		8='Comparison data set has observation not in base'
		9='Base data set has BY group not in comparison'
		10='Comparison data set has BY group not in base'
		11='Base data set has variable not in comparison'
		12='Comparison data set has variable not in base'
		13='A value comparison was unequal'
		14='Conflicting variable types'
		15='BY variables do not match'
		16='Fatal error: comparison not done';
quit;



* -------------------------------------------------;
* ---------------- FCMP Definition ----------------;
* -------------------------------------------------;

* 所有fcmp函数默认被保存于work.funcs.glue;
* 文件末尾执行importFuncs将work.funcs写入cmplib;

proc fcmp outlib=work.funcs.glue;


	* ------------------------------------------------;
	* ---------------- String functions --------------;
	* ------------------------------------------------;

	* ---- function strInit ----;
	* fcmp字符变量初始化;
	* test;
	*	@test_fcmp_strInit;
	* details;
	*	使用方式;
	*		s=strInit(.);
	*		该语句等价于 length s $ 32767;
 
	*	函数逻辑;
	*		fcmp函数中的字符串变量不支持不定长字符串，如果未使用length声明，则sas会自动推断该变量的长度并设置为固定长度;
	*		这种自动推断可能导致意外的字符串截取，因此对函数中的字符串变量，都应该显式的声明长度;
	*		对于一些不能确定长度的场景，可以使用strInit将该字符串设置为允许的最大值，即32767;

	*	sas字符串长度推断逻辑;
	*		(设：args1为参数名称,var1为其他变量名称，x为待推断的变量名);
	*		情景						推断长度;
	*		x='abc'					长度为3;
	*		x=args1					args1实际长度<=33，则为实际长度，否则为33;
	*		x=var1					与var1相同;		
	*		x=myfunc(...)			如果myfunc函数内声明了返回值长度，或返回值的长度可推断，则为相应的长度，例如：x=repeat('_',6)，则x长度为6;
	*								如果未声明且无法推断，则为固定200，例如：x=repeat('_',round(10*rand('uniform')))，x长度为200;
	*	data字符串变量的长度设定;
	*		strInit将长度设为最大值是为了在函数计算过程中尽可能避免截断的出现;
	*		在data step中，应事先设定变量长度，以避免最终存储的变量长度推断为32767，占用过多空间;
	*	cat禁止使用;
	*		在声明了str为32767长度后，注意不要直接使用cat或||进行字符串连接，否则会导致异常;
	*		可以使用cats或先对该变量进行strip处理;

	function strInit(null) $ 32767;
		return('');
	endsub; 

	* ---- function strcode ----;
	* 字符串->utf8 unicode数值字符串转换函数;
	* test;
	*	@test_fcmp_strcode;
	function strcode(s $) $;
		uc=strInit(.);
		uc=unicodec(strip(s),'PAREN');
		uc=transtrn(uc, '<u','');
		uc=transtrn(uc, '>','');
		return(uc);
	endsub;


	* ---- function rightPadding ----;
	* 右截取与padding函数;
	* 对于给定字符串，当超过目标长度将进行右侧截取，未超过将进行右侧补充;
	* input;
	*	rs		字符串;
	*	len		pad后的长度;
	* test;
	*	@test_fcmp_rightPadding;
	* details;
	*	注意对于输入字符串s,是strip后处理的;
	function rightPadding(rs $,len,pad $) $;
		s=strInit(.);
		s=strip(rs);
		pad=strip(pad);
		if missing(len) then return(s);
		if missing(pad) then pad='.';
		l=length(s);
		lp=length(pad);
		if missing(s) then return(repeat(strip(pad),len-1));
		else if l>len then return(substr(s,1,len));
		else if l<len then return(cats(s,substr(repeat(strip(pad),ceil((len-l)/lp)),1,len-l)));
		else return(s);
	endsub;


	* ---- function leftPadding ----;
	* 左侧截取与padding函数;
	* test;
	*	@test_fcmp_leftPadding;
	function leftPadding(rs $,len,pad $) $;
		s=strInit(.);
		s=strip(rs);
		pad=strip(pad);
		if missing(len) then return(s);
		if missing(pad) then pad='.';
		l=length(s);
		lp=length(pad);
		if missing(s) then return(repeat(strip(pad),len-1));
		else if l>len then return(substr(s,l-len+1,len));
		else if l<len then return(cats(substr(repeat(strip(pad),ceil((len-l)/lp)),1,len-l),s));
		else return(s);
	endsub;

	* ---- function substring ----;
	* 逻辑与宏substring相同;
	* input;
	*	sraw		字符串;
	*	pStart		截取开始位置;
	*	pEnd		截取停止位置;
	* test;
	*	@test_fcmp_substring;
	function subString(sraw $,pStart,pEnd) $;
		doReverse=0;
		res=strInit(.);
		s=strInit(.);
		res=' ';
		s=strip(sraw);
		len=length(s);
		if missing(s) then return(res);

		* 默认值填充;
		if missing(pStart) then pStart=1;
		if missing(pEnd) then pEnd=-1;

		* 负值转换;
		if pStart<0 then pStart=pStart+len+1;
		if pEnd<0 then pEnd=pEnd+len+1;

		* 逆序调整;
		if pStart>pEnd then do;
			pTemp=pStart;
			pStart=pEnd;
			pEnd=pTemp;
			doReverse=1;
		end;
	
		* 裁剪范围存在性判定;
		if pStart>len then return(' ');
		if pEnd<1 then return(' ');

		* 实际裁剪范围范围确定;
		pStart=min(max(pStart,1),len);
		pEnd=max(min(pEnd,len),1);

		* 字符串提取;
		res=substr(s,pStart,pEnd-pStart+1);
	
		* 逆序调整;
		if doReverse=1 then res=reverse(res);
		return(strip(res));
	endsub;

	* ---- function md5hex ----;
	* 返回字符型，hex格式的md5数值;
	* 注意：md5在计算时与输入字符串的变量长度有关，相同字符串，保存为不同长度的变量，其md5值不同;
	* 为避免这种影响，md5hex在进行md5运算前，将进行strip操作;
	* test;
	*	@test_fcmp_md5hex;
	function md5hex(s $) $32;
		a=md5(strip(s));
		md5=putc(a,'hex32.');
		return(md5);
	endsub;

	* ---- function md5base32 ----;
	* 根据字符串生成MD5，并转换为base32格式，对应md5base32宏;
	* 注意：由于md5受变量长度影响的问题，这里的md5也是进行strip再进行计算，因此在有首尾空格的场景下与宏md5base32计算的结果不同;
	* test;
	*	@test_fcmp_md5base32;
	function md5base32(s $) $ 26;
		length binStr $ 130 base32 $ 28 b $ 5 c $ 1; 
		h=md5(strip(s));
		binStr=putc(h,'binary128.');
		l=length(binStr);
		k=ceil(l/5);
		p=k*5-l;
		if p>0 then binStr=cats(binStr,repeat('0',p-1));
		do i=1 to k;
			start=(i-1)*5+1;
			b=substr(binStr,start,5);
			c=inputc(b,'$base32x');
			base32=cats(base32,c);
		end;
		return(base32);
	endsub;

	* ------------------------------------------------;
	* ---------------- Log functions -----------------;
	* ------------------------------------------------;

	* ---- function lerror ----;
	* test;
	*	@test_fcmp_log;
	subroutine lerror(log $);
		call saslog("ERROR",log);
	endsub;

	* ---- function lwarn ----;
	* test;
	*	@test_fcmp_log;
	subroutine lwarn(log $);
		call saslog("WARN",log);
	endsub;

	* ---- function linfo ----;
	* test;
	*	@test_fcmp_log;
	subroutine linfo(log $);
		call saslog("INFO",log);
	endsub;

	* ---- function saslog ----;
	* test;
	*	@test_fcmp_log;
	subroutine saslog(level $,log $);
		length msg $ 1000;
		ts=put(datetime(),B8601DT.3);
		msg=cats('[',ts,'][',level,']',log);
		err=log4sas_logevent("&GLUE_LOGGER", level,strip(msg));
		if level='INFO' then put msg;
	endsub;


	* ------------------------------------------------;
	* ---------------- Date functions ----------------;
	* ------------------------------------------------;

	* ---- function timetype -----;
	* 根据数值判断指定的数值是否是date或datetime;
	* 要求的时间范围必须在[01/jan/1961,31/dec/9999]范围内;
	* input;
	*	a		时间数值;
	* output;
	*	返回值	2 datetime;
	*			1 date;
	*			0 其他;
	* test;
	*	@test_fcmp_timetype;
	function timetype(a);
		if a>=31622400 and a<=253717747199 then return(2);
		if a>=366 and a<=2936547 then return(1);
		return(0);
	endsub;

	* ---- function dateToDt ----;
	* 将数值由date转换为datetime;
	* test;
	*	@test_fcmp_dateToDt;
	function dateToDt(d);
		return(DHMS(d,0,0,0));
	endsub;

	* ---- function timeFloor -----;
	* 对时间向下取整;
	* input;
	*	d			时间变量;
	*	int			取整的单位，包括所有sas date与datetime interval;
	*				注意提供的interval不需要增加dt前缀，函数会自动适配;
	*	base		窗口的基准;
	* output;
	*	返回值		取整后的时间;
	* test;
	*	@test_fcmp_timeFloor;
	function timeFloor(d,interval $);
		timeType=timetype(d);
		intv=interval;
		if timeType=2 then intv=cats('dt',interval);
		if timeType=0 then return(.);
		return(intnx(intv,d,0,'BEGIN'));
	endsub;

	* ---- function timeCeil -----;
	* 对时间向上取整;
	* test;
	*	@test_fcmp_timeFloor;
	function timeCeil(d,interval $);
		timeType=timetype(d);
		intv=interval;
		if timeType=2 then intv=cats('dt',interval);
		if timeType=0 then return(.);
		return(intnx(intv,d,0,'END'));
	endsub;

	* ------------------------------------------------;
	* ---------------- Test functions ----------------;
	* ------------------------------------------------;

	* ---- subroutine assertEqual ----;
	* 数值变量相等断言;
		subroutine assertEqual(a,b,msg $);
		length str $ 1000;
		if a=b then str=cats('[ASSERTEQUAL][PASS][',a,'][',b,']',msg);
		else str=cats('[ASSERTEQUAL][FAILED][',a,'][',b,']',msg);
		put str;
	endsub;

	* ---- subroutine assertStrEqual ----;
	* 字符变量相等断言;
	* details;
	*	注意：前后的空格数量将被忽略不影响比较;
	subroutine assertStrEqual(a $,b $,msg $);
		length str $ 1000;
		if a=b then str=cats('[ASSERTSTREQUAL][PASS][',a,'][',b,']',msg);
		else str=cats('[ASSERTSTREQUAL][FAILED][',a,'][',b,']',msg);
		put str;
	endsub;

run;


* -----------------------------------------------------;
* ---------------- Format Basic macros ----------------;
* -----------------------------------------------------;

* format类宏中的format形参;
*	format可能使用以下几种格式;
*		full format		表示完整的format，如：BEST. BEST12.2 $ISO6401.2等，一般用于data step中;
*		format name		表示format的名称，不包含小数点、位数等附加部分，如：BEST,$ISO6401等，一般用于以format（而不是数据）为对象的操作;

* format转换中无法识别情况的处理;
*	使用format进行转换时，如format的定义域没有完整覆盖变量的定义域，则会导致转换时无法识别的情况;
*	在data step中，使用input(var,??format)语法可以部分解决这个问题，但宏层面只能使用封装的inputn，inputc等，这类函数不支持这种语法;
*	因此在所有用于宏场景的format定义中，建议都应设置other选项;


* ---- macro inputn ----;
* inputn封装;
* details;
*	因为转换内容中可能包含特殊字符，因此封装使用qsysfunc;
%macro inputn(v,f);
	%qsysfunc(inputn(&v,&f))
%mend;

* ---- macro inputc ----;
* inputc封装;
%macro inputc(v,f);
	%qsysfunc(inputc(&v,&f))
%mend;

* ---- macro putn ----;
* putn封装;
%macro putn(v,f);
	%qsysfunc(putn(&v,&f))
%mend;

* ---- macro putc ----;
* putc封装;
%macro putc(v,f);
	%qsysfunc(putc(&v,&f))
%mend;

* ---- macro isStrFormat ----;
* 判定输入的format是否是包含$;
* test;
*	@test_isStrFormat;
%macro isStrFormat(f);
	%local res;
	%let res=0;
	%if %isBlank(&f) %then %let res=0;
	%else %if %substr(%strip(&f),1,1)=%str($) %then %let res=1;
	&res.
%mend;

* ---- macro fullFormat ----;
* 转换为full format;
* input;
*	f		任意格式的format;
* details;
*	fullFormat不涉及$的处理;
* test;
*	@test_fullFormat;
%macro fullFormat(f);
	%local res;
	%if %isBlank(&f) %then %let res=%str();
	%else %if %index(&f,%str(.)) %then %let res=&f;
	%else %let res=&f..;
	&res.
%mend;


* ---- macro dotFormat ----;
* fullFormat别名;
%macro dotFormat(f);
	%fullFormat(&f)
%mend;


* ---- macro formatName ----;
* 转换为format name;
* input;
*	f		任意格式的format;
* details;
*	formatName不涉及$的处理;
* test;
*	@test_formatName;
%macro formatName(f);
	%prxchange(%str(s/^(\$?[a-z|A-Z|0-9]*[a-z|A-Z]+)\d*\.?\d*$/$1/),-1,%strip(&f))
%mend;


* ---- macro noDotFormat ----;
* formatName别名;
%macro noDotFormat(f);
	%formatName(&f)
%mend;


* ---- macro checkFormats ----;
* format存在性检查函数;
* 注意：checkFormats用于检查指定的lib中是否存在指定的format，但不保证该format当前可用，检查format是否可用应使用pingFormats;
* input;
*	lib				目标lib;
*	path			目标path;
*					位置参数优先级 lib > path > work;
*	formats/format	format名称，必须是formatName;
*	isInformat		0|1，查询format是否是informat，默认为0;
*					所有要检查的format必须类型相同;
*	res				返回不存在的format;
* details;
* test;
*	@test_checkFormats;
%macro checkFormats(lib=,path=,format=,formats=,isInformat=,res=) /parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;

	%local fmtSuffix fmtName fmtType isTempLib;
	%local formatsN fmt i;
	%local notExistFormats;

	%let isTempLib=0;

	* 参数检查;
	%resCheck(&res);
	%let formats=%paramAlias(&formats,&format);
	%let isInformat=%nonBlank(&isInformat,0);

	%if %isBlank(&formats) %then %return;

	* 路径检查;
	%if %notBlank(&lib) %then %let lib=%upcase(&lib);
	%else %if %notBlank(&path) %then %do;
		%if not %folderExist(&path) %then %return;
		%importTempLib(&path,&tres);%let lib=&&&tres;
		%let isTempLib=1;
	%end;
	%else %let lib=WORK;

	%varsCount(vars=&formats,res=&tres);%let formatsN=&&&tres;
	
	%do i=1 %to &formatsN;
		%varsN(vars=&formats,n=&i,res=&tres);%let fmt=&&&tres;
		%let fmtName=%formatName(&fmt);
		%let fmtSuffix=%str();
		%let fmtType=FORMAT;
		
		%if %isStrFormat(&fmtName) %then %do;
			%let fmtSuffix=C;
			%let fmtName=%subString(&fmtName,2);	
		%end;
		%if &isInformat=1 %then %let fmtType=INFMT;
		%if %sysfunc(cexist(&lib..formats.&fmtName..&fmtType.&fmtSuffix.))=0 %then %let notExistFormats=&notExistFormats &fmt;
	%end;
	%resSet(&res,&notExistFormats);

	* 资源释放;
	%if &isTempLib %then %dropLib(&lib);
%mend;


* ---- macro checkformat ----;
%macro checkformat(lib=,path=,format=,formats=,isInformat=,res=);
	%checkFormats(lib=&lib,path=&path,format=&format,formats=&formats,isInformat=&isInformat,res=&res);
%mend;

* ---- macro checkInformats ----;
%macro checkInformats(lib=,path=,format=,formats=,res=);
	%checkFormats(lib=&lib,path=&path,format=&format,formats=&formats,isInformat=1,res=&res);
%mend;

* ---- macro checkInformat ----;
%macro checkInformat(lib=,path=,format=,formats=,res=);
	%checkFormats(lib=&lib,path=&path,format=&format,formats=&formats,isInformat=1,res=&res);
%mend;


* ---- macro pingFormats ----;
* 检查指定的format是否可用;
* input;
*	formats/format		目标format，vars格式,必须是formatName;
*	res					当前不可用的format，vars格式;
* test;
*	@test_pingFormats;
%macro pingFormats(format=,formats=,isInformat=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local fmtType;
	%local stmt_where;
	%let fmtType=F;

	%resCheck(&res);
	%let formats=%paramAlias(&formats,&format);
	%let isInformat=%nonBlank(&isInformat,0);
	%if &isInformat=1 %then %let fmtType=I;
	
	%if %isBlank(&formats) %then %return;
	%let stmt_where=%quote(fmtName in (%sasVarsToQuote(%upcase(&format))));
	proc sql noprint;
		select fmtname into :&tres separated by ' ' from sashelp.vformat where fmttype="&fmtType" and (%unquote(&stmt_where));
	quit;
	%varsSub(a=&format,b=&&&tres,res=&res);
%mend;

* ---- macro pingFormat ----;
%macro pingFormat(format=,formats=,isInformat=,res=);
	%pingFormats(format=&format,formats=&formats,isInformat=&isInformat,res=&res);
%mend;

* ---- macro pingInformats ----;
%macro pingInformats(format=,formats=,res=);
	%pingFormats(format=&format,formats=&formats,isInformat=1,res=&res);
%mend;

* ---- macro pingInformat ----;
%macro pingInformat(format=,formats=,res=);
	%pingFormats(format=&format,formats=&formats,isInformat=1,res=&res);
%mend;

* ---- macro deleteFormats ----;
* 删除指定的lib中的format;
* input;
*	lib					目标lib;
*	path				目标path;
*						位置优先级lib>path>WORK;
*	formats/format		待删除format，必须是formatName格式;
*	res					返回变量;
* test;
*	@test_deleteFormats;
%macro deleteFormats(path=,lib=,formats=,format=,isInformat=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local tl;

	%local fmtSuffix fmtName fmtType;
	%local formatsN fmt i;
	%local stmt_delete;

	%let formats=%paramAlias(&formats,&format);
	%let isInformat=%nonBlank(&isInformat,0);
	%if %isBlank(&formats) %then %return;
	%if %isBlank(&lib) %then %do;
		%if %notBlank(&path) %then %do;
			%importTempLib(&path,&tres);%let lib=&&&tres;
			%let tl=&lib;
		%end;
		%else %let lib=WORK;
	%end;

	%varsCount(vars=&formats,res=&tres);%let formatsN=&&&tres;
	%do i=1 %to &formatsN;
		%varsN(vars=&formats,n=&i,res=&tres);%let fmt=&&&tres;
		%let fmtName=%formatName(&fmt);
		%let fmtSuffix=%str();
		%let fmtType=FORMAT;
		%if %isStrFormat(&fmtName) %then %do;
			%let fmtSuffix=C;
			%let fmtName=%subString(&fmtName,2);	
		%end;
		%if &isInformat=1 %then %let fmtType=INFMT;
		%if %sysfunc(cexist(&lib..formats.&fmtName..&fmtType.&fmtSuffix.))=1 %then %let stmt_delete=&stmt_delete &fmtName..&fmtType.&fmtSuffix;
	%end;

	%if %notBlank(&stmt_delete) %then %do;
		proc catalog catalog=%unquote(&lib..FORMATS);
	       	delete %unquote(&stmt_delete);
	   	run;quit;
	%end;
	%dropLib(&tl);
%mend;

* ---- macro deleteFormat ----;
%macro deleteFormat(path=,lib=,format=,formats=,isInformat=);
	%deleteFormats(path=&path,lib=&lib,format=&format,formats=&formats,isInformat=&isInformat);
%mend;

* ---- macro deleteInformats ----;
%macro deleteInformats(path=,lib=,format=,formats=);
	%deleteFormats(path=&path,lib=&lib,format=&format,formats=&formats,isInformat=1);
%mend;

* ---- macro deleteInformat ----;
%macro deleteInformat(path=,lib=,format=,formats=);
	%deleteFormats(path=&path,lib=&lib,format=&format,formats=&formats,isInformat=1);
%mend;

* ---- macro dropFormats ----;
%macro dropFormats(path=,lib=,format=,formats=,isInformat=);
	%deleteFormats(path=&path,lib=&lib,format=&format,formats=&formats,isInformat=&isInformat);
%mend;

* ---- macro dropFormat ----;
%macro dropFormat(path=,lib=,format=,formats=,isInformat=);
	%deleteFormats(path=&path,lib=&lib,format=&format,formats=&formats,isInformat=&isInformat);
%mend;

* ---- macro dropInformats ----;
%macro dropInformats(path=,lib=,format=,formats=);
	%deleteFormats(path=&path,lib=&lib,format=&format,formats=&formats,isInformat=1);
%mend;

* ---- macro dropInformat ----;
%macro dropInformat(path=,lib=,format=,formats=);
	%deleteFormats(path=&path,lib=&lib,format=&format,formats=&formats,isInformat=1);
%mend;


* ---- macro reportFormats ----;
* 显示指定的lib中的format;
* input;
*	lib			目标lib;
*	path		目标path;
*				目标优先级 lib>path>WORK;
*	format		要显示的format名称，vars格式，为空时显示lib中的全部format与informat;
*	msg			信息;
* test;
*	@test_reportFormats;

%macro reportFormats(path=,lib=,formats=,format=,isInformat=,msg=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local tl;

	%let isInformat=%nonBlank(&isInformat,0);
	%let formats=%paramAlias(&formats,&format);
	%if %isBlank(&lib) %then %do;
		%if %notBlank(&path) %then %do;
			%importTempLib(&path,&tres);%let lib=&&&tres;
			%let tl=&lib;
		%end;
		%else %let lib=WORK;
	%end;

	%if %isBlank(&formats) %then %do;
		title "FORMAT REPORT LIB=&lib FORMAT=_ALL_ &msg";
		proc format library=%unquote(&lib..formats);
			exclude _;
		quit;
	%end;
	%else %do;
		%if &isInformat=1 %then %do;
			title "FORMAT REPORT LIB=&lib INFORMATS=&formats &msg";
			%varsPrefix(vars=&formats,prefix=%str(@),res=&tres);%let formats=&&&tres;
		%end;
		%else %do;
			title "FORMAT REPORT LIB=&lib FORMATS=&formats &msg";
		%end;
		proc format library=%unquote(&lib..formats);
			select %unquote(&formats);
		quit;
	%end;

	%dropLib(&tl);
%mend;

* ---- macro reportFormat ----;
%macro reportFormat(path=,lib=,formats=,format=,isInformat=,msg=);
	%reportFormats(path=&path,lib=&lib,formats=&formats,format=&format,isInformat=&isInformat,msg=&msg);
%mend;

* ---- macro reportInformats ----;
%macro reportInformats(path=,lib=,formats=,format=,isInformat=,msg=);
	%reportFormats(path=&path,lib=&lib,formats=&formats,format=&format,isInformat=1,msg=&msg);
%mend;

* ---- macro reportInformat ----;
%macro reportInformat(path=,lib=,formats=,format=,isInformat=,msg=);
	%reportFormats(path=&path,lib=&lib,formats=&formats,format=&format,isInformat=1,msg=&msg);
%mend;


* ---- macro copyFormatLib ----;
* 将指定lib中的所有formats拷贝到指定位置;
* input;
*	inlib		format来源lib;
*	inpath		format来源path;
*	outlib		format目标lib;
*	outpath		format目标path;
*				参数优先级 lib > path;
* test;
*	@test_copyFormats;
%macro copyFormatLib(inlib=,outlib=,inPath=,outPath=) /parmbuff;

	%local tres;%let tres=%createTempVar;%local &tres;
	%local isTempInlib isTempOutLib;

	%let isTempInLib=0;
	%let istempOutLib=0;

	* param check;
	%paramRequired(&inLib.&inPath);
	%paramRequired(&outLib.&outPath);
	
	* import format lib;
	%if %isBlank(&inLib) %then %do;
		%importTempLib(&inPath,&tres);%let inLib=&&&tres;
		%if %isBlank(&inLib) %then %error(Failed import INLIB! &syspbuff);
		%let isTempInLib=1;
	%end;
	%if %isBlank(&outLib) %then %do;
		%importTempLib(&outPath,&tres);%let outLib=&&&tres;
		%if %isBlank(&outLib) %then %error(Failed import OUTLIB! &syspbuff);
		%let isTempOutLib=1;
	%end;

	* check formats;
	%if not %cexist(&inLib..formats) %then %do;
		%if &isTempInLib %then %dropLib(&inLib);
		%if &isTempOutLib %then %dropLib(&outLib);
		%return;
	%end;

	* copy formats;
	proc catalog catalog=&inlib..formats;
		copy out=&outlib..formats;
	quit;

	* clear env;
	%if &isTempInLib %then %dropLib(&inLib);
	%if &isTempOutLib %then %dropLib(&outLib);
%mend;

* ---- macro importFormatLib ----;
* 将指定lib添加到fmtsearch;
* input;
*	path	存放format的文件夹;
*	lib		存放format的lib;
*			参数优先级 lib > path;
*	res		返回变量;
* output;
*	res		导入的lib名称;
*			对于使用path参数的场景，返回临时lib用于后续释放;
*			对于使用lib参数的场景，直接返回lib;
* test;
*	@test_importFormatLib;
%macro importFormatLib(path=,lib=,res=) /parmbuff;
	%if %isBlank(&lib) %then %do;
		%resCheck(&res);
		%paramRequired(&path);
		%importTempLib(&path,&res);
		%let lib=&&&res;
	%end;
	%else %resSet(&res,&lib);
	%addOption(fmtsearch,&lib);
%mend;


* ---- macro dropFormatLib ----;
* 将指定lib从fmtsearch中删除;
* test;
*	@test_importFormatLib;
%macro dropFormatLib(lib);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local libN l i;
	%varsCount(vars=&lib,res=&tres);%let libN=&&&tres;
	%do i=1 %to &libN;
		%varsN(vars=&lib,n=&i,res=&tres);%let l=&&&tres;
		%deleteOption(fmtsearch,&l);
	%end;
	%dropLib(&lib);
%mend;



* --------------------------------------------------;
* ---------------- Format ds macros ----------------;
* --------------------------------------------------;
* format应用于ds的各种宏;


* ---- macro clearFormat ----;
* 删除ds的所有format;
* test;
*	@test_clearFormat;
%macro clearFormat(ds);
	%local table lib;
	%let table=%getTableName(&ds);
	%let lib=%getLibName(&ds);
	proc datasets lib=&lib memtype=data noprint;
	   	modify &table; 
	    	attrib _all_ format=;
		run;
	quit;
%mend;


* ---- macro clearLabel ----;
* 删除ds的所有label;
* test;
*	@test_clearFormat;
%macro clearLabel(ds);
	%local table lib;
	%let table=%getTableName(&ds);
	%let lib=%getLibName(&ds);
	proc datasets lib=&lib memtype=data noprint;
	   	modify &table; 
	    	attrib _all_ label=' ';
		run;
	quit;
%mend;


* ---- macro changeFormat ----;
* 修改附加于ds变量上的format;
* input;
*	data				目标数据集;
*	vars/var			待修改的目标变量;
*	formats/format		待适配的format，fullFormat或formatName;
*						二者必须一一对应;
*	stmt				format语句;

%macro changeFormat(data=,var=,vars=,format=,formats=,stmt=) /parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local varsN v formatsN f i;

	%let vars=%paramAlias(&vars,&var);
	%let formats=%paramAlias(&formats,&format);
	%if not %dsExist(&data) %then %error(DATA is invalid! &syspbuff);

	%if %isBlank(&stmt) %then %do;
		%varsCount(vars=&vars,res=&tres);%let varsN=&&&tres;
		%varsCount(vars=&formats,res=&tres);%let formatsN=&&&tres;
		%if &varsN ne &formatsN %then %error(varsN ne formatsN!);
		%if &varsN=0 %then %return;
		%do i=1 %to &varsN;
			%varsN(vars=&vars,n=&i,res=&tres);%let v=&&&tres;
			%varsN(vars=&formats,n=&i,res=&tres);%let f=&&&tres;
			%let stmt=&stmt &v %fullFormat(&f); 
		%end;
	%end;
	proc datasets lib=%getLibName(&data) memtype=data noprint;
	   	modify %getTableName(&data); 
	    	format %unquote(&stmt);
		run;
	quit;
%mend;


* ---- macro formatChange ----;
* 使用指定的format修改变量的值;
* 注意：changeFormat是改变ds中附加的显示用format，但不改变变量的值，formatChange是使用指定的format对数值进行修改;
* input;
*	data			目标数据集;
*	out				输出数据集，默认data;
*	vars			待修改的目标变量;
*	formats			待适配的formats，formatName或fullFormat格式;
*	outVars			格式转换后的变量名称，为空时则使用原来的名称;
*					vars、outVars、formats必须一一对应;
*	putVars			使用put进行类型转换的变量;
*	specVars		putVars别名;
* details;

*	变量转换的format要求;
*		由于put输出字符，而input可以直接根据format名称来自动调节输出数值或字符，因此所有转换格式默认使用input进行，配合使用informat;
*		对于必须要使用put/format的特殊情况，可以使用putVars参数进行注明;

*	转换异常;
*		formatChange使用??参数禁止格式匹配错误的出现;
*		为避免存在数据与格式不符无法转换也无法发现的情况，所有使用的informat应包含other处理逻辑;

* 	vars与outVars;
*		允许二者相同;
*		允许转换同时进行名称交换，即：vars=A B，outVars=B A;
* test;
*	@test_formatChange;
%macro formatChange(data=,out=,vars=,outVars=,putVars=,specVars=,formats=) /parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local i;
	%local var varsN;
	%local format formatsN;
	%local outVar outVarsN;
	%local stmt_change;
	%local tempVar tempVars;
	%local usePut;

	%let stmt_change=%str();

	* 参数检查;
	%if not %dsExist(&data) %then %error(DATA doesnot exist! &syspbuff);
	%let out=%nonBlank(&out,&data);
	%let outVars=%nonBlank(&outVars,&vars);
	%let putVars=%paramAlias(&putVars,&specVars);
	
	%dsVarsRequired(data=&data,vars=&vars);
	%varsCount(vars=&vars,res=&tres);%let varsN=&&&tres;
	%varsCount(vars=&outVars,res=&tres);%let outVarsN=&&&tres;
	%varsCount(vars=&formats,res=&tres);%let formatsN=&&&tres;

	%if &varsN ne &outVarsN %then %error(VARS and OUTVARS doesnot matched! &syspbuff);
	%if &varsN ne &formatsN %then %error(VARS and FORMATS doesnot matchde! &syspbuff);

	%do i=1 %to &varsN;

		%varsN(vars=&vars,n=&i,res=&tres);%let var=&&&tres;
		%varsN(vars=&outVars,n=&i,res=&tres);%let outvar=&&&tres;
		%varsN(vars=&formats,n=&i,res=&tres);%let format=%fullFormat(&&&tres);
		
		* 临时变量生成;
		%let tempVar=%hashVar(&outvar);
		%let tempVars=&tempVars &tempVar;

		* 判断是否使用put进行转换;
		%varsExist(source=&putVars,target=&var,res=&tres);%let usePut=&&&tres;

		* 变换语句生成;
		%if &usePut=1 %then %let stmt_change=&stmt_change %quote(%str(
			&tempVar=put(&var,??&format);
		));
		%else %let stmt_change=&stmt_change %quote(%str(
			&tempVar=input(strip(&var),??&format);
		));
	%end;

	%*put stmt_change=&stmt_change;
	
	data &out;
		set &data;
		drop %unquote(&vars);
		%unquote(&stmt_change);
	run;

	%renameDsVar(data=&out,old=&tempVars,new=&outVars);
%mend;




* ----------------------------------------------------------------------------------------------------------;
* ----------------------------------------------- CATALOG TOOLS --------------------------------------------;
* ----------------------------------------------------------------------------------------------------------;

* ---- macro cexist ----;
* 判定catalog存在性,封装cexist;
* input;
*	entry	entry名称;
*			注意cexist仅支持2级或4级的entry名称格式，提供1级或3级的entry名称将必然返回0;
* output;
*	返回值	0|1;
%macro cexist(entry);
	%sysfunc(cexist(&entry))
%mend;


* ----------------------------------------------------------------------------------------------------------;
* ----------------------------------------------- FCMP TOOLS -----------------------------------------------;
* ----------------------------------------------------------------------------------------------------------;


* -------------------------------------------------;
* ---------------- FCMP macros --------------------;
* -------------------------------------------------;

* ---- macro importFuncs -----;
* 导入fcmp函数;
* SAS管理函数的格式为：lib.ds;
* input;
*	path	导入的文件夹;
*	lib		导入的lib;
*			位置优先级lib > path > WORK;
*			使用path时将自动生成临时lib;
*	table	导入的ds,默认为funcs;
*	res		返回导入的ds（lib.table）名称，用于dropFuncs删除;
* test;
*	@test_importFuncs;
%macro importFuncs(path=,lib=,table=,res=) /parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;
	%if %isBlank(&table) %then %let table=FUNCS;
	%if %isBlank(&lib) and %isBlank(&path) %then %let lib=WORK;
	%else %if %isBlank(&lib) %then %do;
		%if not %isBlank(&path) %then %do;
			%resCheck(&res);
			%importTempLib(&path,&tres);%let lib=&&&tres;
			%resSet(&res,&lib..&table);
		%end;
		%else %error(Required param is empty!);
	%end;	
	%addOption(cmplib,&lib..&table);
%mend;


* ----- macro dropFuncs -----;
* 删除导入的fcmp函数;
* dropFuncs将删除cmplib中的指定ds;
* input;
*	ds		lib.table格式;
* test;
*	@test_dropFuncs;
* details;
*	注意：dropFuncs不会释放lib，如果是临时lib，需要手动释放;
%macro dropFuncs(ds);
	%deleteOption(cmplib,&ds);
%mend;


* ----- macro clearFuncs -----;
* 清空cmplib中的所有参数;
* 注意：调用clearFuncs前，如由临时的lib在查询目标中，则应事先释放;
* test;
*	@test_dropFuncs;
%macro clearFuncs;
	options cmplib=();
%mend;


* ----- macro clearCmplib -----;
%macro clearCmplib;
	%clearFuncs;
%mend;


* ----------------------------------------------------------------------------------------------------------;
* ------------------------------------------------ DEV TOOLS -----------------------------------------------;
* ----------------------------------------------------------------------------------------------------------;

* -------------------------------------------------;
* ---------------- timer macros -------------------;
* -------------------------------------------------;

* ---- macro genTimerId ----;
* 生成timer id，由输入id的大写格式的md5base32计算，取前16位;
* 若s为空则使用%str( )替代;
* test;
*	@test_timer;
%macro genTimerId(s);
	%if %isBlank(&s) %then %let s=%str( );
	%else %let s=%strip(%upcase(&s));
	_GLUE_TIMER_%substr(%md5base32(&s),1,16)
%mend;

* ---- macro timer ----;
* 计时器;
* input;
*	id		计时器id，任意长度字符串，为空时默认为%str( );
*	type	需要返回的时间间隔类型;
*			1	life mode，自创建至今的时长，默认值;
*			2	step mode，自上次type=2调用至今的时长;
* output;
*	返回值	返回时间间隔，以毫秒为单位;
* test;
*	@test_timer;
* details;
*	每个计时器包含以下2个全局宏变量;
*		_GLUE_TIMER_[id]_1		该计时器创建时间，毫秒时间戳;
*		_GLUE_TIMER_[id]_2		该计时器最近一次调用时间，毫秒时间戳;
*								上述变量将在对应id首次被使用时创建，并设定初始值;

%macro timer(id,type);
	%local timer lifeTimer stepTimer;
	%local life step;
	%local res;
	%local currTime;

	%if %isBlank(&id) %then %let id=%str( );
	%if %isBlank(&type) %then %let type=1;

	%let timer=%genTimerId(&id);
	%let lifeTimer=&timer._1;
	%let stepTimer=&timer._2;
	%let currTime=%hts;
	
	%if %symglobl(&lifeTimer) %then %do;
		%global &lifeTimer &stepTimer;
		%let life=%sysevalf(&currTime-&&&lifeTimer);
		%let step=%sysevalf(&currTime-&&&stepTimer);
		%if &type=2 %then %let &stepTimer=&currTime;
	%end;
	%else %do;
		%global &lifeTimer &stepTimer;
		%let &lifeTimer=&currTime;
		%let &stepTimer=&currTime; 
		%let life=0;
		%let step=0;
	%end;
	%if &type=1 %then %let res=&life;
	%else %let res=&step;
	&res.
%mend;

* ---- macro resetTimer ----;
* 将指定的timer归零，即视同该次调用为timer的初始化;
* test;
*	@test_timer;
%macro resetTimer(id);
	%local timer lifeTimer stepTimer;
	%local currTime;
	%if %isBlank(&id) %then %let id=%str( );
	%let timer=%genTimerId(&id);
	%let lifeTimer=&timer._1;
	%let stepTimer=&timer._2;
	%let currTime=%hts;
	
	%global &lifeTimer &stepTimer;
	%let &lifeTimer=&currTime;
	%let &stepTimer=&currTime; 
%mend;

* ---- macro stepTimer ----;
* 步进计时器宏;
%macro stepTimer(id);
	%timer(&id,2)
%mend;

* ---- macro lifeTimer ----;
* 时长计时器;
%macro lifeTimer(id);
	%timer(&id,1)
%mend;

* ---- macro dropAllTimers ----;
* 释放所有用于timer的全局宏变量;
%macro dropAllTimers;
	%dropGlobalsByPrefix(_GLUE_TIMER_);
%mend;

* ---- macro cp ----;
* check point，简单版step timer，直接输出结果;
* 使用固定的id:_CP_;
* test;
*	@test_cp;
%macro cp(msg);
	%saslog(level=INFO,log=&msg %stepTimer(_CP_)ms,invokerLevel=1);
%mend;

* ---- macro cp0 ----;
* check point归零，将cp中内置的计数器归零;
* test;
*	@test_cp;
%macro cp0(msg);
	%resetTimer(_CP_);
%mend;

* ---- macro fulltimerOn ----;
* 启动sas fullstimer;
* test;
*	@test_fulltimer;
%macro fulltimerOn;
	options NOTES FULLSTIMER;
%mend;

* ---- macro fulltimerOff ----;
* 关闭sas fullstimer;
* test;
*	@test_fulltimer;
%macro fulltimerOff;
	options NONOTES NOFULLSTIMER;
%mend;


* -------------------------------------------------;
* ------------------- Log macros ------------------;
* -------------------------------------------------;

* 主要提供日志相关功能;
* 主要的日志功能通过封装SAS logging facility来实现，对其具体介绍参见;
*	http://documentation.sas.com/api/docsets/logug/9.4/content/logug.pdf?locale=en;
* 此外，可以参考测试用例 @test_saslog 中的配置文件;


* ---- macro logToFile ----;
* 将日志输出到文件，而不再输出到日志窗口;
* input;
*	file		输出文件名，默认为saslog.txt;
*	path		输出路径，默认为代码当前路径;
* test;
*	@test_logToFile;
* details;
*	注意：该设置表示log窗口重定向位置，不影响SAS Logging Facility的文件输出;
*	当输出目标文件已存在时，sas将使用append模式进行写入;
%macro logToFile(file=,path=);
	%local path;
	%if %isBlank(&file) %then %let file=saslog;
	%if %isBlank(&path) %then %let path=%getPath;
	%let d=%substr(%timestamp,1,8);
	%let file=&path.&file..txt;
	proc printto log="&file";
	quit;
%mend;

* ---- macro logClose ----;
* 将日志窗口的输出关闭;
* logClose一般用于屏蔽一些不重要的警告信息;
* test;
*	@test_logToFile;
filename _junk_ dummy;
%macro logClose;	
	proc printto log=_junk_;quit;
%mend;

* ---- macro logReset ----;
* 恢复将日志输出到日志窗口;
%macro logReset;
	proc printto log=log;
	quit;
%mend;

* ---- macro logOn ----;
%macro logOn;
	%logReset;
%mend;

* ---- macro logOff ----;
%macro logOff;
	%logClose;
%mend;

* ---- macro lstart ----;
* SAS Logging Facility启用函数;
* test;
*	@test_saslog;
%macro lstart;
	%log4sas;
%mend;

* ---- macro saslog ----;
* 通用日志函数，记录一条日志;
* 主要封装SAS logging facility，主要增加了日志的发送宏与时间信息;
* 参见SAS logging facility文档;
* 示例;
*	[20160203160145][warning][testMarcro]:This is a test log!;
* input;
*	level			日志级别，默认为INFO;
*	log				日志正文;
* 	invokerLevel	从saslog所在宏算起为0，上一层为1，上两层为2，依次类推;
*					默认为1;
* test;
*	@test_saslog;
* details;
*	saslog使用的logger通过全局变量GLUE_LOGGER指定，默认为root，注意与配置文件中保持一致;
%macro saslog(level=,log=,invokerLevel=);
	%local invoker slog;
	%global GLUE_LOGGER;
	* param check;
	%if %isBlank(&log) %then %return;
	%if %isBlank(&level) %then %let level=INFO;
	%if %isBlank(&invokerLevel) %then %let invokerLevel=1;
	%let invoker=%getInvoker(&invokerLevel);
	%let level=%qupcase(&level);
	%let slog=%quote([%timestamp][&level][&invoker]&log);
	%if &level=FATAL %then %log4sas_fatal(&GLUE_LOGGER,%quote(&slog));
	%else %if &level=ERROR %then %log4sas_error(&GLUE_LOGGER,%quote(&slog));
	%else %if &level=WARN %then %log4sas_warn(&GLUE_LOGGER,%quote(&slog));
	%else %do;
		%put &slog;
	%end;
%mend;


* ---- macro lfatal ----;
%macro lfatal(log);
	%saslog(level=FATAL,log=&log);
%mend;


* ---- macro lerror ----;
%macro lerror(log);
	%saslog(level=ERROR,log=&log);
%mend;


* ---- macro lwarn ----;
%macro lwarn(log);
	%saslog(level=WARN,log=&log);
%mend;


* ---- macro lwarning ----;
%macro linfo(log);
	%saslog(level=INFO,log=&log);
%mend;


* ---- macro ldebug ----;
%macro ldebug(log);
	%saslog(level=DEBUG,log=&log);
%mend;


* ---- macro ltrace ----;
%macro ltrace(log);
	%saslog(level=TRACE,log=&log);
%mend;


* ---- macro logbreak ----;
* 发送一条分隔日志，用于突出显示;
* 分隔日志为定宽，固定宽度为80字符，居中显示日志，两侧使用-补齐，具体格式如下：;
* ------------ This is a log --------------;
* input;
*	log				日志正文;
* test;
*	@test_saslog;
%macro logBreak(log);
	%local w l padLen pad;
	%let w=50;
	%let l=%length(&log);
	%if &l<&w %then %let padLen=%floor(%sysevalf((&w-&l)/2));
	%else %let padLen=5;
	%let pad=%repeat(%str(-),&padLen);
	%saslog(level=info,log=%quote(&pad &log &pad));
%mend;

* ---- macro lbreak ----;
%macro lbreak(log);
	%local w l padLen pad;
	%let w=50;
	%let l=%length(&log);
	%if &l<&w %then %let padLen=%floor(%sysevalf((&w-&l-2)/2));
	%else %let padLen=5;
	%let pad=%repeat(%str(-),&padLen);
	%saslog(level=info,log=%quote(&pad &log &pad));
%mend;


* -------------------------------------------------;
* ---------------- debug macros -------------------;
* -------------------------------------------------;

* 各种测试相关的功能，如：断言、临时变量清理情况的检查等;


* ---- macro error ----;
* 触发异常宏，终止执行并发送日志;
* test;
*	@test_error;
%macro error(msg);
	%saslog(level=ERROR,log=&msg,invokerLevel=1);
	%abort;
%mend;

* ---- macro showAllTemp ----;
* 显示所有临时资源，主要用于测试时确认资源清理是否完成;
%macro showAllTemp;
	%showAllObj;
	%showAllTempLib;
%mend;


* ---- macro assertEqual -----;
* 断言相等函数;
* input;
*	a		比较的目标a;
*	b		比较的目标b;
*	desc	测试的描述信息;
*	abort	测试未通过时是否abort;
* test;
*	@test_assertEqual;
* details;
*	assertEqual是将目标当做字符串进行比较，因此1 ^= 1.0;
%macro assertEqual(a=,b=,msg=,abort=);
	%local result;
	%let result=FAIL;
	%if %isBlank(&abort)=1 %then %let abort=0;
	%if %quote(&a)=%quote(&b) %then %let result=PASS;
	%if &result=PASS %then %saslog(level=INFO,log=%quote([&result][assertEqual][&a][&b] &msg),invokerLevel=1);
	%else %saslog(level=WARN,log=%quote([&result][assertEqual][&a][&b] &msg),invokerLevel=1);
	%if &abort eq 1 and &result=FAIL %then %abort;
%mend;


* ---- macro assertDsEqual -----;
* 断言ds相等函数，assertDsEqual使用dsSame作为ds比较函数;
* input;
*	a		比较的目标ds a;
*	b		比较的目标ds b;
*	desc	测试的描述信息;
*	abort	测试未通过时是否abort;
* test;
*	@test_assertDsEqual;
* details;
*	assertDsEqual使用dsSame作为比较逻辑，具体的比较逻辑参见dsSame;
%macro assertDsEqual(a=,b=,msg=,abort=) /parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local tres2;%let tres2=%createTempVar;%local &tres2;
	%local isEqual err;

	* 参数检查;
	%if %isBlank(&abort) %then %let abort=0;

	* 数据集比较;
	%dsSame(a=&a,b=&b,res=&tres,err=&tres2);%let isEqual=&&&tres;%let err=&&&tres2;

	* 结果输出;
	%if &isEqual=1 %then %do;
		%saslog(level=INFO,log=%quote([PASS][assertDsEqual][&a][&b] &msg),invokerLevel=1);
	%end;
	%else %do;
		%saslog(level=WARN,log=%quote([FAILED][assertDsEqual][&a][&b] &msg),invokerLevel=1);
		%if &abort=1 %then %abort;
	%end;
%mend;


* ---- macro assertDsNotExist -----;
* 断言目标ds不存在;
* test;
*	@test_assertDsNotExist;
%macro assertDsNotExist(data=,msg=,abort=) /parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local result;
	%let result=FAIL;
	%if %isBlank(&abort)=1 %then %let abort=0;
	%if not %dsExist(&data) %then %let result=PASS;
	%if &result=PASS %then %saslog(level=INFO,log=%quote([&result][assertDsNotExist][&data] &msg),invokerLevel=1);
	%else %saslog(level=WARN,log=%quote([&result][assertDsNotExist][&data] &msg),invokerLevel=1);
	%if &abort eq 1 and &result=FAIL %then %abort;
%mend;


* ---- macro assertDsNoObs -----;
* 断言目标ds不存在或存在但观测为0;
%macro assertDsNoObs(data=,msg=,abort=) /parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local result;
	%let result=FAIL;
	%if %isBlank(&abort)=1 %then %let abort=0;
	%getDsObs(ds=&data,res=&tres);%if &&&tres=0 %then %let result=PASS;
	%if &result=PASS %then %saslog(level=INFO,log=%quote([&result][assertDsNoObs][&data] &msg),invokerLevel=1);
	%else %saslog(level=WARN,log=%quote([&result][assertDsNoObs][&data] &msg),invokerLevel=1);
	%if &abort eq 1 and &result=FAIL %then %abort;
%mend;



* -------------------------------------------------;
* ------------------ Options macros --------------;
* -------------------------------------------------;

* 用于sas options的管理操作;

* ---- macro displayOption ----;
* 显示指定配置的信息;
* 	@test_options;
%macro displayOption(op);
	proc options option=&op define value lognumberformat;
	run;
%mend;

* ---- macro getOption ----;
* 获取指定option;
* 对于有括号的option会自动将括号去掉;
* test;
* 	@test_options;
%macro getOption(op);
	%local opValue res;
	%let opValue=%str(%sysfunc(getoption(&op)));
	%if %length(&opValue)=0 %then %let res=%str();
	%else %if %inBracket(&opValue)=1 %then %let res=%debracket(&opValue);
	%else %let res=&opValue;
	&res.
%mend;

* ---- macro setOption ----;
* 设置指定option;
* test;
* 	@test_options;
%macro setOption(op,opValue);
	option &op=(%unquote(%deBracket(&opValue)));
%mend;

* ---- macro addOption ----;
* 在指定option中增加一段value，适合允许多个值的，格式为(opv1 opv2 ...)格式的option;
* 新增加的值将被加入末尾;
* test;
* 	@test_options;
%macro addOption(op,value);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local oldOpValue newOpValue;
	%let oldOpValue=%getOption(&op);	
	%varsOr(a=&oldOpValue,b=&value,res=&tres);%let newOpValue=&&&tres;
	%setOption(&op,&newOpValue);
%mend;

* ---- macro deleteOption ----;
* 在指定option中删除一段value，适合允许多个值的option;
* test;
* 	@test_options;
%macro deleteOption(op,value);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local oldOpValue newOpValue;
	%let oldOpValue=%getOption(&op);
	%varsSub(a=&oldOpValue,b=&value,res=&tres);%let newOpValue=&&&tres;
	%setOption(&op,&newOpValue);
%mend;


* ----------------------------------------------------------------------------------------------------------;
* --------------------------------------------- BASIC TOOLS ------------------------------------------------;
* ----------------------------------------------------------------------------------------------------------;


* -------------------------------------------------;
* ---------------- Math functions -----------------;
* -------------------------------------------------;
* 基本数学计算类宏;

* ----- macro log -----;
* 返回ln值;
* 返回精度为15位有效数字;
* input;
*	n			输入数值;
* output;
*	返回值		计算结果;
* 	异常时报错;
* test;
*	@test_math;

%macro log(n);
 	%sysfunc(log(&n))
%mend;


* ----- macro floor -----;
* 向下取整;
* 返回精度为15位有效数字;
* input;
*	n			输入数值;
* output;
*	返回值		计算结果;
* 	异常时报错;
*test;
*	@test_math;

%macro floor(n);
 	%sysfunc(floor(&n))
%mend;

* ----- macro ceil -----;
* 向上取整;
* 返回精度为15位有效数字;
* input;
*	n			输入数值;
* output;
*	返回值		计算结果;
* 	异常报错;
*test;
*	@test_math;

%macro ceil(n);
 	%sysfunc(ceil(&n))
%mend;


* ----- macro abs -----;
* 绝对值;
* 返回精度为15位有效数字;
* input;
*	n			输入数值;
* output;
*	返回值		计算结果;
* 	异常报错;
*test;
*	@test_math;

%macro abs(n);
 	%sysfunc(abs(&n))
%mend;


* ----- macro round -----;
* 四舍五入取整;
* 对负数取整时，结果与去掉负号round然后再加上负号;
* input;
*	n		数值;
*	unit	单位，n=123.456如0.1表示取整到123.5，10表示取整为120;
* output;
*	返回值		计算结果;
* 	异常报错;
*test;
*	@test_math;

%macro round(n,unit);
	%local u;
	%if %isBlank(&unit) %then %let u=1;
	%else %let u=&unit;
 	%sysfunc(round(&n,&u))
%mend;


* ----- macro max -----;
* 返回一组值中的最大值;
* input;
*	value1,value2,...valueN		待比较的一组数;
* output;
*	返回值		计算结果;
* 	异常报错;
*test;
*	@test_math;

%macro max/parmbuff;
	%local s res l;
	%let res=%str();
	%let l=%length(&syspbuff);
	%if &l<=2 %then %let s=%str();
	%else %let s=%substr(&syspbuff,2,%eval(&l-2));
	%sysfunc(max(%unquote(&s)))
%mend;


* ----- macro min -----;
* 返回一组值中的最小值;
* input;
*	value1,value2,...valueN		待比较的一组数;
* output;
*	返回值		计算结果;
* 	异常报错;
*test;
*	@test_math;

%macro min/parmbuff;
	%local s res l;
	%let res=;
	%let l=%length(&syspbuff);
	%if &l<=2 %then %let s=%str();
	%else %let s=%substr(&syspbuff,2,%eval(&l-2));
	%sysfunc(min(%unquote(&s)))
%mend;


* ---------------------------------------------------------------------------------------------------;
* ------------------------------------------- String macros -----------------------------------------;
* ---------------------------------------------------------------------------------------------------;

* 字符串处理函数;
* 注意：各类返回值为字符串的函数，一般返回的都是被%quote之后的字符串，若字符串需要进行代码解析，需要显式调用%unquote进行去转义;
* 一种比较好的编码习惯是：对于所有在proc或data中嵌入的宏代码，均使用%unquote进行处理;

* -------------------------------------------------;
* ---------------- String Format ------------------;
* -------------------------------------------------;

* 由于sas宏只支持字符串，因此一般需要各种字符格式检查函数来辅助进行数据类型的识别;

* isBlank vs isVoid;
*	对于转义空格，isBlank返回0，而isVolid返回0;

* ---- macro isBlank -----;
* 判断输入是否为空;
* test;
*	@test_isBlank;
* details;
* 	isBlank vs isVoid;
*		isBlank(%str( ))=0;
*		isVoid(%str( ))=1;

%macro isBlank(param);
	%eval(%length(%quote(&param))=0)
%mend;


* ---- macro notBlank ----;
* 判断输入是否为空;
* test;
*	test_notBlank;

%macro notBlank(param);
	%eval(%length(%quote(&param))>0)
%mend;


* ---- macro isVoid -----;
* 判断输入是否为空;
* test;
*	@test_isVoid;

%macro isVoid(param);
	%eval(%length(%strip(&param))=0)
%mend;

* ---- macro notVoid -----;
* 判断输入是否为空;
* test;
*	@test_notVoid;

%macro notVoid(param);
	%eval(%length(%strip(&param))>0)
%mend;


* ----- macro anyAlpha -----;
* 判断字符串中是否有字母，字母包括a-z,A-Z;
* output;
*	返回值		1|0;
*test;
*	@test_anyAlpha;

%macro anyAlpha(s);
	%eval(%sysfunc(anyAlpha(&s))>0)
%mend;


* ----- macro anyDigit -----;
* 判断字符串中是否有数字，数字包括0-9;
* output;
*	返回值		1|0;
*test;
*	@test_anyDigit;

%macro anyDigit(s);
	%eval(%sysfunc(anyDigit(&s))>0)
%mend;


* ---- macro isDigit ----;
* 判断字符串是否是数字;
* input
*	s			输入字符串;
*				输入字符串的前后空白字符不影响判断;
* output;
*	返回值		1|0;
* test;
*	@test_isDigit;
* details;
*	支持的格式;
*		浮点数				1.23 -1.23;
*		缺失值				.;
*		科学计数法			2.445E-6 -2.476E6;
*	isDigit vs anyDigit;
*		isDigit使用正则表达式判断字符串是否为数字;
*		anyDigit仅判断字符串中是否包含数字字符;

%macro isDigit(s);
	%local res;
	%let res=0;
	%let s=%strip(&s);
	%if %isBlank(&s) %then %let res=0;
	%else %do;
		%if %index(&s,%str(.))=0 %then %let s=&s%str(.);
		%if %prxmatch(%str(/^[-+]?[0-9]*\.[0-9]*(E-?\d*)?$/),&s) %then %let res=1;
	%end;
	&res.
%mend;


* ---- macro isUINT ----;
* 判断字符串是否是UINT;
* input
*	s			输入字符串;
*				输入字符串的前后空白字符不影响判断;
* output;
*	返回值		1|0;
* test;
*	@test_isUINT;

%macro isUINT(s);
	%local res;
	%let res=0;
	%let s=%strip(&s);
	%if %isBlank(&s) %then %let res=0;
	%else %if &s=0 %then %let res=1; 
	%else %if %prxmatch(%str(/^[+]?[1-9]{1}[0-9]*$/),&s) %then %let res=1;
	&res.
%mend;


* ---- macro isVar ----;
* 判断字符串是否是变量;
* input
*	s			输入字符串;
*				输入字符串的前后空白字符不影响判断;
* output;
*	返回值		1|0;
* test;
*	@test_isUINT;
* details;
*	识别条件;
*		长度小于等于32;
*		以字母或_开头;
*		只使用字母、数字或_;

%macro isVar(s);
	%local res;
	%let res=0;
	%let s=%strip(&s);
	%if %prxmatch(%str(/^[A-Za-z_]\w{0,31}$/),&s) %then %let res=1;
	&res.
%mend;


* ---- macro isEven ----;
* 判定是否是偶数;
* input
*	s			输入字符串;
*				输入字符串的前后空白字符不影响判断;
* output;
*	返回值		1|0;
* test;
*	@test_isEven;
* details;
*	0002将被认定为是偶数;
%macro isEven(s);
	%local res;
	%let res=0;
	%let s=%strip(&s);
	%if %prxmatch(%str(/^[-+]?[0-9]*[02468]$/),&s) %then %let res=1;
	&res.
%mend;


* ---- macro isOdd ----;
* 判定是否是奇数;
* test;
*	@test_isOdd;
* details;
*	0001将被认定为是奇数;
%macro isOdd(s);
	%local res;
	%let res=0;
	%let s=%strip(&s);
	%if %prxmatch(%str(/^[-+]?[0-9]*[13579]$/),&s) %then %let res=1;
	&res.
%mend;


* ---- macro inBracket ----;
* 判断字符串是否是包含在括号中（首尾是否是()）;
* test;
*	@test_inBracket;

%macro inBracket(s);
	%local res;
	%let res=0;
	%if %prxmatch(%str(/^\(.*\)$/),%strip(&s)) %then %let res=1;
	&res.
%mend;


* ---- macro inQuote ----;
* 判断字符串是否是包含在引号中（首尾是否是''或""）;
* test;
*	@test_inQuote;

%macro inQuote(s);
	%local res;
	%let res=0;
	%if %prxmatch(%str(/^\'.*\'$/),%strip(&s)) %then %let res=1;
	%else %if %prxmatch(%str(/^\".*\"$/),%strip(&s)) %then %let res=1;
	&res.
%mend;


* -------------------------------------------------;
* --------------- String Conversion ---------------;
* -------------------------------------------------;

* String Conversion vs String Operation;
*	本节的宏一般都是对“整个字符串”进行的操作，基本不改变字符串原貌;
*	String Operation 则主要是对字符串的局部”进行的各种操作;

* ---- macro strip ----;
* 去掉首尾白空格;
* example(以_代表空格);
*	_a_bc_def_ -> a_bc_def;
* test;
* 	@test_strip;

%macro strip(s);
	%local res;
	%if %klength(&s)=0 %then %let res=%str();
	%else %let res=%qsysfunc(strip(&s));
	&res.
%mend; 


* ---- macro compress ----;
* 删除所有白空格;
* input;
*	s		source字符串;
*	chars	被删除的目标字符清单，当为空时为删除所有白空格;
* example:
*	ab cde -> abcde;
* details;
*	注意compress的删除是一个单个字符为单位，chars是所有待删除的字符的清单而不是要删除的字符串;
*	当chars为空时，会删除白空格，当chars不为空时，仅会删除chars指定的字符，除非指定，不会再删除白空格;
*test;
*	@test_compress;

%macro compress(s,chars);
	%local res;
	%if %klength(&s)=0 %then %let res=%str();
	%else %if %isBlank(&chars) %then %let res=%qsysfunc(compress(&s));
	%else %let res=%qsysfunc(compress(&s,&chars));
	&res.
%mend; 


* ---- macro removeDupBlanks ----;
* 删除重复白空格，将字符串中的连续空格合并为1个;
* input;
*	s			输入字符串;
* output;
*	返回值		剔除了多余空格;
* test;
*	@test_removeDupBlanks;
* details;
*	compress vs removeDupBlanks vs varsCompress;
*		compress			删除所有白空格;
*		removeDupBlanks		将所有连续2个及以上白空格替换为单个空格;
*		varsCompress		将所有连续2个及以上白空格替换为单个空格，但不包括在单引号或双引号中的;
*							删除首尾所有白空格;

%macro removeDupBlanks(s);
	%local l1 l2;
	%let l1=0;
	%let l2=1;
	%if %length(&s)=0 %then %let s=%str();
	%do %while (&l1^=&l2);
		%let l1=%length(%quote(&s));
		%let s=%tranwrd(%quote(&s),%quote(  ),%quote( ));
		%let l2=%length(%quote(&s));
	%end;
	&s.
%mend;


* ---- macro reverse ----;
* 翻转字符串;
* example:
*	abcde -> edcba;
*test;
*	@test_reverse;

%macro reverse(s);
	%local res;
	%if %length(&s)=0 %then %let res=%str();
	%else %let res=%qsysfunc(kreverse(&s));
	&res.
%mend;


* ---- macro safeQuote ----;
* 安全quote函数，避免过度使用quote导致的嵌套层级错误;
* safeQuote会将输入字符串的转义嵌套层级降为1;
* details;
*	sas嵌套层级;
*		SAS最大嵌套quote层级为10，使用safequote可以避免quote超过限制（递归函数中较常见）,参见测试用例;
*	去嵌套的实现方式;
*		qsubstr，qsysfunc等都可以实现嵌套层数重置，safeQuote使用qsysfunc来实现;
*		safeQuote使用parmbuff/syspbuff的形参格式，从而可以直接输入各种特殊字符,而不再需要使用 %safeQuote(%quote( a b c )) 这种冗余形式;
* test;
*	@test_safeQuote;
%macro safeQuote/parmbuff;
	%deBracket(&syspbuff)
%mend;


* ---- macro safequote ----;
%macro squote/parmbuff;
	%deBracket(&syspbuff)
%mend;


* ---- macro padding ----;
* 字符串补齐宏;
* input;
*	str			原始字符串;
*	mode		补齐方式，支持left|right，默认right;
*	char		补齐字符串，默认为空;
*	len			补齐后的长度，必须大于0;
*	fixed		是否固定长度，默认为1;
*					1	结果字符串长度大于目标长度，则将被截断;
*					0	不截断;
* details;
*	多字符补齐;
*		str=abc char=123 len=10 mode=right fixed=1 	-> abc1231231;
*		str=abc char=123 len=10 mode=right fixed=0 	-> abc123123123;
*		str=abc char=123 len=10 mode=left fixed=1 	-> 3123123abc;
*		str=abc char=123 len=10 mode=left fixed=0	-> 123123123abc;

*test;
*	@test_padding;
%macro padding(str=,mode=,char=,len=,fixed=);

	%local l lc newStr;

	%if %isBlank(&len) %then %error(Required param is empty!);
	%if %sysevalf(&len<=0) %then %error(LEN must be gt 0!);
	%if %isBlank(&char) %then %let char=%str();
	%if %isBlank(&mode) %then %let mode=RIGHT;%else %let mode=%upcase(&mode);
	%if %isBlank(&fixed) %then %let fixed=1;
	
	%let l=%klength(&str);
	%let lc=%klength(&char);

	%if &l<&len %then %do;
		%let k=%ceil(%sysevalf((&len-&l)/&lc));
		%if &mode=RIGHT %then %let newStr=&str.%repeat(&char,&k);
		%else %let newStr=%repeat(&char,&k)&str.;
	%end;
	%else %let newStr=&str;
	%let l=%klength(&newStr);
	%if &l>&len and &fixed=1 %then %do;
		%if &mode=RIGHT %then %let newStr=%subString(&newStr,1,&len);
		%else %let newStr=%subString(&newStr,%eval(&l-&len+1));
	%end;
	&newStr.
%mend;


* ---- macro unicodecParen ----;
* 将字符串转换为UNICODE PAREN编码格式;
* A -> <u0041>;
* test;
*	@test_unicode;

%macro unicodecParen(v);
	%qsysfunc(unicodec(&v,PAREN))
%mend;

* ---- macro unicodeParen ----;
* 将UNICODE PAREN编码格式转换为字符串;
* <u0041> -> A;
* test;
*	@test_unicode;

%macro unicodeParen(v);
	%qsysfunc(unicode(&v,PAREN))
%mend;


* ---- macro debracket ----;
* 去掉最外面一层的括号;
* 当字符串最外层不是()时返回原字符串;
*test;
*@;

%macro deBracket(s);
	%prxchange(%str(s/^\((.*)\)$/$1/),1,&s)
%mend;


* ---- macro enQuote ----;
* 为字符串增加双引号;
* test;
*	@test_enquote;
* details;
*	fcmp.quote vs macro quote;
*		fcmp函数对于非成对的双引号会自动补全，因此这里没有采用封装fcmp.quote的方式来实现;
%macro enQuote(a);
	%quote(%"&a.%")
%mend;


* ---- macro enSquote ----;
* 为字符串增加单引号;
* test;
*	@test_ensquote;
* details;

%macro enSquote(a);
	%quote(%'&a.%')
%mend;


* ---- macro dequote ----;
* 去掉最外面一层的引号;
* 当字符串最外层不是''或""时返回原字符串;
* test;
* 	@test_dequote;

%macro dequote(s);
	%local res;
	%if %prxmatch(%str(/^\'.*\'$/),%strip(&s)) %then %let res=%prxchange(%str(s/^\'(.*)\'$/$1/),1,%strip(&s));
	%else %if %prxmatch(%str(/^\".*\"$/),%strip(&s)) %then %let res=%prxchange(%str(s/^\"(.*)\"$/$1/),1,%strip(&s));
	%else %let res=&s;
	&res.
%mend;

* ---- macro toSqlLike ----;
* abc -> '%abc%' ;
* 用于sql like场景;

%macro toSqlLike(var,mode);
	%local sfxRight sfxLeft res;
	%if %isBlank(&mode) %then %let mode=BOTH;
	%let mode=%upcase(&mode);
	%let sfxRight=%nrstr(%%);
	%let sfxLeft=%nrstr(%%);
	%if &mode=LEFT %then %let sfxRight=;
	%if &mode=RIGHT %then %let sfxLeft=;
	%let res=%nrstr(%')&sfxLeft.&var.&sfxRight.%nrstr(%');
	&res.
%mend;


* -------------------------------------------------;
* ---------------- String macros ------------------;
* -------------------------------------------------;

* 本节中的宏除count、countc、countw、replacec以外，均支持unicode;

* ---- macro repeat ----;
* 重复字符串;
* input;
*	s			输入字符串;
*	n			重复次数，如果n不是大于等于1的整数，则将输出空字符串;
* output;
*	返回值		重复字符串;
* example;
*	repeat(abc,4) -> abcabcabcabc;
* test;
*	@test_repeat;

%macro repeat(s,n);
	%local res;
	%if %isBlank(&s) %then %let res=%str();
	%else %if %sysevalf(&n>=1) %then %let res=%qsysfunc(repeat(&s,%sysevalf(&n-1)));
	%else %let res=%str();
	&res.
%mend;


* ----- macro findStr -----;
* 在指定string中搜索目标字符串，并返回其【所有】的出现位置;
* input;
* 	source		搜索的范围字符串，长字符串;
*	target		搜索的基准字符串，短字符串;
*	pos			搜索开始的位置，1为首位，默认为1;
* output;
*	返回值		返回值列表，vars格式，如：1 19 37;
*				当未找到匹配字符时，将返回空字符串;
*				当source或target为空时，将返回空字符串;
* details;
*	匹配的位置的计算采用“搜索，记录位置，删除已匹配，再搜索”的方式，如在字符串AAAAA中搜索AA，则会返回1 3;
*	findStr vs find;
*		fcmp.find只会返回搜索到的第一个匹配的位置;
* test;
*	@test_findStr;

%macro findStr(source,target,pos);
	%local src ind r len_s len_t finded_pos next_pos;
	%if %klength(&source)=0 or %klength(&target)=0 %then %let r=%str();
	%else %do;
		%if %isBlank(&pos) %then %let pos=1;
		%let src=%qksubstr(&source,&pos);
		%let ind=%kindex(&src,&target);
		%if &ind=0 %then %let r=%str();
		%else %do;
			%let len_s=%klength(&source);
			%let len_t=%klength(&target);
			%let finded_pos=%eval(&pos+&ind-1);
			%let next_pos=%eval(&pos+&ind+&len_t-1);
			%if &next_pos>&len_s %then %let r=&finded_pos;
			%else %do;
				%let r=&finded_pos %findStr(&source,&target,&next_pos);
				%let r=%strip(&r);
			%end;
		%end;
	%end;
	&r.
%mend;


* ----- macro tranwrd -----;
* 替换目标字符串中的字符;
* input;
*	source			搜索的范围字符串，长字符串;	
*	target			搜索的基准字符串，短字符串,当source或target为空时将返回原字符串;
* 	replacement		替换字符串;
* output;
*	返回值			替换完毕的字符串;
*					当未匹配成功时，将返回原字符串;
* details;
*	注意：当replacement为空时，默认使用一个空格作为replacement，并不会执行删除操作;
* test;
*	@test_tranwrd;

%macro tranwrd(source,target,replacement);
	%local res;
	%if %isBlank(&source) or %isBlank(&target) %then %let res=%quote(&source); 
	%else %let res=%qsysfunc(tranwrd(&source,&target,&replacement));
	&res.
%mend;


* ----- macro transtrn -----;
* 替换目标字符串中的字符;
* input;
*	source			搜索的范围字符串，长字符串;	
*	target			搜索的基准字符串，短字符串,当source或target为空时将返回原字符串;
* 	replacement		替换字符串;
* output;
*	返回值			替换完毕的字符串;
*					当未匹配成功时，将返回原字符串;
* details;
*	tranwrd vs transtrn;
*		当replacement为空时，tranwrd执行替换为空格，transtrn执行删除;
*test;
*	@test_transtrn;

%macro transtrn(source,target,replacement);
	%local res;
	%if %isBlank(&source) or %isBlank(&target) %then %let res=%quote(&source); 
	%else %let res=%qsysfunc(transtrn(&source,&target,&replacement));
	&res.
%mend;


* ----- macro replaceStr -----;
%macro replaceStr(source,target,replacement);
	%transtrn(&source,&target,&replacement)
%mend;


* ----- macro replacec -----;
* 单字节替换目标;
* input;
* 	source				搜索的范围字符串，长字符串，为空时视为%str( );
*	replacement			用于替换的字符;
*							长度为0					视同%str()，即删除;
*							长度为1	 				正常;
*							长度大于1				取第一个字符;
*	pos					替换的位置，默认为0;
*							[1,length(source)]		替换相应字符;
*							>length(source)			视同其间为空格;
*							其他值					不执行;
*						
* output;
*	返回值				替换后的字符串;
* test;
*	@test_replacec;
%macro replacec(source,replacement,pos);
	%local res ls lr;
	%if %isBlank(&pos) %then %let pos=0;
	%let ls=%length(&source);
	%let lr=%length(&replacement);
	%if &lr>1 %then %let replacement=%qsubstr(&replacement,1,1);
	%if &ls=0 %then %let res=&source;
	%else %if &pos=1 %then %let res=&replacement.%qsubstr(&source,%eval(&pos+1));
	%else %if &pos>1 and &pos<&ls %then %let res=%qsubstr(&source,1,%eval(&pos-1))&replacement.%qsubstr(&source,%eval(&pos+1));
	%else %if &pos=&ls %then %let res=%qsubstr(&source,1,%eval(&pos-1))&replacement;
	%else %if &pos=%eval(&ls+1) %then %let res=&source.&replacement;
	%else %if &pos>%eval(&ls+1) %then %let res=&source.%repeat(%str( ),%eval(&pos-&ls-1))&replacement;
	%else %let res=&source;
	&res.
%mend;


* ----- macro insertStr -----;
* 将字符插入指定字符串;
* input;
* 	source				搜索的范围字符串，长字符串，为空时视为%str( );
*	inserter			用于插入的字符;
*	pos					插入的位置，insertStr将在pos指定的位置后面插入，如abc插入x，pos=2，则插入后为abxc，默认为0;
*							[0,length(source)]		插入相应位置;
*							>length(source)			中间以空格填充;
*							其他值					返回原字符串;
* output;
*	返回值				插入后的字符串;
* details;
* test;
*	@test_insertStr;

%macro insertStr(source,inserter,pos);
	%local res ls li;
	%if %isBlank(&pos) %then %let pos=0;
	%let ls=%klength(&source);
	%let li=%klength(&inserter);
	%if &li=0 %then %let res=&source;
	%if &pos=0 %then %let res=&inserter.&source;
	%else %if %sysevalf(&pos>0) and &pos<&ls %then %let res=%qksubstr(&source,1,&pos)&inserter.%qksubstr(&source,%eval(&pos+1));
	%else %if %sysevalf(&pos=&ls) %then %let res=&source.&inserter;
	%else %if %sysevalf(&pos>&ls) %then %let res=&source.%repeat(%str( ),%eval(&pos-&ls))&inserter;
	%else %let res=&source;
	&res.
%mend;


* ----- macro countStr -----;
* 在指定string中搜索目标字符串，并返回其出现的次数;
* countStr的计算逻辑与findStr相同;
* input;
* 	source		搜索的范围字符串，长字符串;
*	target		搜索的基准字符串，短字符串;
*	pos			搜索开始的位置，1为首位，默认为1;
* output;
*	返回值		字符串出现的计数;
*	返回值		当未找到匹配字符时，将返回0;
*				当source或target为空时，将返回0;
* test;
* 	@test_countStr;
* details;
*	countStr vs fcmp.count;
*		功能基本相同，但根据SAS说明，count主要有以下两个问题;
*			1 fcmp.count是I18N Level 0 status，对于unicode支持不好;
*			2 对于在boobooboo中搜索booboo的场景，fcmp.count会返回不确定的结果;
*		参见：http://support.sas.com/documentation/cdl//en/lefunctionsref/69762/HTML/default/viewer.htm#p02vuhb5ijuirbn1p7azkyianjd8.htm;

%macro countStr(source,target,pos);
	%local src ind r len_s len_t finded_pos next_pos;
	%if %klength(&source)=0 or %klength(&target)=0 %then %let r=0;
	%else %do;
		%if %isBlank(&pos) %then %let pos=1;
		%let src=%qksubstr(%quote(&source),&pos);
		%let ind=%kindex(%quote(&src),%quote(&target));
		%if &ind=0 %then %let r=0;
		%else %do;
			%let len_s=%klength(&source);
			%let len_t=%klength(&target);
			%let finded_pos=%eval(&pos+&ind-1);
			%let next_pos=%eval(&pos+&ind+&len_t-1);
			%if &next_pos>&len_s %then %let r=1;
			%else %do;
				%let r=%countStr(%quote(&source),%quote(&target),&next_pos);
				%let r=%eval(1+&r);
			%end;
		%end;
	%end;
	&r.
%mend;

* ---- macro count ----;
* 字符计数函数;
* http://support.sas.com/documentation/cdl//en/lefunctionsref/69762/HTML/default/viewer.htm#p02vuhb5ijuirbn1p7azkyianjd8.htm;
%macro count(s,c,m);
	%sysfunc(count(&s,&c,&m))
%mend;

* ---- macro countc ----;
* 字符计数函数;
* http://support.sas.com/documentation/cdl//en/lefunctionsref/69762/HTML/default/viewer.htm#n1qcntq4r6p3w3n1mtsnm58tbomc.htm;
%macro countc(s,c,m);
	%sysfunc(countc(&s,&c,&m))
%mend;

* ---- macro countw ----;
* 字符计数函数;
* http://support.sas.com/documentation/cdl//en/lefunctionsref/69762/HTML/default/viewer.htm#p18xi2516ihygyn1qg1b1nby326k.htm;
%macro countw(s,c,m);
	%sysfunc(countw(&s,&c,&m))
%mend;


* ---- macro subString ----;
* 按位置提取子字符串;
* input;
*	s		字符串;
*	start	开始位置	（包含），默认值1;
*	end		结束位置（包含），默认值-1;
*			start/end可以填正值或负值，负值表示逆序的位置;
*			1表示首位，-1表示最后一位;
* output;
*	返回值	提取后的字符串;
* details;
*	当以正向位置表示的start<=end时，返回正序字符串，当start>end时返回逆序的字符串;
* test;
* 	@test_subString;


%macro subString(s,start,end);
	%local l startPos endPos p reverse res i;
	%let reverse=0;
	%let res=;
	%if %isBlank(&start) %then %let start=1;
	%if %isBlank(&end) %then %let end=-1;
	%let l=%klength(&s);
	%if &start<0 %then %let startPos=%eval(&l+&start+1);
	%else %let startPos=&start;
	%if &end<0 %then %let endPos=%eval(&l+&end+1);
	%else %let endPos=&end;

	%if &startPos>&endPos %then %do;
		%let p=&startPos;
		%let startPos=&endPos;
		%let endPos=&p;
		%let reverse=1;
	%end;

	%if %eval(&startPos>&l) or %eval(&endPos<1) %then %let res=;
	%else %do;
		%let startPos=%min(%max(&startPos,1),&l);
		%let endPos=%min(%max(&endPos,1),&l);
		%let res=%qksubstr(&s,&startPos,%eval(&endPos-&startPos+1));
		%if &reverse %then %let res=%reverse(&res);
	%end;
	&res.
%mend;


* ---- macro prxmatch ----;
* 封装prxmatch函数，正则匹配搜索;
* input;
*	reg			正则表达式，应使用%quote或%str进行转义;
*	source		匹配的目标字符串;
* output;
*	返回值		首个匹配的位置，无匹配时为0;
*test;
* 	@test_prxmatch;

%macro prxmatch(reg,source);
	%qsysfunc(prxmatch(&reg,&source))
%mend;


* ---- macro prxchange ----;
* 封装prxchange函数，正则匹配替换;
* input;
*	reg			正则表达式，应使用%quote或%str进行转义;
*	times		替换次数，必须为大于等于-1的整数;
*				-1	替换直到字符串结束;
*				0	不替换;
*				1-k	替换k次或直到字符串结束;
*	source		匹配的目标字符串;
* output;
*	返回值		替换后的字符串;
* test;
*  @test_prxchange;

%macro prxchange(reg,times,source);
	%qsysfunc(prxchange(&reg,&times,&source))
%mend;


* -----------------------------------------------;
* --------------- String Binary -----------------;
* -----------------------------------------------;

* 二进制字符串操作宏，例如：二进制AND、OR、XOR、转换为base32格式等;

* 二进制字符表示 vs 数值表示;
* 	使用二进制字符串而不是使用数值进行计算后转换，主要是因为没有位数的限制，也便于实现bool数组;

* 二进制字符串表示;
*	从左至右排列，左边第一位记为第1位;
*	所有字符串都将在strip之后处理，即%str(   1001   )等价于1001;
*	字符串中间的白空格视同为0;

* 逻辑计算;
* 	二进制字符串在进行逻辑运算时，如果位数不同，则将左对齐后，缺失位补0;
*	完全空的字符串被视为0;

* ---- macro numToBin ----;
* 将数字转换为二进制字符串;
* input;
*	n		数值，自然数，必须小于等于2^52，即52bits;
* 	len		输出截取，不为空时只输出最低的len位，默认为全部输出;
*test;
*	@test_bin;

%macro numToBin(n,len);
	%local b;
	%paramRequired(&n)
	%if %sysevalf(&n<0) %then %error(Number must be LE 0!);
	%if %isBlank(&len) %then %do;
		%if &n=0 %then %let b=0;
		%else %do;
			%let b=%sysfunc(putn(&n,BINARY53));
			%let b=%prxchange(%str(s/^0+(1.*)/$1/),1,&b);
		%end;
	%end;
	%else %do;
		%if %sysevalf(&len<1) or %sysevalf(&len>52) %then %error(LEN exceeded the valid range!);
		%let b=%sysfunc(putn(&n,BINARY53));
		%let b=%subString(&b,-&len,-1);
	%end;
	&b.
%mend;


* ---- macro bin1 ----;
* 返回长度为k的全是1的bin;
* test;
* 	@test_bin1;

%macro bin1(k);
	%repeat(1,&k)
%mend;


* ---- macro bin0 ----;
* 返回长度为k的全是1的bin;
* test;
* 	@test_bin0;

%macro bin0(k);
	%repeat(0,&k)
%mend;

* ---- macro binFill0 ----;
* 将其中的空格填充为0;
* test;
* 	@test_bin1;

%macro binFill0(bin);
	%transtrn(%strip(&bin),%str( ),0)
%mend;


* ---- macro binCount1 ----;
* 统计binary中1的个数;
* test;
* 	@test_binCount1;

%macro binCount1(bin);
	%countc(&bin,1)
%mend;

* ---- macro binCount0 ----;
* 统计binary中1的个数;
* test;
* 	@test_binCount0;

%macro binCount0(bin);
	%eval(%length(%strip(&bin))-%count(&bin,1))
%mend;

* ---- macro binN ----;
* 返回第n位的值;
* test;
* 	@test_binN;

%macro binN(bin,k);
	%substr(%strip(&bin),&k,1)
%mend;

* ---- macro binSet1 ----;
* 设置第n位为1;
* test;
* 	@test_binSet11;

%macro binSet1(bin,k);
	%binFill0(%replacec(&bin,1,&k))
%mend;

* ---- macro binSet0 ----;
* 设置第n位为1;
* test;
* 	@test_binSet0;

%macro binSet0(bin,k);
	%binFill0(%replacec(&bin,0,&k))
%mend;

* ---- macro binToPos1 ----;
* 将bin中1情况转换为位置vars格式;
* 01101 -> 2 3 5;
* input;
*	bin		二进制字符串;
*test;
* 	@test_binToPos1;

%macro binToPos1(bin);
	%local i res;
	%let res=%str();
	%do i=1 %to %length(&bin);
		%if %qsubstr(&bin,&i,1)=1 %then %let res=&res &i;
	%end;
	%strip(&res)
%mend;


* ---- macro binAnd ----;
* bin与运算;
* test;
* 	@test_binAnd;

%macro binAND(a,b);
	%local la lb res i;
	%if %isBlank(&a) %then %let a=0;
	%if %isBlank(&b) %then %let b=0;
	%let a=%binFill0(&a);
	%let b=%binFill0(&b);
	%let la=%length(&a);
	%let lb=%length(&b);
	%do i=1 %to %min(&la,&lb);
		%let res=&res.%eval(%substr(&a,&i,1) and %substr(&b,&i,1));
	%end;
	%if &la<&lb %then %let res=&res.%repeat(0,%eval(&lb-&la));
	%else %if &la>&lb %then %let res=&res.%repeat(0,%eval(&la-&lb));
	&res.
%mend;


* ---- macro binOr ----;
* bin或运算;
* test;
* 	@test_binAnd;

%macro binOR(a,b);
	%local la lb res i;
	%if %isBlank(&a) %then %let a=0;
	%if %isBlank(&b) %then %let b=0;
	%let a=%binFill0(&a);
	%let b=%binFill0(&b);
	%let la=%length(&a);
	%let lb=%length(&b);
	%do i=1 %to %min(&la,&lb);
		%let res=&res.%eval(%substr(&a,&i,1) or %substr(&b,&i,1));
	%end;
	%if &la<&lb %then %let res=&res.%substr(&b,%eval(&la+1));
	%else %if &la>&lb %then %let res=&res.%substr(&a,%eval(&lb+1));
	&res.
%mend;

* ---- macro binNOT ----;
* bin或运算;
* test;
* 	@test_binAnd;

%macro binNOT(a);
	%local la lb res i;
	%if %isBlank(&a) %then %let a=0;
	%let a=%binFill0(&a);
	%let la=%length(&a);
	%do i=1 %to &la;
		%let res=&res.%eval(not %substr(&a,&i,1));
	%end;
	&res.
%mend;


* ---- macro binOr ----;
* bin或运算;
* test;
* 	@test_binAnd;

%macro binXOR(a,b);
	%local la lb res i;
	%if %isBlank(&a) %then %let a=0;
	%if %isBlank(&b) %then %let b=0;
	%let a=%binFill0(&a);
	%let b=%binFill0(&b);
	%let la=%length(&a);
	%let lb=%length(&b);
	%do i=1 %to %min(&la,&lb);
		%if %substr(&a,&i,1)=1 %then %do;
			%if %substr(&b,&i,1)=1 %then %let res=&res.0;
			%else %let res=&res.1;
		%end;
		%else %do;
			%if %substr(&b,&i,1)=1 %then %let res=&res.1;
			%else %let res=&res.0;
		%end;
	%end;
	%if &la<&lb %then %do;
		%let res=&res.%substr(&b,%eval(&la+1));
	%end;
	%else %if &la>&lb %then %do;
		%let res=&res.%substr(&a,%eval(&lb+1));
	%end;
	&res.
%mend;


* ---- macro binStrToBase32 ----;
* 将二进制字符串转变为base32格式;
* example:
*	10011111111101->KZT;
* test;
*	@test_binStrToBase32;

%macro binStrToBase32(binStr);
	%local l k p i start end b c base32;
	%let l=%length(&binStr);
	%let k=%ceil(%sysevalf(&l/5));
	%let p=%eval(&k*5-&l);
	%if &p>0 %then %let binStr=&binStr.%repeat(0,&p);

	%let base32=%str();
	%do i=1 %to &k;
		%let start=%eval((&i-1)*5+1);
		%let end=%eval(&start+4);
		%let b=%subString(&binStr,&start,&end);
		%let c=%sysfunc(inputc(&b,$base32x.));
		%let base32=&base32.%strip(&c);
	%end;
	%unquote(&base32)
%mend;


* -------------------------------------------------;
* ---------------- Hash functions -----------------;
* -------------------------------------------------;

* ---- macro md5 ----;
* test;
*	@test_md5;

%macro md5(str);
	%sysfunc(md5(&str),hex32.)
%mend;


* ---- macro md5base32 ----;
* 将字符串进行md5 hash然后以base32形式输出;
* input;
*	str			待编码的字符串;
* output;
*	返回值		base32编码的字符串;
* details;
*	md5为128bit长度，base32为5bit/字，因此md5base32返回字符串长度为26;
*test;
*	@test_md5base32;

%macro md5base32(str);
	%binStrToBase32(%sysfunc(md5(&str),$binary128.))
%mend;


* ---- macro sha256 ----;
* test;
*	@test_sha256;

%macro sha256(str);
	%sysfunc(sha256(&str),hex64.)
%mend;


* ---- macro sha256base32 ----;
* 将字符串进行sha256然后以base32形式输出;
* input;
*	str			待编码的字符串;
* output;
*	返回值		base32编码的字符串;
* details;
*	sha256为256bit长度，base32为5bit/字，因此md5base32返回字符串长度为52;
*test;
*	@test_md5base32;

%macro sha256base32(str);
	%binStrToBase32(%sysfunc(sha256(&str),$binary256.))
%mend;


* ----------------------------------------------------------------------------------------------------------;
* ----------------------------------------------- VARS  ----------------------------------------------------;
* ----------------------------------------------------------------------------------------------------------;

* vars概念;
* 	vars是形如 a b c 的字符串，以白空格分割的多个元素，可以用于模仿数组、集合等不同数据结构;
* 	vars使用白空格来分隔不同元素，在引号内的白空格除外;
*	vars是sas宏变量保存的字符串，因此应注意不应超过65534的长度限制;
*	vars的优点在于交互便利，便于书写，便于阅读，缺点是容量与访问效率较差;
*	因此vars适用于元素相对较少、较简单的场景，一个最常见的使用场景是用来保存变量名列表，这也是vars名称的由来;
*	对于数据量较大的数组，不建议适用vars，可以考虑再数据集中通过sql处理，或者使用后文的array object;

* vars使用注意事项;
* 	vars的计算过程中字符串都是转义的，如果在代码中使用，注意去转义;


* -------------------------------------------------;
* ------------------- Vars Basic ------------------;
* -------------------------------------------------;

* ---- macro varsDelimiter ----;
* vars分隔符转换宏;
* A B C -> a|b|c     A,B,C-> A#B#C;
* input;
*	vars						vars;
*	new/delimiter				新的delimiter;
*	old/oldDelimiter			原有delimiter，对应scan的charlist参数，默认为空;
*	modifier/oldModifier		原有modifier，对于scan的modifer参数，默认为空;
*								当两者同时为空时，默认oldDelimiter=QS，即认为vars是标准vars; 
* test;
*	@test_varsDelimiter;

%macro varsDelimiter(vars=,new=,old=,modifier=,delimiter=,oldDelimiter=,oldModifier=,res=);
	%local c i var newVars;
	%resCheck(&res);
	%let new=%paramAlias(&new,&delimiter);
	%let old=%paramAlias(&old,&oldDelimiter);
	%let modifier=%paramAlias(&modifier,&oldModifier);
	%if %isBlank(&old) and %isBlank(&modifier) %then %let modifier=QS;
	%let c=%countw(&vars,&old,&modifier);
	%if &c=0 %then %return;
	%do i=1 %to &c;
		%let var=%qscan(&vars,&i,&old,&modifier);
		%if &i=1 %then %let newVars=&var;
		%else %let newVars=&newVars.&new.&var;
	%end;
	%let &res=&newVars;
%mend;


* ---- macro varsSort ----;
* 对vars按字母ascii进行升序排序;
* input;
*	vars					目标vars;
*	res						返回变量;
* output;
*	res						排序后的字符串;
* test;
*	@test_varsSort;
* details;
*	注意：对于汉字，varsSort按unicode编码进行排序;

%macro varsSort(vars=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local i sw;
	%local prefix param;
	%local var varsN;
	%local result;

	%let prefix=%createTempVar;
	%let param=%str();
	%let result=%str();
	%let sw=1;
	%let i=1;
	
	%resCheck(&res);
	%do %while(&sw);
		%let var=%qscan(&vars,&i,,QS);
		%if %isBlank(&var) %then %do;
			%let varsN=%eval(&i-1);
			%let sw=0;
		%end;
		%else %do;
			%local &prefix.&i;
			%let &prefix.&i=&var;
			%let result=&result %nrstr(&)&prefix&i;
			%if &i=1 %then %let param=%quote(&prefix&i);
			%else %let param=&param.%quote(,&prefix&i);
			%let i=%eval(&i+1);
		%end;
	%end;
	%syscall sortc(%unquote(&param));
	%let &res=%unquote(&result);
%mend;


* ---- macro varsCompress ----;
* 删除vars中的重复分隔符;
*    a    b     c -> a b c;
%macro varsCompress(vars=,res=); 
	%local sw r var i;
	%let sw=1;
	%let i=1;
	%let r=%str();

	%resCheck(&res);
	%do %while(&sw);
		%let var=%qscan(&vars,&i,,QS);
		%if %isBlank(&var) %then %let sw=0;
		%else %do;
			%if &i=1 %then %let r=&var;
			%else %let r=&r &var;
			%let i=%eval(&i+1);
		%end;
	%end;
	%let &res=&r;
%mend;


* ---- macro varsCat ----;
* 逐个元素的连接两个vars，形成一个新vars;
* 	eg. a b c + 1 2 3 -> a1 b2 c3;
* input;
*	a						vars;
*	b						vars;
*							vars的元素个数必须相同;
* 	delimiter				这里指元素中间的连接符，默认为空;
*							例如:delimiter=_，则连接结果将为：a_1 b_2 c_3;
*	res						返回变量;
* output;
*	res						连接后的vars;
* test;
*	@test_varsCat;

%macro varsCat(a=,b=,delimiter=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local varsAN varA varsBN varB i vars;

	%resCheck(&res);
	%varsCount(vars=&a,res=&tres);%let varsAN=&&&tres;
	%varsCount(vars=&b,res=&tres);%let varsBN=&&&tres;
	%if &varsAN ne &varsBN %then %error(VARSNA ne VARSNB!);
	%if &varsAN=0 %then %return;

	%let vars=%str();
	%do i=1 %to &varsAN;
		%varsN(vars=&a,n=&i,res=&tres);%let varA=&&&tres;
		%varsN(vars=&b,n=&i,res=&tres);%let varB=&&&tres;
		%if &i=1 %then %let vars=&varA.&delimiter.&varB;
		%else %let vars=&vars &varA.&delimiter.&varB;
	%end;

	%let &res=&vars;
%mend;


* -------------------------------------------------;
* ---------------- Vars Conversion ----------------;
* -------------------------------------------------;

* vars conversion主要用于将vars转换为各种SAS常用格式（如：SQL）;
* vars conversion宏都直接返回处理后的结果，以简化书写;
* 更加复杂的格式转换或语句生成，可以使用varsSuffix或循环语句;

* ---- macro sasVarsToSql ----;
* a b c -> a,b,c;
* input;
*	vars	vars;
* output;
*	返回值	转换后的字符串;
* details;
*	注意包裹在引号(""与'')中的空格将不被识别为分隔符;
*	注意多个空格将被视为一个分隔符;
* test;
*	@test_sasVarsToSql;
%macro sasVarsToSql(vars);
	%local sw res var i;
	%let sw=1;
	%let i=1;
	%let res=%str();
	%do %while(&sw);
		%let var=%qscan(&vars,&i,,QS);
		%if %isBlank(&var) %then %let sw=0;
		%else %do;
			%if &i=1 %then %let res=&var;
			%else %let res=&res.%str(,&var);
			%let i=%eval(&i+1);
		%end;
	%end;
	&res.
%mend;


* ---- macro sasVarsToQuote ----;
* a b c -> 'a','b','c';
* input;
*	vars	vars;
* output;
*	返回值	转换后的字符串;
* test;
*  	@test_sasVarsToQuote;
%macro sasVarsToQuote(vars);
	%local sw res var qvar i;
	%let sw=1;
	%let i=1;
	%let res=%str();
	%do %while(&sw);
		%let var=%qscan(&vars,&i,,QS);
		%if %isBlank(&var) %then %let sw=0;
		%else %do;
			%if &i=1 %then %let res=%str(%')&var%str(%');
			%else %let res=&res%str(,)%str(%')&var%str(%');
			%let i=%eval(&i+1);
		%end;
	%end;
	&res.
%mend;


* ---- macro sasVarsAddQuote ----;
* a b c -> 'a' 'b' 'c';
* input;
*	vars	vars;
* output;
*	返回值	转换后的字符串;
*test;
* 	@test_sasVarsAddQuote;

%macro sasVarsAddQuote(vars);
	%local sw res var qvar i;
	%let sw=1;
	%let i=1;
	%let res=%str();
	%do %while(&sw);
		%let var=%qscan(&vars,&i,,QS);
		%if %isBlank(&var) %then %let sw=0;
		%else %do;
			%if &i=1 %then %let res=%quote(%'&var%');
			%else %let res=&res %str(%')&var%str(%');
			%let i=%eval(&i+1);
		%end;
	%end;
	&res.
%mend;


* ---- macro sasVarsToVar ----;
* a b c -> A_B_C;
* input;
*	vars	vars;
* output;
*	返回值	转换后的字符串，注意都是大写;
* test;
*	@test_sasVarsToVar;

%macro sasVarsToVar(vars);
	%local sw res var qvar i;
	%let sw=1;
	%let i=1;
	%let res=%str();
	%do %while(&sw);
		%let var=%qscan(&vars,&i,,QS);
		%if %isBlank(&var) %then %let sw=0;
		%else %do;
			%if &i=1 %then %let res=&var;
			%else %let res=&res._&var;
			%let i=%eval(&i+1);
		%end;
	%end;
	%upcase(&res)
%mend;

* ---- macro sqlVarsToSas ----;
* a,b,c -> a b c;
* input;
*	vars		sql vars;
* output;
*	返回值	转换后的字符串;
* details;
*	注意：包裹在引号(""与'')中的,将不被识别为分隔符;
*	注意：由于vars格式中无法区别多个连续空格，因此多个逗号也将被视为一个分隔符;
* test;
*	@test_sqlVarsToSas;

%macro sqlVarsToSas(vars);
	%local sw res var i;
	%let sw=1;
	%let i=1;
	%let res=%str();
	%do %while(&sw);
		%let var=%qscan(&vars,&i,%str(,),QR);
		%if %isBlank(&var) %then %let sw=0;
		%else %do;
			%if &i=1 %then %let res=&var;
			%else %let res=&res &var;
			%let i=%eval(&i+1);
		%end;
	%end;
	&res.
%mend;


* ---- macro sasVarsToWhere ----;
* 将assigns转换为where条件形式;
* a=1 b='str' c=100 -> a=1 and b='str' and c=100;
* test;
* 	@test_sasVarsToWhere;
%macro sasVarsToWhere(vars);
	%local sw res var qvar i;
	%let sw=1;
	%let i=1;
	%let res=%str();
	%do %while(&sw);
		%let var=%qscan(&vars,&i,,QS);
		%if %isBlank(&var) %then %let sw=0;
		%else %do;
			%if &i=1 %then %let res=&var;
			%else %let res=&res %str(and) &var;
			%let i=%eval(&i+1);
		%end;
	%end;
	&res.
%mend;

* ---- macro assignsToWhere ----;
%macro assignsToWhere;
	%sasVarsToWhere
%mend;



* -------------------------------------------------;
* ----------------- Vars Position -----------------;
* -------------------------------------------------;

* 基于位置的vars操作;
* 注意：varsN与varsK功能相同，仅返回不同模式，都支持负数;
* 注意：varsCount与varsLength功能相同，仅返回方式不同;	


* ---- macro varsLength ----;
* 返回vars中的var个数;
* input;
*	vars	vars;
*	res		返回变量;
* output;
*	res		返回变量个数;
* test;
*	@test_countVars;

%macro varsLength(vars);
	%local sw res var i;
	%let sw=1;
	%let i=1;
	%let res=0;
	%if %isBlank(&vars) %then %let res=0;
	%else %do;
		%do %while(&sw);
			%let var=%qscan(&vars,&i,,QS);
			%if %isBlank(&var) %then %do;
				%let sw=0;
				%let res=%eval(&i-1);
			%end;
			%else %let i=%eval(&i+1);
		%end;
	%end;
	&res.
%mend;


* ---- macro varsK ----;
* 返回vars中的第k个var，直接返回;
* input;
*	vars		vars;
*	ks			位置列表，vars格式，当位置小于0时表示逆序，当位置=0或超界限值时该位置为空;
* output;
*	return		vars格式，返回指定位置的元素;
* test;
*	@test_varsK;
%macro varsK(vars,ks);
	%local res l k i;
	%let l=%varsLength(&ks);
	%do i=1 %to &l;
		%let k=%qscan(&ks,&i,,QS);
		%if %notBlank(&k) and &k ne 0 %then %let res=&res %qscan(&vars,&k,,QS);
	%end;
	%strip(&res)
%mend;


* ---- macro subVars ----;
* 提取部分vars，subString的vars版;
* 参数与逻辑与subString相同;
* input;
*	vars		vars;
*	start		开始位置;
*	end			结束位置;
*				支持负数，表示从末尾倒数的位置;
*				start>end时表示逆序输出;
* output;
*	return		vars格式，返回指定给定位置的元素;
* test;
*	@test_subVars;
%macro subVars(vars,start,end);
	%local l p reverse res i;
	%let reverse=0;
	%let res=;
	%let l=%varsLength(&vars);

	%if %isBlank(&start) %then %let start=-99999;
	%else %if &start<-32767 or &start>32767 %then %error(%quote(START must in [-32767,32767]));

	%if %isBlank(&end) %then %let end=99999;
	%else %if &end<-32767 or &end>32767 %then %error(%quote(START must in [-32767,32767]));
	
	%if &start<0 %then %let start=%eval(&l+&start+1);
	%if &end<0 %then %let end=%eval(&l+&end+1);

	%if &start>&end %then %do;
		%let p=&start;
		%let start=&end;
		%let end=&p;
		%let reverse=1;
	%end;

	%if &l=0 or &start>&l or &end<1 %then %let res=;
	%else %do;
		%let start=%min(%max(&start,1),&l);
		%let end=%min(%max(&end,1),&l);
		
		%if &reverse=0 %then %do;
			%do i=&start %to &end;
				%let res=&res %qscan(&vars,&i,,QS);
			%end;
		%end;
		%else %do;
			%do i=&start %to &end;
				%let res=%qscan(&vars,&i,,QS) &res;
			%end;
		%end;
	%end;
	%strip(&res)
%mend;


* ---- macro varsReverse----;
* 转换vars的顺序;
* input;
*	vars		vars;
* output;
*	return		反向的vars;
* test;
*	@test_varsReverse;
%macro varsReverse(vars);
	%local sw res var i;
	%let sw=1;
	%let i=1;
	%let res=;
	%if not %isBlank(&vars) %then %do;
		%do %while(&sw);
			%let var=%qscan(&vars,&i,,QS);
			%if %isBlank(&var) %then %let sw=0;
			%else %do;
				%let res=&var &res;
				%let i=%eval(&i+1);
			%end;
		%end;
	%end;
	&res.
%mend;


* ---- macro varsDelete ----;
* 删除指定位置元素;
* input;
*	vars		vars;
*	n			目标位置;
* output;
*	return		删除结果;
* test;
*	@test_varsDelete;

%macro varsDelete(vars,n);
	%local res;
	%if %isBlank(&vars) or %isBlank(&n) or &n=0 %then %let res=&vars;
	%else %if &n=-1 %then %let res=%subVars(&vars,,%eval(&n-1));
	%else %let res=%subVars(&vars,,%eval(&n-1)) %subVars(&vars,%eval(&n+1));
	%strip(&res)
%mend;


* ---- macro varsInsert ----;
* 在指定位置后插入元素;
* input;
*	vars		vars;
*	n			目标位置;
*	value		插入值，可以是vars;
* output;
*	return		插入结果;
* test;
*	@test_varsInsert;
* details;
*	注意;
*		varsInsert执行后，value一定被插入到vars中，但不能认为varsK(vars,n)对应的值就是value;
*		例如：vars长度10，插入位置100，则元素实际的位置是11;

%macro varsInsert(vars,n,value);
	%local res;
	%if %isBlank(&vars) %then %let res=&value;
	%else %if %isBlank(&n) %then %let res=&vars;
	%else %if &n=-1 %then %let res=&vars &value;
	%else %let res=%subVars(&vars,,&n) &value %subVars(&vars,%eval(&n+1));
	%strip(&res)
%mend;


* ---- macro varsReplace ----;
* 替换指定位置元素;
* input;
*	vars		vars;
*	n			目标位置;
*	value		替换值，可以是vars;
* output;
*	return		替换结果;
* test;
*	@test_varsReplace;
* details;
*	注意;
*		varsReplace执行后，原位置n处的值一定被删除，但不能认为varsK(vars,n)对应的值就是value;
*		例如：vars长度10，替换位置100，则元素实际的位置是11;

%macro varsReplace(vars,n,value);
	%local res;
	%if %isBlank(&vars) %then %let res=&value;
	%else %if %isBlank(&n) %then %let res=&vars;
	%else %if &n=-1 %then %let res=%subVars(&vars,,%eval(&n-1)) &value;
	%else %if &n=0 %then %let res=&value &vars;
	%else %let res=%subVars(&vars,,%eval(&n-1)) &value %subVars(&vars,%eval(&n+1));
	%strip(&res)
%mend;



* ---- macro varsCount ----;
* 返回vars中的var个数;
* input;
*	vars	vars;
*	res		返回变量;
* output;
*	res		返回变量个数;
* test;
*	@test_varsCount;

%macro varsCount(vars=,res=);
	%local sw var i;
	%let sw=1;
	%let i=1;
	%resCheck(&res,0);
	%if %isBlank(&vars) %then %return;
	%do %while(&sw);
		%let var=%qscan(&vars,&i,,QS);
		%if %isBlank(&var) %then %let sw=0;
		%else %do;
			%let &res=&i;
			%let i=%eval(&i+1);
		%end;
	%end;
%mend;


* ---- macro varsN ----;
* 返回vars中的第n个var;
* input;
*	vars	vars;
*	n		序数，当n小于0时表示逆序，当n=0或其他非整数时返回空;
*	res		返回变量;
* output;
*	res		第n个var;
* test;
*	@test_varsN;

%macro varsN(vars=,n=,res=);
	%resCheck(&res);
	%if %isBlank(&vars) or %isBlank(&n) %then %return;
	%if &n=0 %then %return;
	%let &res=%qscan(&vars,&n,,QS);
%mend;


* ---- macro varsNS ----;
* varsN多位置版;
* vars=a b c , n=1 3 -> res=a c; 
* input;
*	vars			vars;
*	n/pos			选取的单元位置，vars格式，随意指定顺序，允许重复（例如：3 2 2 2）;
* test;
* 	@test_varsNS;

%macro varsNS(vars=,n=,pos=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local posN p;
	%local i;
	%local newvars;
	%resCheck(&res);
	%let pos=%paramAlias(&n,&pos);
	%if %isBlank(&vars) or %isBlank(&pos) %then %return;
	%varsCount(vars=&pos,res=&tres);%let posN=&&&tres;
	%do i=1 %to &posN;
		%varsN(vars=&pos,n=&i,res=&tres);%let p=&&&tres;
		%varsN(vars=&vars,n=&p,res=&tres);%let newvars=&newvars &&&tres;
	%end;
	%let &res=&newvars;
%mend;


* ---- macro varsPos ----;
%macro varsPos(vars=,n=,pos=,res=);
	%varsNS(vars=&vars,n=&n,pos=&pos,res=&res);
%mend;



* -------------------------------------------------;
* ----------------- Vars Matching -----------------;
* -------------------------------------------------;

* ---- macro varsMatch ----;
* 返回vars中正则表达式匹配的vars;
* input;
*	vars			目标vars;
*	regexp			正则表达式;
* test;
*	@test_varsMatch;

%macro varsMatch(vars=,regexp=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local i;
	%local var varsN newVars;

	%resCheck(&res);
	%paramRequired(&regexp);
	%if %isBlank(&vars) %then %return;
	%varsCount(vars=&vars,res=&tres);%let varsN=&&&tres;
	%do i=1 %to &varsN;
		%varsN(vars=&vars,n=&i,res=&tres);%let var=&&&tres;
		%if %prxmatch(&regexp,&var) %then %let newVars=&newVars &var;
	%end;
	%let &res=&newVars;
%mend;


* ---- macro varsFilter ----;
* vars过滤函数，过滤包含filter字符串的var(黑名单模式)，或者保留相应字符（白名单模式）;
* input;
*	vars			目标vars;
*	filter			过滤vars;
*					当filter为空且为白名单模式时，则返回空;
*					当filter为空且为黑名单模式时，返回vars;
*	isBlacklist		是黑名单过滤，默认为1;
*	caseSensitive	区分大小写，默认为0;
* test;
*	@test_varsFilter;
* details;
*	varsFilter vs varsSub;
*		varsSub仅相当于黑名单过滤，varsSub按集合方式来处理;

%macro varsFilter(vars=,filter=,isBlacklist=,caseSensitive=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local varsN var;
	%local i j;
	%local matched;

	%resCheck(&res);
	%if %isBlank(&vars) %then %return;
	%let isBlacklist=%nonBlank(&isBlackList,1);
	%let caseSensitive=%nonBlank(&caseSensitive,0);
	%if %isBlank(&filter) %then %do;
		%if &isBlacklist=0 %then %return;
		%let &res=&vars;%return; 
	%end;

	%varsCount(vars=&vars,res=&tres);%let varsN=&&&tres;
	%do i=1 %to &varsN;
		%varsN(vars=&vars,n=&i,res=&tres);%let var=&&&tres;
		%varsExist(source=&filter,target=&var,caseSensitive=&caseSensitive,res=&tres);
		%if &&&tres %then %do;
			%if &isBlacklist=0 %then %let matched=&matched &var;
		%end;
		%else %do;
			%if &isBlacklist=1 %then %let matched=&matched &var;
		%end;
	%end;
	%resSet(&res,%strip(&matched));
%mend;


* ---- macro varsBefore ----;
* 返回vars在指定var之前的部分;
* input;
*	vars					vars;
*	var/before				目标var;
*	res						返回变量;
* eg;
*	vars=a b c d, before=c, result=a b;
*	vars=a b c c d, before=c, result=a b;
* test;
*	@test_varsBefore;

%macro varsBefore(vars=,var=,before=,caseSensitive=,res=);

	%local sw var i str found;

	%let sw=1;
	%let i=1;
	%let found=0;

	%resCheck(&res);
	%let before=%paramAlias(&var,&before);
	%if %isBlank(&vars) %then %return;
	%if %isBlank(&before) %then %return;
	%if %isBlank(&caseSensitive) %then %let caseSensitive=0;

	%if &caseSensitive=1 %then %do;
		%do %while(&sw);
			%let var=%qscan(&vars,&i,,QS);
			%if %isBlank(&var) %then %let sw=0;
			%else %if &var=&before %then %do;
				%let found=1;
				%let sw=0;
			%end;
			%else %let str=&str &var;
			%let i=%eval(&i+1);
		%end;
	%end;
	%else %do;
		%do %while(&sw);
			%let var=%qscan(&vars,&i,,QS);
			%if %isBlank(&var) %then %let sw=0;
			%else %if %upcase(&var)=%upcase(&before) %then %do;
				%let found=1;
				%let sw=0;
			%end;
			%else %let str=&str &var;
			%let i=%eval(&i+1);
		%end;
	%end;
	%if &found=1 %then %let &res=&str;
%mend;


* ---- macro varsAfter ----;
* 返回vars在指定var之后的部分;
* input;
*	vars					vars;
*	var/after				目标var;
*	res						返回变量;
* eg;
*	vars=a b c d, after=b, result=c d;
*	vars=a b c c d, after=c, result=c d;
* test;
*	@test_varsAfter;

%macro varsAfter(vars=,var=,after=,caseSensitive=,res=);

	%local sw var i str found;

	%let sw=1;
	%let i=1;
	%let found=0;

	%resCheck(&res);
	%let after=%paramAlias(&var,&after);
	%if %isBlank(&vars) %then %return;
	%if %isBlank(&after) %then %return;
	%if %isBlank(&caseSensitive) %then %let caseSensitive=0;

	%if &caseSensitive=1 %then %do;
		%do %while(&sw);
			%let var=%qscan(&vars,&i,,QS);
			%if %isBlank(&var) %then %let sw=0;
			%else %if &found=1 %then %let str=&str &var;
			%else %if &var=&after %then %let found=1;
			%let i=%eval(&i+1);
		%end;
	%end;
	%else %do;
		%do %while(&sw);
			%let var=%qscan(&vars,&i,,QS);
			%if %isBlank(&var) %then %let sw=0;
			%else %if &found=1 %then %let str=&str &var;
			%else %if %upcase(&var)=%upcase(&after) %then %let found=1;
			%let i=%eval(&i+1);
		%end;
	%end;
	%let &res=&str;
%mend;

* ---- macro varsPrev ----;
* 返回指定var前面一个var;
* e.g;
*	vars=a b c d  var=c res=b;
* test;
*	@test_varsPrev;

%macro varsPrev(vars=,var=,caseSensitive=,res=);

	%local sw v i str found;

	%let sw=1;
	%let i=1;
	%let found=0;

	%resCheck(&res);
	%if %isBlank(&vars) %then %return;
	%if %isBlank(&var) %then %return;
	%if %isBlank(&caseSensitive) %then %let caseSensitive=0;

	%if &caseSensitive=1 %then %do;
		%do %while(&sw);
			%let v=%qscan(&vars,&i,,QS);
			%if %isBlank(&v) %then %let sw=0;
			%else %if &v=&var %then %do;
				%let found=1;
				%let sw=0;
			%end;
			%else %let str=&v;
			%let i=%eval(&i+1);
		%end;
	%end;
	%else %do;
		%do %while(&sw);
			%let v=%qscan(&vars,&i,,QS);
			%if %isBlank(&v) %then %let sw=0;
			%else %if %upcase(&v)=%upcase(&var) %then %do;
				%let found=1;
				%let sw=0;
			%end;
			%else %let str=&v;
			%let i=%eval(&i+1);
		%end;
	%end;
	%if &found=1 %then %let &res=&str;
%mend;

* ---- macro varsNext ----;
* 返回指定var后面一个var;
* e.g;
*	vars=a b c d  var=c res=d;
* test;
*	@test_varsNext;
%macro varsNext(vars=,var=,caseSensitive=,res=);

	%local sw v i str found;

	%let sw=1;
	%let i=1;
	%let found=0;

	%resCheck(&res);
	%if %isBlank(&vars) %then %return;
	%if %isBlank(&var) %then %return;
	%if %isBlank(&caseSensitive) %then %let caseSensitive=0;

	%if &caseSensitive=1 %then %do;
		%do %while(&sw);
			%let v=%qscan(&vars,&i,,QS);
			%if %isBlank(&v) %then %let sw=0;
			%else %if &found=1 %then %do;
				%let str=&v;
				%let sw=0;
			%end;
			%else %if &v=&var %then %let found=1;
			%let i=%eval(&i+1);
		%end;
	%end;
	%else %do;
		%do %while(&sw);
			%let v=%qscan(&vars,&i,,QS);
			%if %isBlank(&v) %then %let sw=0;
			%else %if &found=1 %then %do;
				%let str=&v;
				%let sw=0;
			%end;
			%else %if %upcase(&v)=%upcase(&var) %then %let found=1;
			%let i=%eval(&i+1);
		%end;
	%end;
	%let &res=&str;

%mend;


* ---- macro varsFind ----;
* 返回指定var在vars中的位置;
* input;
*	var/target				目标var，短字符串;
*							空字符串或纯粹由白空格构成的字符串将导致返回0;
*	vars/source				搜索范围,vars格式，长字符串;
* 	caseSensitive			是否大小写敏感，默认为0;
*	res						返回变量;
* output;
*	返回值					返回var排序的位数;
*							有多个匹配时返回第一次出现的位置;
* details;
* test;
* 	@test_varsFind;

%macro varsFind(vars=,source=,var=,target=,caseSensitive=,res=);
	%local sw res v i;
	%let sw=1;
	%let i=1;
	%resCheck(&res,0);
	%let source=%paramAlias(&vars,&source);
	%let target=%paramAlias(&var,&target);
	%if %isBlank(&source) or %isBlank(&target) %then %return;
	%if %isBlank(&caseSensitive) %then %let caseSensitive=0;
	%let target=%strip(&target);
	%if %isBlank(&target) %then %return;

	* quick check;
	%if &caseSensitive=1 %then %do;
		%if %index(&source,&target)=0 %then %return;
	%end;
	%else %do;
		%if %index(%qupcase(&source),%qupcase(&target))=0 %then %return;
	%end;

	%do %while(&sw);
		%let v=%qscan(&source,&i,,QS);
		%if %isBlank(&v) %then %let sw=0;
		%else %if &caseSensitive=1 and &target=&v %then %let &res=&i;
		%else %if &caseSensitive=0 and %qupcase(&target)=%qupcase(&v) %then %let &res=&i;
		%if &&&res>0 %then %return;
		%let i=%eval(&i+1);
	%end;
%mend;

* ---- macro varsExist ----;
* 返回指定var在vars中的位置;

%macro varsExist(vars=,source=,var=,target=,caseSensitive=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%resCheck(&res,0);
	%varsFind(vars=&vars,source=&source,var=&var,target=&target,caseSensitive=&caseSensitive,res=&tres);
	%if &&&tres>0 %then %let &res=1; 
%mend;


* -------------------------------------------------;
* ------------------- Vars Batch ------------------;
* -------------------------------------------------;

* 重复对vars所有元素进行相同处理，例如：添加前后缀、padding等;

* ---- macro varsBatch ----;
* vars通用批量宏;
* 	eg. a b c + upcase -> A B C;
* input;
*	vars			vars;
*	macro			批量进行的宏名，该宏必须是直接返回值的宏，例如：upcase、strip;
*	p				vars对应的参数名;
*	p2				其他宏参数，vars/assigns格式;
*					p与p2共同构成最终的宏参数;
*	res				返回变量;
* output;
*	res				按输入vars的顺序返回结果;
* details;
*	 p/p2使用示例;
*		macro		p			p2
*		upcase		 									;
*		subString				3 6						;
*		padding		str			char=0 mode=left len=10	; 
%macro varsBatch(vars=,macro=,p=,p2=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local var varsN i;
	%local r;

	%resCheck(&res);
	%paramRequired(&macro);
	%if %isBlank(&vars) %then %return;
	%if %notBlank(&p) %then %let p=&p.=;
	%if %notBlank(&p2) %then %let p2=,%sasVarsToSql(&p2);

	%varsCount(vars=&vars,res=&tres);%let varsN=&&&tres;
	%do i=1 %to &varsN;
		%varsN(vars=&vars,n=&i,res=&tres);%let var=&&&tres;
		%let r=%&macro.(&p.&var.%unquote(&p2));
		%if &i=1 %then %let &res=&r;
		%else %let &res=&&&res &r;
	%end;
%mend;


* ---- macro varsSuffix ----;
* 对vars添加前、后缀;
* input;
*	vars					待排序,vars格式;
*	prefix					前缀;
*	suffix					后缀;
*	len						是否限定拼接后的最大长度，默认不限定;
*	cut						限定最大长度时的截断模式;
*								LEFT		从左侧截断;
*								RIGHT		从右侧截断， 默认;
*								注意：这两种截断方式都是先截断再拼接，即前后缀部分优先，不会被截断掉;
*	delimiter				新的分割符，例如：vars=A B C，delimiter=_，则结果为A_B_C;
*							默认为空格;	
*	res						返回变量;
* output;
*	res						修改后的变量;
* test;
*	@test_varsSuffix;
%macro varsSuffix(vars=,suffix=,prefix=,delimiter=,len=,cut=,res=);
	%local sw var i str;
	%local lenSuffix lenPrefix lenMax lenVar;
	%let sw=1;
	%let i=1;
	%resCheck(&res);
	%if %isBlank(&vars) %then %return;
	%if %isBlank(&delimiter) %then %let delimiter=%str( );
	%if %isBlank(&suffix) and %isBlank(&prefix) %then %do;
		%let &res=&vars;
		%return;
	%end;
	%if %isBlank(&cut) %then %let cut=RIGHT;%else %let cut=%upcase(&cut);
	%let suffix=%strip(&suffix);
	%let prefix=%strip(&prefix);
	%if not %isBlank(&len) %then %do;
		%let lenSuffix=%length(&suffix);
		%let lenPrefix=%length(&prefix);
		%let lenMax=%eval(&len-&lenSuffix-&lenPrefix);
		%if &lenMax<=0 %then %error(The suffix or prefix is too long!);
		%do %while(&sw);
			%let var=%qscan(&vars,&i,,QS);
			%if %isBlank(&var) %then %let sw=0;
			%else %do;
				%let lenVar=%length(&var);
				%if &lenVar>&lenMax %then %do;
					%if &cut=RIGHT %then %let var=%substr(&var,1,&lenMax);
					%else %let var=%substr(&var,%eval(&lenVar-&lenMax+1),&lenMax);
				%end;
				%if &i=1 %then %let str=&prefix.&var.&suffix;
				%else %let str=&str.&delimiter.&prefix.&var.&suffix;
			%end;
			%let i=%eval(&i+1);
		%end;
	%end;
	%else %do;
		%do %while(&sw);
			%let var=%qscan(&vars,&i,,QS);
			%if %isBlank(&var) %then %let sw=0;
			%else %do;
				%if &i=1 %then %let str=&prefix.&var.&suffix;
				%else %let str=&str.&delimiter.&prefix.&var.&suffix;
			%end;
			%let i=%eval(&i+1);
		%end;
	%end;
	%let &res=&str;
%mend;


* ---- macro varsPrefix ----;
%macro varsPrefix(vars=,suffix=,prefix=,delimiter=,len=,cut=,res=);
	%varsSuffix(vars=&vars,suffix=&suffix,prefix=&prefix,delimiter=&delimiter,len=&len,cut=&cut,res=&res);
%mend;


* ---- macro varsPadding ----;
* vars批量padding宏;
* input;
*	vars		待处理vars;
*	其他参数说明参见padding;
* details;
*	padding白空格的处理;
*		由于vars格式中白空格将被合并处理，因此padding的白空格是无意义的，只有截取作用是有意义的;
*		为了避免padding中过多的白空格导致降低可读性，因此对于padding结果会进行strip处理;
* test;
*	@test_varsPadding;
%macro varsPadding(vars=,mode=,char=,len=,fixed=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local var varsN i;
	%resCheck(&res);
	%if %isBlank(&vars) %then %return;
	%varsCount(vars=&vars,res=&tres);%let varsN=&&&tres;
	%do i=1 %to &varsN;
		%varsN(vars=&vars,n=&i,res=&tres);%let var=&&&tres;
		%let var=%padding(str=&var,mode=&mode,char=&char,len=&len,fixed=&fixed);
		%let &res=&&&res %strip(&var);
	%end;
	%let &res=%strip(&&&res);
%mend;


* ---- macro varsMaxLength ----;
* 计算vars的元素长度的最大值;
* test;
*	@test_varsMaxLength;

%macro varsMaxLength(vars=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local lens;
	%resCheck(&res,0);
	%if %isBlank(%strip(&vars)) %then %return;
	%varsBatch(vars=&vars,macro=klength,res=&tres);%let lens=&&&tres;
	%let &res=%max(%unquote(%sasVarsToSql(&lens))); 
%mend;


* -------------------------------------------------;
* -------------------- Vars Set -------------------;
* -------------------------------------------------;
* 注意：对于包含大小写敏感参数caseSensitive的宏，若caseSensitive=0，则输出可能全部为大写;

* ---- varsUnique ----;
* 剔除vars中重复的var并按字符升序排列;
* input;
*	vars				vars;
* 	caseSensitive		是否大小写敏感，默认为0;
*	res					返回变量;
* output;
*	res					与运算的结果vars;
* details;
*	varsSort vs varsUnique;
*						大小写处理		去重			排序;
*		varsSort		区分				不去重		字符升序;
*		varsUnique		可选				去重			字符升序;
* test;
* 	@test_varsUnique;
%macro varsUnique(vars=,caseSensitive=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local var lastVar rawVars rawVar;
	%local sw i;

	%resCheck(&res);
	%if %isBlank(&vars) %then %return;
	%if %isBlank(&caseSensitive) %then %let caseSensitive=0;
	%if &caseSensitive=0 %then %let vars=%qupcase(&vars);
	%varsSort(vars=&vars,res=&tres);%let vars=&&&tres;
	%let lastVar=%qscan(&vars,1,,QS);
	%let &res=&lastVar;
	%let sw=1;
	%let i=2;
	%do %while(&sw);
		%let var=%qscan(&vars,&i,,QS);
		%if %isBlank(&var) %then %let sw=0;
		%else %if &lastVar ne &var %then %do;
			%let &res=&&&res &var;
			%let lastVar=&var;
		%end;
		%let i=%eval(&i+1);
	%end;
%mend;

* ---- macro varsAnd ----;
* 两个vars元素的与运算;
* input;
*	a					vars A;
*	b					vars B;
*						当A或B为空时，返回空字符串;
* 	caseSensitive		是否大小写敏感，默认为0;
*	res					返回变量;
* output;
*	res					与运算的结果vars,【quote safe】;
* details;
*	varsAnd会对结果进行去重处理;
* test;
*	@;

%macro varsAnd(a=,b=,caseSensitive=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local i j jStart;
	%local sw;
	%local varA varB;

	%resCheck(&res);
	%if %isBlank(&caseSensitive) %then %let caseSensitive=0;
	%if %isBlank(&a) or %isBlank(&b) %then %return;

	%varsUnique(vars=&a,caseSensitive=&caseSensitive,res=&tres);%let a=&&&tres;
	%varsUnique(vars=&b,caseSensitive=&caseSensitive,res=&tres);%let b=&&&tres;
	%let i=1;
	%let j=1;
	%let jStart=1;
	%let sw=1;
	%let varA=%qscan(&a,1,,QS);
	%let varB=%qscan(&b,1,,QS);

	%do %while(&sw);
		%if %isBlank(&varA) %then %do;
			%let sw=0;
		%end;
		%else %if %isBlank(&varB) %then %do;
			%let i=%eval(&i+1);
			%let j=&jStart;
			%let varA=%qscan(&a,&i,,QS);
			%let varB=%qscan(&b,&j,,QS);
		%end;
		%else %if &varA=&varB %then %do;
			%let &res=&&&res &varA;
			%let i=%eval(&i+1);
			%let j=%eval(&j+1);
			%let jStart=&j;
			%let varA=%qscan(&a,&i,,QS);
			%let varB=%qscan(&b,&j,,QS);
		%end;
		%else %do;
			%let j=%eval(&j+1);
			%let varB=%qscan(&b,&j,,QS);
		%end;
	%end;

	%let &res=%strip(&&&res);
%mend;


* ---- macro varsOr ----;
* 两个vars元素的或运算;
* input;
*	a					vars A;
*	b					vars B;
* 	caseSensitive		是否大小写敏感，默认为0;
*	res					返回变量;
* output;
*	res					或运算的结果vars;
* details;
*	varsOr会对结果进行去重处理;
*test;
*	@test_varsOr;
%macro varsOr(a=,b=,caseSensitive=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%resCheck(&res);
	%if %isBlank(&caseSensitive) %then %let caseSensitive=0;
	%varsUnique(vars=&a &b,caseSensitive=&caseSensitive,res=&tres);%let &res=&&&tres;
%mend;

* ---- macro varsSub ----;
* 两个vars元素的减法运算，返回一个新的vars;
* input;
*	a					vars A;
*	b					vars B;
* 	caseSensitive		是否大小写敏感，默认为0;
*	res					返回变量;
* output;
*	res					减运算的结果vars;
* details;
*	varsSub会对结果进行去重处理;
* test;
*	@test_varsSub;
%macro varsSub(a=,b=,caseSensitive=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local i j jStart;
	%local sw;
	%local varA varB;

	%resCheck(&res);
	%if %isBlank(&caseSensitive) %then %let caseSensitive=0;

	%varsUnique(vars=&a,caseSensitive=&caseSensitive,res=&tres);%let a=&&&tres;
	%varsUnique(vars=&b,caseSensitive=&caseSensitive,res=&tres);%let b=&&&tres;

	%if %isBlank(&a) %then %return;
	%if %isBlank(&b) %then %do;
		%let &res=&a;
		%return;
	%end;

	%let i=1;
	%let j=1;
	%let jStart=1;
	%let sw=1;
	%let varA=%qscan(&a,1,,QS);
	%let varB=%qscan(&b,1,,QS);
	%do %while(&sw);
		%if %isBlank(&varA) %then %do;
			%let sw=0;
		%end;
		%else %if %isBlank(&varB) %then %do;
			%let &res=&&&res &varA;
			%let i=%eval(&i+1);
			%let j=&jStart;
			%let varA=%qscan(&a,&i,,QS);
			%let varB=%qscan(&b,&j,,QS);
		%end;
		%else %if &varA=&varB %then %do;
			%let i=%eval(&i+1);
			%let j=%eval(&j+1);
			%let jStart=&j;
			%let varA=%qscan(&a,&i,,QS);
			%let varB=%qscan(&b,&j,,QS);
		%end;
		%else %do;
			%let j=%eval(&j+1);
			%let varB=%qscan(&b,&j,,QS);
		%end;
	%end;
	%let &res=%strip(&&&res);
%mend;

* ---- macro varsIn ----;
* 检查target中的所有var是否都在source中;
* input;
*	target					搜索特征,vars格式;
*	source					搜索范围,vars格式;
* 	caseSensitive			是否大小写敏感，默认为0;
*	res						返回变量;
* output;
*	res						0|1;
* details;
* test;
*	@test_varsIn;
%macro varsIn(source=,target=,res=,caseSensitive=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%resCheck(&res,0);
	%if %isBlank(&caseSensitive) %then %let caseSensitive=0;
	%varsSub(a=&target,b=&source,caseSensitive=&caseSensitive,res=&tres);
	%if %isBlank(&&&tres) %then %let &res=1;
%mend;

* ---- macro varsEqual ----;
* 检查两个的vars的元素是否相同;
* input;
*	a						搜索特征,vars格式;
*	b						搜索范围,vars格式;
* 	caseSensitive			是否大小写敏感，默认为0;
*	res						返回变量;
* output;
*	res						0|1;
* details;
* test;
*	@test_varsEqual;
%macro varsEqual(a=,b=,caseSensitive=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%resCheck(&res,0);
	%if %isBlank(&caseSensitive) %then %let caseSensitive=0;
	%varsUnique(vars=&a,caseSensitive=&caseSensitive,res=&tres);%let varsA=&&&tres;
	%varsUnique(vars=&b,caseSensitive=&caseSensitive,res=&tres);%let varsB=&&&tres;
	%if &varsA=&varsB %then %let &res=1;
%mend;


* -------------------------------------------------;
* ----------------- Assigns Macros ----------------;
* -------------------------------------------------;

* ---- macro varsToAssigns ----;
* 由vars合成assigns;
* input;
*	vars/a			vars，等号左边;
*	values/b		vars，等号右边;
* test;
*	@test_varsToAssigns;
%macro varsToAssigns(vars=,a=,values=,b=,res=);
	%let vars=%paramAlias(&vars,&a);
	%let values=%paramAlias(&values,&b);
	%varsCat(a=&vars,b=&values,delimiter=%str(=),res=&res);
%mend;


* ---- macro getAssignVar ----;
* 取等号左边的变量;
* test;
* 	@test_getAssignVar;
%macro getAssignVar(a);
	%local i res;
	%let i=%kindex(&a,%str(=));
	%if &i>1 %then %let res=%subString(&a,1,%eval(&i-1));
	&res.
%mend;

* ---- macro assignVar ----;
%macro assignVar(a);
	%getAssignVar(&a)
%mend;

* ---- macro getAssignValue ----;
* 取等号右边的值;
* test;
*	@test_getAssignValue;

%macro getAssignValue(a);
	%local i res;
	%let i=%index(&a,%str(=));
	%if &i=0 %then %let res=%str();
	%else %if &i=%length(&a) %then %let res=%str();
	%else %let res=%substr(&a,%eval(&i+1));
	&res.
%mend;

* ---- macro assignValue ----;
%macro assignValue(a);
	%getAssignValue(&a)
%mend;


* ---- macro assignsVars ----;
* 返回assigns中的vars;
* input;
*	assigns				assigns;
* test;
*	@test_assignsVars;
* details;
*	返回的vars顺序与assigns中的顺序相同;
*	注意拼写，不要写为assignVar;

%macro assignsVars(assigns=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;

	%local assignsN assign;
	%local var vars;
	%local i;

	%resCheck(&res);
	%varsCount(vars=&assigns,res=&tres);%let assignsN=&&&tres;
	%if &assignsN=0 %then %return;
	%do i=1 %to &assignsN;
		%varsN(vars=&assigns,n=&i,res=&tres);%let assign=&&&tres;
		%let var=%assignVar(&assign);
		%let vars=&vars &var;
	%end;
	%let &res=&vars;
%mend;


* ---- macro assignsValues ----;
* 返回assigns中的values;
* input;
*	assigns				assigns;
* test;
* 	@test_assignsValues;
* details;
*	返回的vars顺序与assigns中的顺序相同;
*	注意拼写，不要写为assignValue;

%macro assignsValues(assigns=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;

	%local assignsN assign;
	%local value values;
	%local i;

	%resCheck(&res);
	%varsCount(vars=&assigns,res=&tres);%let assignsN=&&&tres;
	%if &assignsN=0 %then %return;
	%do i=1 %to &assignsN;
		%varsN(vars=&assigns,n=&i,res=&tres);%let assign=&&&tres;
		%let value=%assignValue(&assign);
		%let values=&values &value;
	%end;
	%let &res=&values;
%mend;


* ---- macro assignsUnique ----;
* 按var对assigns进行去重，重复值保留后出现的;
* input;
*	assigns				assigns;
*	caseSensitive		大小写控制，针对var;
*						value一定是区分大小写的;
*	res					处理后的assigns;
* output;
*	res					处理后的assigns;
* test;
*	@test_assignsUnique;
* details;
*	对于var为空的情况(=abc)，该assign将被抛弃;

%macro assignsUnique(assigns=,caseSensitive=,res=);

	%local tres;%let tres=%createTempVar;%local &tres;
	%local i assignsN assign var vars newAssigns;
	
	%resCheck(&res);
	%varsCount(vars=&assigns,res=&tres);%let assignsN=&&&tres;
	%if &assignsN=0 %then %return;
	%do i=1 %to &assignsN;
		%varsN(vars=&assigns,n=%eval(&assignsN-&i+1),res=&tres);%let assign=&&&tres;
		%let var=%assignVar(&assign);
		%if not %isBlank(&var) %then %do;
			%varsExist(source=&vars,target=&var,caseSensitive=&caseSensitive,res=&tres);
			%if &&&tres=0 %then %do;
				%let vars=&vars &var;
				%let newAssigns=&assign &newAssigns;
			%end;
		%end;
	%end;
	%let &res=&newAssigns;
%mend;


* ---- macro assignsUpcase ----;
* 将assigns中的var全部替换为大写形式;
* input;
*	assings			;
*	res				返回变量;
* details;
*	返回的vars顺序与assigns中的顺序相同;
* test;
*	@test_assignsUpcase;
%macro assignsUpcase(assigns=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;

	%local assignsN assign newAssigns;
	%local var value;
	%local i;

	%resCheck(&res);
	%if %isBlank(&assigns) %then %return;
	%varsCount(vars=&assigns,res=&tres);%let assignsN=&&&tres;
	%do i=1 %to &assignsN;
		%varsN(vars=&assigns,n=&i,res=&tres);%let assign=&&&tres;
		%let var=%upcase(%getAssignVar(&assign));
		%let value=%getAssignValue(&assign);
		%let newAssigns=&newAssigns %squote(&var=&value);
	%end;
	%let &res=&newAssigns;
%mend;


* ---- macro assignsFind ----;
* 返回assigns中指定var的值;
*	assings			赋值，必须是%str处理后的;
*	var				指定var变量，当var为空时返回空;
*	caseSensitive	是否区分vars的大小写;
* test;
*	@test_assignsFind;

%macro assignsFind(assigns=,var=,caseSensitive=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local i assign assignsN v value;

	%resCheck(&res);
	%if %isBlank(&caseSensitive) %then %let caseSensitive=0;
	%if %isBlank(&assigns) %then %return;
	%if %isBlank(&var) %then %return;

	%varsCount(vars=&assigns,res=&tres);%let assignsN=&&&tres;
	%do i=1 %to &assignsN;
		%varsN(vars=&assigns,n=&i,res=&tres);%let assign=&&&tres;
		%let v=%getAssignVar(&assign);
		%let value=%getAssignValue(&assign);
		%if &caseSensitive %then %do;
			%if &var=&v %then %do;
				%let &res=&value;
				%return; 
			%end;
		%end;
		%else %do;
			%if %upcase(&var)=%upcase(&v) %then %do;
				%let &res=&value;
				%return;
			%end;
		%end;
	%end;
%mend;


* ---- macro assignsFilter ----;
* 按vars对assigns进行过滤;
*	assings			赋值，必须是%str处理后的;
*	vars			指定var变量;
*	isBlacklist		黑名单过滤;
*					默认为1;
*	caseSensitive	是否区分vars的大小写;
* details;
*	注意：caseSensitive指是否对变量名进行大小写的判定，与assign的value无关;
* test;
*	@test_assignsFilter;

%macro assignsFilter(assigns=,vars=,isBlacklist=,caseSensitive=,res=);
	
	%local tres;%let tres=%createTempVar;%local &tres;

	%local assign assignsN;
	%local newAssigns;
	%local i;
	%local var;

	%resCheck(&res);
	%if %isBlank(&assigns) %then %return;
	%if %isBlank(&caseSensitive) %then %let caseSensitive=0;
	%if %isBlank(&isBlacklist) %then %let isBlacklist=1;
	
	%varsCount(vars=&assigns,res=&tres);%let assignsN=&&&tres;
	
	%do i=1 %to &assignsN;
		%varsN(vars=&assigns,n=&i,res=&tres);%let assign=&&&tres;
		%let var=%getAssignVar(&assign);
		%varsExist(source=&vars,target=&var,caseSensitive=&caseSensitive,res=&tres);
		%if &isBlacklist=0 %then %do;
			%if &&&tres %then %let newAssigns=&newAssigns &assign;
		%end;
		%else %do;
			%if not &&&tres %then %let newAssigns=&newAssigns &assign;
		%end;
	%end;

	%let &res=&newAssigns;
%mend;


* ---- macro assignsEqual ----;
* 比较两个assigns是否相同;
* input;
*	a				assigns A;
*	b				assigns B;
*	caseSensitve	大小写敏感，默认为0;
*	res				比较结果;
* details;
*	比较逻辑;
*		caseSensitive仅针对var部分，对于value部分，始终是区分大小写的;
*		A=1 B=2 B=3 与 A=1 B=2 被认为是不相等的;
*		A=1 B=2 B=3 与 A=1 B=2 B=2 B=3 被认为是相等的;
* test;
* 	@test_assignsEqual;

%macro assignsEqual(a=,b=,caseSensitive=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;

	%resCheck(&res);
	%if %isBlank(&caseSensitive) %then %let caseSensitive=0;

	%if &caseSensitive=0 %then %do;
		%assignsUpcase(assigns=&a,res=&tres);%let a=&&&tres;
		%assignsUpcase(assigns=&b,res=&tres);%let b=&&&tres;
	%end;
	%varsEqual(a=&a,b=&b,caseSensitive=1,res=&res);
%mend;


* ---- macro assignsSuffix ----;
* 对assigns中的var添加前缀或后缀;
*	assings			赋值;
*	prefix			前缀;
*	suffix			后缀;
* details;
* test;
*	@test_assignsSuffix;

%macro assignsSuffix(assigns=,suffix=,prefix=,res=);
	
	%local tres;%let tres=%createTempVar;%local &tres;

	%local assign assignsN;
	%local newAssigns;
	%local i;
	%local var value;

	%resCheck(&res);
	%if %isBlank(&assigns) %then %return;
	%if %isBlank(&suffix) and %isBlank(&prefix) %then %do;
		%let &res=&assigns;
		%return;
	%end;
	%varsCount(vars=&assigns,res=&tres);%let assignsN=&&&tres;
	%do i=1 %to &assignsN;
		%varsN(vars=&assigns,n=&i,res=&tres);%let assign=&&&tres;
		%let var=%getAssignVar(&assign);
		%let value=%getAssignValue(&assign);
		%let newAssigns=&newAssigns %quote(&prefix.&var.&suffix=&value);
	%end;

	%let &res=&newAssigns;
%mend;

* ---- macro assignsPrefix ----;
%macro assignsPrefix(assigns=,suffix=,prefix=,res=);
	%assignsSuffix(assigns=&assigns,suffix=&suffix,prefix=&prefix,res=&res);
%mend;


* ---- macro assignsJoin ----;
* assigns左连接宏;
* input;
*	a				左侧assigns;
*	b				右侧assigns;
*	caseSensitive	大小写敏感，默认0;
*					表示a与b的连接变量是否区分大小写;
*	res				返回变量;
* test;
*	@test_assignsJoin;
* detais;
*	示例;
*		assigns1:	A=1 B=2 C=3;
*		assigns2:	1=xxx 2=yyy 4=666; 
*		1 join 2:	A=xxx B=yyy C=;
*	B中存在多个匹配情况;
*		将只匹配第一个;
*		A=1 B=2 C=3 + 1=xxx 2=yyy 2=zzz -> A=xxx B=yyy C=  ;
*	空值处理;
*		当连接值（即示例中的1 2 3）是空时，assignsLeftJoin将不进行匹配，直接返回空;
*		当b是空时，将返回所有匹配值都为空，即A= B= C=形式;

%macro assignsJoin(a=,b=,caseSensitive=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local i;
	%local assignsAN assignA varA valueA valueB newAssigns;

	%resCheck(&res);
	%if %isBlank(&a) %then %return;

	%varsCount(vars=&a,res=&tres);%let assignsAN=&&&tres;
	%do i=1 %to &assignsAN;
		%varsN(vars=&a,n=&i,res=&tres);%let assignA=&&&tres;
		%let varA=%getAssignVar(&assignA);
		%let valueA=%getAssignValue(&assignA);
		%if %isBlank(&valueA) %then %let valueB=%str();
		%else %if %isBlank(&b) %then %let valueB=%str();
		%else %do;
			%assignsFind(assigns=&b,var=&valueA,caseSensitive=&caseSensitive,res=&tres);%let valueB=&&&tres;
		%end;
		%let newAssigns=&newAssigns %str(&varA=&valueB);
	%end;
	%let &res=&newAssigns;
%mend;

* ---- macro assignsUpdate ----;
* assigns合并更新宏;
* input;
*	a				待更新的assigns;
*	b				用于更新的assigns;
*	caseSensitive	大小写敏感，默认0;
*	res				返回更新后的assigns;
* test;
*	@test_assignsUpdate;
* detais;
*	示例;
*		a: A=1 B=2 C=3;
*		b: B=3 D=4;
*		合并后的值为：A=1 B=3 C=3 D=4;

%macro assignsUpdate(a=,b=,caseSensitive=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local varsB;

	%resCheck(&res);
	%if %isBlank(&a) %then %do;
		%let &res=&b;
		%return;
	%end;
	%if %isBlank(&b) %then %do;
		%let &res=&a;
		%return;
	%end;
	%assignsVars(assigns=&b,res=&tres);%let varsB=&&&tres;
	%assignsFilter(assigns=&a,vars=&varsB,isBlacklist=1,caseSensitive=&caseSensitive,res=&tres);%let a=&&&tres;
	%let &res=&a &b;
%mend;


* -------------------------------------------------;
* -------------------- Time Macros ----------------;
* -------------------------------------------------;

* 封装sas fcmp时间相隔函数;
* 详细说明参见：http://support.sas.com/documentation/cdl//en/lefunctionsref/69762/HTML/default/viewer.htm#n1mj2bizbsd7ktn1sf9lz111kku3.htm;
* Glue主要使用dtv与ds两种时间格式;


* 当前时间宏;

* 	数值类;
*	ts					1860527804;
*	dtv					1860527804;
*	datetime			1860527803.982;
*	hts					1860527803982;
*	date				21533;

*	格式类;
*	timestamp			20181215T211644
*   htimestamp			20181215T211643981
*	yyyymmdd			20181215;
*	ds					20181215;

* 时间格式转换宏;
*	datepart			dtv -> date;
*	dtvToDs				dtv -> yyyymmdd;
*	dsToDtv				yyyymmdd -> dtv;

* 时间间隔计算宏;
*	intnx				使用dtv交互;
*	dsIntnx				使用ds交互;
*	intck				使用dtv交互;
*	dsIntck				使用ds交互;


* ---- macro datetime -----;
* 获取当前时间戳;
* test;
*	@test_time;

%macro datetime;
	%strip(%sysfunc(datetime()))
%mend;


* ---- macro timestamp -----;
* 获取当前时间戳，格式为：yyyymmddThhmmss;
* test;
*	@test_time;

%macro timestamp;
	%strip(%sysfunc(datetime(),B8601DT.))
%mend;

* ---- macro htimestamp -----;
* 获取当前的高精度时间戳，格式为：yyyymmddThhmmss.iii;
* test;
*	@test_time;

%macro htimestamp;
	%strip(%sysfunc(datetime(),B8601DT.3))
%mend;

* ---- macro ts -----;
* 获取当前时间戳，格式为整数，单位为秒，例如：1774517328;
* test;
*	@test_time;

%macro ts;
	%local res;
	%let res=%sysfunc(datetime(),D.0);
	&res.
%mend;

* ---- macro dtv -----;
* test;
*	@test_time;

%macro dtv;
	%local res;
	%let res=%sysfunc(datetime(),D.0);
	&res.
%mend;

* ---- macro yyyymmdd -----;
* test;
*	@test_time;
%macro yyyymmdd;
	%local res;
	%let res=%sysfunc(datetime(),B8601DN8.);
	&res.
%mend;

* ---- macro ds -----;
* test;
*	@test_time;
%macro ds;
	%local res;
	%let res=%sysfunc(date(),B8601DA.);
	&res.
%mend;

* ---- macro date -----;
* test;
*	@test_time;
%macro date;
	%sysfunc(date())
%mend;


* ---- macro hts -----;
* 获取当前的高精度时间戳，格式为整数，单位为毫秒，例如1774517328159;
* test;
*	@test_time;

%macro hts;
	%local res;
	%let res=%sysevalf(%sysfunc(datetime())*1000);
	&res.
%mend;


* ---- macro datepart ----;
* test;
*	@test_time;

%macro datepart(dtv);
	%strip(%sysfunc(datepart(&dtv)))
%mend;


* ---- macro dsToDtv ----;
* 将yyyymmdd格式的时间转换为datetime的数值;
* test;
*	@test_dsToDtv;

%macro dsToDtv(ds);
	%strip(%sysfunc(inputn(&ds.000000,B8601DJ18.)))
%mend;


* ---- macro dtvToDs ----;
* 将datetime的数值转换为yyyymmdd格式的时间;
* test;
*	@test_dsToDtv;

%macro dtvToDs(dtv);
	%strip(%sysfunc(putn(&dtv,B8601DN.)))
%mend;

* ---- macro intnx -----;
* 时间间隔函数，封装intnx;
* 注意：align默认值为SAME;
* test;
*	@test_intnx;

%macro intnx(interval,dtv,inc,align);
	%local res;
	%if %isBlank(&align) %then %let align=same;
	%let res=%strip(%sysfunc(intnx(&interval,&dtv,&inc,&align)));
	&res.
%mend;

* ---- macro dsIntnx -----;
* 时间间隔函数，yyyymmdd格式进行输入输出;
* 注意：align默认值为SAME;
* test;
*	@test_intnx;

%macro dsIntnx(interval,ds,inc,align);
	%local res;
	%if %isBlank(&align) %then %let align=same;
	%let res=%dtvToDs(%intnx(&interval,%dsToDtv(&ds),&inc,&align));
	&res.
%mend;

* ---- macro intck ----;
* 时间间隔函数，封装intck函数;
* 注意：method默认值为CONTINUOUS;
* test;
*	@test_intck;

%macro intck(interval,dtv1,dtv2,method);
	%local res;
	%if %isBlank(&method) %then %let method=c;
	%let res=%strip(%sysfunc(intck(&interval,&dtv1,&dtv2,&method)));
	&res.
%mend;

* ---- macro dsIntck ----;
* 时间间隔函数，封装intck函数，ds输入格式版，参见intck;
* 注意：method默认值为CONTINUOUS;
* test;
*	@test_intck;

%macro dsIntck(interval,ds1,ds2,method);
	%local dtv1 dtv2;
	%let dtv1=%dsToDtv(&ds1);
	%let dtv2=%dsToDtv(&ds2);
	%intck(&interval,&dtv1,&dtv2,&method)
%mend;


* -------------------------------------------------;
* ---------------- Random functions -------------;
* -------------------------------------------------;

* 生成ID;
* 	prefix 	id前缀;
*	len		id总长度，默认为30;
* details;
*	id随机生成，由随机数、时间、以及随机种子共同构成字符串，经过md5后，转换为base32格式;
*	随机种子保存于全局变量GLUE_GENID_SEED中;
* test;
*	@test_genId;
%macro genId(prefix=,len=);
	%local t r s m id l rLen;
	%global GLUE_GENID_SEED;
	%if %isBlank(&len) %then %let len=30;
	%let rLen=%eval(&len-%length(&prefix));
	%if &rLen<0 %then %error(Prefix is too long! prefix=&prefix);
	%let id=%str();
	%let l=0;
	%do %while(&l<&rLen);
		%let t=%htimestamp;
		%let r=%random %random;
		%let s=&t.&r.&GLUE_GENID_SEED;
		%let m=%md5base32(&s);
		%let GLUE_GENID_SEED=&m;
		%let id=&id.&m;
		%let l=%length(&id);
	%end;
	%let id=%substr(&id,1,&rLen);
	&prefix.&id.
%mend;


* ----- macro random -----;
* 按均匀分布返回(0,1)区间随机数;
* output;
*	返回值		计算结果;
* 	异常报错;
*test;
*	@test_random;

%macro random();
	%sysfunc(rand(UNIFORM))
%mend;



* ----------------------------------------------------------------------------------------------------------;
* ------------------------------------------------ I/O TOOLS -----------------------------------------------;
* ----------------------------------------------------------------------------------------------------------;


* -------------------------------------------------;
* ------------------ fileIO Macros ----------------;
* -------------------------------------------------;

* 路径格式采用windows标准，请以"\"为分隔符，并且保证文件夹最末尾为"\";
* 请勿使用\\格式;

* ---- macro getFilePath ----;
* 返回给定路径的上级文件路径;
* input;
*	path			路径，当为空时为当前执行代码文件所在路径;
*	level			级别，返回的路径级别;
* test;
* 	@test_getPath;
* details;
*	示例：path=C:\1\2\3\4\5\6\7\test.sas;
*		level		result;
*		1			C:\;
*		2 			C:\1\;
*		3			C:\1\2\;
*		-1			C:\1\2\3\4\5\6\7\;
*		-2			C:\1\2\3\4\5\6\;
*		-3			C:\1\2\3\4\5\;

%macro getPath(path,level);
	%local pos res;
	%if %isBlank(&path) %then %let path=%sysget(SAS_EXECFILEPATH);
	%if %isBlank(&level) %then %let level=-1;
	%let pos=%varsK(%findStr(&path,%str(\)),&level);
	%if %isBlank(&pos) %then %let res=;
	%else %let res=%qksubstr(&path,1,&pos);
	&res.
%mend;


* ---- macro folderExist -----;
* 检查指定路径是否存在;
* test;
* 	@test_folder.sas;
%macro folderExist(dir); 
	%local tres;%let tres=%createTempVar;%local &tres;
   	%local rc err;
	%let rc=0;
	%if %isBlank(&dir) %then %let rc=0;
	%else %do;
		%let rc=%sysfunc(filename(&tres,&dir));
		%if &rc ne 0 %then %let rc=0;
		%else %let rc=%sysfunc(fexist(&&&tres));
		%let err=%sysfunc(filename(&tres));
	%end; 
   	&rc.
%mend;


* ---- macro pathExist -----;
%macro pathExist(dir); 
   	%folderExist(&dir)
%mend;

* ---- macro checkFolder ----;
* 检查指定路径是否存在，如果不存在则建立该文件夹;
* test;
* 	@test_folder;
%macro checkFolder(dir) ; 
   	%local rc fileref; 
   	%if %folderExist(&dir) %then %let rc=1;    
  	%else %do;
		X md "&dir "; 
   	%end;
%mend;

* ---- macro createFolder ----;
%macro createFolder(dir);
	%checkFolder(&dir);
%mend;


* ---- macro removeFolder ----;
* 删除指定文件夹及其中的所有内容;
* test;
* 	@test_folder;
%macro removeFolder(path);
	%if %folderExist(&path) %then %do;
		X rd /s /q "&path";
	%end;
%mend;

* ---- macro deleteFolder ----;
%macro deleteFolder(path);
	%removeFolder(&path);
%mend;


* ---- macro fileExist ----;
* 检查指定文件是否存在;
* input;
*	path		文件路径;
* output;
*	返回结果		01变量，1存在，0不存在;
* test;
*	@test_file;
%macro fileExist(path);
	%local res;
	%if %isBlank(&path) %then %let res=0;
	%else %let res=%sysfunc(FILEEXIST(&path));
	&res.
%mend;

* ---- deleteFile ----;
* 文件删除;
* input;
*	path		文件路径;
* test;
*	@test_file;
%macro deleteFile(path);
	%if %fileExist(&path) %then %do;
		X del /Q /F "&path";
	%end;
%mend;

* ---- macro copyFolder ----;
* 文件夹拷贝;
* copyFolder将一个文件夹中的所有文件拷贝到另一个文件夹;
* input;
*	from		文件夹;
*	inLib		输入lib;
*	to			目标文件夹;
*	outLib		输出lib;
*	clean		是否先删除目标文件夹的所有内容,01变量，默认0;
* details;
*	拷贝逻辑;
*		包含子文件夹;
*		包含所有类型的文件;
*		同名文件复制;
* test;
* 	@test_copyFolder;

%macro copyFolder(from=,to=,inlib=,outlib=,clean=) /parmbuff;
	
	%local option_clean;

	%if %isBlank(&from) and %isBlank(&inLib) %then %error(FROM and INLIB cannot be empty at the same time! &syspbuff);
	%if %isBlank(&to) and %isBlank(&outLib) %then %error(TO and OUTLIB cannot be empty at the same time! &syspbuff);
	%if %isBlank(&clean) %then %let clean=0;

	%if %isBlank(&from) %then %let from=%getLibPath(&inLib);
	%if %isBlank(&to) %then %let to=%getLibPath(&outLib);
	%if %isBlank(&from) or %isBlank(&to) %then %error(FROM or TO is empty! &syspbuff);

	%if &clean=1 %then %let option_clean=%quote(/PURGE);

	X robocopy %unquote(&from) %unquote(&to) /E /np /nfl /njh /njs /ndl /nc /ns /IS &option_clean;

%mend;


* ---- macro dsToXlsx ----;
* ds转换为xlsx;
* input;
*	data		数据集;
*	xlsx		输出目标，完整的xlsx文件路径，注意路径中的文件夹必须已经存在;
*	out			输出目标，lib.table格式，其中lib用于确定文件夹，table用于确定xlsx文件名;
*				当out为空时使用data，即输出到相同文件夹，相同名称（后缀为xlsx）;
*	sheet		输出目标sheet名称，当sheet为空时，将输出到与ds表名相同的sheet;
*	newfile		是否先删除目标xlsx文件再进行输出,01变量，默认0;
*				如果需要写入前删除xlsx，此选项请设为1;
* test;
* 	@test_dsToxlsx;
* details;
*	当重复向一个xlsx的同一个sheet写入时，后面的写入会覆盖前面的;

%macro dsToXlsx(data=,xlsx=,out=,sheet=,newfile=);
	%local stmt_sheet lib table;
	%if not %dsExist(&data) %then %return;
	%if %isBlank(&out) and %isBlank(&xlsx) %then %let out=&data;
	%if %isBlank(&newFile) %then %let newFile=0;
	%if not %isBlank(&out) %then %do;
		%let lib=%getLibName(&out);
		%let table=%getTableName(&out);
		%let xlsx=%getLibPath(&lib)&table..xlsx;
	%end;
	%if &newFile=1 %then %deleteFile(&xlsx);
	%if not %isBlank(&sheet) %then %let stmt_sheet=%quote(sheet="&sheet");
	proc export data=%unquote(&data) outfile="&xlsx" dbms=excel replace;
		%unquote(&stmt_sheet);
	run;quit;
%mend;


* ---- macro xlsxToDs ----;
* xlsx转换为ds;
* input;
*	data		lib.table格式的表示的xlsx文件;
*	xlsx		完整路径格式的xlsx文件;
*	out			lib.table格式的输出目标;
*	sheet		指定导入的sheet名称;
*	where		where语句;
*	getnames	首行是否是变量名，默认为1;
* test;
* 	@test_xlsxToDs;
* details;
*	xlsxToDs一次只能导入一个sheet;
*	getnames为0时，导入的变量名为F1 F2 F3 ...;
%macro xlsxToDs(data=,xlsx=,out=,where=,sheet=,getnames=);

	%local tres;%let tres=%createTempVar;%local &tres;

	%local lib table;
	%local stmt_where stmt_sheet;

	%if &getnames=0 %then %let getnames=NO;
	%else %let getnames=YES;
	%if not %isBlank(&data) %then %do;
		%let lib=%getLibName(&data);
		%let table=%getTableName(&data);
		%let xlsx=%getLibPath(&lib)&table..xlsx;
		%if %isBlank(&out) %then %do;
			 %let out=&lib..&table;
		%end;
	%end;

	%paramRequired(&out);
	%if not %isBlank(&sheet) %then %let stmt_sheet=%quote(sheet="&sheet");
	%if not %isBlank(&where) %then %let stmt_where=%quote((where=(&where)));

	proc import out=&out %unquote(&stmt_where) datafile="&xlsx" dbms=excel replace;
		%unquote(&stmt_sheet);
		getnames=%unquote(&getnames);
	run;quit;
%mend;


* ---- macro dsToCsv ----;
* ds转换为csv;
* input;
* 	data	待转换的数据集;
* 	csv		csv文件格式的完整路径;
*	out		输出目标，lib.table格式，其中lib用于确定文件夹，table用于确定csv文件名;
*			当out为空时使用data，即输出到相同文件夹，相同名称（后缀为csv）;
* test;
* 	@test_dsToCsv.sas;
%macro dsToCsv(data=,csv=,out=);
	%local lib table;
	%if not %dsExist(&data) %then %error(DATA doesnot exist!);
	%if %isBlank(&out) and %isBlank(&csv) %then %let out=&data;
	%if not %isBlank(&out) %then %do;
		%let lib=%getLibName(&out);
		%let table=%getTableName(&out);
		%let csv=%getLibPath(&lib)&table..csv;
	%end;
	proc export data=&data outfile="&csv" DBMS=csv replace;
	run;quit;
%mend;


* ---- macro csvToDs ----;
* xlsx转换为ds;
* input;
*	data		lib.table格式的表示的csv文件;
*	csv			完整路径格式的csv文件;
*	out			lib.table格式的输出目标;
*	getnames	首行是否是变量名，默认为1;
*	where		where语句;
* test;
* 	@test_csvToDs;
* details;
*	getnames为0时，导入的变量名为VAR1 VAR2 VAR3 ...;
%macro csvToDs(data=,csv=,out=,getnames=,where=);

	%local tres;%let tres=%createTempVar;%local &tres;

	%local lib table;
	%local stmt_where;

	%if &getnames=0 %then %let getnames=NO;
	%else %let getnames=YES;

	%if not %isBlank(&data) %then %do;
		%let lib=%getLibName(&data);
		%let table=%getTableName(&data);
		%let csv=%getLibPath(&lib)&table..csv;
		%if %isBlank(&out) %then %do;
			 %let out=&lib..&table;
		%end;
	%end;

	%paramRequired(&out);
	%if not %isBlank(&where) %then %let stmt_where=%quote((where=(&where)));

	proc import out=&out %unquote(&stmt_where) datafile="&csv" dbms=csv replace ;
		getnames=%unquote(&getnames);
	run;quit;
%mend;


* ---- macro libToXlsx ----;
* 将指定lib中的所有ds都转换为xlsx;
* input;
*	inlib/lib	待转换的lib;
*	outlib		输出位置，默认为与lib相同;
* test;
* 	@test_libToXlsx.sas;

%macro libToXlsx(lib=,inlib=,outlib=) /parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;

	%local members membersN member;
	%local i;

	%let lib=%paramAlias(&inlib,&lib);
	%paramRequired(&lib);	
	%let outlib=%nonBlank(&outlib,&lib);
	
	%getLibMember(lib=&lib,res=&tres);%let members=&&&tres;
	%if %isBlank(&members) %then %return;
	%varsCount(vars=&members,res=&tres);%let membersN=&&&tres;
	%do i=1 %to &membersN;
		%varsN(vars=&members,n=&i,res=&tres);%let member=%unquote(&&&tres);
		%dsToXlsx(data=&lib..&member,out=&outlib..&member);
	%end;
%mend;


* ---- macro getFileList ----;
* 输出指定路径下的所有文件和文件夹名，若isFolder为1则只输出文件夹名;
* 输出方式有数据集（指定out）和vars格式的宏变量（指定res）两种;
* input;
* 	path		获取文件名列表的路径，默认为当前文件夹;
* 	onlyFolder	仅返回文件夹名，默认为0;
* 	onlyFile	仅返回文件夹，默认为1;
* 	res			返回变量;
* output;
*	res			返回的文件名;
* test;
* 	@test_getFileList.sas;

%macro getFileList(path=,res=,onlyFolder=,onlyFile=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local ts;%let ts=%createTempDs;
	%local tf;%let tf=%getPath%createTempVar.csv;
	%local stmt_attr;

	%resCheck(&res);
	%if &onlyFolder=1 and &onlyFile=1 %then %error(ONLYFILE and ONLYFOLDER can not be 1 at the same time!);
	%if &onlyFolder=1 %then %let stmt_attr=/ad;
	%if &onlyFile=1 %then %let stmt_attr=/a-d;
	%if %isBlank(&path) %then %let path=%getPath;
	%if not %pathExist(&path) %then %error(PATH &path doesnot exist!);

	x dir "&path" /b &stmt_attr > "&tf";
	%csvToDs(csv=&tf,out=&ts,getnames=0);
	proc sql noprint;
		select var1 into: &res separated by ' ' from &ts;
	quit;

	%deleteFile(&tf);
	%dropDs(&ts);
%mend;


* -------------------------------------------------;
* ------------------- Page macros ----------------;
* -------------------------------------------------;

* 页输出模式说明;
* 	主要用于解决SAS ODS串行输出与并行输出需求之间的矛盾;
* 	举例来说，一个宏/任务T循环执行10次宏S，S每次都会要求输出单独一份pdf报告PS，而T每执行一步也都要报告一部分信息，并在全部执行完毕后形成一份报告PT;
*	理想的情况下，上述执行完成后，应输出报告文件PS 10份，报告文件PT 1份，但实际上，由于SAS ODS串行输出的限制，上述情况无法实现;
*	最多只能实现为：输出报告文件PS 10份，报告文件PT1 PT2 PT3 等多份，而且相关控制逻辑较为麻烦，当涉及更多层级的嵌套时更加复杂;
*	GLUE中的page相关功能即是针对这个问题的一个解决方案，可以实现上述次优的输出模式，同时最大程度简化使用的复杂性;
*	注：针对上述场景，也可以使用在S层面将输出的数据汇总到数据集中，然后一次性输出，但实际SAS ODS输出涉及大量的表格、数据，往往难以简单提取汇总;

* LEVEL的概念;
*	可以理解为photoshop中的图层，使用中，每次调用pageStart即生成一个更高的新图层，随后的ODS输出将写入该层，直到调用pageEnd结束写入，并返回上一级图层;
*	pageStart与pageEnd一般成对出现，以确定该层级输出的起止位置;
*	层级从0开始，可以无限叠加，可以使用clearOutput将立即结束所有所有层级的输出;

* PAGE的概念;
*	换个角度看，pageStart与pageEnd其实是将完整的SAS ODS输出分隔为不同的PAGE，通过对page存储位置与命名的控制，使其具有所需要的结构性;

* 输出方式设置;
*	每次调用pageStart或clearOutput时可以设置该层输出的目标位置、格式（html或pdf）、是否包含时间戳等;
* 	可以使用全局参数设置输出参数的默认值;

* HTML图片输出;
*	HTML的图片将被保存在与文件同名的文件夹中;
*	同一输出不同PAGE都将使用同一个图片文件夹;

* 全局参数变量;
*	GLUE_PAGE_DEFAULT_TYPE				默认输出类型;
*	GLUE_PAGE_DEFAULT_FILE				默认输出文件名称;
*	GLUE_PAGE_DEFAULT_PATH				默认输出文件位置;
*	GLUE_PAGE_DEFAULT_TIMESTAMP			默认是否包含timestamp;
*	GLUE_PAGE_DEFAULT_P1				对于输出的P1是否包含_P1后缀;

* 全局执行变量;
* 	GLUE_PAGE_LEVEL						当前层级;
*	GLUE_PAGE_FILE[k]					输出目标文件;
*	GLUE_PAGE_PATH[k]					输出目标路径;
*	GLUE_PAGE_TYPE[k]					输出类型;
*	GLUE_PAGE_P[k]						输出页码;


* ---- macro clearOutput ----;
* 0层输出启动函数;
* clearOutput将当前输出层级回归0，设置新的输出，并启动;
* input;
* 	noTimestamp		设置输出文件是否不包含生成时间;
* 	type			设置输出的格式，PDF|HTML;
* 	path			输出路径;
* 	file			输出文件名;
*	out				lib.table格式的输出目标;
* test;
* 	@test_page;
%macro clearOutput(path=,file=,out=,noTimestamp=,type=);
	%odsSet(level=0,path=&path,file=&file,out=&out,noTimestamp=&noTimestamp,type=&type);
	%odsClose;
	%odsStart(level=0);
%mend;


* ---- macro pageStart ----;
* 新层输出启动函数;
* pageStart在当前层下再创建新的一层输出，设置该层输出，并启动;
* test;
* 	@test_page;
%macro pageStart(path=,file=,out=,noTimestamp=,type=);

	%global GLUE_PAGE_LEVEL;
	%local level;

	%let level=&GLUE_PAGE_LEVEL;
	%if %isBlank(&level) %then %let level=0;
	%let level=%eval(&level+1);
	%let GLUE_PAGE_LEVEL=&level;

	%odsSet(level=&level,path=&path,file=&file,out=&out,noTimestamp=&noTimestamp,type=&type);
	%odsClose;
	%odsStart(level=&level);
%mend;


* ---- macro pageEnd ----;
* 新层输出结束函数;
* pageEnd结束当前层输出，返回上一次层，将该层页码数加1，然后开始输出;
* test;
* 	@test_page;
%macro pageEnd;

	%global GLUE_PAGE_LEVEL;
	%local level;
	
	%let GLUE_PAGE_LEVEL=%max(%eval(&GLUE_PAGE_LEVEL-1),0);
	%let level=&GLUE_PAGE_LEVEL;
	%global GLUE_PAGE_P&level;
	%let GLUE_PAGE_P&level=%eval(&&GLUE_PAGE_P&level+1);

	%odsClose;
	%odsStart(level=&level);
%mend;


* ---- macro odsSet ----;
* ods输出设置宏;
* 参数说明参见clearOutput;
* 注意：odsSet不是直接调用函数，对于level的设置由上级宏完成;
* test;
* 	@test_page;
%macro odsSet(level=,path=,file=,out=,noTimestamp=,type=);

	%local lib type t;

	%paramRequired(&level);
	%if not %isBlank(&out) %then %do;
		%let lib=%getLibName(&out);
		%let path=%getLibPath(&lib);
		%let file=%getTableName(&out);
	%end;
	%let file=%globalDefault(&file,GLUE_PAGE_DEFAULT_FILE,REPORT);
	%let path=%globalDefault(&path,GLUE_PAGE_DEFAULT_PATH,%getPath);
	%let noTimestamp=%globalDefault(&noTimestamp,GLUE_PAGE_DEFAULT_NOTIMESTAMP,0);
	%let type=%globalDefault(&type,GLUE_PAGE_DEFAULT_TYPE,HTML);

	%let type=%upcase(&type);
	%if not (&type in HTML PDF) %then %error(TYPE &type IS NOT SUPPOTED!);
	%if &noTimestamp ne 1 %then %let t=%timestamp;
	%let file=%sasVarsToVar(&file &t);

	%checkFolder(&path);
	%if &type=HTML %then %do;
		%checkFolder(&path.&file\);
	%end;

	%global GLUE_PAGE_FILE&level;%let GLUE_PAGE_FILE&level=&file;
	%global GLUE_PAGE_PATH&level;%let GLUE_PAGE_PATH&level=&path;
	%global GLUE_PAGE_TYPE&level;%let GLUE_PAGE_TYPE&level=&type;
	%global GLUE_PAGE_P&level;%let GLUE_PAGE_P&level=1;
%mend;


* ---- macro odsStart ----;
* 使用指定level的参数来启动ods输出;
* details;
*	odsStart中的参数检查由上级宏完成，因此ods不对具体的输出参数再进行任何检查;
* test;
* 	@test_page;
%macro odsStart(level=);

	%global GLUE_PAGE_LEVEL GLUE_PAGE_DEFAULT_P1;
	%local file path type page;
	
	%paramRequired(&level);
		
	%global GLUE_PAGE_LEVEL;		%let GLUE_PAGE_LEVEL=&level;
	%global GLUE_PAGE_FILE&level;	%let file=&&GLUE_PAGE_FILE&level;
	%global GLUE_PAGE_PATH&level;	%let path=&&GLUE_PAGE_PATH&level;
	%global GLUE_PAGE_TYPE&level;	%let type=&&GLUE_PAGE_TYPE&level;
	%global GLUE_PAGE_P&level;		%let page=&&GLUE_PAGE_P&level;

	%if &type=HTML %then %do;
		ods graphics on /width=1024px;
		%if &page=1 and &GLUE_PAGE_DEFAULT_P1=0 %then %do;
			ods html body="&file..html" path="&path" gpath = "&path.&file\" (url="&file/");
		%end;
		%else %do;
			ods html body="&file._P&page..html" path="&path" gpath = "&path.&file\" (url="&file/");
		%end;
	%end;
	%else %do;
		%if &page=1 and &GLUE_PAGE_DEFAULT_P1=0 %then %do;
			ods graphics on;
			ods pdf file="&path.&file..pdf" dpi=300;
		%end;
		%else %do;
			ods graphics on;
			ods pdf file="&path.&file._P&page..pdf" dpi=300;
		%end;
	%end;
%mend;

* ---- macro setODSOutputPDF ----;
* 设置默认输出为PDF;
%macro setODSOutputPDF;
	%global GLUE_PAGE_DEFAULT_TYPE;	%let GLUE_PAGE_DEFAULT_TYPE=PDF;
%mend;

* ---- macro setODSOutputHTML ----;
* 设置默认输出为HTML;
%macro setODSOutputHTML;
	%global GLUE_PAGE_DEFAULT_TYPE;	%let GLUE_PAGE_DEFAULT_TYPE=HTML;
%mend;

* ---- macro setODSDefault ----;
* 将ODS输出参数还原为默认值;
%macro setODSDefault;

	%global GLUE_PAGE_DEFAULT_TYPE;				%let GLUE_PAGE_DEFAULT_TYPE=HTML;
	%global GLUE_PAGE_DEFAULT_FILE;				%let GLUE_PAGE_DEFAULT_FILE=REPORT;
	%global GLUE_PAGE_DEFAULT_PATH;				%let GLUE_PAGE_DEFAULT_PATH=;
	%global GLUE_PAGE_DEFAULT_NOTIMESTAMP;		%let GLUE_PAGE_DEFAULT_NOTIMESTAMP=0;
	%global GLUE_PAGE_DEFAULT_P1;				%let GLUE_PAGE_DEFAULT_P1=0;
	%setODSAutoNavigateOn;

%mend;

* ---- macro setODSAutoNavigateOff -----;
* 关闭ods输出后自动打开，以在批量处理时节省内存;
* test;
*	@test_setODSAutoNavigate;
%macro setODSAutoNavigateOff;
	%local t;
	%let t=%genId(prefix=X,len=8);
	filename &t 'temp.sasxreg';
	data _null_;
	   file &t;
	   put '[ODS\GUI\RESULTS]';
	   put ' "Auto Navigate" = "Off"';
	run;
	proc registry import=&t;quit;
	ods preferences;
%mend;

* ---- macro setODSAutoNavigateOn -----;
* 启用ods输出后自动打开;
* test;
*	@test_setODSAutoNavigate;
%macro setODSAutoNavigateOn;
	%local t;
	%let t=%genId(prefix=X,len=8);
	filename &t 'temp.sasxreg';
	data _null_;
	   file &t;
	   put '[ODS\GUI\RESULTS]';
	   put ' "Auto Navigate" = "On"';
	run;
	proc registry import=&t;quit;
	ods preferences;
%mend;

* ---- macro ODSclose -----;
* 结束ods输出;
%macro ODSclose;
	ods _all_ close;
%mend;

* ---- macro closeODS -----;
%macro closeODS;
	ods _all_ close;
%mend;


* --- macro createSashelpDummyPrinter ----;
* 建立一个虚拟ds，供输出使用;
%macro createSashelpDummyPrinter;
	data sashelp.dummyprinter;
		dummyvar=.;
	run;
%mend;

* ---- macro printtext ----;
* 向html文件输出一行文字;
* test;
* 	@test_report;
%macro printText(msg);
	title "&msg";
	proc sql inobs=1;
		select dummyvar from sashelp.dummyprinter where dummyvar=1;
	quit;
%mend;

* ---- macro print -----;
* 清空输出的页面,指定输出html文件（ODS HTML）;
* test;
* 	@test_print;
%macro print(data=,title=,msg=,vars=);
	%local stmt_var;
	%let title=%paramAlias(&title,&msg);
	%if %isBlank(&title) %then %let title=%quote(Print dataset: &data);
	%if not %dsExist(&data) %then %do;
		%report(&title);
		%report(Cannot Print dataset! &data doesnot exist!);
	%end;
	%else %do;
		%if %notBlank(&vars) %then %let stmt_var=var &vars;
		title "&title";
		proc print data=&data;
			%unquote(&stmt_var);
		run;
	%end;
%mend;

* ---- macro report ----;
* 向html文件输出一行文字;
* 注意由于report调用了proc sql，因此不要在proc或data中嵌套使用;
* test;
* 	@test_report;
%macro report(msg);
	%local invoker log;
	%if %isBlank(&msg) %then %return;
	%let invoker=%getInvoker;
	%let ts=%timestamp;
	%let log=%quote([&ts][&invoker] &msg);
	%printtext(&log);
%mend;

* ---- macro varsReport ----;
* 变量报告宏，将变量及其值输出至html;
* 当变量个数少于10个时，将使用横版报告格式，当变量大于10个时，将使用竖版报告格式;
* 注意由于report调用了proc sql，因此不要在proc或data中嵌套使用;
* input;
*	vars		要展示的宏变量名;
*	title		标题;
* details;
*	变量适配范围;
*		对于输入的变量，varsReport仅在宏的局变量中查找;
*		当要查找的变量未声明时，结果中不会返回;
* test;
* 	@test_varsReport;
%macro varsReport(vars=,title=);
	%local varsN;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local invoker;

	%if %isBlank(&vars) %then %return;
	%if %isBlank(&title) %then %let title=VARIABLE REPORT;
	
	%let invoker=%getInvoker;

	%varsCount(vars=&vars,res=&tres);%let varsN=&&&tres;
	%if &vars=0 %then %return;
	%if &varsN<=10 %then %hvarsReport(vars=&vars,title=&title,invoker=&invoker);
	%else %vvarsReport(vars=&vars,title=&title,invoker=&invoker);
%mend;

* ---- macro vVarsReport ----;
* 竖版变量报告,向html文件垂直输出若干个变量，格式为 var value表格;
* 注意由于report调用了proc sql，因此不要在proc或data中嵌套使用;
* test;
* 	@test_varsReport;
%macro vvarsReport(vars=,title=,invoker=);
	%local tres;%let tres=%createTempVar;%local &tres;

	%if %isBlank(&vars) %then %return;
	%if %isBlank(&title) %then %let title=VARIABLE REPORT;
	%if %isBlank(&invoker) %then %let invoker=%getInvoker;
	%let vars=%upcase(&vars);

	title "&title";
	proc sql;
		select name,value 
		from sashelp.vmacro 
		where scope="&invoker" and name in (%unquote(%sasVarsToQuote(&vars)));
	quit;
%mend;

* ---- macro hVarsReport ----;
* 横版变量报告，向html文件垂直输出若干个变量，格式为 var1 var2 var3 ...表格;
* 注意由于report调用了proc sql，因此不要在proc或data中嵌套使用;
* test;
* 	@test_varsReport;
%macro hvarsReport(vars=,title=,invoker=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local t;
	%let t=%createTempDs;

	%if %isBlank(&vars) %then %return;
	%if %isBlank(&title) %then %let title=VARIABLE REPORT;
	%if %isBlank(&invoker) %then %let invoker=%getInvoker;
	%let vars=%upcase(&vars);

	proc sql noprint;
		create table &t as (
			select name as _NAME_,value 
			from sashelp.vmacro 
			where scope="&invoker" and name in (%unquote(%sasVarsToQuote(&vars)))
		);
	quit;

	proc transpose data=&t out=&t(drop=_NAME_ _LABEL_);
		var value;
	quit;
	
	%print(data=&t,title=&title);

	%dropDs(&t);
%mend;


* ----------------------------------------------------------------------------------------------------------;
* ------------------------------------------------ ENV TOOLS -----------------------------------------------;
* ----------------------------------------------------------------------------------------------------------;


* -------------------------------------------------;
* ---------------- Macro APP macros --------------;
* -------------------------------------------------;


* ---- macro getInvoker ----;
* 获取调用本宏的宏（即上级宏）名称;
* 宏调用关系如：A->B->C->D，当D中执行getInvoker时，返回C;
* 当最高级返回OPEN CODE;
* input;
*	level			相对级别;
*					空	等价于0;
*					-1	getInvoker所在的宏为-1，等同于getSelf;
*					0	getInvoker所在的宏的上级;
*					1	getInvoker所在的宏的上级的上级;
* details
*	当getInvoker位于宏参数时，如：%mymacro(%getInvoker)，则此时getInvoker的位置相当于在mymacro中;
* test;
* 	@test_getInvoker;

%macro getInvoker(level);
	%if %isBlank(&level) %then %let level=2;
	%else %let level=%eval(&level+2);
	%if &level>%sysmexecdepth %then %let level=0;
	%else %let level=%eval(%sysmexecdepth - &level);
	%upcase(%sysmexecname(&level))
%mend;


* ---- macro getInvoker ----;
* getInvoker alias;
%macro caller(level);
	%if %isBlank(&level) %then %let level=2;
	%else %let level=%eval(&level+2);
	%if &level>%sysmexecdepth %then %let level=0;
	%else %let level=%eval(%sysmexecdepth - &level);
	%upcase(%sysmexecname(&level))
%mend;

* ---- macro getSelf ----;
* getSelf所在的宏的名称;
* 注意：当getSelf位于宏参数时，如：%mymacro(%getInvoker)，则此时返回结果为mymacro;
* test;
* 	@test_getSelf;
%macro getSelf;
	%upcase(%sysmexecname(%sysmexecdepth - 1))
%mend;

* ---- macroExist ----;
* 检查指定的宏是否可用;
* input;
*	macro		宏名称;
* output;
*	直接返回		01变量，是否可用;
* test;
*	@test_macroExist;
%macro macroExist(macro);
	%SYSMACEXIST(&macro)
%mend;


* ---- macro resExist ----;
%macro resExist(var);
	%varExist(&var)
%mend;


* ---- macro refExist ----;
%macro refExist(var);
	%varExist(&var)
%mend;


* ---- macro resCheck ----;
* 用于必输res变量的检查与设置初始值;
* 如果变量名为空或变量未被声明则报错，否则将其值设为其初始值（默认为空）;
* input;
*	res			res变量名;
*	default		返回默认值，默认为空;
* output;
*	无;
* test;
*	@test_resCheck;
%macro resCheck(res,default);
	%if %isBlank(&default) %then %let default=%str();
	%if %isBlank(&res) %then %do;
		%saslog(level=ERROR,log=RES is EMPTY,invokerLevel=1);
		%abort;
	%end;
	%else %if not %symexist(&res) %then %do;
		%saslog(level=ERROR,log=%quote(RES &res is UNDEFINED!),invokerLevel=1);
		%abort;
	%end;
	%else %do;
		%let &res=&default;
	%end;
%mend;

* ---- macro resSet ----;
* 用于选输res变量的检查与设置;
* 如果变量名为空或变量未被声明则返回，否则将其值设为其初始值（默认为空）;
* input;
*	res			res变量名;
*	default		返回默认值，默认为空;
* output;
*	无;
* test;
*	@test_resSet;
%macro resSet(res,default);
	%if %isBlank(&default) %then %let default=%str();
	%if %isBlank(&res) %then %return;
	%else %if not %symexist(&res) %then %return;
	%else %let &res=&default;
%mend;


* ---- macro paramRequired ----;
* 检查多个必输变量是否为空，支持最多4个变量;
* input;
*	p1-p4		变量;
* output;
*	无;
* test;
*	@test_paramRequired;
%macro paramRequired(p1);
	%if %isVoid(&p1) %then %do;
		%saslog(level=ERROR,log=%quote(Missing Required Param! 1st),invokerLevel=1);
		%abort;
	%end;
%mend;

%macro paramRequired2(p1,p2);
	%if %isVoid(&p1) %then %do;
		%saslog(level=ERROR,log=%quote(Missing Required Param! 1st),invokerLevel=1);
		%abort;
	%end;
	%else %if %isVoid(&p2) %then %do;
		%saslog(level=ERROR,log=%quote(Missing Required Param! 2nd),invokerLevel=1);
		%abort;
	%end;
%mend;

%macro paramRequired3(p1,p2,p3);
	%if %isVoid(&p1) %then %do;
		%saslog(level=ERROR,log=%quote(Missing Required Param! 1st),invokerLevel=1);
		%abort;
	%end;
	%else %if %isVoid(&p2) %then %do;
		%saslog(level=ERROR,log=%quote(Missing Required Param! 2nd),invokerLevel=1);
		%abort;
	%end;
	%else %if %isVoid(&p3) %then %do;
		%saslog(level=ERROR,log=%quote(Missing Required Param! 3rd),invokerLevel=1);
		%abort;
	%end;
%mend;

%macro paramRequired4(p1,p2,p3,p4);
	%if %isVoid(&p1) %then %do;
		%saslog(level=ERROR,log=%quote(Missing Required Param! 1st),invokerLevel=1);
		%abort;
	%end;
	%else %if %isVoid(&p2) %then %do;
		%saslog(level=ERROR,log=%quote(Missing Required Param! 2nd),invokerLevel=1);
		%abort;
	%end;
	%else %if %isVoid(&p3) %then %do;
		%saslog(level=ERROR,log=%quote(Missing Required Param! 3rd),invokerLevel=1);
		%abort;
	%end;
	%else %if %isVoid(&p4) %then %do;
		%saslog(level=ERROR,log=%quote(Missing Required Param! 4th),invokerLevel=1);
		%abort;
	%end;
%mend;

* ---- macro paramAlias ----;
* 返回多个变量中的第一个非空的变量，支持最多4个变量;
* 一般用于函数多个参数别名、参数默认值的处理;
* input;
*	p1-p4		变量;
* output;
*	res			返回非空的第一个变量;
* test;
*	@test_paramAlias;
%macro paramAlias(p1,p2,p3,p4);
	%local res;%let res=%str();
	%if not %isBlank(&p1) %then %let res=&p1;
	%else %if not %isBlank(&p2) %then %let res=&p2;
	%else %if not %isBlank(&p3) %then %let res=&p3;
	%else %if not %isBlank(&p4) %then %let res=&p4;
	&res.
%mend;

* ---- macro nonBlank ----;
* paramAlias别名;
%macro nonBlank(p1,p2,p3,p4);
	%paramAlias(&p1,&p2,&p3,&p4)
%mend;

* ---- macro globalDefault ----;
* 设置参数默认值使用;
* input;
*	v			参数;
*	g			全局参数名称;
*	l			本地参数值;
* test;
*	@test_globalDefault;
* details;
*	globalDefault类似于nonBlank3，区别在于其第二个参数为全局宏变量，且使用isVoid识别空;

%macro globalDefault(v,g,l);
	%local res;
	%if not %isVoid(&v) %then %let res=&v;
	%else %do;
		%if not %globalExist(&g) %then %error(GLOBAL &g DOESNOT EXIST!);
		%let res=&&&g;
		%if %isVoid(&res) %then %let res=&l;
	%end;
	&res.
%mend;

* ---- macro allBlank ----;
* 检查是否全部为空;
* input;
*	p1-p4		变量;
* output;
*	res			是否所有变量都为空;
%macro allBlank(p1,p2,p3,p4);
	%local res;%let res=1;
	%if not %isBlank(&p1) %then %let res=0;
	%else %if not %isBlank(&p2) %then %let res=0;
	%else %if not %isBlank(&p3) %then %let res=0;
	%else %if not %isBlank(&p4) %then %let res=0;
	&res.
%mend;

* ---- macro anyBlank2 ----;
* 是否有任意参数为空，2个参数;
* input;
* output;
* test;
*	@test_anyBlank;
%macro anyBlank2(p1,p2);
	%local res;%let res=0;
	%if %isBlank(&p1) %then %let res=1;
	%else %if %isBlank(&p2) %then %let res=1;
	&res.
%mend;


* ---- macro anyBlank3 ----;
%macro anyBlank3(p1,p2,p3);
	%local res;%let res=0;
	%if %isBlank(&p1) %then %let res=1;
	%else %if %isBlank(&p2) %then %let res=1;
	%else %if %isBlank(&p3) %then %let res=1;
	&res.
%mend;


* ---- macro anyBlank4 ----;
%macro anyBlank4(p1,p2,p3,p4);
	%local res;%let res=0;
	%if %isBlank(&p1) %then %let res=1;
	%else %if %isBlank(&p2) %then %let res=1;
	%else %if %isBlank(&p3) %then %let res=1;
	%else %if %isBlank(&p4) %then %let res=1;
	&res.
%mend;


* -------------------------------------------------;
* ---------------- Macro variable macros ----------;
* -------------------------------------------------;

* ---- macro createTempVar -----;
* 创建临时的变量名称;
* 临时变量一般用做宏返回值变量，以确保该变量不会以外被下层宏重复使用;
* input;
*	prefix		名称前缀，默认为V;
* details;
*	宏变量以V开头，后续为BASE32格式随机字符，总计16个字符长;
*	宏变量名称生成后将进行重名检查，如已有同名变量将重新生成;
* test;
*	@test_createTempVar;
%macro createTempVar(prefix);
	%local var sw;
	%let sw=1;
	%if %isBlank(&prefix) %then %let prefix=V;
	%do %while (&sw);
		%let var=%genId(prefix=&prefix,len=16);
		%if not %symexist(&var) %then %let sw=0;
	%end;
	&var.
%mend;


* ---- macro varExist ----;
* 检查指定的变量名是否为空或未声明;
* input;
*	varname		变量名;
* output;
*	return		01变量;
* test;
*	@test_varExist;
%macro varExist(varname);
	%local res;
	%let res=0;
	%if %isBlank(&varname) %then %let res=0;
	%else %if %symexist(&varname) %then %let res=1;
	&res.
%mend;

* ---- macro globalExist ----;
* 检查指定的变量名是否为空或未声明;
* input;
*	varname		变量名;
* output;
*	return		01变量;
* test;
*	@test_globalExist;
%macro globalExist(varname);
	%local res;
	%let res=0;
	%if %isBlank(&varname) %then %let res=0;
	%else %if %SYMGLOBL(&varname) %then %let res=1;
	&res.
%mend;

* ---- macro getVar ----;
* 获取指定名称或层级宏的宏变量的值;
* input;
*	macro		宏名称;
*	level		相对调用宏的级别，默认为0;
*				以0表示查找getVar宏所在宏的宏变量，1表示向上一级的宏，依次类推;
*				当所对应level为最顶级时，为查找GLOBAL变量;
*				macro和level优先使用macro;
*	var			变量名称;
*	res			返回变量;
* details;
*	注意;
*		getMacroVar不会区分宏变量不存在与值为空的情况，均返回空;
* test;
* 	@test_getVar;
%macro getVar(macro=,level=,var=,res=);

	%resCheck(&res);
	%if %isBlank(&var) %then %error(VAR &var is empty!); 
	%if %isBlank(&level) %then %let level=0;
	%let level=%sysevalf(&level);
	%if %isBlank(&macro) %then %do;
		%let macro=%getInvoker(&level);
		%if &macro=OPEN CODE %then %let macro=GLOBAL;
	%end;
	%let macro=%upcase(&macro);
	%let var=%upcase(&var);
	proc sql noprint;
		select value into :&res
		from sashelp.vmacro
		where name="&var" and scope="&macro";
	quit;
%mend;


* ---- macro getMacroVars -----;
* 获取符合指定条件的宏变量名称列表;
* input;
*	prefix			指定搜索前缀，必须以"_"结尾;
*	macro			直接指定macro scope;
*					当macro为空时，使用scope设定搜索范围;
* 	scope			宏变量的搜索范围：;
*						GLOBAL		所有全局变量（不含SYS_或SQL_开头）;
*						LOCAL		所有本地变量，本地变量指调用此macro的宏中的local变量;
*						USER		所有用户变量，所有非自动、非系统变量、非本层变量（即getMacroVars中定义的local变量）;
*	noDuplicate		剔除变量名中的重复的情况，主要用于USER中，可能存在多级变量同名的情况;
*					使用noDuplicate+USER 返回的变量列表，就是用户在调用宏中，当前可访问的变量;
*					默认为1;
*	noPrefix		返回变量名中不包含前缀，默认0;
*	res				返回变量;
* output;
*	res				返回的宏变量列表,vars格式;
* test;
* 	@test_getMacroVars;

%macro getMacroVars(prefix=,macro=,scope=,noPrefix=,noDuplicate=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;

	%local prefixStr prefixSafe scopeStr invokerScope l result;

	%let result=%createTempVar;%local &result;

	%resCheck(&res);
	%if %isBlank(&noPrefix) %then %let noPrefix=0;
	%if %isBlank(&noDuplicate) %then %let noDuplicate=1;
	%if %isBlank(&scope) %then %let scope=USER;
	%let scope=%upcase(&scope);
	%let macro=%upcase(&macro);

	%if %isBlank(&prefix) %then %let prefixStr=%str();
	%else %do;
		%let prefix=%upcase(&prefix);
		%let prefixSafe=%transtrn(&prefix,%str(_),%str(^_));
		%let prefixStr=%str(and name like %'&prefixSafe.%%%' escape '^');
	%end;

	%if not %isBlank(&macro) %then %do;
		%let scopeStr=%str(and scope="&macro");
	%end;
	%else %do;
		%if &scope=GLOBAL %then %do;
			%let scopeStr=%str(and scope=%'GLOBAL%');
		%end;
		%else %if &scope=USER %then %do;
			%let scopeStr=%str(and scope^=%'AUTOMATIC%');
		%end;
		%else %if &scope=LOCAL %then %do;
			%let invokerScope=%getInvoker;	
			%let scopeStr=%quote(and scope=%'&invokerScope.%');
		%end;
	%end;

	proc sql noprint;
		select name into :&result separated by ' ' from sashelp.vmacro
		where name not like 'SYS_%' and name not like 'SQL_%' and scope^='GETMACROVARS' %unquote(&prefixStr) %unquote(&scopeStr);
	quit;

	%if %isBlank(&&&result) %then %return;

	%if &noPrefix %then %do;
		%let &result=%tranwrd(%quote( &&&result ),%quote( &prefix),%str());
	%end;
	%if &noDuplicate %then %do;
		%varsUnique(vars=%quote(&&&result),res=&tres);%let &result=&&&tres;
	%end;
	%let &res=&&&result;
%mend;

* ---- macro dropGlobals -----;
* 删除指定前缀的宏变量;
* input;
*	vars			待删除的全局宏变量名称;
*					当vars为空时不进行删除;
* test;
* 	@test_dropGlobals;

%macro dropGlobals(vars);
	%symdel %unquote(&vars);
%mend;


* ---- dropAllGlobals -----;
* 删除所有全局宏变量;
* 注意：所有SYS、GLUE_开头的全局宏变量不会被删除;
* test;
* 	@test_dropGlobals;

%macro dropAllGlobals;
	%local tres;%let tres=%createTempVar;%local &tres;
	proc sql noprint;
		select name into :&tres separated by ' '
		from sashelp.vmacro
		where scope="GLOBAL" and name not like 'SYS%' and name not like 'GLUE_%';
	quit;
	%symdel %unquote(&&&tres);
%mend;

* ---- clearGlobals -----;
* dropAllGlobals别名;
* test;
* 	#;
%macro clearGlobals;
	%dropAllGlobals;
%mend;


* ---- dropGlobalsByPrefix -----;
* 删除所有指定前缀的全局宏变量;
* input;
*	prefix			待删除的全局宏变量名称;
*					当prefix为空时不进行删除;
* test;
* 	@test_dropGlobals;

%macro dropGlobalsByPrefix(prefix);

	%local tres;%let tres=%createTempVar;%local &tres;
	%local stmt_prefix;
	%local p prefixN i;

	%if %isBlank(&prefix) %then %return;
	%let prefix=%upcase(&prefix);
	%varsCount(vars=&prefix,res=&tres);%let prefixN=&&&tres;
	%do i=1 %to &prefixN;
		%varsN(vars=&prefix,n=&i,res=&tres);%let p=&&&tres;
		%if	&i=1 %then %let stmt_prefix=%quote((name like %'&p.%%%'));
		%else %let stmt_prefix=&stmt_prefix %quote( or (name like %'&p.%%%'));
	%end;
	
	proc sql noprint;
		select name into :&tres separated by ' '
		from sashelp.vmacro
		where scope="GLOBAL" and %unquote((&stmt_prefix));
	quit;

	%symdel %unquote(&&&tres);

%mend;


* ---- clearAll -----;
* 删除所有全局宏变量与临时工作表;
%macro clearAll;
	%clearGlobals;
	%clearLib;
%mend;


* -------------------------------------------------;
* ------------------- macro plan ------------------;
* -------------------------------------------------;

* macro plan提供了一种批量执行macro的框架;
* plan被设计适用于如下典型场景：根据不同参数，重复一组相同复杂的数据分析动作，并对结果进行汇总;

* plan框架主要包含如下两部分;
*	plan						以xlsx或data形式保存的执行计划，包含每个步骤;
*	main code					核心代码，控制整体的执行逻辑;

* plan格式;
*	_ID_						执行的顺序号，由by变量或默认的顺序生成;
*	[by]						执行的顺序变量;
*	[vars]						执行参数;
*	[res]						返回结果;

* main code格式;
*	main code中主要依赖planInit、planNext来控制执行过程;
*		planInit用于根据编写的plan（一般为xlsx格式）生成具体的执行序号，以及其他的执行准备;
*		planNext用于自计划中提取下一条执行步骤;
*	具体的main code编写方式，参见测试用例test_plan;

* plan相关概念;
*	plan template				手工编写的执行计划，一般为xlsx格式;
*	plan						执行计划，依据template生成的一次具体执行文件，work中的一个临时数据表，格式与template基本相同，命名格式：PLAN_[planId];
*	planId/pid					执行计划ID，调用planInit时自动生成，用于唯一标记该次计划执行，20位随机ID;
*	stepId/sid					记录当前的执行位置，保存在全局宏变量GLUE_PLAN_[planId];

* ---- macro planInit ----;
* input;
*	data		ds格式的plan;
*	xlsx		xlsx格式的plan;
*	where		plan筛选条件;
*	vars		plan中必须有的字段，用于格式检查，选输;
*	by			执行顺序变量，用于确定执行的顺序，选输;
*				为空时将原始顺序执行;
*	res			返回planId;
*	resTotal	返回总step个数;
* test;
*	@test_plan;

%macro planInit(data=,xlsx=,vars=,by=,where=,res=,resTotal=);

	%local tres;%let tres=%createTempVar;%local &tres;
	%local planId d_plan stepIdVar stepN;
	%local stmt_where;
	
	* generate planId;
	%let planId=%genId(len=20);
	%let d_plan=WORK.PLAN_&planId;
	%let stepIdVar=GLUE_PLAN_&planId;
	%let stepN=0;

	%resCheck(&res);
	%resSet(&resTotal,0);
		
	* check plan template;
	%if %isBlank(&data) %then %do;
		%if %isBlank(&xlsx) %then %error(Plan is empty!);
		%xlsxToDs(data=&xlsx,out=&d_plan);
	%end;
	%else %copyDs(data=&data,out=&d_plan);

	* check vars;
	%dsVarsRequired(data=&d_plan,vars=&vars &by);
	
	* check where & by;
	%if %notBlank(&where) %then %let stmt_where=%quote(where=(&where));
	%if %isBlank(&by) %then %do;		
		data &d_plan;
			set &d_plan %unquote(&stmt_where) end=_EOF_;
			_ID_=_N_;
			if _EOF_ then do;
				call symput("&tres",_N_);
			end;
		run;
	%end;
	%else %do;
		proc sort data=%unquote(&d_plan(&stmt_where) out=&d_plan);
			by %unquote(&by);
		quit;
		data &d_plan;
			set &d_plan end=_EOF_;
			_ID_=_N_;
			if _EOF_ then do;
				call symput("&tres",_N_);
			end;
		run;
	%end;
	%let stepN=&&&tres;
	
	* enable step counter;
	%global &stepIdVar;
	%let &stepIdVar=0;

	* return result;
	%resSet(&res,&planId);
	%resSet(&resTotal,&stepN);

%mend;

* ---- macro planNext ----;
* 步进并提取执行计划;
* input;
*	planId		planId;
*	res			返回的计划步骤obj;
* test;
*	@test_plan;

%macro planNext(planId=,res=);

	%local tres;%let tres=%createTempVar;%local &tres;
	%local d_plan stepIdVar step;

	%paramRequired(&planId);
	%resCheck(&res);

	%let d_plan=WORK.PLAN_&planId;
	%let stepIdVar=GLUE_PLAN_&planId;

	* check plan data & step counter;
	%if not %dsExist(&d_plan) %then %error(PLAN doesnot exist!);
	%if %symglobl(&stepIdVar)=0 %then %error(PLAN indicator global doesnot exist!);

	%global &stepIdVar;
	%let &stepIdVar=%sysevalf(&&&stepIdVar+1);
	
	* read step;
	%loadObj(data=&d_plan,where=%quote(_ID_=&&&stepIdVar),res=&tres);%let step=&&&tres;

	%if %isBlank(&step) %then %planEnd(planId=&planId);
	%let &res=&step;

%mend;

* ---- macro planEnd ----;
* 释放plan资源;
* input;
*	planId		planId;
* test;
*	@test_plan;

%macro planEnd(planId=);

	%local d_plan stepIdVar;

	%let d_plan=WORK.PLAN_&planId;
	%let stepIdVar=GLUE_PLAN_&planId;

	%if %isBlank(&planId) %then %return;
	%dropDs(&d_plan);
	%dropGLobalsByPrefix(&stepIdVar);

%mend;



* ----------------------------------------------------------------------------------------------------------;
* ------------------------------------------------- DS TOOLS -----------------------------------------------;
* ----------------------------------------------------------------------------------------------------------;

* -------------------------------------------------;
* ---------------- ds basic macros ----------------;
* -------------------------------------------------;

* 主要ds相关的名称操作，不涉及具体数据实体的操作;
* 包括ds名称、lib名称、table名称、路径、ds中的变量名，以及data option;

* 参数默认含义;
*	ds		数据集的名称，例如：mylib.mytable的整体;
*	table	数据表的名称，例如：mylib.mytable中的mytable;
*	lib		数据库的名称，例如：mylib.mytable中的mylib;
*	path	数据存储的文件路径;


* ---- macro getTableName ----;
* 从lib.table格式中提取table名称;
* test;
*	@test_dsBasic;
%macro getTableName(f);
	%local i;
	%local res;
	%if %isBlank(&f) %then %let res=%str();
	%else %do;
		%let f=%upcase(&f);
		%let i=%index(&f,.);
		%if &i>0 %then %do;
			%if &i=%length(&f) %then %let res=%str(); 
			%else %let res=%substr(&f,&i+1);
		%end;
		%else %let res=&f;
	%end;
	&res.
%mend;


* ---- macro getLibname ----;
* 从lib.table格式中提取lib名称;
* test;
*	@test_dsBasic;
%macro getLibName(f);
	%local i;
	%local res;
	%let i= %index(&f,.);
	%if &i>0 %then %let res=%substr(&f,1,&i-1);
	%else %let res=work;
	%let res=%upcase(&res);
	&res.
%mend;


* ---- macro createTempDs ----;
* 创建临时的ds名称，默认lib为WORK;
* 临时table名称通过createTempTable创建;
* test;
*	@test_dsBasic;
%macro createTempDs(lib);
	%local ds;
	%if %isBlank(&lib) %then %let lib=WORK;
	%let ds=%upcase(&lib..%createTempTable);
	&ds.
%mend;


* ---- macro createTempTable ----;
* 创建临时的变量名称;
* input;
*	prefix			表名前缀，默认T;
*	len				表名长度，默认32;	
* test;
*	@test_dsBasic;
%macro createTempTable(prefix,len);
	%let prefix=%nonBlank(&prefix,T);
	%let len=%nonBlank(&len,32);
	%genId(prefix=&prefix,len=&len)
%mend;


* ---- macro getLibPath ----;
* 返回lib的路径;
* test;
*	@test_dsBasic;
%macro getLibPath(lib);
	%quote(%sysfunc(pathname(&lib))\)
%mend;


* ---- macro pathEqual ----;
* 比较两个path是否相同;
* test;
*	@test_dsBasic;
%macro pathEqual(pa,pb) /parmbuff;
	%local res;
	%let res=0;
	%if %allBlank(&pa,&pb) %then %let res=1;
	%else %if %anyBlank2(&pa,&pb) %then %let res=0;
	%else %if %qupcase(&pa)=%qupcase(&pb) %then %let res=1;
	&res.
%mend;

* ---- macro libEqual ----;
* 比较两个lib是否相同，比较的标准为path;
* sas可能存在两个不同名映射同一个文件夹的情况，因此需要此函数进行比较;
* test;
*	@test_dsbasic;
%macro libEqual(la,lb) /parmbuff;
	%local res pa pb;
	%let res=0;
	%if %allBlank(&la,&lb) %then %let res=1;
	%else %if %anyBlank2(&la,&lb) %then %let res=0;
	%else %if %upcase(&la)=%upcase(&lb) %then %let res=1;
	%else %do;
		%let pa=%getLibPath(&la);
		%let pb=%getLibPath(&lb);
		%if %pathEqual(&pa,&pb) %then %let res=1;
	%end;
	&res.
%mend;

* ---- macro tableEqual ----;
* 比较两个table是否相同;
* test;
*	@test_dsBasic;
%macro tableEqual(ta,tb) /parmbuff;
	%local res;
	%let res=0;
	%if %allBlank(&ta,&tb) %then %let res=1;
	%else %if %anyBlank2(&ta,&tb) %then %let res=0;
	%else %if %upcase(%strip(&ta))=%upcase(%strip(&tb)) %then %let res=1;
	&res.
%mend;

* ---- macro dsEqual ----;
* 判断两个ds是否对应相同的文件;
* input;
*	a			ds名称;
*	b			ds名称;
* output;
*	宏返回值		相同为1，否则为0;
* details;
*	dsEqual按如下顺序进行比较;
*		两个表名都为空				1;
*		两个表名任意一个为空			0;
*		表名lib与table比较;
* test;
*	@test_dsBasic;
%macro dsEqual(a,b) /parmbuff;
	%local res la lb ta tb;
	%if %allBlank(&a,&b) %then %let res=1;
	%else %if %anyBlank2(&a,&b) %then %let res=0;
	%else %do;
		%let la=%getLibName(&a);
		%let lb=%getLibName(&b);
		%let ta=%getTableName(&a);
		%let tb=%getTableName(&b);
		%if %tableEqual(&ta,&tb) and %libEqual(&la,&lb) %then %let res=1;
		%else %let res=0;
	%end;
	&res.
%mend;


* ----- macro suffixVar -----;
* 为变量名添加后缀，根据var和suffix长度自动调整，以避免出现超长变量名情况;
* 当连接后的变量名超过32字符时，将先对变量名进行右侧裁剪，再进行拼接;
* 例如：变量名ABC...XYZ123456(32位)连接后缀 _TEST，则结果为：ABC...XYZ1_TEST;
* input;
*	var				var名称;
*	suffix			suffix;
* output;
*	宏返回值			增加了后缀的变量名;
* details;
* test;
*	@test_varname;
%macro suffixVar(var,suffix);
	%local res v k l;
	%let v=&var.&suffix;
	%let k=%length(&v);
	%if &k<=32 %then %let res=&v;
	%else %do;
		%let l=%sysevalf(32-%length(&suffix));
		%let res=%substring(&var,1,&l)&suffix;
	%end;
	%unquote(&res)
%mend;

* ----- macro prefixVar -----;
* 为变量名添加前缀，根据var和prefix长度自动调整，以避免出现超长变量名情况;
* 当连接后的变量名超过32字符时，将在字符右侧进行截断;
* input;
*	var				var名称;
*	prefix			prefix;
* output;
*	宏返回值			增加了前缀的变量名;
* details;
* test;
*	@test_varname;
%macro prefixVar(var,prefix);
	%local res v k;
	%let v=&prefix.&var;
	%let k=%length(&v);
	%if &k<=32 %then %let res=&v;
	%else %let res=%substring(&v,1,32);
	%unquote(&res)
%mend;


* ----- macro dePrefixVar -----;
* 为变量名去掉前缀，注意去掉前缀仅按前缀长度进行裁剪，并不检查变量的开始字符与给定的前缀是否匹配;
* 功能更强的前缀、后缀处理宏请参见vars类;
* input;
*	var				var名称;
*	prefix			prefix;
* output;
*	宏返回值			去掉了前缀的变量名;
* details;
* test;
*	@test_varname;

%macro dePrefixVar(var,prefix);
	%unquote(%substring(&var,%eval(%length(&prefix)+1)))
%mend;


* ----- macro deSuffixVar -----;
* 为变量名去掉后缀，注意去掉后仅按后缀长度进行裁剪，并不检查变量的结尾字符与给定的后缀是否匹配;
* 功能更强的前缀、后缀处理宏请参见vars类;
* input;
*	var				var名称;
*	suffix			suffix;
* output;
*	宏返回值			去掉了后缀的变量名;
* details;
* test;
*	@test_varname;
%macro deSuffixVar(var,suffix);
	%unquote(%substring(&var,1,%eval(%length(&var)-%length(&suffix))))
%mend;


* ---- macro hashVar ----;
* 对变量名进行md5+base32 hash，以作为临时的变量名，该变量名以T开头，共16位长;
* test;
*	@test_varname;
%macro hashVar(var,len);
	%local res;
	%let len=%nonBlank(&len,32);
	%let res=%substr(T%sha256base32(%upcase(&var)),1,&len);
	&res.
%mend;


* ---- macro getDataOption ----;
* 自包含options的data中提取出option部分;
* L1.abc (where=(b>1) keep=a b c) -----> where=(b>1) keep=a b c
* details;
*	getDataOption的识别规则为字符串中第一个"("及其右侧的所有字符被识别为data option，然后进行去括号处理;
*	返回为转义形式;
* test;
*	@test_dsoption;
%macro getDataOption(data);
	%local d pos res;
	%let res=%str();
	%if not %isBlank(&data) %then %do;
		%let d=%str(&data);
		%let pos=%index(&d,%str(%());
		%if &pos>0 %then %let res=%debracket(%qsubstr(&d,%eval(&pos)));
	%end;
	&res.
%mend;


* ---- macro getDataMain ----;
* 自包含options的data中提取出主体部分;
* L1.abc (where=(b>1) keep=a b c) -----> L1.abc
* input;
*	data			包含option的data;
* details;
*	getDataMain的识别规则为字符串中第一个"("左侧的所有字符;
*	返回为非转义;
* test;
*	@test_dsoption;
%macro getDataMain(data);
	%local d pos res;
	%let res=%str();
	%if not %isBlank(&data) %then %do;
		%let d=%str(&data);
		%let pos=%index(&d,%str(%());
		%if &pos>0 %then %let res=%substr(&d,1,%eval(&pos-1));
		%else %let res=&data; 
	%end;
	&res.
%mend;


* ---- macro mergeDataOption ----;
* 将可能包含option的data与新增的option合并;
*  L1.abc(where=(b>1)) +  keep=a b c ----->  L1.abc(where=(b>1)  keep=a b c); 
* input;
*	data			可能包含option的data;
*	option			添加的option;
* details;
*	getDataMain的识别规则为字符串中第一个"("左侧的所有字符;
*	返回为非转义;
* test;
*	@test_dsoption;
%macro mergeDataOption(data=,option=);
	%local main option_old;
	%let main=%getDataMain(&data);
	%let option_old=%getDataOption(&data);
	&main(&option_old &option)
%mend;

* ----- macro dsExist -----;
* 判断输入的ds是否存在;
* input;
*	ds			ds名称;
* output;
*	宏返回值		存在为1，否则为0;
* test;
*	@test_dsInfo;
%macro dsExist(ds);
	%local res;
	%if %isBlank(&ds) %then %let res=0;
	%else %let res=%sysfunc(exist(%getDataMain(&ds)));
	&res.
%mend;


* ---- macro getDsObs -----;
* 返回ds的变量个数;
* input;
*	ds			ds名称;
*	where		where搜索条件;
*	res			返回宏变量;
* output;
*	res			返回ds的记录条数，ds为空或查询记录为0时返回0;
* test;
*	@test_dsInfo;
%macro getDsObs(data=,ds=,where=,res=);
	%local whereStr dsid anobs whstmt err;
	%resCheck(&res,0)
	%let ds=%paramAlias(&data,&ds);
	%let whereStr=%str();
	%if not %dsExist(&ds) %then %return;
	%if %isBlank(&where) %then %do;
		%let dsid=%sysfunc(open(&ds., IS));
		%let anobs=%sysfunc(attrn(&dsid, ANOBS));
		%let whstmt=%sysfunc(attrn(&dsid, WHSTMT));
		%if &anobs=1 and &whstmt=0 %then %do;
			%let &res=%sysfunc(attrn(&dsid, NLOBS));
			%let err=%sysfunc(close(&dsid));
			%return;
		%end;
		%else %do;
			%let err=%sysfunc(close(&dsid));
		%end;
	%end;
	%else %let whereStr=where &where;
	proc sql noprint;
		select count(*) into :&res from &ds &whereStr;
	quit;
%mend;


* -------------------------------------------------;
* ------------------ ds lib macros ----------------;
* -------------------------------------------------;

* 主要包括各种lib相关操作宏，lib挂载管理、lib信息、lib整体复制删除等;

* 几个lib挂载宏适用的不同场景;
*	importLocalLib		在代码所在文件下创建文件夹并关联，一般用于分类存储的场景，或读取本地文件夹下数据的场景，一般在使用后不删除数据;
*	importTempLib		关联指定文件夹到临时lib名，一般用于需要从指定路径读取数据的场景，一般在使用后不删除数据;
*	createTempLib		创建一个临时lib，一般用于需要批量创建临时数据集时使用，一般在使用后删除数据;

* 几个lib资源释放宏适用的不同场景;
*	dropLib				释放lib，不删除文件夹，不删除文件;
* 	dropLocalLib		释放名为local的lib，等价于dropLib(local);
*	dropTempLib			释放lib，删除文件夹;
*	resetLib			不释放lib，不删除文件夹，删除文件夹内所有内容;
*	clearLib			不释放lib，不删除文件夹，删除文件夹内所有sas数据（如：数据集、视图等），保留其他文件（如：html、pdf）;


* ---- macro importLocalLib ----;
* 导入当前代码文档所在文件夹（本地文件夹）所包含的数据集
* libname：本地文件夹映射到该名称，否则映射到默认的名称local;
* subdir：映射到本地子文件夹;
* test;
*	@test_importLocalLib;

%macro importLocalLib(libname,subdir);
	%local path fullpath;
	%if %isBlank(&libname) %then %let libname=local;
	%let path=%getPath;
	%if &subdir= %then %let fullpath=&path;
	%else %let fullpath=%sysfunc(cats(&path,&subdir));
	options dlcreatedir;
	libname &libname "&fullpath";
%mend;


* ---- macro importTempLib ----;
* 将指定文件路径挂载到一个临时lib名称上;
* 临时lib使用后，应调用dropLib释放lib;
* input;
* 	path	lib路径;
* 	res		返回lib名称的宏变量名称;
* details;
*	导入lib的名称统一为L开头的随机ID，8位长;
* test;
*	@test_importTempLib;

%macro importTempLib(libPath,res);
	%local lib sw;
	%let sw=1;

	* 路径合法性检查;
	%if not %folderExist(&libPath) %then %error(Path does not exist! path=&libPath);

	%do %while(&sw);
		%let lib=%genId(prefix=L,len=8);
		* hash冲突检查;
		proc sql noprint;
			select * from sashelp.vslib where libname="&lib";
		quit;
		%if &SQLOBS=0 %then %let sw=0; 
	%end;
	libname &lib "&libPath";
	%let &res=&lib;
%mend;

* ---- macro showTempLib ----;
* 显示所有临时库，主要用于debug，检查资源释放情况;
* 临时lib识别规则：开头为L，长度为8;
* test;
*	@test_createTempLib;
%macro showAllTempLib;

	%local res;

	proc sql noprint;
		select libname into :res separated by ' ' from sashelp.vslib where length(libname)=8 and libname like "L%";
	quit;

	%if %isBlank(&res) %then %linfo(NO TEMP LIB FOUND!);
	%else %linfo(&res);

%mend;


* ---- macro createTempLib ----;
* 创建一个临时路径并生成lib;
* createTempLib主要用于创建用于临时存放数据的临时性lib，lib使用完毕后一般应调用dropTempLib来删除路径文件夹;
* input;
* 	res		返回lib名称的宏变量名称;
* details;
*	临时性lib的名称统一为TL开头的随机ID，8位长;
*	临时性lib的文件夹建立在WORK文件夹下，名称为TF开头的随机ID，30位长;
* test;
*	@test_tempLib;
%macro createTempLib(res);
	%local folder lib workPath libPath res;
	%let folder=%genId(prefix=TF,len=30);
	%let lib=%genId(prefix=L,len=8);
	%let workPath=%getLibPath(WORK);
	%let libPath=&workPath.&folder.\;
	options dlcreatedir;
	libname &lib "&libPath";
	%let &res=&lib;
%mend;


* ---- macro dropLocalLib ----;
* 删除local字段与当前文件夹的关联关系;
* test;
*	#;
%macro dropLocalLib;
	libname local clear;
%mend;


* ---- macro dropLib ----;
* 删除指定lib的引用;
* test;
*	#;
%macro dropLib(lib);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local i l libN;
	%if %isBlank(&lib) %then %return;
	%varsCount(vars=&lib,res=&tres);%let libN=&&&tres;
	%do i=1 %to &libN;
		%varsN(vars=&lib,n=&i,res=&tres);%let l=&&&tres;
		libname %unquote(&l) clear;
	%end;
%mend;


* ---- macro clearLib ----;
* 删除指定lib内所有数据集，参数为空时清理临时lib（work）;
* 注意：只删除lib中的数据集、视图等sas文件，文件夹、lib引用保留;
* test;
*	@test_clearLib;
%macro clearLib(libname);
	%if %isBlank(&libname) %then %do; 
		proc datasets lib=work kill memtype=all nolist nowarn;run;quit;
	%end;
	%else %do;
		proc datasets lib=&libname kill memtype=all nolist nowarn;run;quit;
	%end;
%mend;


* ---- macro dropTempLib ----;
* 删除指定lib内所有内容，删除引用、删除文件夹;
* test;
*	@test_tempLib;
%macro dropTempLib(lib) /parmbuff;
	%local path;
	%if %isBlank(&lib) %then %return;
	%let path=%getLibPath(&lib);
	%dropLib(&lib);
	X rd /s /q "&path"; 
%mend;


* ---- macro resetLib ----;
* 删除指定lib中的所有内容;
* details;
*	resetLib通过删除指定文件夹，再创建该文件夹来实现文件的删除;
* test;
*	@test_resetLib;
%macro resetLib(lib);
	%local path;
	%if %isBlank(&lib) %then %return;
	%let path=%getLibPath(&lib);
	%removeFolder(&path);
	%createFolder(&path);
%mend;


* ---- macro getLibMember -----;
* 获取指定lib下的所有数据集的表名称;
* input;
*	lib		查找的lib;
*	prefix	指定前缀;
*	res		返回变量;
* output;
*	res		返回的表名列表,vars格式;
* test;
*	@test_getLibMember;

%macro getLibMember(lib=,prefix=,res=)/parmbuff;
	%resCheck(&res);
	%if %isBlank(&lib) %then %error(Requied param is empty! &syspbuff);
	%let lib=%upcase(&lib);
	%let prefix=%upcase(&prefix);
	%if %isblank(&prefix) %then %do;
		proc sql noprint;
    		select memname into :&res separated by ' ' from sashelp.vmember where libname="&lib" and memtype="DATA";
  		quit;
	%end;
	%else %do;
		proc sql noprint;
    		select memname into :&res separated by ' ' from sashelp.vmember where libname="&lib" and memtype="DATA" and substr(memname,1,%length(&prefix))="&prefix";
  		quit;
	%end;
%mend;


* ---- macro getLibDs -----;
* 获取指定lib下的所有数据集名称;
* 与getLibMember的区别在于返回的是包含lib的完整数据集名;
* test;
*	@test_getLibMember;

%macro getLibDs(lib=,prefix=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%getLibMember(lib=&lib,prefix=&prefix,res=&tres); 
	%varsPrefix(vars=&&&tres,prefix=%str(&lib..),res=&res);
%mend;


* ---- macro copyLib -----;
* lib间数据集批量拷贝函数;
* input;
*	inlib		来源lib;
*	outlib		目标lib，二者必须不相同;
*	tables		拷贝的白名单，默认为inLib中的所有数据集;
*	overwrite	是否覆盖，默认为1;
* details;
*	复制逻辑;
*		必须是不同lib;
*		同表名复制;
*		默认强制覆盖;	
* test;
*	@test_copyLib;

%macro copyLib(inlib=,outlib=,tables=,overwrite=) /parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;

	%local selected outTables;
	
	%if %isBlank(&inlib) or %isBlank(&outlib) %then %error(Required param is empty! &syspbuff);
	%if %isBlank(&overwrite) %then %let overwrite=1;

	%if %libEqual(&inLib,&outLib) %then %error(INLIB and OUTLIB is the same LIB!);

	%getLibMember(lib=&inlib,res=&tres);%let inTables=&&&tres;
	%let selected=&inTables;

	%if not %isBlank(&tables) %then %do;
		%varsAnd(a=&selected,b=&tables,res=&tres);%let selected=&&&tres;
	%end;
	
	%if &overwrite=0 %then %do;
		%getLibMember(lib=&outlib,res=&tres);%let outTables=&&&tres;
		%varsSub(a=&selected,b=&outTables,res=&tres);%let selected=&&&tres;
	%end;

	%if %isBlank(&selected) %then %return;

	proc datasets noprint nodetails;
		copy in=&inlib out=&outlib;
			select %unquote(&selected);
		run;
	quit;
%mend;


* -------------------------------------------------;
* ---------------- ds operation macros ------------;
* -------------------------------------------------;
* ds操作宏，主要是以ds整体为操作对象的宏，包括删除、拷贝、移动等;


* ---- macro copyDs ----;
* 拷贝ds;
* copyDs主要通过proc datasets的copy命令进行复制;
* input;
*	data		输入数据集，必输，允许data options，但无效;
*	out			输出数据集，允许data options，但无效;
*	outLib		输出数据lib名称;
*	outPath		输出路径位置;
*				out,outLib,outPath不可以同时为空;
*				均存在时的使用优先级：out>outLib>outPath;
*				使用out方式时，目标表会使用out中指定的表名称;
*				使用outLib或outPath时，目标表会使用data中的原有表名称，
*	isMove		是否是移动操作，默认为0;
* details;
*	proc datasets copy的优点;
*		带索引复制;
*		可能的复制速度提高（一般认为整体复制速度相对逐条复制更快，但实际差异可能并不明显）;
*	proc datasets copy的缺点;
*		不支持在复制的过程中改名				采用临时中间过渡表名解决;
*											重命名可以在proc datasets中的change命令，但为了逻辑清晰，此处使用封装后的renameDs实现;
*		不支持在同一个lib内进行复制			采用临时中间过渡lib来解决;
*											种方式效率较低，因此copyDs在复制前会先检查数据集是否有索引;
*											如存在索引，则按上述方式进行复制，否则使用data set方式直接进行复制;
*	目标表的覆盖;
*		如果目标位置已有同名表，则会被自动覆盖;
*	同lib内的移动
*		如果是移动表，且lib相同，则不进行copy，只进行重命名;
* test;
*	@test_copyDs;

%macro copyDs(data=,out=,outLib=,outPath=,isMove=) /parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local iLib iTable iPath oLib oTable oPath;
	%local optionMove;
	%local hasIndex;
	%local isOutPath;
	%local tempLib tempTable;

	%let optionMove=%str();
	%let isOutPath=0;

	%if %isBlank(&data) %then %return;
	%if %isBlank(&out) and %isBlank(&outLib) and %isBlank(&outPath) %then %return;

	%let data=%getDataMain(&data);
	%let out=%getDataMain(&out);

	%if not %dsExist(&data) %then %return;

	%if %isBlank(&isMove) %then %let isMove=0;
	%if &isMove=1 %then %let optionMove=%str(move);
	
	%let iLib=%getLibName(&data);
	%let iTable=%getTableName(&data);
	%let iPath=%getLibPath(&iLib);

	%if %isBlank(&out)=0 %then %do;
		%let oLib=%getLibName(&out);
		%let oTable=%getTableName(&out);
	%end;
	%else %if %isBlank(&outLib)=0 %then %do;
		%let oLib=&outLib;
		%let oTable=%getTableName(&data);
	%end;
	%else %if %isBlank(&outPath)=0 %then %do;
		%importTempLib(&outPath,&tres);%let oLib=&&&tres;
		%let oTable=%getTableName(&data);
		%let isOutPath=1;
	%end;
	%let oPath=%getLibPath(&oLib);
	%let data=&iLib..&iTable;
	%let out=&oLib..&oTable;


	%if %libEqual(&iLib,&oLib) %then %do;	* lib内copy;
		%if not %tableEqual(&iTable,&oTable) %then %do;* 不同名拷贝;
			%dropDs(&out);
			%if &isMove=1 %then %do;
				%renameDs(old=&data,new=&out);
			%end;
			%else %do;
				%countIndex(data=&data,res=&tres);
				%if &&&tres>0 %then %do;* 有索引;
					* 创建临时lib;
					%createTempLib(&tres);%let tempLib=&&&tres;
					* 拷贝/移动到临时lib;
					proc datasets noprint NODETAILS;
						copy in=&iLib out=&tempLib &optionMove;
							select &iTable;
						run;
					quit;
					* 重命名ds;
					%if not %tableEqual(&iTable,&oTable) %then %renameDs(old=&tempLib..&iTable,new=&tempLib..&oTable);
					* 拷贝/移动到目标lib;
					proc datasets noprint NODETAILS;
						copy in=&tempLib out=&oLib &optionMove;
							select &oTable;
						run;
					quit;
				%end;
				%else %do;* 无索引;
					data &out;
						set &data;
					run;
				%end;
			%end;		
		%end;
	%end; 
	%else %do;* lib间copy;
		%dropDs(&out);
		%if %tableEqual(&iTable,&oTable) %then %do;* 同表名copy;
			proc datasets noprint NODETAILS;
				copy in=&iLib out=&oLib &optionMove;
					select &iTable;
				run;
			quit;
		%end;
		%else %do;* 不同表名copy;
			%let tempTable=%createTempTable;
			%renameDs(old=&data,new=&iLib..&tempTable);
			proc datasets noprint NODETAILS;
				copy in=&iLib out=&oLib &optionMove;
					select &tempTable;
				run;
			quit;
			%if not &isMove %then %renameDs(old=&iLib..&tempTable,new=&data);
			%renameDs(old=&oLib..&tempTable,new=&out);
		%end;
	%end;
	
	%if &isOutPath=1 %then %dropLib(&oLib);
	%dropTempLib(&tempLib);
%mend;

* ---- macro moveDs ----;
* 移动ds;
* 参见copyDs;
* test;
*	@test_copyDs;
%macro moveDs(data=,out=,outLib=,outPath=);
	%copyDs(data=&data,out=&out,outLib=&outLib,outPath=&outPath,isMove=1);
%mend;

* ---- macro dsEmptyClone ----;
* 创建一个与原表结构相同但为空的表;
* test;
*	@test_dsEmptyClone;
%macro dsEmptyClone(data=,out=);
	proc sql inobs=0 noprint;
		create table &out as (select * from &data where 0=1); 
	quit;
%mend;

* ---- cloneEmptyDs ----;
* dsEmptyClone别名;
%macro cloneEmptyDs(data=,out=);
	%dsEmptyClone(data=&data,out=&out);
%mend;

* ---- macro renameDs ----;
* 重命名ds;
* input;
*	data/old	原数据集名，优先使用data;
*	out/new		新数据集名，优先使用out;
*				如果out/new以mylib.newtable形式出现，则其中lib名部分不起作用;
* output;
*	无;
* details;
*	输出如已存在，将被删除;
* test;
*	@test_renameDs;
%macro renameDs(data=,old=,out=,new=) /parmbuff;
	%local lib oldTable newTable;

	%if %isBlank(&data) %then %do;
		%if %isBlank(&old) %then %error(Required param is empty! &syspbuff);
		%else %let data=&old;
	%end;
	%if %isBlank(&out) %then %do;
		%if %isBlank(&new) %then %error(Required param is empty! &syspbuff);
		%else %let out=&new;
	%end;
	%if not %dsExist(&data) %then %error(OLD &old doesnot exist! &syspbuff);
	%let lib=%getLibName(&data);
	%let oldTable=%getTableName(&data);
	%let newTable=%getTableName(&out);
	%if &oldTable=&newTable %then %return;
	%dropDs(&lib..&newTable);
	proc datasets library=&lib noprint NODETAILS;
   		change &oldTable=&newTable;
		run;
	quit;
%mend;

* ---- macro dropDs -----;
* 批量删除宏;
* input;
*	ds			vars格式，待删除数据集名列表;
* output;
*	无;
* details;
*	删除不存在的ds会导致异常，因此这里暂时关闭日志输出;
* test;
*	@test_utili_ds_dropDs;
%macro dropDs(ds);
	%if %isBlank(&ds) %then %return;
	%logOff;
	proc delete data=%unquote(&ds);quit;
	%logOn;
%mend;

* ---- macro clearTable ----;
* dropDs同名宏;
* test;
*	#dropDs;
%macro clearTable(ds);
	%dropDs(&ds);	
%mend;

* ---- macro dropTable ----;
* dropDs同名宏;
* test;
*	#dropDs;
%macro dropTable(ds);
	%dropDs(&ds);	
%mend;

* ---- macro dropView/clearView -----;
* 删除指定view;
* input;
*	views		vars格式;
* test;
*	@test_dropView;
%macro dropView(views);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local i viewsN view stmt_drop;

	%if %isBlank(&views) %then %return;
	%varsCount(vars=&views,res=&tres);%let viewsN=&&&tres;
	%if &viewsN=0 %then %return;
	%do i=1 %to &viewsN;
		%varsN(vars=&views,n=&i,res=&tres);%let view=&&&tres;
		%let stmt_drop=&stmt_drop %str(%quote(
			drop view &view;
		));
	%end;
	proc sql noprint;
		%unquote(&stmt_drop);
	quit;
%mend;

* ---- macro clearView -----;
* dropView别名宏;
* test;
*	#dropview;
%macro clearView(ds);
	%dropView(&ds);
%mend;


* -----------------------------------------------------;
* ---------------- ds var operation macros ------------;
* -----------------------------------------------------;
* ds变量操作宏;

* ---- macro renameDsVar ----;
* 修改ds中的变量名称;
* input;
*	data		输入数据集，必输;
*	old			原变量名，vars格式;
*	new			新变量名，vars格式，新变量名与原变量名数量必须相同，并按顺序一一对应;
*	out			输出数据集，默认为data;
* details;
*	对于任意名称转换，若在数据集中未找到对应变量，则不进行改名;
* test;
*	@test_renameDsVar;

%macro renameDsVar(data=,old=,new=,out=) /parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;

	%local stmt_rename;
	%local lib table;
	%local vars;

	%let stmt_rename=%str();

	* param check;
	%if %isBlank(&data) or %isBlank(&old) or %isBlank(&new) %then %error(Required param is empty! &syspbuff);
	%if %dsExist(&data)=0 %then %error(&data doesnot exist! &syspbuff);
	%if %isBlank(&out) %then %let out=&data;

	* vars check;
	%getDsVarList(data=&data,res=&tres);%let vars=&&&tres;
	%varsToAssigns(a=&old,b=&new,res=&tres);%let stmt_rename=&&&tres;
	%assignsFilter(assigns=&stmt_rename,vars=&vars,isBlacklist=0,res=&tres);%let stmt_rename=&&&tres;

	* ds output;
	%copyDs(data=&data,out=&out);

	%if %isBlank(&stmt_rename) %then %return;

	* rename;
	%let lib=%getLibName(&out);
	%let table=%getTableName(&out);
	proc datasets library=&lib nolist;
		modify &table;
			rename &stmt_rename;
		run;
	quit;

%mend;


* ---- macro dsVarExist -----;
* 返回ds的指定变量是否存在,存在为1，否则为0;
* test;
*	@test_dsVarExist;
%macro dsVarExist(ds,var);
	%local res dsid varnum rc;
	%if not %dsExist(&ds) %then %let res=0;
	%else %do;
		%let dsid=%sysfunc(open(&ds,i));
		%if &dsid=0 %then %let res=0;
		%else %do;
			%let varnum=%sysfunc(varnum(&dsid,&var));
			%if	&varnum=0 %then %let res=0;
			%else %let res=1;
			%let rc=%sysfunc(close(&dsid));
		%end;
	%end;
	&res.
%mend;


* ---- macro checkVars -----;
* 检查data是否存在且指定的vars是否都在data中,返回的清单为不在data中的变量列表;
* test;
*	@test_checkVars;
%macro checkVars(data=,ds=,vars=,res=) /parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local dataVars;

	%resCheck(&res);
	%let data=%paramAlias(&data,&ds);

	%if not %dsExist(&data) %then %error(DATA DOES NOT EXIST! &syspbuff);
	%if %isBlank(&vars) %then %return;
	
	%getDsVarList(ds=&data,res=&tres);%let dataVars=&&&tres;
	%varsSub(a=&vars,b=&dataVars,res=&tres);%let &res=&&&tres;
%mend;


* ---- macro checkDsVars -----;
* checkVars别名;
%macro checkDsVars(data=,ds=,vars=,res=);
	%checkVars(data=&data,ds=&ds,vars=&vars,res=&res);
%mend;


* ---- macro dsVarsRequired -----;
* 检查ds中的变量是否充分;
%macro dsVarsRequired(data=,ds=,vars=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%checkVars(data=&data,ds=&ds,vars=&vars,res=&tres);
	%if not %isBlank(&&&tres) %then %do;
		%saslog(level=ERROR,log=%quote(DATA DOES NOT EXIST or REQUIRED VARS &&&tres ARE MISSING!),invokerLevel=1);
		%abort;
	%end;
%mend;


* ---- macro getDsVarLen -----;
* 返回数据集中指定变量的length，不存在的变量返回0;
* test;
*	@test_utili_ds_var_operation;
%macro getDsVarLen(data=,ds=,var=,res=);
	%local dsid varnum rc;
	%resCheck(&res,0);
	%let data=%paramAlias(&data,&ds);
	%let dsid=%sysfunc(open(&data,i));
	%if &dsid=0 %then %return;
	%let varnum=%sysfunc(varnum(&dsid,&var));
	%if	&varnum=0 %then %do;
		%let rc=%sysfunc(close(&dsid));
		%return;
	%end;
	%let &res=%strip(%sysfunc(varlen(&dsid,&varnum)));
    %let rc=%sysfunc(close(&dsid));
%mend;


* ---- macro setDsVarLen ----;
* 修改ds的变量长度;
* input;
*	data/ds		目标数据集;
*				当ds为空时，将报错;
*				当数据集不存在时，将自动创建;
*	var			变量名称，不得为空;
*	len			长度，默认值为20，必须大于0，等于或小于0的值将被调整为20;
* test;
* 	@;
* details;
*	仅限于对字符类变量进行修改，若目标变量为数值，则将报错;
*	长度只能向上调整，不能向下调整;
*	若指定变量在目标表中不存在，则将被自动创建并填充空;
*	若指定的目标表不存在，则将被自动创建;
* test;
*	@test_setDsVarLen;

%macro setDsVarLen(data=,ds=,var=,len=) /parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;
	%local varType currLen;

	%let data=%paramAlias(&data,&ds);
	%if %isBlank(&data) or %isBlank(&var) %then %error(Required param is empty! &syspbuff);
	%if %isBlank(&len) %then %let len=20;
	%if %sysevalf(&len<=0) %then %let len=20;
	%if %dsExist(&data) %then %do;

		* type check;
		%getDsVarType(ds=&data,var=&var,res=&tres);%let varType=&&&tres;
		%if &varType=1 %then %error(Can not change the length of NUMERIC VAR! &syspbuff);

		* length check; 
		%getDsVarLen(data=&data,var=&var,res=&tres);%let currLen=&&&tres;
		%if &currLen>=&len %then %return;
		proc sql noprint;
			alter table %unquote(&data modify &var char(&len)); 
		quit;
	%end;
	%else %do;
		proc sql noprint;
			create table %unquote(&data (&var char(&len)));
		quit;
	%end;
%mend;


* ---- macro dropDsVar ----;
* 删除ds中指定var;
* input;
*	ds		目标数据集;
*	data	ds别名;
*	var		变量名称，vars格式;
*	vars	var别名;
* details;
*	索引变量的删除;
*		dropDsVar可以删除索引变量，删除同时所有使用该变量的索引将被自动删除;
* test;
* 	@test_dropDsVar;

%macro dropDsVar(ds=,data=,var=,vars=);
	%local tres;%let tres=%createTempVar;%local &tres;	

	%local dsvars listvars;

	%let data=%paramAlias(&data,&ds);
	%let vars=%paramAlias(&vars,&var);
	%getDsVarList(ds=&data,res=&tres);%let dsvars=&&&tres;
	%varsAnd(a=&dsvars,b=&vars,res=&tres);%let listvars=&&&tres;
	%if %isBlank(&listvars) %then %return;
	proc sql noprint;
		alter table %unquote(&data) drop column %sasVarsToSql(&listvars);
	quit;
%mend;


* ---- macro dropDsVars ----;
* dropDsVar的别名宏;
* test;
*	#dropDsVars;
%macro dropDsVars(data=,ds=,vars=,var=);
	%dropDsVar(data=&data,ds=&ds,vars=&vars,var=&var);
%mend;


* ---- macro getDsVarList -----;
* 返回ds的变量列表,类似于data step中的_all_;
* input;
*	data/ds			目标数据集;
* test;
*	@test_getDsVarList;
%macro getDsVarList(data=,ds=,res=);
	%local ts;
	%let ts=%createTempDs;
	%resCheck(&res);
	%let data=%paramAlias(&data,&ds);
	%if not %dsExist(&data) %then %return;
	proc contents data=%getDataMain(&data) out=&ts noprint varnum;
	quit;
	proc sql noprint;
		select name into :&res separated by ' ' from &ts order by varnum;
	quit; 
	%dropDs(&ts);
	%let &res=%strip(&&&res);
%mend;


* ---- macro getDsNumVarList -----;
* 返回ds的numeric变量列表,类似于data step中的_numeric_;
* input;
*	data/ds 		目标数据集;
* test;
*	@test_getDsVarList;
%macro getDsNumVarList(data=,ds=,res=);
	%local ts;
	%resCheck(&res);
	%let ds=%paramAlias(&data,&ds);
	%if not %dsExist(&ds) %then %return;
	%let ts=%createTempDs;
	proc contents data=%getDataMain(&ds) out=&ts noprint varnum;
	quit;
	proc sql noprint;
		select name into :&res separated by ' ' from &ts where type=1 order by varnum;
	quit; 
	%dropDs(&ts);
	%let &res=%strip(&&&res);
%mend;


* ---- macro getDsStrVarList -----;
* 返回ds的string变量列表,类似于data step中的_string_;
* input;
*	data/ds 		目标数据集;
* test;
*	@test_getDsVarList;
%macro getDsStrVarList(data=,ds=,res=);
	%local ts;
	%resCheck(&res);
	%let ds=%paramAlias(&data,&ds);
	%if not %dsExist(&ds) %then %return;
	%let ts=%createTempDs;
	proc contents data=%getDataMain(&ds) out=&ts noprint varnum;
	quit;
	proc sql noprint;
		select name into :&res separated by ' ' from &ts where type=2 order by varnum ;
	quit;
	%dropDs(&ts);
	%let &res=%strip(&&&res);
%mend;


* ---- macro getDsVarType -----;
* 返回ds的指定变量类型，如果1表示数值，2表示字符,0表示data不存在;
* input;
*	data/ds			目标数据集;
*	var				目标变量;
* test;
*	@test_getDsVarList;
%macro getDsVarType(data=,ds=,var=,res=);
	%local ts;
	%resCheck(&res,0);
	%let ds=%paramAlias(&data,&ds);
	%let ds=%getDataMain(&ds);
	%let ts=%createTempDs;
	proc contents data=&ds out=&ts varnum noprint;
	quit;
	proc sql noprint;
		select type into :&res from &ts where upcase(name)=upcase("&var");
	quit;
	%dropDs(&ts);
%mend;


* ---- macro getDsVarCount -----;
* 返回ds的变量中var变量的观测数量;
* input;
*	data/ds			目标数据集;
*	var				目标变量;
*	noNull			统计是否包含null;
* test;
*	@test_getDsVarCount;
%macro getDsVarCount(data=,ds=,var=,res=,noNull=);
	%resCheck(&res,0);
	%let ds=%paramAlias(&data,&ds);
	%if %dsVarExist(&ds,&var)=0 %then %error(DS or VAR doesnot exist! ds=&ds);
	%if %isBlank(&noNull) %then %let noNull=1;
	%if &noNull=1 %then %do;
		proc sql noprint;
			select count(&var) into :&res from &ds;
		quit; 
	%end;
	%else %do;
		%getDsObs(ds=&ds,res=&res);
	%end;
%mend;


* ---- macro getDsVarMax -----;
* 返回ds的变量中var变量的最大值，missing value不纳入计算;
* input;
*	data/ds			目标数据集;
*	var				目标变量;
* test;
*	@test_getDsVarCount;
%macro getDsVarMax(data=,ds=,var=,res=);
	%resCheck(&res);
	%let ds=%paramAlias(&data,&ds);
	%if %dsVarExist(&ds,&var)=0 %then %error(DS or VAR doesnot exist! ds=&ds);
	proc sql noprint;
		select max(&var) into :&res from &ds;
	quit; 
%mend;


* ---- macro getDsVarMin -----;
* 返回ds的变量中var变量的最小值，missing value不纳入计算;
* 注意：数据集中不要使用var=.形式向字符变量赋予缺失值，会导致min值为.;
* input;
*	data/ds			目标数据集;
*	var				目标变量;
* test;
*	@test_getDsVarCount;
%macro getDsVarMin(data=,ds=,var=,res=);
	%resCheck(&res);
	%let ds=%paramAlias(&data,&ds);
	%if %dsVarExist(&ds,&var)=0 %then %error(DS or VAR doesnot exist! ds=&ds);
	proc sql noprint;
		select min(&var) into :&res from &ds;
	quit; 
%mend;



* -----------------------------------------------------;
* ---------------- ds cell operation macros ------------;
* -----------------------------------------------------;
* 以ds中一个单元为操作对象的宏，单元指一个条观测的一个变量值;
* cell类操作宏的典型应用场景包括;
*	loadCell		从某个proc的运行结果报表中提取某个统计量的数值;
*	saveCell		将某个proc的运行结果统计量写入某个汇总表中;


* ---- loadCell ----;
* 自ds中读取一个cell值;
* input;
*	data		数据集;
*	var			读取的目标变量;
*	key/keyVar	主键变量名称，vars格式;
*	keyValue	主键变量值，vars格式;
*				keyVar为字符型变量时，keyValue不需要使用引号;
*				keyVar与keyValue一一对应;
*	where		where查询目标;
* 	res			返回变量;
* output;
*	res			返回的值;
* test;
*	@test_loadCell;
* details;
* 	cell定位方式;
*		key + keyValue + var		即分别输入主键变量名、变量值以及目标变量;
*		where + var					即直接输入查询条件;
*		以上两种方式可以同时使用;
*		当匹配结果多于1个时，按返回结果选择第一个;
*	缺失值表示;
*		当keyValue中需要表示缺失值时;
*			数值变量					使用%str(.);
*			字符变量					使用where语句进行设置;

%macro loadCell(data=,var=,keyVar=,keyValue=,key=,where=,res=);

	%local tres;%let tres=%createTempVar;%local &tres;

	%local keyVarN keyValueN;
	%local numVarList;
	%local stmt_key stmt_where;
	%local vr vl;
	%local i;

	%let stmt_key=1;
	%let stmt_where=1;

	* 参数检查;
	%resCheck(&res,0);
	%let keyVar=%paramAlias(&key,&keyVar);
	%paramRequired2(&data,&var);
	
	* 数据检查;
	%dsVarsRequired(data=&data,vars=&keyVar &var);

	* key查询语句生成;
	%if not %isBlank(&keyVar) %then %do;

		* 数据检查;	
		%varsCount(vars=&keyVar,res=&tres);%let keyVarN=&&&tres;
		%varsCount(vars=&keyValue,res=&tres);%let keyValueN=&&&tres;
		%if &keyVarN ne &keyValueN %then %error(KEYVARN &keyVarN ne KEYVALUEN &keyValueN!);

		* 变量类型提取;
		%getDsNumVarList(ds=&data,res=&tres);%let numVarList=&&&tres;

		* 语句生成;
		%do i=1 %to &keyVarN;
			%varsN(vars=&keyVar,n=&i,res=&tres);%let vr=&&&tres;
			%varsN(vars=&keyValue,n=&i,res=&tres);%let vl=&&&tres;
			%varsExist(source=&numVarList,target=&vr,res=&tres);
			%if &&&tres=0 %then %let stmt_key=&stmt_key %quote(and (&vr="&vl"));
			%else %let stmt_key= &stmt_key %quote(and (&vr=&vl));
		%end;
	%end;

	* where查询语句生成;
	%if not %isBlank(&where) %then %do;
		%let stmt_where=&where;
	%end;

	* sql执行;
	proc sql outobs=1 noprint;
		select &var into :&res 
		from &data 
		where %unquote((&stmt_key) and (&stmt_where));
	quit;

	
%mend;

* ---- saveCell ----;
* 向ds中更新/写入一个或多个cell值;
* input;
*	data		数据集;
*	key/keyVar	主键变量名称，vars格式;
*	keyValue	主键变量值，vars格式;
*				注意：keyVar与keyValue必须一一对应;
*	var			目标变量，vars格式;
*	value		目标变量值，vars格式;
*				注意：var与value必须一一对应;
* 	res			返回变量;
* output;
*	res			SQLOBS;
* test;
*	@test_saveCell;
* details;

*	写入逻辑;
*		先检查指定目标是否存在，如果存在则update否则进行insert;

*	缺失值处理;
*		由于vars格式限制，建议ds中所有字符变量的缺失值，以非空字符串来替代，例如:NULL;
*		如果ds中以空字符串表示缺失;
*			查询的key变量为缺失						使用where语句来编写查询条件;
*			1次设置1个变量，value为缺失				value不输入，留空;
*			1次设置多个变量，其中包含至少1个缺失		不支持;

*	全观测匹配;
*		当key变量为空且where为空时，则认为观测匹配计算结果始终为1，即所有观测都匹配，因此将更新所有观测的相应变量;

*	写入变量事先存在;
*		saveCell要求所有被写入的变量都必须事先存在;
*		saveCell不会在ds中创建新的变量或修改已有变量的长度（这是与saveObj的区别之一）;

%macro saveCell(data=,var=,value=,keyVar=,keyValue=,key=,where=,res=);

	%local tres;%let tres=%createTempVar;%local &tres;

	%local keyVarN keyValueN varN valueN;
	%local numVarList;
	%local stmt_key stmt_where stmt_set stmt_set_key;
	%local vr vl;
	%local i;
	%local delimiter;

	%let stmt_key=1;
	%let stmt_where=1;


	* 参数检查;
	%resSet(&res,0);
	%let keyVar=%paramAlias(&key,&keyVar);
	%paramRequired2(&data,&var);
	%dsVarsRequired(data=&data,vars=&keyVar &var);

	* 变量类型提取;
	%getDsNumVarList(ds=&data,res=&tres);%let numVarList=&&&tres;

	* key查询语句生成;
	%if not %isBlank(&keyVar) %then %do;
	
		* 数据检查;
		%varsCount(vars=&keyVar,res=&tres);%let keyVarN=&&&tres;
		%varsCount(vars=&keyValue,res=&tres);%let keyValueN=&&&tres;
		%if &keyVarN ne &keyValueN %then %error(KEYVARN &keyVarN ne KEYVALUEN &keyValueN!);

		* 语句生成;
		%do i=1 %to &keyVarN;
			%varsN(vars=&keyVar,n=&i,res=&tres);%let vr=&&&tres;
			%varsN(vars=&keyValue,n=&i,res=&tres);%let vl=&&&tres;
			%varsExist(source=&numVarList,target=&vr,res=&tres);
			%if &&&tres=0 %then %do;
				%let stmt_key=&stmt_key %quote(and (&vr="&vl"));
				%let stmt_set_key=&stmt_set_key %quote(,&vr="&vl"); 
			%end;
			%else %do;
				%let stmt_key=&stmt_key %quote(and (&vr=&vl));
				%let stmt_set_key=&stmt_set_key %quote(,&vr=&vl);
			%end;
		%end;
	%end;

	* where查询语句生成;
	%if not %isBlank(&where) %then %do;
		%let stmt_where=&where;
	%end;

	* set语句生成;
	%varsCount(vars=&var,res=&tres);%let varN=&&&tres;
	%varsCount(vars=&value,res=&tres);%let valueN=&&&tres; 

	%if &varN=1 and &valueN=0 %then %do;
		* 缺失值设置;
		%varsExist(source=&numVarList,target=&var,res=&tres);
		%if &&&tres=0 %then %let stmt_set=%quote(&var=' ');
		%else %let stmt_set=%quote(&var=.));
	%end;
	%else %do;
		* 一般值设置;
		%if &varN ne &valueN %then %error(VARN &varN ne VALUEN &valueN!);
		%do i=1 %to &varN;
			%varsN(vars=&var,n=&i,res=&tres);%let vr=&&&tres;
			%varsN(vars=&value,n=&i,res=&tres);%let vl=&&&tres;
			%varsExist(source=&numVarList,target=&vr,res=&tres);
			%if &i=1 %then %let delimiter=;%else %let delimiter=%str(,);
			%if &&&tres=0 %then %let stmt_set=&stmt_set %quote(&delimiter.&vr="&vl");
			%else %let stmt_set=&stmt_set %quote(&delimiter.&vr=&vl);
		%end;
	%end;

	* 检查目标是否存在;
	proc sql noprint;
		select * from &data where %unquote((&stmt_key) and (&stmt_where));
	quit;

	%if &SQLOBS>0 %then %do;
		proc sql noprint;
			update &data set %unquote(&stmt_set) where %unquote((&stmt_key) and (&stmt_where));
		quit;
	%end;
	%else %do;
		proc sql noprint;
			insert into &data set %unquote(&stmt_set &stmt_set_key);
		quit;
	%end;

	%resSet(&res,&SQLOBS);
%mend;


* ------------------------------------------------------;
* --------------------- ds obs  macros -----------------;
* ------------------------------------------------------;

* ---- macro removeDupObs----;
* 删除ds中的重复观测;
* input;
*	data			数据表名;
*	key/keySort		主排序语句，用于确定主键以及主键的排序，支持降序，例如： var1 descending var2;
*	dup/dupSort		副排序语句，格式与key相同，用于对同一key值组内的观测进行排序，该语句与keep共同确定重复值的处理规则;
*	keep			保留的重复值的筛选规则;
*						FIRST	保留组内的第1个观测，默认值;
*						LAST	保留组内的最后1个观测;
*						NONE 	该key值所有观测均不保留;
* 	out				输出表名，默认为data;
*	dupOut			被删除的观测;
*					out+dupOut=data;
* details;
*	removeDupObs vs proc sort nodupkey;
*		假设数据集ds有变量A B C D，以A+B为key，删除重复观测，其中重复的保留按C+D排序第一个的;
*		对于该场景，proc sort nodupkey无法处理：如果使用by A B则不能保证重复观测保留的顺序，如果使用by A B C D则会导致重复的观测;
* test;
*	@test_removeDupObs;
%macro removeDupObs(data=,key=,keySort=,dup=,dupSort=,keep=,out=,dupOut=) /parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;

	%local lastKey;

	%let keySort=%paramAlias(&key,&keySort);
	%let dupSort=%paramAlias(&dup,&dupSort);
	%paramRequired2(&data,&keySort);
	%let out=%nonBlank(&out,&data);
	%let keep=%nonBlank(&keep,FIRST);
	%if not %dsExist(&data) %then %error(DATA doesnot exist! param=&syspbuff);

	%let lastKey=%varsK(&keySort,-1);
	proc sort data=&data out=&out ;
		by %unquote(&keySort &dupSort);
	run;
	data %unquote(&out &dupOut);
		set %unquote(&out);
		by %unquote(&keySort &dupSort);
		
		%if %upcase(&keep)=FIRST %then %do;
			if first.&lastKey then do;
				output %unquote(&out);
			end;
		%end;
		%else %if %upcase(&keep)=LAST %then %do;
			if last.&lastKey then do;
				output %unquote(&out);
			end;
		%end;
		%else %if %upcase(&keep)=NONE %then %do;
			if last.&lastKey and first.&lastKey then do;
				output %unquote(&out);
			end;
		%end;
		%if not %isBlank(&dupOut) %then %do;
			else do;
				output %unquote(&dupOut);
			end;
		%end;
	run;
%mend;


* ---- macro getDsKeyCount -----;
* 返回ds中指定key的个数;
* input;
*	ds/data		输入数据集;
*	key			构成key的变量，vars格式;
*	res			返回结果;
* output;
*	res			key的个数，如果data不存在或观测为0，则返回0;
* details;
*	异常处理逻辑;
*		如果指定的key不存在，则报error;
* test;
*	@test_getDsKeyCount;
%macro getDsKeyCount(ds=,data=,key=,res=) /parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;

	%local t keysN;

	%let t=%createTempDs;

	%resCheck(&res,0);
	%let data=%paramAlias(&data,&ds);
	%paramRequired2(&data,&key);

	%getDsObs(ds=&data,res=&tres);%if &&&tres=0 %then %return; 
	%dsVarsRequired(data=&data,vars=&key);
	
	%varsCount(vars=&key,res=&tres);%let keysN=&&&tres;
	%if &keysN=1 %then %do;
		proc sql noprint;
			select count(distinct &key) into :&res from &data;
		quit;
	%end;
	%else %do;
		proc sort data=&data(keep=%unquote(&key)) out=&t nodupkey;
			by %unquote(&key);
		run;quit;
		%getDsObs(ds=&t,res=&res);
	%end;
	%dropDs(&t);
%mend;


* ---------------------------------------------------------;
* ---------------- multi-ds operation macros --------------;
* ---------------------------------------------------------;

* ---- macro dsSame ----;
* 比较两个ds数据是否相同，封装sas proc compare，比较A B两个数据集的差异;
* input;
*	a				ds A;
*	b				ds B;
*	vars			A中比较变量，为空时默认为A中所有变量;
*	varsB			B中比较变量;
*	method			比较方法，对应method参数，默认exact;
*	criterion		比较阈值，默认10E-8;
*	out				差异数据集，格式参见proc compare说明;
*	res				返回比较结果;
*						1		相同;
*						0		不相同;
*	err				返回不同错误原因，2进制16位，对应proc compare的SYSINFO返回结果，共16bit，bit为1时表示错误，为0时表示正常，对应含义如下;
*						1		Data set labels differ;
*						2		Data set types differ;
*						3		Variable has different informat;
*						4		Variable has different format;
*						5		Variable has different length;
*						6		Variable has different label;
*						7		Base data set has observation not in comparison;
*						8		Comparison data set has observation not in base;
*						9		Base data set has BY group not in comparison;
*						10		Comparison data set has BY group not in base;
*						11		Base data set has variable not in comparison;
*						12		Comparison data set has variable not in base;
*						13		A value comparison was unequal;
*						14		Conflicting variable types;
*						15		BY variables do not match;
*						16		Fatal error: comparison not done;
*					由于该结果不易读取，因此会在日志中逐条输出所有存在的错误;
*					上述文本转换使用format为procCompareErrBits;
*					参见:https://www.lexjansen.com/nesug/nesug10/po/po27.pdf;
*	noprint			默认为1，是否通过log与html输出比较结果;

* details;

*	比较异常;
*		dsSame认为

* 	排序逻辑;
*		【注意】	与原始的proc compare不同，dsSame不考虑观测排序差异，因此每次会先对数据集进行排序，排序变量参见后文;
*		由于dsSame每次会强制排序，因此不支持id参数，在proc compare的调用中也不再使用id语句;

*	vars与varsB为空时的处理逻辑;
*		情景						排序变量					比较	变量				
*		vars有，varsB无			按vars排序				vars应为共有变量，比较此变量;
*		vars无，varsB无			按交集排序				按两个数据集的变量交集进行比较;
*		vars有，varsB有			按vars、varsB分别排序	vars与varsB应为一一对应;
*		vars无，varsB有									不允许，报错;

*	比较结果输出;
*		dsSame通过以下几种方式输出比较结果;
*			out			比较结果数据集，只输出差异;
*			res			01方式输出比较结果，仅当值有差异时为0，其他情况为1;
*			err			输出sysinfo的错误bits;
*			html		输出比较结果汇总，不包括具体数据比较;
*			log			输出差异类型;
* test;
*	@test_dsSame;

%macro dsSame(a=,b=,vars=,varsB=,out=,method=,criterion=,noprint=,res=,err=);
	%local tres;%let tres=%createTempVar;%local &tres;

	%local t_a t_b t_out;
	%local id idA idB;
	%local varsNA varsNB;
	%local errBits errN errLog errObs i;
	%local stmt_var stmt_with stmt_criterion stmt_noprint;
	%global sysinfo;
	
	%let t_out=%createTempDs;
	%let t_a=%createTempDs;
	%let t_b=%createTempDs;

	* 参数检查;
	%paramRequired2(&a,&b);
	%let out=%nonBlank(&out,&t_out);
	%let method=%nonBlank(&method,EXACT);
	%let noprint=%nonBlank(&noprint,1);
	%resSet(&res,0);
	%resSet(&err);

	%if %isBlank(&criterion) %then %let stmt_criterion=%quote(criterion=0.000001);
	%if %upcase(&method)=EXACT %then %let stmt_criterion=%str();
	%if &noprint=1 %then %let stmt_noprint=NOPRINT;

	%if %isBlank(&vars) %then %do;
		%getDsVarList(ds=&a,res=&tres);%let vars=&&&tres;
		%getDsVarList(ds=&b,res=&tres);%let varsB=&&&tres;
		%varsAnd(a=&vars,b=&varsB,res=&tres);%let id=&&&tres;
		%let idA=&id;
		%let idB=&id;
		%let stmt_var=;
		%let stmt_with=;
	%end;
	%else %if %isBlank(&varsB) %then %do;
		%let varsB=&vars;
		%let idA=&vars;
		%let idB=&vars;
		%let stmt_var=%quote(var &vars);
		%let stmt_with=;
	%end;
	%else %do;
		%varsCount(vars=&vars,res=&tres);%let varsNA=&&&tres;
		%varsCount(vars=&varsB,res=&tres);%let varsNB=&&&tres;
		%if %sysevalf(&varsNA ne &varsNB) %then %error(VARS and VARSB does not match!);
		%let idA=&vars;
		%let idB=&varsB;
		%let stmt_var=%quote(var &vars);
		%let stmt_with=%quote(with &varsB);
	%end;

	* A B数据集检查;
	%dsVarsRequired(data=&a,vars=&vars &idA);
	%dsVarsRequired(data=&b,vars=&varsB &idB);
	
	* id语句处理;
	proc sort data=&a out=&t_a force;
		by %unquote(&idA);
	quit;
	proc sort data=&b out=&t_b force;
		by %unquote(&idB);
	quit;

	* 比较;
	%if &noprint=0 %then %do;
		title "DSSAME &a vs &b";
	%end;
	proc compare base=&t_a compare=&t_b method=&method %unquote(&stmt_criterion) out=&out OUTBASE OUTCOMP OUTNOEQUAL NODATE NOVALUES &stmt_noprint;
		%unquote(&stmt_var);
		%unquote(&stmt_with);
	quit;
	
	* sysinfo结果处理;
	%let errBits=%padding(str=%numToBin(&sysinfo),mode=left,char=0,len=16);
	%if &noprint=0 %then %do;	
		%let errN=0;
		%do i=1 %to 16;
			%if %substr(&errBits,%eval(16-&i+1),1)=1 %then %do;
				%let errLog=%putn(&i,procCompareErrBits);
				%let errN=&errN + 1;
				%linfo(&errLog);
			%end;
		%end;
		%if errN=0 %then %linfo(No diff found!);
	%end;

	* res err output;
	%getDsObs(ds=&out,res=&tres);%let errObs=&&&tres;
	%if &errObs=0 %then %resSet(&res,1);
	%resSet(&err,&errBits);

	* 资源释放;
	%dropDs(&t_a &t_b &t_out);

%mend;


* ---- macro filter ----;
* 表过滤宏;
* 使用索引变量对表进行黑/白名单过滤或拼接;
* input;
*	data			目标表;
*	filter			过滤表，当filter不存在或无观测时，不过滤;
*	out				结果表;
*	outComp			out的互补表，即outComp = data - out;
*	outAll			out + outComp;
*					out与outComp一般用于“过滤”场景，outAll用于类似leftjoin的“拼接”场景;
*					上述三个out中，至少应有一个非空;
*	matchStmt		当filter匹配时执行的data语句;
*	unmatchStmt		当filter没有匹配时执行的data语句;
*					注意：match与unmatch的执行取决于是否在filter中发现匹配的记录，与过滤方式（黑或白名单）无关;
*	key				filter表索引变量，data按key变量在filter中搜索匹配变量，vars格式;
*	indexVar		key别名;
*					当为空时，默认为filter中的所有变量;
*					data、filter表中必须包含所有indexVar，如果不满足则不进行过滤操作，同时提示警告信息;
*	where			where过滤条件，filter将首先使用where参数对目标表进行过滤;
* 	keep			filter表中保留的变量;
*	isBlacklist		默认为1，表示为黑名单过滤
*						黑名单		对于filter表中的所有keys，data表中具有相同keys的观测被从data中删除，结果为out，删除部分为outComp;
*						白名单		对于filter表中的所有keys，data表中具有相同keys的观测被保留，保留结果为out，删除部分为outComp;
*	res				返回变量，被删除的观测个数;

* details;

*	输出表模式;
*		filter最多有三个输出表，分别为过滤结果（out）、过滤掉的部分（outComp）以及全量（outAll）;
*			out与outComp一般用于过滤场景;
*			outAll配合matchStmt与unmatchStmt，一般用于类似leftjoin的数据拼接;
*		注意data可以与out、outComp或outAll相同，但不可以同时与其中两个相同;
*		除非与data相同，否则输出表都将在执行前被删除;
*		若filter为空或不存在，则data会被原样复制到out与/或outAll;

*	数据缺失情况的处理机制（顺序）;
*		data不存在								不处理;
*		data零观测								不过滤，直接copyDs;
*		data正常，filter不存在或0观测				不过滤，直接copyDs;		
*		indexVar不全部在filter与data中			error;

*	keep的拼接作用机制;
*		keep指在filter表中保留的变量（即在拼接场景下，所要拼接的变量）;
*		keep默认为空，此时filter表仅检查保留indexVar，即没有“拼接”的效果;
*		当keep非空时，此时filter具有类似于leftjoin的效果，会将filter表中的额外的（keep）变量通过映射关系，保存到输出表中;
*		当过滤模式为白名单时，outComp中的keep变量均为缺失，当过滤模式为黑名单时，out中的所有keep变量均为缺失;
*		一般keep只在白名单或拼接模式下使用;
*		当keep变量在data中也存在时，filter表中的值会覆盖原data中的值;
*		当keep变量在data中也存在时，务必保持该变量在data与filter表中的类型、长度相同，否则会导致错误或截取;
*		SAS将所有set读入变量设置为retain，与filter的一般应用逻辑存在差异，因此filter中增加了自动的置缺失操作，对所有的keep变量，在data步运行结束时自动置缺失;
*		从而保证对于第k个观测匹配，第k+1个观测不匹配时，keep变量输出正常（即为缺失，而非前一个观测匹配的keep变量）;

*	filter vs leftjoin;
*		filter在拼接模式下与leftjoin效果类似，二者的主要区别在于，当data中的一个观测匹配成功filter中的k个观测时;
*		leftjoin输出的是k个观测，而filter输出的是1个观测（匹配的第一个）;

* test;
*	@test_filter;

%macro filter(data=,filter=,out=,outComp=,outAll=,key=,indexVar=,keep=,where=,isBlacklist=,matchStmt=,unmatchStmt=,res=) /parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;

	%local whereStr dataObas filterObs outObs err;
	%local filterVars dataVars;
	%local notInDataKeepVars callMissingStmt;
	%local indexName;

	%resSet(&res,0);
	%let indexVar=%nonBlank(&key,&indexVar);
	%let isBlacklist=%nonBlank(&isBlacklist,1);
	%paramRequired3(&data,&filter,&indexVar);
	%if %allBlank(&out,&outComp,&outAll) %then %error(All OUT are empty! &syspbuff);

	
	%if not %isBlank(&where) %then %let whereStr=%str((where=(&where)));
	
	* 输出表清理;
	%if not %dsEqual(&data,&out) %then %dropDs(&out);
	%if not %dsEqual(&data,&outComp) %then %dropDs(&outComp);
	%if not %dsEqual(&data,&outAll) %then %dropDs(&outAll);

	* data与filter数据存在性检查;
	%getDsObs(ds=&data,res=&tres);%let dataObs=&&&tres;
	%getDsObs(ds=&filter,res=&tres);%let filterObs=&&&tres;
	%if &dataObs=0 or &filterObs=0 %then %do;
		%copyDs(data=&data,out=&out);
		%copyDs(data=&data,out=&outAll);
		%return;
	%end;

	* key检查;
	%if %isBlank(&indexVar) %then %do;
		%getDsVarList(ds=&filter,res=&tres);%let indexVar=%unquote(&&&tres);
	%end;
	%checkVars(data=&data,vars=&indexVar,res=&tres);
	%if not %isBlank(&&&tres) %then %error(INDEXVAR &&&tres doesnot exist in DATA! &syspbuff);
	%checkVars(data=&filter,vars=&indexVar,res=&tres);
	%if not %isBlank(&&&tres) %then %error(INDEXVAR &&&tres doesnot exist in FILTER! &syspbuff);
	
	* 索引检查;
	%findIndex(data=&filter,vars=&indexVar,res=&tres);
	%if %isBlank(&&&tres) %then %do;
		* 无索引情况;
		%createIndex(data=&filter,index=&indexName,vars=&indexVar,res=&tres);%let indexName=&&&tres;
	%end;
	%else %do;
		* 有索引情况;
		%let indexName=&&&tres;
	%end;

	* keep变量处理;
	%if not %isBlank(&keep) %then %do;
		* keep变量存在性检查;
		%getDsVarList(ds=&filter,res=&tres);%let filterVars=&&&tres;
		%varsSub(a=&keep,b=&filterVars,res=&tres);
		%if not %isBlank(&&&tres) %then %error(KEEP vars &&&tres doesnot exist in FILTER! &syspbuff);

		* keep变量置缺失语句设置;
		%checkVars(data=&data,vars=&keep,res=&tres);%let notInDataKeepVars=&&&tres;
		%if not %isBlank(&notInDataKeepVars) %then %let callMissingStmt=%quote(%str(
			call missing(%sasVarsToSql(&notInDataKeepVars));
		));
	%end;
	%else %let keep=%str();

	%let err=%createTempVar;
	data &out &outComp &outAll;
		set %unquote(&data.&whereStr);
		drop &err;
		%if &dataObs^=0 and &filterObs^=0 %then %do;
			set &filter(keep=&indexVar &keep) key=&indexName /unique;
			%if &isBlacklist=0 %then %do;
				* 白名单过滤;
				select(_iorc_);
					when(%sysrc(_sok)) do;
						%unquote(&matchStmt);
						%if not %isBlank(&out) %then %do;
							output &out;
						%end;
					end;
					when(%sysrc(_dsenom)) do;
						_error_=0;
						%unquote(&unmatchStmt);
						%if not %isBlank(&outComp) %then %do;
							output &outComp;
						%end;
					end;
					otherwise do;
						&err=dosubl('%error(Unexpected _IORC_ CODE!)');
        			end;
				end;
			%end;
			%else %do;
				* 黑名单过滤;
				select(_iorc_);
					when(%sysrc(_sok)) do;
						%unquote(&matchStmt);
						%if not %isBlank(&outComp) %then %do;
							output &outComp;
						%end;
					end;
					when(%sysrc(_dsenom)) do;
						_error_=0;
						%unquote(&unmatchStmt);
						%if not %isBlank(&out) %then %do;
							output &out;
						%end;
					end;
					otherwise do;
						&err=dosubl('%error(Unexpected _IORC_ CODE!)');
        			end;
				end;
			%end;
		%end;
		* 全量表输出;
		%if not %isBlank(&outAll) %then %do;
			output &outAll;
		%end;
		* keep变量置缺失;
		%unquote(&callMissingStmt);
	run;

	%getDsObs(ds=&out,res=&tres);%let outObs=&&&tres;
	%resSet(&res,%eval(&dataObs-&outObs));
%mend;



* ---- macro split ----;
* 将表格按指定变量（按分组变量或按输出位置）拆分为多个子表;
*	data			拆分目标，必输;	
*	by				拆分分组变量，vars格式，除OBS模式以外为必输;
*	key				by别名;
*	outlib			输出的lib，默认为data所在lib;
*	outTablePrefix	输出表格名称前缀，选输;
*	outTableSuffix	输出表格名称后缀，选输;
*	outPrefix		输出的前缀，选输，格式如：temp.scores;
*					outPrefix等价于outLib.outTablePrefix，优先级高于outLib与outTablePrefix;
*	useVarName		是否在合成文件名中包含分组变量名，默认为1;
*					1					输出表名为VARA_1_VARB_2;
*					0 					输出表名为1_2;
*	keepByVar		是否在拆分后的文件中保存用于分组的变量，默认为1;
*					1					保留;
*					0					不保留;
*	method			拆分模式，具体说明参见details;
*					OBS					逐观测指定;
*					DIRECT				直接指定;
*					SIMPLE				简单拼接，默认模式;
*					HASH				hash拼接;
*	outSetting		分组的拆分设置，包含以下参数;
*					[by]				分组变量;
*					_out_				输出数据集名称,lib.table格式;
*					_outLib_			输出的lib;
*					_outTableSuffix_	输出的table后缀;
*					_outTablePrefix_	输出的table前缀;
*	result			分组拆分时的输出结果，格式与outSetting基本相同;
*					_out_				实际拆分子表的名称;
*					_count_				实际拆分子表的观测数;
* details;

*	拆分模式;
*					拆分颗粒度			输出指定方式;
*		OBS			按观测				逐观测指定输出的目标，通过data中的_out_变量来说明输出的目标;
*		DIRECT		按分组变量			通过outSetting中的[by]指定分组变量的值，_out_指定该组对应的输出目标;
*		SIMPLE		按分组变量			例如：表X包含变量type，值为A|B|C，拆分成三个表:X_TYPE_A，X_TYPE_B，X_TYPE_C;
*		HASH		按分组变量			SIMPLE模式在分组变量是多个变量或值较长时，容易超过32位的表名长度限制，HASH模式的表名为使用分组的hash来避免这一问题;

*	分组拆分逻辑;
*		对于分组拆分模式，拆分都是以outSetting表为拆分依据，对每个观测匹配相应的输出目标，当outSetting未提供时，将按照提供的out类参数自动生成;
*		DIRECT、SIMPLE、HASH三种方式的差异仅在于其输出表名的生成逻辑不同（直接指定、简单拼接、拼接后的HASH值）;
*		宏参数outlib，outTablePrefix，outTableSuffix，outPrefix等与outSetting表中的对应变量相同，是表中对应变量的默认值;
*		例如：_outlib_，对于给定分组，如果其_outlib_值为空，则使用参数outlib来填充;

*	分组拆分表名生成逻辑(示例);
*		假设数据DATA包含分组变量GROUP、TYPE，值分别为1|2|3，与A|B|C;
*		outlib=local, outTablePrefix=PRE_, outTableSuffix=_SUF;
*			SIMPLE模式		'local.PRE_GROUP_1_TYPE_B_SUF';
*			HASH模式			'local.PRE_S' + md5base32('GROUP_1_TYPE_b') + '_SUF';
*							注意:分组变量的名称均为大写，变量的值根据实际值来确定;

*	不输出的观测;
*		OBS模式		如果data中的_OUT_缺失，则该观测将不被输出;
*		分组模式		如果outSetting中的_OUT_缺失，或data中的某个分组在outSetting中不存在，则该组不会被输出;	

* test;
*	@test_utili_ds_multi_split;
%macro split(data=,method=,by=,key=,outLib=,outPrefix=,outTablePrefix=,outTableSuffix=,outSetting=,result=,useVarName=,keepByVar=) /parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;

	%local vars var varsN;
	%local outs out outsN;
	%local i;
	%local t_outSetting t_setting t_main;
	%local d_main;
	%local tableMain;
	%local stmt_when stmt_drop;

	%let t_outSetting=%createTempDs;
	%let t_setting=%createTempDs;
	%let t_main=%createTempDs;

	* 参数检查;
	%paramRequired(&data);
	%let by=%paramAlias(&by,&key);
	%let outLib=%nonBlank(&outLib,%getLibName(&data));
	%let method=%upcase(%nonBlank(&method,SIMPLE));
	%let outSetting=%nonBlank(&outSetting,&t_outSetting);
	%let useVarName=%nonBlank(&useVarName,1);
	%let keepByVar=%nonBlank(&keepByVar,1);
	%if not %isBlank(&outPrefix) %then %do;
		%let outLib=%getLibName(&outPrefix);
		%let outTablePrefix=%getTableName(&outPrefix);
	%end;
	
	%if &keepByVar=0 %then %let stmt_drop=&by;

	* 分模式进行处理;
	%if &method=SIMPLE or &method=HASH or &method=DIRECT %then %do;

		* 参数检查;
		%if %isBlank(&by) %then %error(BYVARS doesnot exist! &syspbuff);
		%let vars=%upcase(&by);
		%checkVars(data=&data,vars=&vars,res=&tres);%if not %isBlank(&&&tres) %then %error(VARS &&&tres doesnot exist! &syspbuff);
		%varsSort(vars=&vars,res=&tres);%let vars=&&&tres;
		%varsCount(vars=&vars,res=&tres);%let varsN=&&&tres;

		* 配置数据集检查;
		%if &method=DIRECT %then %do;
			%if not %dsExist(&outSetting) %then %error(OUTSETTING doesnot exist! &syspbuff);
			%checkVars(data=&outSetting,vars=&vars _out_,res=&tres);%if not %isBlank(&&&tres) %then %error(VARS &&&tres doesnot exisit in OUTSETTING! &syspbuff); 
		%end;

		* 配置数据集生成;
		%if not %dsExist(&outSetting) %then %do;
			proc sql;
				create table &outSetting as (
					select %sasVarsToSql(&vars),count(*) as _count_ 
					from &data
					group by %sasVarsToSql(&vars)
				);
			quit;
		%end;

		* 配置数据集调整准备 - 变量名称拼接;
		%if &method=SIMPLE or &method=HASH %then %do;
			%if &useVarName=1 %then %do;
				%do i=1 %to &varsN;
					%varsN(vars=&by,n=&i,res=&tres);%let var=%upcase(&&&tres);
					%if &i=1 %then %let tableMain=%quote(%str("&var._",&var));
					%else %let tableMain=&tableMain %quote(%str(,"_&var._",&var));
				%end;
			%end;
			%else %do;
				%do i=1 %to &varsN;
					%varsN(vars=&by,n=&i,res=&tres);%let var=%upcase(&&&tres);
					%if &i=1 %then %let tableMain=&var;
					%else %let tableMain=&tableMain %quote(%str(,"_",&var));
				%end;
			%end;
			%if &method=SIMPLE %then %let tableMain=cats(&tableMain);
			%else %let tableMain=cats('S',md5base32(cats(&tableMain)));
		%end;

		* 配置数据集调整;
		%let &tres=0;
		data &t_setting;
			length _outLib_ _outTable_ _outTablePrefix_ _outTableSuffix_ _outTableMain_ _out_ $ 100;
			set &outSetting;

			%if &method=SIMPLE or &method=HASH %then %do;
				if missing(_outLib_) then _outlib_=strip("&outLib");
				if missing(_outTablePrefix_) then _outTablePrefix_=strip("&outTablePrefix");
				if missing(_outTableSuffix_) then _outTableSuffix_=strip("&outTableSuffix");

				_outTableMain_=%unquote(&tableMain);
				_outTable_=cats(_outTablePrefix_,_outTableMain_,_outTableSuffix_);
				_out_=cats(_outLib_,'.',_outTable_);

			%end;
			if length(_outTable_)>32 or length(_outLib_)>8 or length(_out_)>41 then do;
				call symput("&tres",1);
				put _all_;
				stop;
			end;
			if missing(_out_) then delete;
		run;
		%if &&&tres %then %error(The name of output target datset is invalid! &syspbuff);

		* 生成拆分语句与拆分目标;
		proc sql noprint;
			select _out_ into :&tres separated by ' ' from &t_setting;
		quit;
		%let outs=&&&tres;
		%varsCount(vars=&outs,res=&tres);%let outsN=&&&tres;
		%if &outsN=0 %then %error(No valid output target! &syspbuff);
		%do i=1 %to &outsN;
			%varsN(vars=&outs,n=&i,res=&tres);%let out=&&&tres;
			%let stmt_when=&stmt_when %quote(%str(
				when("&out") do;output &out;end;
			));
		%end;

		* 数据过滤与_out_拼接;
		%filter(data=&data,filter=&t_setting,indexVar=&vars,keep=_out_,isBlacklist=0,out=&t_main);
		%let d_main=&t_main;

		* 配置数据返回;
		%if not %isBlank(&result) %then %copyDs(data=&t_setting,out=&result);
	%end;
	%else %if &method=OBS %then %do;
		* 参数检查;
		%checkVars(data=&data,vars=_out_,res=&tres);%if not %isBlank(&&&tres) %then %error(_OUT_ doesnot exist! &syspbuff);

		* 生成拆分语句与拆分目标;
		proc sql noprint;
			select distinct(_out_) into :&tres separated by ' ' from &data;
		quit;
		%let outs=&&&tres;
		%varsCount(vars=&outs,res=&tres);%let outsN=&&&tres;
		%if &outsN=0 %then %error(No valid output target! &syspbuff);
		%do i=1 %to &outsN;
			%varsN(vars=&outs,n=&i,res=&tres);%let out=&&&tres;
			%let stmt_when=&stmt_when %quote(%str(
				when("&out") do;output &out;end;
			));
		%end;
		%let d_main=&data;
	%end;
	%else %error(METHOD is not supported! &syspbuff);

	* 数据拆分执行;
	data %unquote(&outs);
		drop _out_ %unquote(&stmt_drop);
		set &d_main;
		if missing(_out_) then delete;
		select(_out_);
			%unquote(&stmt_when)
			otherwise do;
			end;
		end;
	run;

	* 环境清理;
	%dropDs(&t_outSetting &t_setting &t_main);
%mend;



* ---- macro merge ----;
* 将多表合并为一个表（横向合并）;
* input;
*	tables/data			待连接表，vars格式;
*	by					合并的索引变量，vars格式;
*	key					by别名;
*	out					输出表，支持dataOption;
*	defaultValue		默认值，assigns格式，当defaultValue为空时，不进行默认值修正;
* details;
*	合并实现;
*		merge是用data step中的merge+索引方式进行合并;
*		合并细节参见http://support.sas.com/documentation/cdl/en/lestmtsref/63323/HTML/default/viewer.htm#n1i8w2bwu1fn5kn1gpxj18xttbb0.htm;
*	key唯一性要求;
*		merge对key没有唯一性要求，key重复时的具体处理方法，参见merge说明;
*		merge在key非唯一时的对多观测的合并结果受排序结果影响，其中存在不确定性;
*	tables中ds重复出现;
*		tables允许存在重复的ds（即一个ds出现多次），会按独立ds处理;
*	多个ds中重复的变量;
*		重复变量将按“后面优先”原则，按tables中的出现，越后面的优先级越高（覆盖前面的）;
*	默认值的使用;
*		默认值针对合并过程中因未找到匹配观测而导致相应变量为空的情况;
*		例如：表A、B按ID合并，其中表B中包含变量name，A中包含ID=0001的观测，但B中不包含ID=00001的观测;
*		这时，如果设置了变量name的默认值，则对于该观测使用默认值来填充;
*		默认值的格式为assigns，即：defaultValue=%str(name='0001');
* test;
*	@test_merge;
%macro merge(tables=,data=,out=,by=,key=,defaultValue=) /parmbuff;

	%local tres;%let tres=%createTempVar;%local &tres;

	%local table tablesN;
	%local i;
	
	%let key=%paramAlias(&by,&key);
	%let tables=%paramAlias(&tables,&data);
	%paramRequired3(&tables,&out,&key);
	%varsCount(vars=&tables,res=&tres);%let tablesN=&&&tres;
	%do i=1 %to &tablesN;
		%varsN(vars=&tables,n=&i,res=&tres);%let table=&&&tres;
		%checkVars(data=&table,vars=&key,res=&tres);%if not %isBlank(&&&tres) %then %error(VARS &&&tres doesnot exist in DATA &table!);
		%createIndex(data=&table,vars=&key);
	%end;
	
	data %unquote(&out);
		merge %unquote(&tables);
		by %unquote(&key);
	run; 

	%if not %isBlank(&defaultValue) %then %do;
		%useDefaultValue(data=%getDataMain(&out),defaultValue=&defaultValue);
	%end;

%mend;


* ---- macro useDefaultValue ----;
* 对表中的缺失值使用默认值进行修复;
* input;
*	data			输入数据集;
*	out				输出数据集;
*	defaultValue	默认值，assigns格式，注意字符变量的默认值应使用单引号;
*					例如: NAME='NULL' GENDER=0 VALUE=1;
*	vars			默认值适用变量范围，默认为所有变量;
* details;
*	默认值设定的变量可以多于data中的实际变量，useDefaultValue会自动匹配适用的默认值;
*	对于字符型变量，useDefaultValue会根据默认值的宽度自动调整原数据集的变量长度，以保证默认值完整呈现;
* test;
*	@test_defaultValue;
%macro useDefaultValue(data=,out=,defaultValue=,vars=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local script;
	%local dataVars;
	%local i strVars strVarsN var;
	%local dvLen;

	%if not %dsExist(&data) %then %error(DATA doesnot exist!);
	%if %isBlank(&defaultValue) %then %return;
	%if %isBlank(&out) %then %let out=&data;

	* generate assignment scripts for default value;
	%getDsVarList(ds=&data,res=&tres);%let dataVars=&&&tres;
	%if not %isBlank(&vars) %then %do;
		%varsAnd(a=&dataVars,b=&vars,res=&tres);%let vars=&&&tres;
	%end;
	%defaultValueToScript(defaultValue=&defaultValue,vars=&vars,res=&tres);%let script=&&&tres;

	* check length of string variable; 
	%getDsStrVarList(data=&data,res=&tres);%let strVars=&&&tres;
	%varsCount(vars=&strVars,res=&tres);%let strVarsN=&&&tres;
	%do i=1 %to &strVarsN;
		%varsN(vars=&strVars,n=&i,res=&tres);%let var=&&&tres;
		%assignsFind(assigns=&defaultValue,var=&var,res=&tres);%let dvLen=%length(&&&tres);
		%if &dvLen>0 %then %setDsVarLen(data=&data,var=&var,len=&dvLen);
	%end;
	
	* run scripts;
	data &out;
		set &data;
		%unquote(&script);
	run;
%mend;


* ---- macro defaultValueToScript ----;
* 将defaultValue转换为data step赋值语句，配合useDefaultValue使用;
* defaultValue是assign格式的字符串，其中等号左侧为变量名，右侧为默认值;
* 默认值必须是数值或字符串，其中字符串应包含引号;
* input;
*	defaultValue	默认值;
*	vars			vars范围限定;
*	res				返回引用;
* test;
*	@test_defaultValue;
%macro defaultValueToScript(defaultValue=,vars=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local dv dvsN;
	%local i;
	%local s;
	%local var value;
	%let s=%str();
	%if not %refExist(&res) %then %error(RES doesnot exist!);
	%let &res=%str();
	%if %isBlank(&defaultValue) %then %return;
	%varsCount(vars=&defaultValue,res=&tres);%let dvsN=&&&tres;
	%do i=1 %to &dvsN;
		%varsN(vars=&defaultValue,n=&i,res=&tres);%let dv=&&&tres;
		%let var=%getAssignVar(&dv);
		%let value=%getAssignValue(&dv);
		%if not %isBlank(&vars) %then %do;
			%varsExist(source=&vars,target=&var,res=&tres);
			%if &&&tres %then %let s=&s %str(if missing(&var) then &dv;);
		%end;
		%else %do;
			%let s=&s %str(if missing(&var) then &dv;);
		%end;
	%end;

	%let &res=&s;
%mend;


* ---- macro concate ----;
* 多表连接宏（纵向合并）;
* input;
*	tables/data		目标表，vars格式;
*					对于data中不存在的表，将不进行处理;
*	out				输出表，必输;
*	mode			输出表的变量确定方式;
*						SAFE	所有数据表的变量的交集;
*						FIRST	首个数据表的所有变量，默认;
*						ALL		所有数据表的所有变量;
*	vars			输出表变量白名单，vars格式;
*					最终输出的变量等于根据合并规则合并的各表变量与vars参数白名单的交集;
* details;
*	表连接的实现;
*		concate使用set进行多个表的连接操作;
*	对于输入“空表”的处理逻辑;
*		如果该表不存在，则该表完全不会被处理;
*		如果该表存在但观测为0，则根据不同MODE，其表结构（变量）会影响输出表的结构（变量）;
*		如果所有表均不存在或观测为0，则会将out删除;
*	FIRST模式下的特殊要求;
*		在FIRST模式下，如果首个表为空，则会报错;
* test;
*	@test_concate;
%macro concate(tables=,data=,out=,vars=,mode=) /parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;

	%local table tablesN;
	%local dsVars;	
	%local var;
	%local nonEmptyTables nonEmptyTablesN;
	%local allDsVars allDsVarsN;
	%local obs;
	%local i j;
	%local isFirstNonEmpty;
	%local type varLen len stmt_length;

	%let isFirstNonEmpty=1;

	%let tables=%paramAlias(&tables,&data);
	%paramRequired2(&tables,&out);
	%let mode=%upcase(%nonBlank(&mode,FIRST));

	%varsCount(vars=&tables,res=&tres);%let tablesN=&&&tres;

	* 表格存在性检查与确定保存变量清单;
	%do i=1 %to &tablesN;
		%varsN(vars=&tables,n=&i,res=&tres);%let table=&&&tres;
		%getDsVarList(ds=&table,res=&tres);%let dsVars=&&&tres;
		%if not %isBlank(&dsVars) %then %do;
			%let nonEmptyTables=&nonEmptyTables &table;
			%if &mode=ALL %then %do;
				* ALL mode;
				%varsOr(a=&allDsVars,b=&dsVars,res=&tres);%let allDsVars=&&&tres;
			%end;
			%else %if &mode=SAFE %then %do;
				* SAFE mode;
				%if &isFirstNonEmpty=1 %then %do;
					%let allDsVars=&dsVars;
					%let isFirstNonEmpty=0;
				%end;
				%else %do; 
					%varsAnd(a=&allDsVars,b=&dsVars,res=&tres);%let allDsVars=&&&tres;
				%end;
			%end;
			%else %do;
				* FIRST mode;
				%if &i=1 %then %let allDsVars=&dsVars; 
			%end;
		%end;
		%else %if &i=1 and &mode=FIRST %then %error(In FIRST mode the first table cannot be empty! &syspbuff);
	%end;

	* allDsVars的内容;
	*	ALL		全变量清单;
	*	SAFE	所有非空表的变量的交集;
	*	FIRST	首表的变量;

	%if %isBlank(&nonEmptyTables) %then %do;
		%return;
	%end;

	%if not %isBlank(&vars) %then %do;
		%varsAnd(a=&vars,b=&allDsVars,res=&tres);%let allDsVars=&&&tres;
	%end;
	%if %isBlank(&allDsVars) %then %error(No var to output! &syspbuff);
	
	* 字符变量长度调整;
	%varsCount(vars=&allDsVars,res=&tres);%let allDsVarsN=&&&tres;
	%varsCount(vars=&nonEmptyTables,res=&tres);%let nonEmptyTablesN=&&&tres;

	%do i=1 %to &allDsVarsN;
		%varsN(vars=&allDsVars,n=&i,res=&tres);%let var=&&&tres;
		
		%let varLen=0;
		%do j=1 %to &nonEmptyTablesN;
			%varsN(vars=&nonEmptyTables,n=&j,res=&tres);%let table=&&&tres;

			%getDsVarType(ds=&table,var=&var,res=&tres);%let type=&&&tres;
			%if &type=2 %then %do;
				%getDsVarLen(ds=&table,var=&var,res=&tres);%let len=&&&tres;
				%if not %isBlank(&len) %then %let varLen=%max(&varLen,&len);
			%end;
		%end;

		%if not %isBlank(&varLen) and &varLen>0 %then %do;
			%let stmt_length=&stmt_length %quote(&var $ &varLen);
		%end;
	%end;

	* 表合并;
	data &out;
		%if not %isBlank(&stmt_length) %then %do;
			length %unquote(&stmt_length);
		%end;
		keep %unquote(&allDsVars);
		set %unquote(&nonEmptyTables);
	run;
	
%mend;


* ---- macro sqljoin ----;
* 左连接函数，支持多表连接、支持默认值功能;
* input;
*	type				连接方式，支持的方式包括LEFT、INNER、OUTER、FULL（与OUTER含义相同）;
*						默认为LEFT;
*	tables				待连接的表，按其输入顺序连接;
*	key					连接变量，vars格式;
*	out					输出表，如果为空则为tables第一个表;
*	defaultValue		默认值，格式为assigns;
*						左连接完成后，对于缺失值，将自动使用defaultValue中的值进行填充;
* details;
*	多个表中包含的同名变量;
*		sqljoin将输出所有被合并表中的所有变量;
*		多个表中存在同名变量时，将按“前面优先”原则（与merge相反），按tables中的出现，越前面的优先级越高;
*	key变量的输出;
*		前述“前面优先”原则，对于key变量同样适用，因此对于outerjoin;
*			1 输出表中的key变量不是所有输入表中key变量的“全集”（这一点与merge不同）;
*			2 所有来自第一个表之外的key，其在输出中的key值都是缺失（因为该值取自第一个表，但第一个表中并没有这些key值）;
*		以上问题示例参见测试用例;
* test;
*	@test_sqljoin;

%macro sqljoin(type=,tables=,key=,out=,defaultValue=)/parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;
	
	%local i j;
	%local tablesN t;
	%local keyN k;
	%local ht hb;
	%local stmt_join stmt_on;
	%local tempDs;


	* 参数检查;
	%paramRequired2(&tables,&key);
	%varsCount(vars=&key,res=&tres);%let keyN=&&&tres;
	%varsCount(vars=&tables,res=&tres);%let tablesN=&&&tres;
	%if &tablesN < 2 %then %error(TABLES must be ge 2!);
	%let type=%upcase(%nonBlank(&type,LEFT));
	%if not(&type in LEFT INNER OUTER FULL) %then %error(JOIN TYPE &type is not supported!);
	%if &type=OUTER %then %let type=FULL;

	%if %isBlank(&out) %then %let out=%varsK(&tables,1);
	
	* 数据检查与语句生成;
	%do i=1 %to &tablesN;
		%varsN(vars=&tables,n=&i,res=&tres);%let t=&&&tres;
		%checkVars(data=&t,vars=&key,res=&tres);%if not %isBlank(&&&tres) %then %error(VARS &&&tres doesnot exist in &t!);

		* 表名hash处理;
		%let ht=%substr(H%md5base32(%upcase(%getTableName(&t))),1,16);

		* 输出同名表检查;
		%if %dsEqual(&t,&out) %then %do;
			%copyDs(data=&t,out=&ht);
			%let t=&ht;
			%let tempDs=&tempDs &ht;
		%end;

		* join code generaion;
		%if &i=1 %then %do;
			%let hb=&ht;
			%let stmt_join=%quote(&t as &hb);
		%end;
		%else %do;
			%let stmt_on=1;
			%do j=1 %to &keyN;
				%varsN(vars=&key,n=&j,res=&tres);%let k=&&&tres;
				%let stmt_on=&stmt_on %quote(and &hb..&k=&ht..&k);	
			%end;
			%let stmt_join=&stmt_join &type join &t as &ht on (&stmt_on);
		%end;
	%end;

	* 代码执行;
	%logOff;
	proc sql noprint;
		create table %unquote(&out) as (
			select * 
			from %unquote(&stmt_join)
		);
	quit;
	%logOn;

	* 默认值处理;
	%if not %isBlank(&defaultValue) %then %useDefaultValue(data=&out,out=&out,defaultValue=&defaultValue);
	
	* 资源释放;
	%dropDs(&tempDs);
%mend;


* ---- macro leftJoin ----;
* leftjoin;
* test;
*	@test_sqljoin;
%macro leftjoin(tables=,key=,out=,defaultValue=);

	%sqljoin(type=LEFT,tables=&tables,key=&key,out=&out,defaultValue=&defaultValue);

%mend;

* ---- macro innerJoin ----;
* innerjoin;
* test;
*	@test_sqljoin;
%macro innerjoin(tables=,key=,out=,defaultValue=);

	%sqljoin(type=INNER,tables=&tables,key=&key,out=&out,defaultValue=&defaultValue);

%mend;

* ---- macro outerJoin ----;
* outerjoin;
* test;
*	@test_sqljoin;
%macro outerjoin(tables=,key=,out=,defaultValue=);

	%sqljoin(type=OUTER,tables=&tables,key=&key,out=&out,defaultValue=&defaultValue);

%mend;


* -------------------------------------------------;
* ---------------- Index macros ------------------;
* -------------------------------------------------;
* index系列宏主要封装索引管理相关功能;


* ---- macro getIndexName ----;
* 根据索引变量生成索引名;
* 规则示例;
*	简单索引		索引变量为A，则索引名为A;	
*	复杂索引		索引变量为(A,B,C)，则索引名为:'I' + md5base32('A B C');
* test;
*	@test_getIndexName;
%macro getIndexName(vars=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%resCheck(&res);
	%if %isBlank(&vars) %then %error(VARS is empty!);
	%let vars=%upcase(%strip(&vars));
	%varsCount(vars=&vars,res=&tres);
	%if &&&tres=1 %then %let &res=%unquote(&vars);
	%else %let &res=%unquote(I%md5base32(&vars));
%mend;


* ---- macro countIndex ----;
* 返回数据集索引个数;
* input;
*	data 		目标表;
*	res			返回结果;				
* test;
*	@test_countIndex;
%macro countIndex(data=,res=) /parmbuff;
	%resCheck(&res,0);	
	%if %isBlank(&data) %then %error(Required param is empty!);
	proc sql noprint;
		select count(unique indxname) into :&res from sashelp.vindex where libname="%getLibName(&data)" and memname="%getTableName(&data)";
	quit;
%mend;


* ---- macro indexExist ----;
* 检查指定名称的索引是否存在;
* input;
*	data 		目标表;
*	index		索引名;
* test;
*	@test_indexExist;
%macro indexExist(data=,index=,res=) /parmbuff;
	%resCheck(&res,0);	
	%if %isBlank(&data) or %isBlank(&index) %then %error(Required param is empty!);
	proc sql noprint;
		select sign(count(*)) into :&res from sashelp.vindex where upcase(indxname)=upcase("&index") and libname="%getLibName(&data)" and memname="%getTableName(&data)";
	quit;
%mend;


* ---- macro findIndex ----;
* 查找指定变量名所对应的索引名;
* findIndex会对指定的data进行查找，查看是否有包含指定变量名的index，并返回其索引名称;
* input;
*	data 		目标表;
*	vars		索引变量清单，注意顺序有意义;
*	res			返回变量;
* output;
*	res			返回的索引名，如果不存在，则为空;
* details;
*	findIndex基于proc contents返回的index清单进行比较，比较方法为按索引id进行检索;
*	索引id按索引变量md5处理，变量间以"+"分隔;
*	注意content返回清单中的变量名区分大小写;
* test;
*	@test_createIndex;
%macro findIndex(data=,vars=,res=) /parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;

	%local t_indexList;
	%local index indexId;
	%local varsN;
	%local i;
	%local stmt_cats;

	%let t_indexList=%createTempDs;

	* 参数检查;
	%resCheck(&res);
	%if not %dsExist(&data) %then %error(DATA doesnot exist! &syspbuff);
	%if %isBlank(&vars) %then %error(VARS is EMPTY! &syspbuff);
	
	%let data=%getDataMain(&data);
	%let vars=%upcase(&vars);

	%varsCount(vars=&vars,res=&tres);%let varsN=&&&tres;

	* 索引id计算;
	%varsDelimiter(vars=%upcase(%strip(&vars)),delimiter=%str(+),res=&tres);%let indexId=%md5(%str(+)&&&tres); 

	* 提取数据集索引清单;
	proc contents data=&data out2=&t_indexList noprint;
	quit;
	%getDsObs(ds=&t_indexList,res=&tres);
	%if &&&tres=0 %then %do;
		%dropDs(&t_indexList);
		%return;
	%end;

	* 索引检索语句生成;
	%let stmt_cats=%quote('');
	%do i=1 %to &varsN;
		%let stmt_cats=&stmt_cats.%quote(,'+',var&i);
	%end;

	* 提取索引名称;
	%let &tres=%str();
	data _null_;
		set &t_indexList;
		length _indexId_ $ 40;
		if type='Index' and numvars=&varsN then do;
			_indexId_=md5hex(upcase(cats(%unquote(&stmt_cats))));
			if _indexId_="&indexId" then do;
				call symputx("&tres",name);
				stop;
			end;
		end; 
	run;
	%let &res=&&&tres;

	* 资源释放;
	%dropDs(&t_indexList);
%mend;


* ---- macro createIndex ----;
* 索引创建宏;
* input;
*	data 		目标表;
*	index		索引名;
*	vars		索引变量;
*	res			返回变量;
* output;
*	res			如果索引未存在，则为新创建的索引名（指定或自动生成），如果索引已经存在，则为已存在的索引名;
* details;
*	当数据表中已存在相同变量的索引时，createIndex不会重复创建索引;
* test;
*	@test_createIndex;
%macro createIndex(data=,index=,vars=,unique=,res=) /parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;

	%local uniqueOption;
	%let uniqueOption=%str();

	%let data=%getDataMain(&data);
	%if not %dsExist(&data) %then %error(DATA doesnot exist! &syspbuff);
	%if %isBlank(&vars) %then %error(VARS cannot be empty! &syspbuff);
	%if %isBlank(&unique) %then %let unique=0;
	%if &unique=1 %then %let uniqueOption=unique;
	%if %refExist(&res) %then %let &res=%str();

	%findIndex(data=&data,vars=&vars,res=&tres);
	%if %isBlank(&&&tres) %then %do;
		%if %isBlank(&index) %then %do;
			%getIndexName(vars=&vars,res=&tres);%let index=&&&tres;
		%end;
		proc sql noprint;
			create &uniqueOption index &index on &data (%sasVarsToSql(&vars));
		quit;
	%end;
	%else %do;
		%let index=&&&tres;
	%end;
	%if %refExist(&res) %then %let &res=&index;
%mend;


* ---- macro dropIndex ----;
* 索引创建宏;
* input;
*	data 		目标表;
*	index		索引名，当索引名为空时，由vars自动计算索引名;
*	vars		索引变量;
* details;
* 	dropIndex会同时根据索引名和索引变量进行删除操作;
* test;
*	@test_utili_index;
%macro dropIndex(data=,index=,vars=) /parmbuff;
	%dropIndexByVars(data=&data,vars=&vars);
	%dropIndexByName(data=&data,index=&index);
%mend;


* ---- macro dropIndexByVars ----;
* 按索引变量删除索引;
* input;
*	data 		目标表;
*	vars		索引变量;
* test;
*	@utili_index;
%macro dropIndexByVars(data=,vars=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local index;
	%if not %dsExist(&data) or %isBlank(&vars) %then %return;
	%findIndex(data=&data,vars=&vars,res=&tres);%let index=&&&tres;
	%if not %isBlank(&index) %then %do;
		proc sql noprint;
			drop index &index on &data;
		quit;
	%end;
%mend;


* ---- macro dropIndexByName ----;
* 按索引名删除索引;
* input;
*	data 		目标表;
*	index		索引名;
* test;
*	@test_utili_index;
%macro dropIndexByName(data=,index=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%if not %dsExist(&data) or %isBlank(&index) %then %return;
	%indexExist(data=&data,index=&index,res=&tres);
	%if &&&tres %then %do;
		proc sql noprint;
			drop index &index on &data;
		quit;
	%end;
%mend;


* -------------------------------------------------;
* ---------------- Object macros ------------------;
* -------------------------------------------------;

* obj的概念;
*	obj是一种类似object、struct形式的数据结构;
*	obj主要提供给用户方便的操作一组变量的便利;

* obj的一般使用方式;
*	obj创建			调用newObj(members=name type value,res=),其中返回变量为obj的变量名，name type value为对象成员;
* 	obj成员赋值 		%let &obj.type=abc;
* 	obj成员引用 		%let temp=&&&record.type;

* obj的实现方法;
*	一个obj成员变量实质是一个全局变量，其名称分为对象名与成员名两部分;
*	例如：一个包含name,type两个成员的obj是由如下2个全局宏变量组成的;
*		JLZZC21XZ9RZtype;
*		JLZZC21XZ9RZname;
*	其中变量名的前12位是obj名（第1位固定为J），后20位是成员名;
*	obj名称一般是由newObj生成的base32格式随机字符串;
*	obj名本身并不是宏变量，其内容默认为obj名称，例如前面的RLZZC21XZ9RZ就不是一个宏变量;

* obj的用途;
*	obj主要用于需要批量操作变量的场景，例如;
*		作为函数参数传递数据;
*		与数据集进行数据交互，如setDsObj，getDsObj;
 


* ----  newObj -----;
* 根据member列表创建一个obj,对象名将自动创建;
* newObj主要完成所属成员宏变量的声明;
* input;
*	members		vars格式，成员名称列表，必输;
*				成员长度必须小于20个字符，否则将报错;
*				当members为空时，将返回一个有效的对象名称，但不含有任何成员;
*	res			返回变量;
* output;
*	res			创建的obj名;
* details;
*	obj重名检查;
*		newObj的生成的随机obj名不会与已有名称重复;
* test;
*	@test_newObj;

%macro newObj(members=,res=) /parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;

	%local obj vars sw;
	%let sw=1;

	* 参数检查;
	%resCheck(&res);

	* 对象名hash冲突检查;
	%do %while(&sw);
		%let obj=%genId(prefix=J,len=12);
		%getObjMembers(obj=&obj,res=&tres);
		%if %isBlank(&&&tres) %then %let sw=0;
	%end;

	%let &res=&obj;

	* members存在检查;
	%if %isBlank(&members) %then %return;

	* members增加前缀并进行长度检查;
	%varsPrefix(vars=&members,prefix=&obj,res=&tres);%let vars=&&&tres;
	%varsMaxLength(vars=&vars,res=&tres);%if &&&tres>32 %then %error(Length of member exceed 32! &syspbuff);

	* members声明;
	%global %unquote(&vars);
%mend;


* ---- macro G ----;
* 多级对象值提取宏;
* input;
*	path			访问路径;
*					例如：&obj.member.13.type;
* output;
*	return			返回值;
* test;
*	@test_nested;
%macro G(path);
	%local res sw var i parent curr cumPath;
	%let sw=1;
	%let i=2;
	%let parent=%scan(&path,1,%str(.));
	%let cumPath=&parent;
	%if not %globalExist(&parent) %then %error(GLOBAL root.%substr(&cumPath,13) DOES NOT EXIT!);
	%do %while(&sw);
		%let var=%scan(&path,&i,%str(.));
		%let cumPath=&cumPath..&var;
		%if %isBlank(&var) %then %do;
			%let sw=0;
			%global &parent;
			%let res=&&&parent;
		%end;
		%else %do;
			%let curr=&&&parent..&var;
			%if not %globalExist(&curr) %then %error(GLOBAL root.%substr(&cumPath,13) DOES NOT EXIT!);
			%let parent=&curr;
			%let i=%eval(&i+1);
		%end;
	%end;
	&res.
%mend;

* ---- macro L ----;
* 多级对象值设置宏;
* input;
*	path			访问路径;
*					例如：&obj.member.13.type;
*	value			设置值;
* output;
*	return			0;
* test;
*	@test_nested;
%macro L(path,v);
	%local res sw var i parent curr cumPath;
	%let sw=1;
	%let i=2;
	%let parent=%scan(&path,1,%str(.));
	%let cumPath=&parent;
	%if not %globalExist(&parent) %then %error(GLOBAL root.%substr(&cumPath,13) DOES NOT EXIT!);
	%do %while(&sw);
		%let var=%scan(&path,&i,%str(.));
		%let cumPath=&cumPath..&var;
		%if %isBlank(&var) %then %do;
			%let sw=0;
			%global &parent;
			%let res=&parent;
		%end;
		%else %do;
			%let curr=&&&parent..&var;
			%if not %globalExist(&curr) %then %error(GLOBAL root.%substr(&cumPath,13) DOES NOT EXIT!);
			%let parent=&curr;
			%let i=%eval(&i+1);
		%end;
	%end;
	%let &res=&v;
%mend;



* ---- macro listObj ----;
* 在日志中显式obj成员，与showObj基本相同，展示成员可选;
* input;
*	obj			对象名;
*	members		成员名，默认所有;
*	title		显示内容，默认为obj名;
* output;
*	日志	输出		按字母顺序排序;
* test;
*	@test_newObj;
%macro listObj(obj=,members=,title=);

	%local tres;%let tres=%createTempVar;%local &tres;
	%local members membersN i member objMembers;
	%local strLeft strRight;

	%if %isBlank(&title) %then %let title=OBJ &obj;

	%if %isBlank(&obj) %then %do;
		%lbreak(&title DOES NOT EXIST!);
		%return;
	%end;

	%getObjMembers(obj=&obj,res=&tres);%let ObjMembers=&&&tres;
	%if not %isBlank(&members) %then %do;
		%varsAnd(a=&objMembers,b=&members,res=&tres);%let members=&&&tres;
	%end;
	%else %let members=&objMembers;
	%varsSort(vars=&members,res=&tres);%let members=&&&tres;
	%varsCount(vars=&members,res=&tres);%let membersN=&&&tres;
	%if &membersN=0 %then %do;
		%lbreak(&title IS EMPTY!);
		%return;
	%end;
	%lbreak(&title LIST START);
	%do i=1 %to &membersN;
		%varsN(vars=&members,n=&i,res=&tres);%let member=%unquote(&&&tres);
		%global &obj.&member;
		%let strLeft=%padding(mode=right,str=&member,len=22,char=%str( ),fixed=1);
		%let strRight=%quote(&&&obj.&member);
		%linfo(&strLeft.&strRight.);
	%end;
	%lbreak(&title LIST END);
%mend;


* ---- macro showObj -----;
* listObj简化版;
%macro showObj(obj);
	%listObj(obj=&obj);
%mend;


* ---- macro showAllObj ----;
* 显示所有当前存在的临时全局宏变量，主要用于对象相关的debug与测试，检查是否有未被及时释放的对象;
* 临时宏变量的标准为：宏变量格式符合对象的格式，即以J开头，前12位由数字与大写字母组成，整体大于12个字符;
* 结果将直接输出;
* test;
* 	@test_newObj;
%macro showAllObj;
	%local tres;%let tres=%createTempVar;%local &tres;
	proc sql noprint;
		select name into :&tres separated by ' ' from sashelp.vmacro where scope='GLOBAL' and prxmatch('/^J[A-Z|0-9]{11}\w*/',name) and length(name)>12;
	quit;
	%if %isBlank(&&&tres) %then %linfo(NO OBJ FOUND!);
	%else %linfo(&&&tres);
%mend;


* ---- macro showAllObjs ----;
* showAllObj别名;
%macro showAllObjs;
	%showAllObj;
%mend;


* ---- macro dropObj -----;
* 删除obj;
* test;
*	@test_newObj;
%macro dropObj(obj) /parmbuff;
	%dropGlobalsByPrefix(&obj);
%mend;


* ---- macro getObjMembers ----;
* 获取指定obj的成员;
* input;
*	obj			obj;
*	res			返回变量;
* test;
*	@test_getObjMembers;
%macro getObjMembers(obj=,res=);
	%resCheck(&res);
	%if %isBlank(&obj) %then %return;
	%getMacroVars(prefix=&obj,scope=GLOBAL,noPrefix=1,noDuplicate=1,res=&res);
%mend;

* ---- macro addObjMembers -----;
* 增加对象成员;
* input;
*	obj			obj;
*	member		member;
* test;
* 	@test_getObjMembers;
%macro addObjMembers(obj=,members=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local vars;

	%if %anyBlank2(&obj,&members) %then %return;
	%varsPrefix(vars=&members,prefix=&obj,res=&tres);%let vars=&&&tres;
	%varsMaxLength(vars=&vars,res=&tres);%if &&&tres>32 %then %error(Length of member exceed 32! &syspbuff);
	%global %unquote(&vars);
%mend;


%macro addObjMember(obj=,member=);
	%addObjMembers(obj=&obj,members=&member);
%mend;


* ---- macro dropObjMembers ----;
* 删除对象成员;
* test;
*	@test_getObjMembers;
%macro dropObjMembers(obj=,members=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local vars;

	%if %anyBlank2(&obj,&members) %then %return;
	%varsPrefix(vars=&members,prefix=&obj,res=&tres);%let vars=&&&tres;
	%logOff;
	%dropGlobals(&vars);
	%logOn;
%mend;


%macro dropObjMember(obj=,member=);
	%dropObjMembers(obj=&obj,members=&member);
%mend;


* ---- macro reportObj ----;
* 以ods形式报告obj，一般用于obj成员较多、内容复杂的场景;
* input;
*	obj				对象，必输;
*	members			待展示的成员;
*					为空时为所有成员;
*	title			显示标题;
*					默认为obj的名称;
* test;
*	@test_newObj;

%macro reportObj(obj=,members=,title=);
	%local tres;%let tres=%createTempVar;%local &tres;

	%local members member membersN;
	%local var value;
	%local len maxLen;
	%local t;
	%local i;
	%local stmt_assign;

	%let t=%createTempDs;
	%let maxLen=20;

	* 参数检查;
	%if %isBlank(&obj) %then %error(Required param is empty!);
	%if %isBlank(&title) %then %let title=%quote(Obj &obj Members Report);
	%if %isBlank(&members) %then %do;
		%getObjMembers(obj=&obj,res=&tres);%let members=&&&tres;
	%end;

	%logOff;* 避免VALUE中内容过长导致警告;

	* 成员检索;
	%varsCount(vars=&members,res=&tres);%let membersN=&&&tres;
	%do i=1 %to &membersN;
		%varsN(vars=&members,n=&i,res=&tres);%let member=%unquote(&&&tres);
		%let var=&obj.&member;
		%if %symglobl(&var) %then %do;
			%let value=&&&var;
			%let len=%length(&value);
			%let maxLen=%max(&maxLen,&len);
			%let stmt_assign=&stmt_assign %quote(%str(
				MEMBER="&member";VALUE="&value";output;
			));
		%end;
	%end;
	
	%if %isBlank(&stmt_assign) %then %do;
		%let maxLen=40;
		%let stmt_assign=%quote(%str(
			MEMBER="NULL";VALUE="The obj has no matched obj to report!";output;
		));
	%end;

	data &t;
		length MEMBER $ 32 VALUE $ &maxLen;
		%unquote(&stmt_assign);
	run;

	%logOn;

	%print(data=&t,title=&title);
	%dropDs(&t);
%mend;


* ---- macro cloneObj -----;
* 创建一个obj的克隆;
* input;
*	obj			目标obj;
*	res			返回变量;
* output;
*	res			复制的record名;
* details;
*	当目标obj不存在时，cloneObj返回一个空的obj;
* test;
*	@test_cloneObj;

%macro cloneObj(obj=,res=) /parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;

	%local members membersN member;
	%local i;
	%local newRecord;

	%resCheck(&res);
	%if %isBlank(&obj) %then %error(OBJ is EMPTY! param=&syspbuff);

	* 成员变量创建;
	%getObjMembers(obj=&obj,res=&tres);%let members=&&&tres;
	%newObj(members=&members,res=&tres);%let newObj=&&&tres;
	%let &res=&newObj;

	* 成员赋值;
	%varsCount(vars=&members,res=&tres);%let membersN=&&&tres;
	%do i=1 %to &membersN;
		%varsN(vars=&members,n=&i,res=&tres);%let member=%unquote(&&&tres);
		%global &newObj.&member &obj.&member;
		%let &newObj.&member=&&&obj.&member;
	%end;
%mend;


* ---- macro copyObj -----;
* 将一个对象的成员复制到另一个对象;
* input;
*	from		源对象;
*	to			目的对象;
*	members		拷贝的成员范围，如为空则视为拷贝from的全部成员;
*	prefix		拷贝到目的对象的成员名增加prefix;
*	suffix		拷贝到目的对象的成员名增加suffix;
*				例如原obj中的变量名为a.type，增加前缀pre_，则拷贝到b中为b.pre_type;
*				注意成员名不要超过20，否则将导致报错;
*	overrite	是否覆盖，默认0;
* details;
*	成员copy规则;
*		只copy members指定范围内的成员;
*		若成员在from中存在，在to中不存在，则进行复制;
*		若成员在from中不存在，在to中存在，则不进行复制;
*		若为overwrite模式，则所有from中的成员都将被复制到to中;
*		若非overwrite模式，则若仅当该成员在from存在，且to中该成员不存在或为空，则进行复制;
* test;
*	@test_copyObj;

%macro copyObj(from=,to=,members=,prefix=,suffix=,overwrite=) /parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;

	%local fromMembers;
	%local member membersN;
	%local i;
	%local fromMember toMember;
	
	%if %isBlank(&from) or %isBlank(&to) %then %error(No required param! &syspbuff);
	%if %isBlank(&overwrite) %then %let overwrite=0;

	%getObjMembers(obj=&from,res=&tres);%let fromMembers=&&&tres;
	%if %isBlank(&fromMembers) %then %return;

	%if not %isBlank(&members) %then %do;
		%varsAnd(a=&fromMembers,b=&members,res=&tres);%let members=&&&tres;
	%end;
	%else %let members=&fromMembers;
	%if %isBlank(&members) %then %return;

	%varsCount(vars=&members,res=&tres);%let membersN=&&&tres;
	%do i=1 %to &membersN;
		%varsN(vars=&members,n=&i,res=&tres);%let member=%unquote(&&&tres);
		%let fromMember=%unquote(&from.&member);
		%let toMember=%unquote(&to.&prefix.&member.&suffix);
		%if %length(&toMember)>20 %then %error(Member name is TOO LONG! member=&toMember);
		%global &fromMember;
		%if %symglobl(&toMember)=0 %then %do;
			%global &toMember;
			%let &toMember=&&&fromMember;
		%end;
		%else %do;
			%global &toMember;
			%if &overwrite=1 or %isBlank(&&&toMember) %then %let &toMember=&&&fromMember;
		%end;
	%end;
%mend;


* ---- macro checkObj ----;
* 检查obj成员的必输项;
* input;
*	obj			对象，必输;
*	members		目标成员，vars格式;
*				当为空时，默认为所有成员;
*				当目标obj中不含任何成员，且members为空时，认为是正常;
*	res			返回值;
* output;
*	res			返回为空的成员清单，vars格式;
* test;
*	@test_checkObj;
%macro checkObj(obj=,members=,res=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local membersN member mc i;
	%resCheck(&res);
	%if %isBlank(&obj) %then %error(Required param is empty!);
	%if %isBlank(&members) %then %do;
		%getObjMembers(obj=&obj,res=&tres);%let members=&&&tres;
	%end;
	%varsCount(vars=&members,res=&tres);%let membersN=&&&tres;
	%do i=1 %to &membersN;
		%varsN(vars=&members,n=&i,res=&tres);%let member=&&&tres;%let mc=%unquote(&obj.&member);
		%global &mc;
		%if %isBlank(&&&mc) %then %let &res=&&&res &member;
	%end;
%mend;


* ---- macro clearObj -----;
* 擦除对象成员;
* input;
*	obj			待处理的obj;
*	members		待处理的成员，vars格式;
*				当members为空时，对所有成员进行处理;
*				当members不为空时，对于所有指定且存在的成员进行擦除处理;
* test;
*	@test_clearObj;

%macro clearObj(obj=,members=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local objMembers member membersN i;
	%if %isBlank(&obj) %then %return;
	%getObjMembers(obj=&obj,res=&tres);%let objMembers=&&&tres;
	%if not %isBlank(&members) %then %do;
		%varsAnd(a=&members,b=&objMembers,res=&tres);%let members=&&&tres;
	%end;
	%else %let members=&objMembers;
	%if %isBlank(&members) %then %return;
	%varsCount(vars=&members,res=&tres);%let membersN=&&&tres;
	%do i=1 %to &membersN;
		%varsN(vars=&members,n=&i,res=&tres);%let member=%unquote(&&&tres);
		%global &obj.&member;
		%let &obj.&member=%str();
	%end;
%mend;


* ---- macro quoteObj -----;
* 转义对象成员，用于通过sql select into直接读取的复杂内容时处理（例如包含等号、空格等符号）;
* input;
*	obj			待处理的obj;
*	members		待处理的成员，vars格式;
*				当members为空时，对所有成员进行处理;
*				当members不为空时，对于所有指定且存在的成员进行quote处理;
* test;
*	@test_quoteObj;

%macro quoteObj(obj=,members=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local objMembers member membersN i;

	%if %isBlank(&obj) %then %return;
	%getObjMembers(obj=&obj,res=&tres);%let objMembers=&&&tres;
	%if not %isBlank(&members) %then %do;
		%varsAnd(a=&members,b=&objMembers,res=&tres);%let members=&&&tres;
	%end;
	%else %let members=&objMembers;
	%if %isBlank(&members) %then %return;
	%varsCount(vars=&members,res=&tres);%let membersN=&&&tres;
	%do i=1 %to &membersN;
		%varsN(vars=&members,n=&i,res=&tres);%let member=%unquote(&&&tres);
		%global &obj.&member;
		%let &obj.&member=%quote(&&&obj.&member);
	%end;
%mend;


* ---- macro stdObj ---
* 规范化obj成员变量;
* 规范化内容主要包括：大小写、排序、多余空格处理、去重等处理;
* 要求目标成员必须是vars格式; 
* input;
*	obj			对象;
*	members		目标成员，默认全部;
*	sort		是否排序，默认1;
*	upcase		是否转换为大写，默认1;
*	unique		是否转换为唯一，默认1;
* details;
*	注意经标准化处理后的vars都是quote后的;
*	上述转换执行顺序为upcase->unique->sort;
* test;
*	@test_stdObj;
%macro stdObjVars(obj=,sort=,upcase=,unique=,members=);
	%local tres;%let tres=%createTempVar;%local &tres;
	%local membersN member mc i;

	%if %isBlank(&obj) %then %return;
	%if %isBlank(&sort) %then %let sort=1;
	%if %isBlank(&upcase) %then %let upcase=1;
	%if %isBlank(&unique) %then %let unique=1;
	%if %isBlank(&members) %then %do;
		%getObjMembers(obj=&obj,res=&tres);%let members=&&&tres;
	%end;
	%varsCount(vars=&members,res=&tres);%let membersN=&&&tres;
	%do i=1 %to &membersN;
		%varsN(vars=&members,n=&i,res=&tres);%let member=&&&tres;%let mc=%unquote(&obj.&member);
		%global &mc;
		%if not %isBlank(&&&mc) %then %do; 
			%if &upcase=1 %then %let &mc=%qupcase(&&&mc);
			%if &unique=1 %then %varsUnique(vars=&&&mc,res=&mc);
			%if &sort=1 %then %varsSort(vars=&&&mc,res=&mc);
		%end;
	%end;
%mend;


* ---- macro upcaseObj ----;
* 将成员值转换为大写;
* input;
*	obj			对象;
*	members		转换成员清单，默认为全部;
* details;
*	参见stdObj;
*	注意处理后的为quote值;
* test;
*	@test_stdObj;
%macro upcaseObj(obj=,members=);
	%stdObjVars(obj=&obj,members=&members,sort=0,upcase=1,unique=0);
%mend;


* ---- macro loadObj ----;
* 从数据集中读取指定的记录，并返回为obj格式;
* input:
*	data/ds		data;
*	where		where条件语句;
*	res			返回变量;
* output;
*	res			保存查找到的数据记录的obj，根据查询结果不同返回以下值;
*					数据集不存在			返回空;
*					数据集无观测			返回空;
*					无匹配记录			返回空;
*					有1条匹配记录		返回创建的obj;
*					有多于1条匹配记录		返回创建的obj，其中存储第1条记录;
* details;

*	批量读取的实现;
*		loadObj主要针对单一obj的读取场景，如果要读取多个内容，可以通过where语句设计来实现;

*	特殊转义变量内容;
*		loadObj通过select into来将数据写入宏变量，因此一些包含特殊字符(如：分号、引号、百分号等)的字符串可以被成功保存到宏变量中;
*		这些内容如果直接被引用则可能出现错误，因此应该在引用时要进行转义;
*		例如 %let a=%quote(&&&myobj.str);
*		一个典型的场景是使用字符串在ds中保存一些可执行代码，然后再读取进行执行;

* test;
*	@test_loadObj;

%macro loadObj(ds=,data=,where=,res=) /parmbuff;
	%local tres;%let tres=%createTempVar;%local &tres;

	%local vars obj;
	%local stmt_where stmt_select stmt_into;

	* 参数检查;
	%resCheck(&res);
	%let data=%paramAlias(&data,&ds);
	%if %isBlank(&data) %then %error(DATA is empty! &syspbuff);
	%if not %isBlank(&where) %then %let stmt_where=where &where;

	* 数据集检查;
	%getDsObs(ds=&data,res=&tres);%if &&&tres=0 %then %return;
	%getDsVarList(ds=&data,res=&tres);%let vars=&&&tres;%if %isBlank(&vars) %then %return;

	* 对象创建;
	%newObj(members=&vars,res=&tres);%let obj=&&&tres;

	* 查询执行;
	%let stmt_select=%sasVarsToSql(&vars);
	%varsPrefix(vars=&vars,prefix=%str(:&obj),res=&tres);%let stmt_into=%sasVarsToSql(&&&tres);
	proc sql outobs=1 noprint;
		select %unquote(&stmt_select) into %unquote(&stmt_into) from %unquote(&data) %unquote(&stmt_where);
	quit;

	* 无匹配记录情况的处理;
	%if &SQLOBS<1 %then %do;
		%dropObj(&obj);
		%return;
	%end;

	* 结果返回;
	%let &res=&obj;
%mend;


* ---- macro saveObj ----;
* 将obj中的成员逐个写入数据集的对应变量中;
* input;
*	data/ds			写入数据集;
*	key				key变量清单，vars格式;
*	obj				拟写入的对象;

* details;
*	【内容格式要求】;
*		不得出现双引号，但可以使用单引号;
*		不得出现非对称的单个( 或 );

*	内容处理逻辑;
*		所有待写入的内容，将被进行strip处理，以避免由于空白字符影响存储与后续处理;
*		对于ds中存在，而obj中不存在的变量，将置为默认的缺失值;

* 	【内容存储格式】;
*		saveObj将所有内容以字符形式写入数据集中，所有变量均为字符串变量;

*	数据集变量的动态扩充;
*		数据集可以随着obj的变动而自动扩充，自动扩充主要包括变量与变量长度两方面;
*			变量扩充			即当obj中有在ds中增加新的变量;
*			变量长度扩充		即在ds中变量不能满足存储新的数据要求时，自动进行扩充;

*	key模式 vs 追加模式;
*		当参数key为空时，写入被认为是追加模式，否则是key模式;
*			key模式			会按照key中指定的主键，先删除相关的记录，再写入新的记录;
*			追加模式			直接追加写入记录;

*	key变量的要求;
*		key可以包含多个变量;
*		所有key变量在obj中必须已经存在，但内容允许为空;
*		所有key变量在ds中可以事先不存在，但写入后将被自动创建;

*	数值型变量;
*		saveObj不支持写入数值型变量，主要原因在于宏变量本身并无类型，在与ds变量的交互中，需要进行复杂的识别与转换，存在准确性的隐患;
		
* test;
*	@test_saveObj;

%macro saveObj(ds=,data=,key=,obj=) /parmbuff;

	%local tres;%let tres=%createTempVar;%local &tres;

	* 变量初始化;
	%local members member membersN;
	%local k keyN;
	%local i;
	%local value;
	%local mode;
	%local stmt_where stmt_set;
	
	%let mode=APPEND;
	%let doExtend=0;
	%let stmt_length=%str();
	%let stmt_assign=%str();
	%let stmt_where=%str();
	%let stmt_set=%str();

	* 参数检查;
	%let data=%paramAlias(&data,&ds);
	%paramRequired2(&data,&obj);
	%varsCount(vars=&key,res=&tres);%let keyN=&&&tres;
	%if &keyN>0 %then %let mode=KEY;
	
	* 对象成员变量提取;
	%getObjMembers(obj=&obj,res=&tres);%let members=&&&tres;
	%varsCount(vars=&members,res=&tres);%let membersN=&&&tres;
	%if &membersN=0 %then %return;

	%logClose;

	* key模式 - key变量存在性检查;
	%if &mode=KEY %then %do;
		%varsSub(a=&key,b=&members,res=&tres);%if not %isBlank(&&&tres) %then %error(KEY VARS &&&tres doesnot exist in OBJ! &syspbuff);
	%end;

	* 数据集元数据处理与语句生成;
	%do i=1 %to &membersN;
		%varsN(vars=&members,n=&i,res=&tres);%let member=%unquote(&&&tres);

		* 变量值处理;
		%let value=%quote(%strip(%quote(&&&obj.&member)));

		* 变量长度检查;
		%setDsVarLen(ds=&data,var=&member,len=%length(&value));

		* set语句生成;
		%if &i=1 %then %let stmt_set=%quote(%str(&member="&value"));
		%else %let stmt_set=&stmt_set %quote(%str(,&member="&value"));
	%end;

	* 数据更新执行;
	%if &mode=KEY %then %do;

		* key模式;
		%do i=1 %to &keyN;
			%varsN(vars=&key,n=&i,res=&tres);%let k=%unquote(&&&tres);
			%let value=%strip(&&&obj.&k);

			* where语句生成;
			%if &i=1 %then %let stmt_where=%quote(%str(&k="&value"));
			%else %let stmt_where=&stmt_where %quote(%str(and &k="&value"));
		%end;
		
		proc sql noprint;
			delete * from &data where %unquote(&stmt_where);
			insert into &data set %unquote(&stmt_set);
		quit;
		
	%end;
	%else %do;
		* 追加模式;
		proc sql noprint;
			insert into &data set %unquote(&stmt_set);
		quit;
	%end;

	%logReset;
%mend;


* -------------------------------------------------;
* ----------------- array object ------------------;
* -------------------------------------------------;

* array用于实现数组功能，其实现方式与访问方式与obj基本相同;

* array的基本操作;
* 	%let x=&&&arr.&i					访问数组元素i;
* 	%let x=&&&arr.10					访问数组元素10;
* 	%let &arr.&i=value					置数组元素i;
* 	%let &arr.10=value					设置数组元素10;
* 	%let x=&&&arr.length				数组长度;
*	%let y=%arrayPop(&arr)				弹出尾部元素;
*	%arrayPush(&arr,&value)				添加元素;

* array扩充;
* 	数组在初始化后不能直接访问超过原长度的位置，但可以arrayExtend或arrayPush来扩充;
* 	如果强行使用，在某些场景可能导致预期外的情况（例如：在宏A内创建数组并向上级宏返回时）;

* obj宏的复用;
*	由于实现方式基本相同，理论上array可以复用某些obj的宏;
*	但实际上，obj宏都基于“成员个数相对较少”这一假设前提设计，在元素个数较多时可能效率较差，因此建议使用array专用宏;


* ---- macro arrayInit ----;
* array初始化;
* input;
*	n				元素个数，默认为0;
*	res				返回的array地址;
* test;
*	@test_arrayInit;
%macro arrayInit(n,res);

	%local tres;%let tres=%createTempVar;%local &tres;
	%local i arr sw;
	%let sw=1;

	%resCheck(&res);
	%let n=%nonBlank(&n,0);
	%if not %isUINT(&n) %then %error(N must be UINT);

	%do %while(&sw);
		%let arr=%genId(prefix=A,len=12);
		%if not %arrayExist(&arr) %then %let sw=0;
	%end;
	
	%if %eval(&n>0) %then %do;
		%do i=1 %to &n;
			%global &arr.&i;
		%end;
	%end;
	%global %unquote(&arr.length);
	%let &arr.length=&n;
	%let &res=&arr;
%mend;


* ---- macro arrayExist ----;
* array存在性检查;
* input;
*	n				元素个数，默认为0;
*	res				返回的array是否存在;
* test;
*	@test_arrayExist;
* details;
*	检查逻辑;
*		arrayExist判定数组是否存在的条件是length变量存在且其值是UINT;
*		出于效率考虑，arrayExist不会检查所有数组变量是否存在;

%macro arrayExist(arr);
	%local l res;
	%let res=0;
	%if not %isVar(&arr) %then %goto exit;
	%if not %globalExist(&arr.length) %then %goto exit;
	%if not %isUINT(&&&arr.length) %then %goto exit;
	%let res=1;
	%exit:
	&res.
%mend;

* ---- macro isArray ----;
%macro isArray(arr);
	%arrayExist(&arr)
%mend;


* ---- macro arrayDelete ----;
* array存在性检查;
* input;
*	arr				arr;
* test;
*	@test_arrayInit;
%macro arrayDelete(arr);
	%local i;
	%if not %arrayExist(&arr) %then %return;
	%do i=1 %to &&&arr.length;
		%symdel %unquote(&arr.&i);
	%end;
	%symdel %unquote(&arr.length);
%mend;

* ---- macro dropArray ----;
%macro dropArray(arr);
	%arrayDelete(&arr);
%mend;


* ---- macro arrayExtend ----;
* array扩充;
* input;
*	arr				arr;
*	n				扩展后的数组大小，如果n小于当前数组length则将不进行操作;
* test;
*	@test_arrayExtend;
%macro arrayExtend(arr,n);
	%local i;
	%if not %isUINT(&n) %then %error(N must be an UINT!);
	%if not %isArray(&arr) %then %error(ARR must be an ARRAY!);
	%if &n>&&&arr.length %then %do;
		%do i=&&&arr.length %to &n;
			%global %unquote(&arr.&i);
		%end;
		%let &arr.length=&n;
	%end;
%mend;


* ---- macro arrayPush ----;
* array push;
* input;
*	arr				arr;
*	value			push的值;
* test;
*	@test_arrayPush;
%macro arrayPush(arr,value);
	%local last;
	%if not %isArray(&arr) %then %error(ARR must be an ARRAY!);
	%let last=%eval(&&&arr.length+1);
	%global %unquote(&arr.&last);
	%let &arr.&last=&value;
	%let &arr.length=&last;
%mend;


* ---- macro arrayPop ----;
* array pop;
* input;
*	arr				arr;
*	value			pop的值;
* test;
*	@test_arrayPush;
* details;
*	结束标识;
*		arrayPop以该arr的名称作为返回标记;
*		例如:array名称为A49TW4JWYNTY，当length为0时继续调用arrayPop，将返回A49TW4JWYNTY;
*		可以使用 if &result=&arr 来判断是否结束;

%macro arrayPop(arr);
	%local value last;
	%if not %isArray(&arr) %then %error(ARR must be an ARRAY!);
	%let last=&&&arr.length;
	%if &last=0 %then %do;
		%let value=&arr;
	%end;
	%else %do;
		%let value=&&&arr.&last;
		%symdel %unquote(&arr.&last);
		%let &arr.length=%eval(&last-1);
	%end;
	&value.
%mend;





* ----------------------------------------------------------------------------------------------------------;
* ----------------------------------------------- INITIALIZATION -------------------------------------------;
* ----------------------------------------------------------------------------------------------------------;

%importFuncs;
%lstart;
%createSashelpDummyPrinter;
%setODSOutputHTML;
%setODSAutoNavigateOn;

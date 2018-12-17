
* http://www.miraclesalad.com/webtools/md5.php;

%macro test_md5;
	
	%local s;

	%let s=%str(goodboy);
	%assertEqual(a=%upcase(57e7f266bb0dc62f2cb0f25976c14e93),b=%md5(&s),msg=&s);

	%let s=%str( goodboy);
	%assertEqual(a=%upcase(950dc5415ff941d377695519b57a4c60),b=%md5(&s),msg=&s);

	
	%let s=%str(汉字测试);
	%assertEqual(a=%upcase(8db0b7277e4c251bc9a2e05586aee71c),b=%md5(&s),msg=&s);

	%let s=%str(汉字，。测试);
	%assertEqual(a=%upcase(35c23470036f61fbd26ddd0dab8d6885),b=%md5(&s),msg=&s);

	%let s=%str("goodboy");
	%assertEqual(a=%upcase(9bc6c8baf36a9ada201278d4b037f44f),b=%md5(&s),msg=&s);

	%let s=%str('goodboy');
	%assertEqual(a=%upcase(822a55cf656f3a647a631a1b9f16183d),b=%md5(&s),msg=&s);

	%let s=%str(%'goodboy%');
	%assertEqual(a=%upcase(822a55cf656f3a647a631a1b9f16183d),b=%md5(&s),msg=&s);

%mend;

%test_md5;

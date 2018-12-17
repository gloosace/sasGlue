

%macro test_md5base32;
	
	%local str;
	%let str=%str(goodboy);
	%put %md5base32(&str) - &str;

	%let str=%str( goodboy );
	%put %md5base32(&str) - &str;

	%let str=%str(汉字测试);
	%put %md5base32(&str) - &str;
	
	%let str=%str( );
	%put %md5base32(&str) - &str;

	%let str=%str(  );
	%put %md5base32(&str) - &str;
%mend;


%test_md5base32;

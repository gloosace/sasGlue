
%macro test_sha256base32;
	
	%local str;
	%let str=%str(goodboy);
	%put %sha256base32(&str) %length(%sha256base32(&str)) - &str;

	%let str=%str( goodboy );
	%put %sha256base32(&str) %length(%sha256base32(&str)) - &str;

	%let str=%str(汉字测试);
	%put %sha256base32(&str) %length(%sha256base32(&str)) - &str;
	
	%let str=%str( );
	%put %sha256base32(&str) %length(%sha256base32(&str)) - &str;

	%let str=%str(  );
	%put %sha256base32(&str) %length(%sha256base32(&str)) - &str;
%mend;


%test_sha256base32;

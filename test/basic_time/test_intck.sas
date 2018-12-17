
%macro test_intck;
	%assertEqual(a=2,b=%dsIntck(dtmonth,20180105,20180401));
	%assertEqual(a=2,b=%intck(dtmonth,%dsToDtv(20180105),%dsToDtv(20180401)));
%mend;
%test_intck;

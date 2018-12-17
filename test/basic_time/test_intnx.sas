
%macro test_intnx;
	%assertEqual(a=20181101,b=%dsIntnx(dtmonth,20180105,10,BEGINNING));
	%assertEqual(a=%dsToDtv(20181101),b=%intnx(dtmonth,%dsToDtv(20180105),10,BEGINNING));

%mend;

%test_intnx;

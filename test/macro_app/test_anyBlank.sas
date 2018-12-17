

%macro test_anyBlank;


	%lbreak(BLANK);

	%put %anyBlank2;
	%put %anyBlank2();
	%put %anyBlank2(abc);
	%put %anyBlank2(,abc);

	%put %anyBlank3;
	%put %anyBlank3();
	%put %anyBlank3(abc);
	%put %anyBlank3(,abc);
	%put %anyBlank3(123,abc);
	%put %anyBlank3(123,abc,);

	%put %anyBlank4;
	%put %anyBlank4();
	%put %anyBlank4(abc);
	%put %anyBlank4(,abc);
	%put %anyBlank4(123,abc);
	%put %anyBlank4(123,abc,);
	%put %anyBlank4(123,abc,def);
	%put %anyBlank4(,abc,def,xyz);


	%lbreak(NONBLANK);
	%put %anyBlank2(1,2);
	%put %anyBlank3(1,2,3);
	%put %anyBlank4(1,2,3,4);
%mend;


%test_anyBlank;

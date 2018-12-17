

%macro test_allBlank;


	%lbreak(NOT ALLBLANK);

	%put %allBlank(1,2);
	%put %allBlank(1,2,3);
	%put %allBlank(1,2,3,4);

	%put %allBlank(,abc);
	%put %allBlank(123,abc);
	%put %allBlank(123,abc,);
	%put %allBlank(123,abc,def);
	%put %allBlank(,abc,def,xyz);
	%put %allBlank(,%str( ),       ,);
	%put %allBlank(,    ,%quote( ),);

	%lbreak(ALLBLANK);
	
	%put %allBlank;
	%put %allBlank();
	%put %allBlank(,);
	%put %allBlank(,,);
	%put %allBlank(,,,);
	%put %allBlank(,,       ,);
	%put %allBlank(,    ,,);
%mend;


%test_allBlank;



%macro test_options;

	
	%local old_option;

	%let old_option=%getOption(cmplib);

	%put %getOption(cmplib);

	%addOption(cmplib,local.test);

	%put %getOption(cmplib);

	%setOption(cmplib,local.test2 local.test3);

	%put %getOption(cmplib);

	%deleteOption(cmplib,local.test3);

	%put %getOption(cmplib);

	%setOption(cmplib,&old_option);

	%put %getOption(cmplib);

	%displayOption(cmplib);


%mend;

%test_options;

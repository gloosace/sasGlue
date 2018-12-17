
%macro test_copyLib;


	%importLocalLib(l1,l1);
	%importLocalLib(l2,l2);
	%importLocalLib(l3,l3);
	%importLocalLib(l4,l4);

	data l1.a; s='aaaaa';run;
	data l1.b; s='bbbbb';run;
	data l1.c; s='ccccc';run;

	data l3.a; s='xxxxxxxxxxx';run;

	data l4.a; s='yyyyyyyyyy';run;

	%copyLib(inlib=l1,outlib=l2);

	%copyLib(inlib=l1,outlib=l3,tables=a b);

	%copyLib(inlib=l1,outlib=l4,overwrite=0);


	%dropLib(l1);
	%dropLib(l2);
	%dropLib(l3);
	%dropLib(l4);
%mend;

%macro test_copyLib_error;

	%importLocalLib(l5,l5);
	%importLocalLib(l6,l5);
	
	
	%copyLib(inlib=l5,outlib=l6);

	%dropLib(l5);
	%dropLib(l6);
%mend;

%test_copyLib;
%test_copyLib_error;

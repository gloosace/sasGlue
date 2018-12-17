
%macro test_copyFormatLib;

	%importLocalLib(local,local);
	%importLocalLib(l1,test_copyFormats_l1);
	%importLocalLib(l21,test_copyFormats_l21);
	%importLocalLib(l22,test_copyFormats_l22);
	%importLocalLib(l3,test_copyFormats_l3);

	proc format lib=local;

		value testFormat
			1='a'
			2='b'
			other='na';

		invalue testInformat
			'x'=1
			'y'=2
			other=.;
	quit;

	%copyFormatLib(inLib=local,outlib=l1);
	%copyFormatLib(inLib=local,outlib=l21,outPath=%getLibPath(l22));
	%copyFormatLib(inPath=%getLibPath(local),outlib=l3);
	
	%dropLib(local l1 l21 l22 l3);

%mend;



%test_copyFormatLib;

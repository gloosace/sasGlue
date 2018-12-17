
%macro test_ceil;
	
	%assertEqual(a=6,b=%ceil(5.123));
	%assertEqual(a=-1,b=%ceil(-1.234));
	%assertEqual(a=0,b=%ceil(-0.785));

%mend;


%macro test_floor;
	
	%assertEqual(a=5,b=%floor(5.123));
	%assertEqual(a=-2,b=%floor(-1.234));
	%assertEqual(a=-1,b=%floor(-0.785));

%mend;

%macro test_log;
	%assertEqual(a=0,b=%log(1));
	%assertEqual(a=0.69314718055994,b=%log(2));
%mend;


%macro test_abs;
	%assertEqual(a=0,b=%abs(0));
	%assertEqual(a=1.123,b=%abs(1.123));
	%assertEqual(a=1.123,b=%abs(-1.123));
	%assertEqual(a=0.123,b=%abs(-0.123));
%mend;


%macro test_round;
	%assertEqual(a=5,b=%round(5.123));
	%assertEqual(a=6,b=%round(5.623));
	%assertEqual(a=-1,b=%round(-1.234));
	%assertEqual(a=-1,b=%round(-0.785));

	%assertEqual(a=12345700,b=%round(12345678,100));
	%assertEqual(a=12346000,b=%round(12345678,1000));

	%assertEqual(a=-12345700,b=%round(-12345678,100));
	%assertEqual(a=-12346000,b=%round(-12345678,1000));
%mend;


%macro test_max;
	%assertEqual(a=300,b=%max(100,200,300));
	%assertEqual(a=-100,b=%max(-100,-200,-300));
	%assertEqual(a=16,b=%max(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16));
%mend;

%macro test_min;
	%assertEqual(a=100,b=%min(100,200,300));
	%assertEqual(a=-300,b=%min(-100,-200,-300));
	%assertEqual(a=1,b=%min(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16));
%mend;

/*
%test_ceil;
%test_floor;
%test_log;
%test_abs;
%test_round;
%test_max;
%test_min;
*/

%test_min;

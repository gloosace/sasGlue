
data test_padding;


	length s $ 20 r $ 1000;
	
	s=' abcd ';
	r=leftPadding(s,10,' ');
	put 'LEFT  ' r= s=;
	output;

	s=' abcd ';
	r=leftPadding(s,10,'.');
	put 'LEFT  ' r= s=;
	output;

	s=' abcd ';
	r=rightPadding(s,10,'.');
	put 'RIGHT ' r= s=;
	output;

	s='123456789012345';
	r=leftPadding(s,10,'.');
	put 'LEFT  ' r= s=;
	output;

	s='123456789012345';
	r=rightPadding(s,10,'.');
	put 'RIGHT ' r= s=;
	output;

	s=' ';
	r=leftPadding(s,10,'.');
	put 'LEFT  ' r= s=;
	output;

	s=' ';
	r=leftPadding(s,10,'.');
	put 'RIGHT ' r= s=;
	output;

	s='';
	r=leftPadding(s,10,'.');
	put 'LEFT  ' r= s=;
	output;

	s='';
	r=leftPadding(s,10,'.');
	put 'RIGHT ' r= s=;
	output;

	s=' abcd ';
	r=rightPadding(s,10,'x');
	put 'RIGHT ' r= s=;
	output;

	s='abcd';
	r=leftPadding(s,10,'1234');
	put 'LEFT  ' r= s=;
	output;

	s='abcd';
	r=rightPadding(s,10,'1234');
	put 'RIGHT ' r= s=;
	output;
	

	s='abcd';
	r=rightPadding(s,300,'1234567890');
	l=length(r);
	put 'RIGHT ' r= s= l=;
	output;

	s='abcd';
	r=leftPadding(s,300,'1234567890');
	l=length(r);
	put 'LEFT ' r= s= l=;
	output;
	
run;



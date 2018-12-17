
%macro test_timeType;

	data _null_;
		format x E8601DT. y YYMMDD10. d best.;

		put '----- timetype ----';
		x='01jan1961 00:00:00'dt;
		d=x;
		r=timetype(d);
		put x= d= r=;

		x='31dec9999 23:59:59'dt;
		d=x;
		r=timetype(d);
		put x= d= r=;

		x='01dec2017 23:59:59'dt;
		d=x;
		r=timetype(d);
		put x= d= r=;

		x='01dec1967 23:59:59'dt;
		d=x;
		r=timetype(d);
		put x= d= r=;

	
		y='01jan1961'd;
		d=y;
		r=timetype(d);
		put y= d= r=;

		y='31dec2128'd;
		d=y;
		r=timetype(d);
		put y= d= r=;

		y='31dec9999'd;
		d=y;
		r=timetype(d);
		put y= d= r=;

		y='01feb1960'd;
		d=y;
		r=timetype(d);
		put y= d= r=;

		x='01dec1960 23:59:59'dt;
		d=x;
		r=timetype(d);
		put x= d= r=;

		y=.;
		d=y;
		r=timetype(d);
		put y= d= r=;

	run;
%mend;

%test_timeType;



data _null_;

	format dt E8601DT. d YYMMDD10.;
	
	put '----- dateToDt ----';
	d='13jan2016'd;
	dt=dateToDt(d);
	put d= dt=;

	put '----- dateToDt ----';
	d='13jan2008'd;
	dt=dateToDt(d);
	put d= dt=;

run;

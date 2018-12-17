

data _null_;

	format dt E8601DT. d YYMMDD10.;
	
	put '-----timeFloor month----';
	a='13jan2016 00:00:00'dt;
	dt=timeFloor(a,'month');
	put a= dt=;

	put '-----timeCeil month ----';
	a='13jan2016 00:00:00'dt;
	dt=timeCeil(a,'month');
	put a= dt=;

	put '-----timeFloor year ----';
	a='13jan2016 00:00:00'dt;
	dt=timeFloor(a,'year');
	put a= dt=;

	put '-----timeCeil year ----';
	a='13jan2016 00:00:00'dt;
	dt=timeCeil(a,'year');
	put a= dt=;

	put '-----timeFloor month----';
	a='13jan2016'd;
	d=timeFloor(a,'month');
	put a= d=;

	put '-----timeCeil month----';
	a='13jan2016'd;
	d=timeCeil(a,'month');
	put a= d=;

	put '-----timeFloor year----';
	a='13jan2016'd;
	d=timeFloor(a,'year');
	put a= d=;

	put '-----timeCeil year----';
	a='13jan2016'd;
	d=timeCeil(a,'year');
	put a= d=;
run;

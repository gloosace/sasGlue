

%macro test_time;
	%local t;

	%lbreak(time value)
	%put dtv=%dtv;
	%put ts=%ts;
	%put datetime=%datetime;
	%put hts=%hts;
	%put date=%date;
	

	%lbreak(time format)
	%put timestamp=%timestamp;
	%put htimestamp=%htimestamp;
	%put yyyymmdd=%yyyymmdd;
	%put ds=%ds;

	%lbreak(time conversion);

	%put datepart=%datepart(%dtv);
	%put dtvToDs=%dtvToDs(%dtv);
	%put dsToDtv=%dtvToDs(%ds);


%mend;




%test_time;

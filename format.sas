/*1: CALL EXECUTE*/
data _null_;
	set demo end=eof;
	if _n_=1 then call execute('proc format; value vs1t');
	call execute(cats(AVISITN)||' = '||quote(cats(AVISIT)));
	if eof then call execute('; run;');
run;

/*2: macro variable*/
proc sql noprint;
	select catx(' = ', cats(AVISITN), quote(cats(AVISIT))) into :fmtlst separated by ' '
		from demo
		order by AVISITN;
quit;
 
proc format;
	value vs2t
	&fmtlst;
run;

/*3: CNTLIN= option*/
proc sql;
	create table fmt as
		select distinct 'vs3t' as FMTNAME
			 , AVISITN as START
			 , cats(AVISIT) as label
		from demo
		order by AVISITN
		;
quit;
 
proc format library=work cntlin=fmt;
run;

/*4: FILENAME*/
proc sql;
	create table fmt as
		select distinct AVISITN
			 , quote(cats(AVISIT)) as AVISIT
		from demo
		order by AVISITN
		;
quit;
 
/*Write the generated code to a temporary file*/
filename code temp;
data _null_;
	file code;
	set fmt;
	if _n_=1 then put +4 'value vs4t';
	put +14 AVISITN ' = ' AVISIT;
run;
 
proc format;
	%inc code / source2;
	;
run;

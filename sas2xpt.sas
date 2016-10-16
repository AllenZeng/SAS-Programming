/*-----------------------------------------------------------------------------
 Author:          Xianhua Zeng
 Creation Date:   25Jun2015
 Program Purpose: To convert SAS datasets to .xpt files
-----------------------------------------------------------------------------*/
/*.xpt files*/
%let dir=/xpt/;
 
proc sql;
	create table vtable as
		select *
		from dictionary.tables
		where LIBNAME='SDATA'
		;
quit;
 
data _null_;
	set vtable end=eof;
	MEMNAME=lowcase(MEMNAME);
	call execute('libname temp xport "&dir.'||cats(MEMNAME)||'.xpt";'
				 ||'data '||cats(MEMNAME)||'(sortedby=_null_ label="'||cats(MEMLABEL)||'"); set sdata.'||cats(MEMNAME)||'; run;'
				 ||'proc copy in=work out=temp mt=data; select '||cats(MEMNAME)||'; run;');
	if eof then call execute('libname temp clear;');
run;
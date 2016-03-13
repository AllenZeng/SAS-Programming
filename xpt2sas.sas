/*.sas7bdat files*/
libname sdata "/sas/";
 
/*.xpt files*/
%let dir=/xpt/;
 
filename xpts pipe "ls &dir.*.xpt";
 
data _null_;
	infile xpts truncover;
	input;
	XPTFILE=prxchange('s/(.+)\/(.+)(\.xpt)/\2/', -1, _INFILE_);
	call execute('libname xptin xport "&dir.'||strip(XPTFILE)||'.xpt";'
				 ||'proc copy in=xptin out=sdata mt=all; run;');
run;
 
filename xpts clear;
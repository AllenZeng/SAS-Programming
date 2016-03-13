filename fdate pipe "ls -t ./*.sas7bdat | head -1";
 
data _null_;
	infile fdate lrecl=32767;
	input;
	call symputx('filename', _INFILE_, 'L');
run;
 
filename fdate "&filename";
 
proc sql noprint;
	select cats(put(MODATE, is8601dt.)) into :file_dt
		from dictionary.extfiles
		where FILEREF='FDATE'
		;
quit;
 
filename fdate clear;

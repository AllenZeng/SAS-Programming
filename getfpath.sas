x 'cd /projects/study123456/';
filename fpath pipe "find . -name '*define*.xml' | head -1 | sed 's#.##'";
 
data _null_;
	infile fpath lrecl=32767;
	input;
	call symputx('path', prxchange("s#(.+)/(.+?)$#/projects/study123456/\1/#", -1, cats(_INFILE_)));
run;
 
filename fpath clear;
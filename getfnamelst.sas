/*-----------------------------------------------------------------------------
 Author:          Xianhua Zeng
 Creation Date:   25Jun2015
 Program Purpose: To get the filenames of all files in a directory
-----------------------------------------------------------------------------*/
filename filelst pipe "ls ./*.txt | sed -e 's#.*/##; s#\..*$##' | paste -sd '|' -";
 
data _null_;
	infile filelst lrecl=32767;
	input;
	call symputx('filelst', _INFILE_, 'L');
run;
 
filename filelst clear;
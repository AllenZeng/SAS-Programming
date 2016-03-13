%macro getfname(keyword=, type=);
filename fname pipe "ls -t ./*.&type | grep -i '&keyword' | head -1";
 
data _null_;
	infile fname lrecl=32767;
	input;
	_INFILE_=prxchange("s/(.+)\/(.+)(\.&type)/\2/", -1, _INFILE_);
	call symputx("fname", _INFILE_, "g");
run;

filename fname clear;
%mend getfname;
 
/*Using Example*/
%getfname(keyword=mapping specifications, type=xlsx)

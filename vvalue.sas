/*-----------------------------------------------------------------------------
 Author:          Xianhua Zeng
 Creation Date:   08Oct2016
 Program Purpose: To automagically copy variable value
-----------------------------------------------------------------------------*/
%macro vvalue();
gsubmit '
dm "wcopy";
filename clip clipbrd;
data _null_;
   infile clip;
   input;
   call symputx("var", _INFILE_);
run;
filename clip clear;

proc sql noprint;
    select distinct &var into :varlst separated by "@"
    from &syslast
    ;
quit;

%let increment=%eval(&increment+1);

filename clip clipbrd;

data _null_;
    file clip;
    length value $32767;
	if &increment <= countw("&varlst", "@") then value=scan("&varlst", &increment, "@");
	else value=scan("&varlst", countw("&varlst", "@"), "@");
    put value;
run;

filename clip clear;';
%mend vvalue;
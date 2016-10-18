/*-----------------------------------------------------------------------------
 Author:          Xianhua Zeng
 Creation Date:   08Oct2016
 Program Purpose: To run the selected code and automagically open the last created dataset 
-----------------------------------------------------------------------------*/
%macro markcode();
gsubmit "
dm 'wcopy';
filename clip clipbrd;
data _null_;
   infile clip end=eof;
   input;
   put _INFILE_;
   if eof then call execute('dm ""vt &syslast;"" continue ;');
run;
filename clip clear;";
%mend markcode;
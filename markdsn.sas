/*-----------------------------------------------------------------------------
 Author:          Xianhua Zeng
 Creation Date:   08Oct2016
 Program Purpose: To automagically open the dataset selected 
-----------------------------------------------------------------------------*/
%macro markdsn();
gsubmit "
dm 'wcopy';

filename clip clipbrd;

data _null_;
    infile clip;
    input;
    call execute('dm ""vt '||_INFILE_||';"" continue ;');
run;

filename clip clear;";
%mend markdsn;
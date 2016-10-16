/*-----------------------------------------------------------------------------
 Author:          Xianhua Zeng
 Creation Date:   08Oct2016
 Program Purpose: To automagically open the dataset selected 
-----------------------------------------------------------------------------*/
%macro markdsn();
store;
gsubmit "%nrstr(%%let) clip_d=%nrstr(%%nrstr%()";
gsubmit buf=default;
gsubmit ");";

gsubmit 'dm "vt &clip_d;" continue;';
%mend markdsn;
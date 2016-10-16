/*-----------------------------------------------------------------------------
 Author:          Xianhua Zeng
 Creation Date:   08Oct2016
 Program Purpose: To run the selected code and automagically open the last created dataset 
-----------------------------------------------------------------------------*/
%macro markcode();
store;
gsubmit "%nrstr(%%let) clip_c=%nrstr(%%nrstr%()";
gsubmit buf=default;
gsubmit ");";

gsubmit "&clip_c";
gsubmit 'dm "vt &syslast;" continue;';
%mend markcode;
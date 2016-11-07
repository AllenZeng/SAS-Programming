/*-----------------------------------------------------------------------------
  PAREXEL INTERNATIONAL LTD

  Sponsor / Protocol No: PAREXEL / Macro and Application Development committee
  PXL Study Code:        222354

  SAS Version:           9.3
  Operating System:      UNIX
-------------------------------------------------------------------------------

  Author:                Allen Zeng $LastChangedBy: $
  Creation Date:         08Oct2016 / $LastChangedDate: $

  Program Location/name: $HeadURL: $

  Files Created:         NA

  Program Purpose:       run the selected code and open the last created dataset 

  Macro Parameters       NA

-------------------------------------------------------------------------------
MODIFICATION HISTORY:    Subversion $Rev: $
-----------------------------------------------------------------------------*/
%macro markcode();
gsubmit "
dm 'wcopy';
filename clip clipbrd;
data _null_;
   infile clip end=eof;
   input;
   call execute(_INFILE_);
   if eof then call execute('%nrstr(dm ''vt &syslast;'' continue ;)');
run;
filename clip clear;";
%mend markcode;
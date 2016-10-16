/*-----------------------------------------------------------------------------
 Author:          Xianhua Zeng
 Creation Date:   25Jun2015
 Program Purpose: To get all tables name in a directory
-----------------------------------------------------------------------------*/
/*DICTIONARY Tables and SASHELP Views*/
proc sql noprint;
	 select MEMNAME into :tnames separated by ', '
		 from dictionary.tables
		 where libname='SASHELP'
			 ;
 
		select MEMNAME into :tnames separated by ', '
		 from sashelp.vtable
		 where libname='SASHELP'
			 ;
quit;

/*PROC FCMP*/
%macro get_tnames();
proc sql noprint;
	select MEMNAME into :tnames separated by ', '
		from dictionary.tables
		where libname=&lib
	;
quit;
%mend get_tnames;
 
proc fcmp outlib=work.functions.demo;
	function get_tnames(LIB $) $;
	length TNAMES $ 32767;
	rc=run_macro('get_tnames', LIB, TNAMES);
	return(TNAMES);
	endsub;
run;

options cmplib=work.functions;

/*Using Example*/ 
data demo;
	TNAMES=get_tnames('SASHELP');
run;
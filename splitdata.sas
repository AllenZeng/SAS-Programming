/*CALL EXECUTE*/
proc sql;
	create table sex as
		select distinct SEX
		from sashelp.class
		;
quit;
 
data _null_;
	set sex;
	call execute('data sex_'||cats(SEX)||'(where=(SEX='||quote(cats(SEX))||')); set sashelp.class; run;');
run;

/*FILENAME*/
proc sql;
	create table sex as
		select distinct SEX
		from sashelp.class
		;
quit;
 
filename code temp;
data _null_;
	file code;
	set sex;
	put ' sex_' SEX '(where=(SEX="' SEX '"))' @@;
run;
 
data %inc code;;
	set sashelp.class;
run;

/*HASH*/
proc sort data=sashelp.class out=class;
	by SEX;
run;
 
data _null_;
	dcl hash h(multidata:'y');
	h.definekey('SEX');
	h.definedone();
	do until(last.SEX);
		set class;
		by SEX;
		h.add();
	end;
	h.output(dataset:cats('sex_', SEX));
run;
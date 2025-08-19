%let pgm=utl-fixing-add-attributes-sas-macros-for-vartype-varlength-varfmt-varinfmt-varlabel-varcount-varnum;

%stop_submission;


This repo
https://tinyurl.com/mvca4z4f
https://github.com/rogerjdeangelis/utl-fixing-add-attributes-sas-macros-for-vartype-varlength-varfmt-varinfmt-varlabel-varcount-varnum

Fixing adding sas macros for vartype varlength varfmt varinfmt varlabel varcount varnum

CORRECTING THESE REPOS (WILL HAVE FIXES LATER TODAY)

macros
https://tinyurl.com/y9nfugth
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories

github
https://tinyurl.com/3axaxt8s
https://github.com/rogerjdeangelis/utl-adding-attributes-sas-macros-for-vartype-varlength-varfmt-varinfmt-varlabel-varcount-varnum

ithub
https://tinyurl.com/48kcestb
https://github.com/rogerjdeangelis/utl-get-text-file-attributes-and-window-file-properties-powershell-python-sas

macros
https://tinyurl.com/y9nfugth
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories

STATUS

 FILE ATTRIBUTES

 Flat files       ok as is
 utl_CreateTime   ok as is
 utl_filesize     ok as is
 utl_LastModified ok as is

 SAS DATASET VARIABLE ATTRIBUTES

 utl_varcount  fix embedded simi-colon
 utl_varfmt    fix
 utl_varifmt   fix
 utl_varlabel  fix
 utl_varlen    fix
 utl_varnum    fix
 utl_vartype   fix


CORRECTION

   OLD CODE
   ========

     %macro utl_varcount(dsn)/des="Number of variables";
       %local dsid posv rc;
         %let dsid = %sysfunc(open(&dsn,i));
         %sysfunc(attrn(&dsid,NVARS));
         %let rc = %sysfunc(close(&dsid));
     %mend utl_varcount;

   This failed because of embedded simi column

     data _null_;
         set sashelp.bweight;
         array bwt[%utl_varcount(sashelp.bweight)] %utl_varlist(sashelp.bweight);
     run;quit;


     2654  +array bwt[
     2655  +10;
              -
              22
              76
     MPRINT(DEBUG.DEBUGA):   array bwt[ 10;
     2656  +]

   As I side note, you need to run the macro debug command to see where the error is located;

   NEW CODE (removed pesky simicolumn)
   ====================================

     %macro utl_varcount(dsn)/des="Number of variables";
       %local dsid posv rc;
         %let dsid = %sysfunc(open(&dsn,i));

         %let res=%sysfunc(attrn(&dsid,NVARS)); /*-- note change ---*/

         %let rc = %sysfunc(close(&dsid));

        &res   /*--- added this to eliminate imbedded simi-colon ---*/

     %mend utl_varcount;

     data _null_;
         set sashelp.bweight;
         array bwt[%utl_varcount(sashelp.bweight)] %utl_varlist(sashelp.bweight);
     run;quit;

     From macro degug
     MPRINT(DEBUG.DEBUGA):   array bwt[ 10 ] WEIGHT BLACK MARRIED BOY MOMAGE MOMSMOKE CIGSPERDAY MOMWTGAIN VISIT MOMEDLEVEL ;

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/



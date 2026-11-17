//REBIND01 JOB (ACCT),'REBIND EOD',CLASS=A,MSGCLASS=X,NOTIFY=&SYSUID
//*===================================================================*
//* REBIND JOB : REBIND01 - REBIND STATIC PACKAGE POST-INDEX CREATION *
//* SUBSYSTEM  : DB2A (Db2 13 for z/OS)                               *
//* PACKAGE    : COL_BANKING.BNK7100B                                  *
//*===================================================================*
//STEP01   EXEC PGM=IKJEFT01
//STEPLIB  DD DISP=SHR,DSN=DSN1310.SDSNLOAD
//SYSTSPRT DD SYSOUT=*
//SYSTSIN  DD *
  DSN SYSTEM(DB2A)
  BIND PACKAGE(COL_BANKING) MEMBER(BNK7100B) -
       ACTION(REPLACE) -
       EXPLAIN(YES) -
       PLANMGMT(EXTENDED) -
       APREUSE(NONE) -
       ISOLATION(CS) -
       RELEASE(COMMIT)
  END
/*

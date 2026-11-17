       IDENTIFICATION DIVISION.
       PROGRAM-ID. BNK7100B.
       AUTHOR. IBM DB2 AI FOR Z/OS DEMO TEAM.
      *================================================================*
      * PROGRAM: BNK7100B - CORE BANKING EOD LEDGER & INTEREST POSTING *
      * SCENARIO: STATIC SQL BATCH QUERY TARGETED BY DB2 AI FOR Z/OS   *
      *================================================================*
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
           EXEC SQL INCLUDE SQLCA END-EXEC.

           EXEC SQL BEGIN DECLARE SECTION END-EXEC.
           01 WS-ACCT-ID             PIC X(10) VALUE 'ACC8829101'.
           01 WS-POSTING-DATE        PIC X(10) VALUE '2026-11-01'.
           01 WS-TOTAL-AMT           PIC S9(11)V99 COMP-3.
           01 WS-TOTAL-COUNT         PIC S9(9) COMP.
           01 WS-STATUS-CODE         PIC X(10) VALUE 'POSTED'.
           EXEC SQL END DECLARE SECTION END-EXEC.

           01 WS-DISPLAY-AMT         PIC $$$,$$$,$$9.99.
           01 WS-DISPLAY-COUNT       PIC ZZZ,ZZ9.

       PROCEDURE DIVISION.
       0000-MAIN-PROCESSING.
           DISPLAY '==================================================='
           DISPLAY 'BNK7100B: STARTING END-OF-DAY BATCH RECONCILIATION'
           DISPLAY '==================================================='

           PERFORM 1000-AGGREGATE-POSTED-TXNS
           PERFORM 2000-EVALUATE-RESULTS

           DISPLAY '==================================================='
           DISPLAY 'BNK7100B: PROCESSING COMPLETED SUCCESSFULLY'
           DISPLAY '==================================================='
           GOBACK.

       1000-AGGREGATE-POSTED-TXNS.
      *----------------------------------------------------------------*
      * STATIC SQL STATEMENT #420 IDENTIFIED BY DB2ZAI FOR TUNING       *
      * BASELINE: MATCHCOLS=1, INDEXONLY=N (HIGH GETPAGES / SLOW)      *
      * OPTIMIZED: MATCHCOLS=2, INDEXONLY=Y (ZERO DATA PAGE READS)     *
      *----------------------------------------------------------------*
           EXEC SQL
               SELECT SUM(TXN_AMOUNT), COUNT(*)
                 INTO :WS-TOTAL-AMT, :WS-TOTAL-COUNT
                 FROM BANKDB01.ACCT_TRANSACTION
                WHERE ACCT_ID      = :WS-ACCT-ID
                  AND TXN_DATE    >= :WS-POSTING-DATE
                  AND STATUS_CODE  = :WS-STATUS-CODE
           END-EXEC.

           IF SQLCODE NOT = 0
               DISPLAY 'SQL ERROR IN STMT #420. SQLCODE: ' SQLCODE
               MOVE 12 TO RETURN-CODE
           END-IF.

       2000-EVALUATE-RESULTS.
           MOVE WS-TOTAL-AMT   TO WS-DISPLAY-AMT
           MOVE WS-TOTAL-COUNT TO WS-DISPLAY-COUNT
           DISPLAY 'ACCOUNT ID: ' WS-ACCT-ID
           DISPLAY 'TOTAL POSTED TXN COUNT: ' WS-DISPLAY-COUNT
           DISPLAY 'TOTAL POSTED TXN AMOUNT: ' WS-DISPLAY-AMT.

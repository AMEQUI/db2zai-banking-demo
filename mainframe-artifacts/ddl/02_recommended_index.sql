-- ==============================================================================
-- DDL 02: Db2 AI for z/OS Recommended Covering Index
-- Recommendation ID: REC-2026-IX04
-- Target Query: Stmt #420 in Package COL_BANKING.BNK7100B
-- ==============================================================================

-- Create the covering index that enables Index Screening & Index-Only access
CREATE INDEX BANKDB01.IX_TXN_ACCT_EOD
    ON BANKDB01.ACCT_TRANSACTION
     ( ACCT_ID      ASC,
       TXN_DATE     ASC,
       STATUS_CODE  ASC,
       TXN_AMOUNT   ASC )
    USING STOGROUP BANKSTG
    PRIQTY 150000 SECQTY 15000
    BUFFERPOOL BP2
    CLOSE NO;

COMMIT;

-- Optional: Run RUNSTATS to update catalog statistics
-- RUNSTATS TABLESPACE BANKDB01.TSTRANS INDEX(ALL) KEYCARD UPDATE ALL

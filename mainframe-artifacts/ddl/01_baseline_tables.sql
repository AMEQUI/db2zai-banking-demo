-- ==============================================================================
-- DDL 01: Baseline Banking Schema and Initial (Non-Covering) Index
-- Subsystem: DB2A | Database: BANKDB01
-- ==============================================================================

CREATE DATABASE BANKDB01
    BUFFERPOOL BP1
    INDEXBP BP2
    CCSID UNICODE;

COMMIT;

CREATE TABLESPACE TSTRANS
    IN BANKDB01
    USING STOGROUP BANKSTG
    PRIQTY 500000 SECQTY 50000
    ERASE NO
    FREEPAGE 5 PCTFREE 10
    BUFFERPOOL BP1
    LOCKSIZE ROW
    SEGSIZE 32;

COMMIT;

CREATE TABLE BANKDB01.ACCT_TRANSACTION
    ( TXN_ID          BIGINT GENERATED ALWAYS AS IDENTITY NOT NULL,
      ACCT_ID         CHAR(10) NOT NULL,
      TXN_DATE        DATE NOT NULL,
      TXN_TIME        TIME NOT NULL,
      TXN_AMOUNT      DECIMAL(11,2) NOT NULL,
      TXN_TYPE        CHAR(4) NOT NULL,
      STATUS_CODE     CHAR(10) NOT NULL,
      BRANCH_CODE     CHAR(6),
      DESCRIPTION     VARCHAR(100),
      PRIMARY KEY (TXN_ID)
    )
    IN BANKDB01.TSTRANS;

COMMIT;

-- Baseline Index (Non-Covering: requires table page reads for STATUS_CODE and TXN_AMOUNT)
CREATE INDEX BANKDB01.IX_TXN_ACCT_DT
    ON BANKDB01.ACCT_TRANSACTION
     ( ACCT_ID   ASC,
       TXN_DATE  ASC )
    USING STOGROUP BANKSTG
    PRIQTY 100000 SECQTY 10000
    BUFFERPOOL BP2
    CLOSE NO;

COMMIT;

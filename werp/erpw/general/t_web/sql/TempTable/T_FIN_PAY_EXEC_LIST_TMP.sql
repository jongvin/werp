CREATE Global Temporary TABLE T_FIN_PAY_EXEC_LIST_TMP (
       COMP_CODE            VARCHAR2(10) NOT NULL,
       WORK_DT              DATE NOT NULL,
       SEQ                  NUMBER NOT NULL,
       CRTUSERNO            VARCHAR2(8) NULL,
       CRTDATE              DATE NULL,
       MODUSERNO            VARCHAR2(8) NULL,
       MODDATE              DATE NULL,
       EXEC_KIND_TAG        VARCHAR2(1) NULL,
       TARGET_SLIP_ID       NUMBER NULL,
       TARGET_SLIP_IDSEQ    NUMBER NULL,
       EXEC_AMT             NUMBER NULL,
       OUT_ACC_NO           VARCHAR2(20) NULL,
       IN_BANK_MAIN_CODE    VARCHAR2(4) NULL,
       IN_ACC_NO            VARCHAR2(20) NULL,
       ACCNO_OWNER          VARCHAR2(60) NULL,
       SLIP_PUB_SEQ         NUMBER NULL,
       SLIP_ID              NUMBER NULL,
       SLIP_IDSEQ           NUMBER NULL,
       CHK_BILL_NO          VARCHAR2(20) NULL,
       EXPR_DT              DATE NULL
);
ALTER TABLE T_FIN_PAY_EXEC_LIST_TMP
       ADD  ( PRIMARY KEY (COMP_CODE, WORK_DT, SEQ) ) ;

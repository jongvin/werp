CREATE Global Temporary TABLE T_CARD_ACCOUNTING_DETAIL_T (
       CardNumber           VARCHAR2(16) NOT NULL,
       AdjustYearMonth      VARCHAR2(6) NOT NULL,
       AcctSubSeq           NUMBER NOT NULL,
       SeqNo                NUMBER NULL,
       ACC_CODE             VARCHAR2(10) NULL,
       CrAmt                NUMBER(13) NULL,
       DrAmt                NUMBER(13) NULL,
       SupplyAmt            NUMBER(13) NULL,
       VatAmt               NUMBER(13) NULL,
       TaxGubun             VARCHAR2(2) NULL,
       UsageGubun           VARCHAR2(1) NULL,
       MerchantName         VARCHAR2(50) NULL,
       ApprovalDate         VARCHAR2(8) NULL,
       ApprovalTime         VARCHAR2(6) NULL,
       ApprovalNumber       VARCHAR2(10) NULL,
       MccName              VARCHAR2(20) NULL,
       Attribute1           VARCHAR2(200) NULL,
       Attribute2           VARCHAR2(200) NULL,
       Attribute3           VARCHAR2(200) NULL
)
/

CREATE INDEX IX_CARD_ACCOUNTING_DETAIL_T_01 ON T_CARD_ACCOUNTING_DETAIL_T
(
       ACC_CODE                       ASC
)
/
ALTER TABLE T_CARD_ACCOUNTING_DETAIL_T
       ADD  ( PRIMARY KEY (CardNumber, AdjustYearMonth, AcctSubSeq))
/

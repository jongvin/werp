Create Or Replace Procedure SP_T_FIN_LOAN_SHEET_I
(
	AR_LOAN_NO                                 VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_LOAN_KIND_CODE                          VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_LOAN_NAME                               VARCHAR2,
	AR_BANK_CODE                               VARCHAR2,
	AR_LOAN_AMT                                NUMBER,
	AR_LIMIT_AMT                               NUMBER,
	AR_LOAN_FDT                                VARCHAR2,
	AR_LOAN_EXPR_DT                            VARCHAR2,
	AR_CHG_EXPR_DT                             VARCHAR2,
	AR_REAL_INTR_RATE                          NUMBER,
	AR_TITLE_INTR_RATE                         NUMBER,
	AR_ORG_REFUND_YEAR                         VARCHAR2,
	AR_ORG_REFUND_DIV_YEAR                     VARCHAR2,
	AR_ORG_REFUND_MONTH                        VARCHAR2,
	AR_ORG_REFUND_FIRST_MONTH                  VARCHAR2,
	AR_INTR_MTHD                               VARCHAR2,
	AR_INTR_REFUND_DAY                         VARCHAR2,
	AR_INTR_REFUND_DIV_MONTH                   VARCHAR2,
	AR_INTR_REFUND_FIRST_DT                    VARCHAR2,
	AR_REMARK                                  VARCHAR2,
	AR_REAL_LOAN_NO                            VARCHAR2,
	AR_LOAN_CONT_NO                            NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_LOAN_SHEET_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_LOAN_SHEET ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-29)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	lrT_FIN_BILL_KIND							T_FIN_BILL_KIND%RowType;
	lbFound										Boolean;
Begin
	Insert Into T_FIN_LOAN_SHEET
	(
		LOAN_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		LOAN_KIND_CODE,
		COMP_CODE,
		LOAN_NAME,
		BANK_CODE,
		LOAN_AMT,
		LIMIT_AMT,
		LOAN_FDT,
		LOAN_EXPR_DT,
		CHG_EXPR_DT,
		REAL_INTR_RATE,
		TITLE_INTR_RATE,
		ORG_REFUND_YEAR,
		ORG_REFUND_DIV_YEAR,
		ORG_REFUND_MONTH,
		ORG_REFUND_FIRST_MONTH,
		INTR_MTHD,
		INTR_REFUND_DAY,
		INTR_REFUND_DIV_MONTH,
		INTR_REFUND_FIRST_DT,
		REMARK,
		REAL_LOAN_NO,
		LOAN_CONT_NO
	)
	Values
	(
		AR_LOAN_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_LOAN_KIND_CODE,
		AR_COMP_CODE,
		AR_LOAN_NAME,
		AR_BANK_CODE,
		AR_LOAN_AMT,
		AR_LIMIT_AMT,
		F_T_StringToDate(AR_LOAN_FDT),
		F_T_StringToDate(AR_LOAN_EXPR_DT),
		F_T_StringToDate(AR_CHG_EXPR_DT),
		AR_REAL_INTR_RATE,
		AR_TITLE_INTR_RATE,
		AR_ORG_REFUND_YEAR,
		AR_ORG_REFUND_DIV_YEAR,
		AR_ORG_REFUND_MONTH,
		F_T_StringToDate(AR_ORG_REFUND_FIRST_MONTH),
		AR_INTR_MTHD,
		AR_INTR_REFUND_DAY,
		AR_INTR_REFUND_DIV_MONTH,
		F_T_StringToDate(AR_INTR_REFUND_FIRST_DT),
		AR_REMARK,
		AR_REAL_LOAN_NO,
		AR_LOAN_CONT_NO
	);
	Begin
		Select
			*
		Into
			lrT_FIN_BILL_KIND
		From	T_FIN_BILL_KIND a
		Where	a.REL_LOAN_KIND_CODE = AR_LOAN_KIND_CODE;
		lbFound := True;
	Exception When No_Data_Found Then
		lbFound := False;
	End;
	If lbFound Then				--���� �ش� ������ ȯ���� ó�� ���޾����� ���õ� ���̶��
		If AR_BANK_CODE Is Null Then
			Raise_Application_Error(-20009,'������ �ݵ�� ����ϼž� �մϴ�.');
		End If;
		If AR_COMP_CODE Is Null Then
			Raise_Application_Error(-20009,'������� �ݵ�� ����ϼž� �մϴ�.');
		End If;
		Begin
			Insert Into T_FIN_PAY_CHK_BILL
			(
				CHK_BILL_NO,
				CRTUSERNO,
				CRTDATE,
				MODUSERNO,
				MODDATE,
				CHK_BILL_CLS,
				BILL_KIND,
				STAT_CLS,
				COMP_CODE,
				BANK_CODE,
				CUST_SEQ,
				ACPT_DT,
				PUBL_DT,
				PUBL_AMT,
				EXPR_DT,
				CHG_EXPR_DT,
				DUSE_DT,
				CUST_DOUT_DT,
				COLL_DT,
				RETURN_DT,
				DISC_RAT,
				DISC_AMT,
				SLIP_ID,
				SLIP_IDSEQ,
				RESET_SLIP_ID,
				RESET_SLIP_IDSEQ,
				REMARKS
			)
			Values
			(
				AR_REAL_LOAN_NO,
				AR_CRTUSERNO,
				SysDate,
				Null,
				Null,
				'B',
				lrT_FIN_BILL_KIND.BILL_KIND,
				'2',		--�⺻ ���� ���·�...
				AR_COMP_CODE,
				AR_BANK_CODE,
				Null,
				AR_LOAN_FDT,
				AR_LOAN_FDT,
				AR_LOAN_AMT,
				AR_LOAN_EXPR_DT,
				Null,
				Null,
				Null,
				Null,
				Null,
				Null,
				Null,
				Null,
				Null,
				Null,
				Null,
				Null
			);
		Exception When Dup_Val_On_Index Then
			Null;
		End;
	End If;
End;
/
Create Or Replace Procedure SP_T_FIN_LOAN_SHEET_U
(
	AR_LOAN_NO                                 VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_LOAN_KIND_CODE                          VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_LOAN_NAME                               VARCHAR2,
	AR_BANK_CODE                               VARCHAR2,
	AR_LOAN_AMT                                NUMBER,
	AR_LIMIT_AMT                               NUMBER,
	AR_LOAN_FDT                                VARCHAR2,
	AR_LOAN_EXPR_DT                            VARCHAR2,
	AR_CHG_EXPR_DT                             VARCHAR2,
	AR_REAL_INTR_RATE                          NUMBER,
	AR_TITLE_INTR_RATE                         NUMBER,
	AR_ORG_REFUND_YEAR                         VARCHAR2,
	AR_ORG_REFUND_DIV_YEAR                     VARCHAR2,
	AR_ORG_REFUND_MONTH                        VARCHAR2,
	AR_ORG_REFUND_FIRST_MONTH                  VARCHAR2,
	AR_INTR_MTHD                               VARCHAR2,
	AR_INTR_REFUND_DAY                         VARCHAR2,
	AR_INTR_REFUND_DIV_MONTH                   VARCHAR2,
	AR_INTR_REFUND_FIRST_DT                    VARCHAR2,
	AR_REMARK                                  VARCHAR2,
	AR_REAL_LOAN_NO                            VARCHAR2,
	AR_LOAN_CONT_NO                            NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_LOAN_SHEET_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_LOAN_SHEET ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-29)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
Begin
	Update T_FIN_LOAN_SHEET
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		LOAN_KIND_CODE = AR_LOAN_KIND_CODE,
		COMP_CODE = AR_COMP_CODE,
		LOAN_NAME = AR_LOAN_NAME,
		BANK_CODE = AR_BANK_CODE,
		LOAN_AMT = AR_LOAN_AMT,
		LIMIT_AMT = AR_LIMIT_AMT,
		LOAN_FDT = F_T_StringToDate(AR_LOAN_FDT),
		LOAN_EXPR_DT = F_T_StringToDate(AR_LOAN_EXPR_DT),
		CHG_EXPR_DT = F_T_StringToDate(AR_CHG_EXPR_DT),
		REAL_INTR_RATE = AR_REAL_INTR_RATE,
		TITLE_INTR_RATE = AR_TITLE_INTR_RATE,
		ORG_REFUND_YEAR = AR_ORG_REFUND_YEAR,
		ORG_REFUND_DIV_YEAR = AR_ORG_REFUND_DIV_YEAR,
		ORG_REFUND_MONTH = AR_ORG_REFUND_MONTH,
		ORG_REFUND_FIRST_MONTH = F_T_StringToDate(AR_ORG_REFUND_FIRST_MONTH),
		INTR_MTHD = AR_INTR_MTHD,
		INTR_REFUND_DAY = AR_INTR_REFUND_DAY,
		INTR_REFUND_DIV_MONTH = AR_INTR_REFUND_DIV_MONTH,
		INTR_REFUND_FIRST_DT = F_T_StringToDate(AR_INTR_REFUND_FIRST_DT),
		REMARK = AR_REMARK,
		REAL_LOAN_NO = AR_REAL_LOAN_NO,
		LOAN_CONT_NO = AR_LOAN_CONT_NO
	Where	LOAN_NO = AR_LOAN_NO;
End;
/
Create Or Replace Procedure SP_T_FIN_LOAN_SHEET_D
(
	AR_LOAN_NO                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_LOAN_SHEET_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_LOAN_SHEET ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-29)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
Begin
	Delete T_FIN_LOAN_SHEET
	Where	LOAN_NO = AR_LOAN_NO;
End;
/

CREATE OR REPLACE Procedure SP_T_BUDG_DEPT_H_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                 NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_CONFIRM_TAG                             VARCHAR2,
	AR_BUDG_APPLY_YM                           VARCHAR2,
	AR_REQUEST_TAG                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_DEPT_H_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BUDG_DEPT_H ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-15)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
ls_CONFIRM_TAG					T_BUDG_DEPT_H.CONFIRM_TAG%Type;
Begin
	 Select	CONFIRM_TAG
	 Into	ls_CONFIRM_TAG
	 From	T_BUDG_DEPT_H a
	 Where	COMP_CODE = AR_COMP_CODE
	 And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	 And	DEPT_CODE = AR_DEPT_CODE
	 And	CHG_SEQ = AR_CHG_SEQ - 1;
	 If ls_CONFIRM_TAG = 'F' Then
		Raise_Application_Error(-20009,'������ ������ ��Ȯ���Ǿ� �����û�� �Ұ����մϴ�.');
	 End If;
	 
	 Insert Into T_BUDG_DEPT_H
	 (
		COMP_CODE,
		CLSE_ACC_ID,
		DEPT_CODE,
		CHG_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CONFIRM_TAG,
		BUDG_APPLY_YM
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_DEPT_CODE,
		AR_CHG_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_CONFIRM_TAG,
		To_Date(AR_BUDG_APPLY_YM,'YYYY-MM')
	);	 
	 	
	Insert Into T_BUDG_DEPT_ITEM_H
	(
		COMP_CODE,
		CLSE_ACC_ID,
		DEPT_CODE,
		CHG_SEQ,
		BUDG_CODE_NO,
		RESERVED_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		TARGET_DEPT_CODE,
		BUDG_ADD_AMT,
		BUDG_ITEM_REQ_AMT,
		BUDG_ITEM_ASSIGN_AMT,
		REMARKS
	)   
	Select 
		COMP_CODE,
		CLSE_ACC_ID,
		DEPT_CODE,
		AR_CHG_SEQ,
		BUDG_CODE_NO,
		RESERVED_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		TARGET_DEPT_CODE,
		BUDG_ADD_AMT,
		BUDG_ITEM_REQ_AMT,
		BUDG_ITEM_ASSIGN_AMT,
		REMARKS
	FROM   T_BUDG_DEPT_ITEM_H
	Where  Comp_code= AR_COMP_CODE
	And	   CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	   DEPT_CODE = AR_DEPT_CODE
	And	   chg_seq = AR_CHG_SEQ - 1;
		 
		
	Insert Into T_BUDG_MONTH_AMT_H
	(
		COMP_CODE,
		CLSE_ACC_ID,
		DEPT_CODE,
		CHG_SEQ,
		BUDG_CODE_NO,
		RESERVED_SEQ,
		BUDG_YM,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		BUDG_MONTH_REQ_AMT,
		BUDG_MONTH_ASSIGN_AMT,
		REMARKS
	) 
	Select 
		   	COMP_CODE,
			CLSE_ACC_ID,
			DEPT_CODE,
			AR_CHG_SEQ,
			BUDG_CODE_NO,
			RESERVED_SEQ,
			BUDG_YM,
			CRTUSERNO,
			CRTDATE,
			MODUSERNO,
			MODDATE,
			BUDG_MONTH_REQ_AMT,
			BUDG_MONTH_ASSIGN_AMT,
			REMARKS
	From T_BUDG_MONTH_AMT_H
	Where  Comp_code= AR_COMP_CODE
	And	   CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	   DEPT_CODE = AR_DEPT_CODE
	And	   CHG_SEQ = AR_CHG_SEQ-1;
	
	Update	T_BUDG_DEPT
	Set		LAST_WORK_SEQ = AR_CHG_SEQ
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		DEPT_CODE = AR_DEPT_CODE;	 
End;
/

CREATE OR REPLACE Procedure SP_T_BUDG_DEPT_H_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                 NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_CONFIRM_TAG                             VARCHAR2,
	AR_BUDG_APPLY_YM                           VARCHAR2,
	AR_REQUEST_TAG                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_DEPT_H_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BUDG_DEPT_H ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-15)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
ls_CONFIRM_TAG					T_BUDG_DEPT_H.CONFIRM_TAG%Type;
Begin
	If AR_CHG_SEQ = 0 Then
	   SP_T_BUDG_CHECK_REQ_CLSE_DT(AR_COMP_CODE,AR_CLSE_ACC_ID,AR_DEPT_CODE);
	End If; 
	Select	CONFIRM_TAG
	Into	ls_CONFIRM_TAG
	From	T_BUDG_DEPT_H a
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		DEPT_CODE = AR_DEPT_CODE
	And		CHG_SEQ = AR_CHG_SEQ;
	If ls_CONFIRM_TAG = 'T' Then
		Raise_Application_Error(-20009,'�ش� ������ �̹� Ȯ���Ǿ� ������ �Ұ����մϴ�.');
	End If;
	Update T_BUDG_DEPT_H
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		CONFIRM_TAG = AR_CONFIRM_TAG,
		BUDG_APPLY_YM = to_date(AR_BUDG_APPLY_YM,'YYYY-MM'),
		REQUEST_TAG = AR_REQUEST_TAG
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	CHG_SEQ = AR_CHG_SEQ;
End;
/
CREATE OR REPLACE Procedure SP_T_BUDG_DEPT_H_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                 NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_DEPT_H_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BUDG_DEPT_H ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-15)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
ls_CONFIRM_TAG					T_BUDG_DEPT_H.CONFIRM_TAG%Type;
ls_R_CNT					            	NUMBER;
Begin
	If AR_CHG_SEQ = 0 Then
	   SP_T_BUDG_CHECK_REQ_CLSE_DT(AR_COMP_CODE,AR_CLSE_ACC_ID,AR_DEPT_CODE);
	End If; 
	Select	CONFIRM_TAG
	Into	ls_CONFIRM_TAG
	From	T_BUDG_DEPT_H a
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		DEPT_CODE = AR_DEPT_CODE
	And		CHG_SEQ = AR_CHG_SEQ;
	If ls_CONFIRM_TAG = 'T' Then
		Raise_Application_Error(-20009,'�ش� ������ �̹� Ȯ���Ǿ� �����û��Ұ� �Ұ����մϴ�.');
	End If;
	
	Select	count(CONFIRM_TAG)
	Into	ls_R_CNT
	From	T_BUDG_DEPT_H a
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		DEPT_CODE = AR_DEPT_CODE
	And		CHG_SEQ > AR_CHG_SEQ;
	If ls_R_CNT > 0 Then
		Raise_Application_Error(-20009,'���������� �����ϱ� ������ ���������� �����Ҽ� �����ϴ�');
	End If;
	
	Delete T_BUDG_MONTH_AMT_H
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	CHG_SEQ = AR_CHG_SEQ;
	
	Delete T_BUDG_DEPT_ITEM_H
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	CHG_SEQ = AR_CHG_SEQ;
	
	if AR_CHG_SEQ > 0 then
	    Delete T_BUDG_MONTH_REQ_DETAIL
		Where	COMP_CODE = AR_COMP_CODE
		And	CLSE_ACC_ID = AR_CLSE_ACC_ID
		And	DEPT_CODE = AR_DEPT_CODE
		And	CHG_SEQ = AR_CHG_SEQ;
		
		Delete T_BUDG_MONTH_REQ
		Where	COMP_CODE = AR_COMP_CODE
		And	CLSE_ACC_ID = AR_CLSE_ACC_ID
		And	DEPT_CODE = AR_DEPT_CODE
		And	CHG_SEQ = AR_CHG_SEQ;
	End If;
	
	Delete T_BUDG_DEPT_H
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	CHG_SEQ = AR_CHG_SEQ;
	If AR_CHG_SEQ = 0 then
		Delete T_BUDG_DEPT
		Where	COMP_CODE = AR_COMP_CODE
		And	CLSE_ACC_ID = AR_CLSE_ACC_ID
		And	DEPT_CODE = AR_DEPT_CODE;
	elsif AR_CHG_SEQ > 0 then
		Update	T_BUDG_DEPT
		Set		LAST_CONFIRMED_SEQ = AR_CHG_SEQ -1,
		        LAST_WORK_SEQ = AR_CHG_SEQ -1
		Where	COMP_CODE = AR_COMP_CODE
		And		CLSE_ACC_ID = AR_CLSE_ACC_ID
		And		DEPT_CODE = AR_DEPT_CODE;
	End If;
End;
/

CREATE OR REPLACE Procedure SP_T_BUDG_ALL_CHANGE_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_ALL_CHG_SEQ                             NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_BUDG_APPLY_YM                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_ALL_CHANGE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BUDG_ALL_CHANGE ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-05)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
ln_Count						               Number;
ls_clse_acc_id								   Varchar2(4);
Begin
	
	select count(*)
	into   ln_Count
	from t_budg_dept_h
	where comp_code   = AR_COMP_CODE
	and	  clse_acc_id = AR_CLSE_ACC_ID;

	if ln_Count = 0 then
	   	  Raise_Application_Error(-20009,'�μ��� ���ʿ����� �������� �ʾ� <br> �ϰ����꺯������ �� �� �����ϴ�');		  
	end if;
	
	select to_char(sysdate,'YYYY')
	into   ls_clse_acc_id
	from dual;

	if ls_clse_acc_id > AR_CLSE_ACC_ID then
	   	  Raise_Application_Error(-20009,'ȸ�Ⱑ ���� �ϰ� ���꺯���� �Ҽ� �����ϴ�');		  
	end if;
	
	Insert Into T_BUDG_ALL_CHANGE
	(
		COMP_CODE,
		CLSE_ACC_ID,
		ALL_CHG_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		BUDG_APPLY_YM
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_ALL_CHG_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		to_Date(AR_BUDG_APPLY_YM,'yyyy-mm')
	);
	SP_T_BUDG_ALL_CHANGE_DETAIL(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_ALL_CHG_SEQ, AR_CRTUSERNO, AR_BUDG_APPLY_YM);

End;
/
Create Or Replace Procedure SP_T_BUDG_ALL_CHANGE_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_ALL_CHG_SEQ                             NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_BUDG_APPLY_YM                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_ALL_CHANGE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BUDG_ALL_CHANGE ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-05)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_BUDG_ALL_CHANGE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		BUDG_APPLY_YM = to_Date(AR_BUDG_APPLY_YM,'YYYY-MM')
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	ALL_CHG_SEQ = AR_ALL_CHG_SEQ;
End;
/
CREATE OR REPLACE Procedure SP_T_BUDG_ALL_CHANGE_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_ALL_CHG_SEQ                             NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_ALL_CHANGE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BUDG_ALL_CHANGE ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-05)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
ls_clse_acc_id								   Varchar2(4);
Begin

	select to_char(sysdate,'YYYY')
	into   ls_clse_acc_id
	from dual;

	if ls_clse_acc_id > AR_CLSE_ACC_ID then
	   	  Raise_Application_Error(-20009,'ȸ�Ⱑ ���� �ϰ� ���꺯����Ҹ�  �Ҽ� �����ϴ�');		  
	end if;
	
	--�μ������������� �����Ұ��(�ϰ�����Ȯ���� �Ȼ��¸�) ���� �Ұ�
	SP_T_BUDG_ALL_CHANGE_CHECK(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_ALL_CHG_SEQ);
	--���� ������ �����Ұ�� ���� �Ұ�
	SP_T_POST_BUDG_ALL_CHANGE_CHK(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_ALL_CHG_SEQ);
	--���������رݾ� ����
	Delete T_BUDG_BF_BASE_AMT
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	ALL_CHG_SEQ = AR_ALL_CHG_SEQ;
	
	--�������ο���Ȳ ���� 
	Delete T_BUDG_BF_ORDER_STAT
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	ALL_CHG_SEQ = AR_ALL_CHG_SEQ;
	
	--��������� �ݾ׻���
	Delete T_BUDG_NOW_APPL_AMT
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	ALL_CHG_SEQ = AR_ALL_CHG_SEQ;
	
	--������ο���Ȳ ���� 
	Delete T_BUDG_NOW_ORDER_STAT
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	ALL_CHG_SEQ = AR_ALL_CHG_SEQ;
	
	--�ϰ��������� ���� 
	Delete T_BUDG_ALL_CHANGE
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	ALL_CHG_SEQ = AR_ALL_CHG_SEQ;
	
	 
End;
/


Create Or Replace Procedure SP_T_BUDG_ITEM_GRADE_COST_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_BUDG_CODE_NO                            NUMBER,
	AR_ITEM_NO                                 NUMBER,
	AR_GRADE_CODE                              VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_UNIT_COST                               NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_ITEM_GRADE_COST_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BUDG_ITEM_GRADE_COST ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-13)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	--Ȯ������üũ
	if( F_T_CONFIRM_CHECK(AR_COMP_CODE, AR_CLSE_ACC_ID) <> 0) then
		Raise_Application_Error(-20009,'ȸ�Ⱑ Ȯ���Ǿ�  �ܰ��� ������ �� �����ϴ�');
	end if;
	
	Insert Into T_BUDG_ITEM_GRADE_COST
	(
		COMP_CODE,
		CLSE_ACC_ID,
		BUDG_CODE_NO,
		ITEM_NO,
		GRADE_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		UNIT_COST
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_BUDG_CODE_NO,
		AR_ITEM_NO,
		AR_GRADE_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_UNIT_COST
	);
End;
/
Create Or Replace Procedure SP_T_BUDG_ITEM_GRADE_COST_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_BUDG_CODE_NO                            NUMBER,
	AR_ITEM_NO                                 NUMBER,
	AR_GRADE_CODE                              VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_UNIT_COST                               NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_ITEM_GRADE_COST_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BUDG_ITEM_GRADE_COST ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-13)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	--Ȯ������üũ
	if( F_T_CONFIRM_CHECK(AR_COMP_CODE, AR_CLSE_ACC_ID) <> 0) then
		Raise_Application_Error(-20009,'ȸ�Ⱑ Ȯ���Ǿ�  �ܰ��� ������ �� �����ϴ�');
	end if;
	
	Update T_BUDG_ITEM_GRADE_COST
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		UNIT_COST = AR_UNIT_COST
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	BUDG_CODE_NO = AR_BUDG_CODE_NO
	And	ITEM_NO = AR_ITEM_NO
	And	GRADE_CODE = AR_GRADE_CODE;
End;
/
Create Or Replace Procedure SP_T_BUDG_ITEM_GRADE_COST_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_BUDG_CODE_NO                            NUMBER,
	AR_ITEM_NO                                 NUMBER,
	AR_GRADE_CODE                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_ITEM_GRADE_COST_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BUDG_ITEM_GRADE_COST ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-13)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	--Ȯ������üũ
	if( F_T_CONFIRM_CHECK(AR_COMP_CODE, AR_CLSE_ACC_ID) <> 0) then
		Raise_Application_Error(-20009,'ȸ�Ⱑ Ȯ���Ǿ�  �ܰ��� ������ �� �����ϴ�');
	end if;
	
	Delete T_BUDG_ITEM_GRADE_COST
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	BUDG_CODE_NO = AR_BUDG_CODE_NO
	And	ITEM_NO = AR_ITEM_NO
	And	GRADE_CODE = AR_GRADE_CODE;
End;
/

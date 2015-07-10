Create Or Replace Procedure SP_T_FL_DEPT_FORECAST_CLOSE_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_QUARTER_YEAR                            NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_FORE_CONFIRM_TAG                        VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_DEPT_FORECAST_CLOSE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_DEPT_FORECAST_CLOSE ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-17)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FL_DEPT_FORECAST_CLOSE
	(
		COMP_CODE,
		CLSE_ACC_ID,
		DEPT_CODE,
		QUARTER_YEAR,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		FORE_CONFIRM_TAG,
		REMARKS
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_DEPT_CODE,
		AR_QUARTER_YEAR,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_FORE_CONFIRM_TAG,
		AR_REMARKS
	);
End;
/
Create Or Replace Procedure SP_T_FL_DEPT_FORECAST_CLOSE_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_QUARTER_YEAR                            NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_FORE_CONFIRM_TAG                        VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_DEPT_FORECAST_CLOSE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_DEPT_FORECAST_CLOSE ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-17)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FL_DEPT_FORECAST_CLOSE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		FORE_CONFIRM_TAG = AR_FORE_CONFIRM_TAG,
		REMARKS = AR_REMARKS
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	QUARTER_YEAR = AR_QUARTER_YEAR;
End;
/
Create Or Replace Procedure SP_T_FL_DEPT_FORECAST_CLOSE_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_QUARTER_YEAR                            NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_DEPT_FORECAST_CLOSE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_DEPT_FORECAST_CLOSE ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-17)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FL_DEPT_FORECAST_CLOSE
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	QUARTER_YEAR = AR_QUARTER_YEAR;
End;
/

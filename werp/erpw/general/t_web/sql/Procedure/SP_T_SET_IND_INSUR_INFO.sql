Create Or Replace Procedure SP_T_SET_IND_INSUR_INFO_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_YM                                 VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_HO_IND_DISASTER_AMT                     NUMBER,
	AR_S_L_AMT_RATIO                           NUMBER,
	AR_INSUR_RATIO                             NUMBER,
	AR_PROJ_SUMMARY                            VARCHAR2,
	AR_CUST_SEQ                                Number
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SET_IND_INSUR_INFO_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SET_IND_INSUR_INFO ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-23)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_SET_IND_INSUR_INFO
	(
		COMP_CODE,
		WORK_YM,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		HO_IND_DISASTER_AMT,
		S_L_AMT_RATIO,
		INSUR_RATIO,
		PROJ_SUMMARY,
		CUST_SEQ
	)
	Values
	(
		AR_COMP_CODE,
		AR_WORK_YM,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_HO_IND_DISASTER_AMT,
		AR_S_L_AMT_RATIO,
		AR_INSUR_RATIO,
		AR_PROJ_SUMMARY,
		AR_CUST_SEQ
	);
End;
/
Create Or Replace Procedure SP_T_SET_IND_INSUR_INFO_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_YM                                 VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_HO_IND_DISASTER_AMT                     NUMBER,
	AR_S_L_AMT_RATIO                           NUMBER,
	AR_INSUR_RATIO                             NUMBER,
	AR_PROJ_SUMMARY                            VARCHAR2,
	AR_CUST_SEQ                                Number
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SET_IND_INSUR_INFO_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SET_IND_INSUR_INFO ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-23)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_SET_IND_INSUR_INFO
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		HO_IND_DISASTER_AMT = AR_HO_IND_DISASTER_AMT,
		S_L_AMT_RATIO = AR_S_L_AMT_RATIO,
		INSUR_RATIO = AR_INSUR_RATIO,
		PROJ_SUMMARY = AR_PROJ_SUMMARY,
		CUST_SEQ = AR_CUST_SEQ
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_YM = AR_WORK_YM;
End;
/
Create Or Replace Procedure SP_T_SET_IND_INSUR_INFO_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_YM                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SET_IND_INSUR_INFO_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SET_IND_INSUR_INFO ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-23)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_SET_IND_INSUR_INFO
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_YM = AR_WORK_YM;
End;
/

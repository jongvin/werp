Create Or Replace Procedure SP_T_FIX_DEPREC_CAL_TEMP_I
(
	AR_WORK_SEQ                                NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_WORK_NAME                               VARCHAR2,
	AR_TARGET_CLS                              VARCHAR2,
	AR_WORK_USENO                              NUMBER,
	AR_WORK_FROM_DT                            VARCHAR2,
	AR_WORK_TO_DT                              VARCHAR2,
	AR_TRANS_CLS                               VARCHAR2,
	AR_CAL_CLS                                 VARCHAR2,
	AR_REMARK                                  VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIX_DEPREC_CAL_TEMP_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIX_DEPREC_CAL_TEMP ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-03-08)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FIX_DEPREC_CAL_TEMP
	(
		WORK_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		COMP_CODE,
		WORK_DT,
		WORK_NAME,
		TARGET_CLS,
		WORK_USENO,
		WORK_FROM_DT,
		WORK_TO_DT,
		TRANS_CLS,
		CAL_CLS,
		REMARK
	)
	Values
	(
		AR_WORK_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_COMP_CODE,
		F_T_StringToDate(AR_WORK_DT),
		AR_WORK_NAME,
		AR_TARGET_CLS,
		AR_WORK_USENO,
		F_T_StringToDate(AR_WORK_FROM_DT),
		F_T_StringToDate(AR_WORK_TO_DT),
		AR_TRANS_CLS,
		AR_CAL_CLS,
		AR_REMARK
	);
End;
/
Create Or Replace Procedure SP_T_FIX_DEPREC_CAL_TEMP_U
(
	AR_WORK_SEQ                                NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_WORK_NAME                               VARCHAR2,
	AR_TARGET_CLS                              VARCHAR2,
	AR_WORK_USENO                              NUMBER,
	AR_WORK_FROM_DT                            VARCHAR2,
	AR_WORK_TO_DT                              VARCHAR2,
	AR_TRANS_CLS                               VARCHAR2,
	AR_CAL_CLS                                 VARCHAR2,
	AR_REMARK                                  VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIX_DEPREC_CAL_TEMP_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIX_DEPREC_CAL_TEMP ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-03-08)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FIX_DEPREC_CAL_TEMP
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		COMP_CODE = AR_COMP_CODE,
		WORK_DT = F_T_StringToDate(AR_WORK_DT),
		WORK_NAME = AR_WORK_NAME,
		TARGET_CLS = AR_TARGET_CLS,
		WORK_USENO = AR_WORK_USENO,
		WORK_FROM_DT = F_T_StringToDate(AR_WORK_FROM_DT),
		WORK_TO_DT = F_T_StringToDate(AR_WORK_TO_DT),
		TRANS_CLS = AR_TRANS_CLS,
		CAL_CLS = AR_CAL_CLS,
		REMARK = AR_REMARK
	Where	WORK_SEQ = AR_WORK_SEQ;
End;
/
Create Or Replace Procedure SP_T_FIX_DEPREC_CAL_TEMP_D
(
	AR_WORK_SEQ                                NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIX_DEPREC_CAL_TEMP_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIX_DEPREC_CAL_TEMP ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-03-08)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FIX_DEPREC_CAL_TEMP
	Where	WORK_SEQ = AR_WORK_SEQ;
End;
/

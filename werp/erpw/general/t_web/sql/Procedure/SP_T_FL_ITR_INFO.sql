Create Or Replace Procedure SP_T_FL_ITR_INFO_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_ITR_DATE_F                              VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ITR_DATE_TO                             VARCHAR2,
	AR_ITR_RATIO_IN                            NUMBER,
	AR_ITR_RATIO_OUT                           NUMBER,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_ITR_INFO_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_ITR_INFO ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-10)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FL_ITR_INFO
	(
		COMP_CODE,
		ITR_DATE_F,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ITR_DATE_TO,
		ITR_RATIO_IN,
		ITR_RATIO_OUT,
		REMARKS
	)
	Values
	(
		AR_COMP_CODE,
		F_T_StringToDate(AR_ITR_DATE_F),
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		F_T_StringToDate(AR_ITR_DATE_TO),
		AR_ITR_RATIO_IN,
		AR_ITR_RATIO_OUT,
		AR_REMARKS
	);
End;
/
Create Or Replace Procedure SP_T_FL_ITR_INFO_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_ITR_DATE_F                              VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_ITR_DATE_TO                             VARCHAR2,
	AR_ITR_RATIO_IN                            NUMBER,
	AR_ITR_RATIO_OUT                           NUMBER,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_ITR_INFO_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_ITR_INFO ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-10)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FL_ITR_INFO
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ITR_DATE_TO = F_T_StringToDate(AR_ITR_DATE_TO),
		ITR_RATIO_IN = AR_ITR_RATIO_IN,
		ITR_RATIO_OUT = AR_ITR_RATIO_OUT,
		REMARKS = AR_REMARKS
	Where	COMP_CODE = AR_COMP_CODE
	And	ITR_DATE_F = F_T_StringToDate(AR_ITR_DATE_F);
End;
/
Create Or Replace Procedure SP_T_FL_ITR_INFO_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_ITR_DATE_F                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_ITR_INFO_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_ITR_INFO ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-10)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FL_ITR_INFO
	Where	COMP_CODE = AR_COMP_CODE
	And	ITR_DATE_F = F_T_StringToDate(AR_ITR_DATE_F);
End;
/

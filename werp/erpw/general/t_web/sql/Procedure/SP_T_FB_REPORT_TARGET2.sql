Create Or Replace Procedure SP_T_FB_REPORT_TARGET2_I
(
	AR_CREATION_EMP_NO                         VARCHAR2,
	AR_PAY_SEQ                                 NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FB_REPORT_TARGET2_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FB_REPORT_TARGET2 ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FB_REPORT_TARGET2
	(
		CREATION_EMP_NO,
		PAY_SEQ
	)
	Values
	(
		AR_CREATION_EMP_NO,
		AR_PAY_SEQ
	);
End;
/
Create Or Replace Procedure SP_T_FB_REPORT_TARGET2_U
(
	AR_CREATION_EMP_NO                         VARCHAR2,
	AR_PAY_SEQ                                 NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FB_REPORT_TARGET2_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FB_REPORT_TARGET2 ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Null;
End;
/
Create Or Replace Procedure SP_T_FB_REPORT_TARGET2_D
(
	AR_CREATION_EMP_NO                         VARCHAR2,
	AR_PAY_SEQ                                 NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FB_REPORT_TARGET2_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FB_REPORT_TARGET2 ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FB_REPORT_TARGET2
	Where	CREATION_EMP_NO = AR_CREATION_EMP_NO
	And	PAY_SEQ = AR_PAY_SEQ;
End;
/
Create Or Replace Procedure SP_T_FB_REPORT_TARGET2_ALL_D
(
	AR_CREATION_EMP_NO                         VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FB_REPORT_TARGET2_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FB_REPORT_TARGET2 ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FB_REPORT_TARGET2
	Where	CREATION_EMP_NO = AR_CREATION_EMP_NO;
End;
/

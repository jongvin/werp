Create Or Replace Procedure SP_T_FB_REPORT_TARGET3_I
(
	AR_CREATION_EMP_NO                         VARCHAR2,
	AR_PAY_SEQ                                 NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FB_REPORT_TARGET3_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FB_REPORT_TARGET3 ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FB_REPORT_TARGET3
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
Create Or Replace Procedure SP_T_FB_REPORT_TARGET3_U
(
	AR_CREATION_EMP_NO                         VARCHAR2,
	AR_PAY_SEQ                                 NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FB_REPORT_TARGET3_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FB_REPORT_TARGET3 ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Null;
End;
/
Create Or Replace Procedure SP_T_FB_REPORT_TARGET3_D
(
	AR_CREATION_EMP_NO                         VARCHAR2,
	AR_PAY_SEQ                                 NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FB_REPORT_TARGET3_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FB_REPORT_TARGET3 ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FB_REPORT_TARGET3
	Where	CREATION_EMP_NO = AR_CREATION_EMP_NO
	And	PAY_SEQ = AR_PAY_SEQ;
End;
/
Create Or Replace Procedure SP_T_FB_REPORT_TARGET3_ALL_D
(
	AR_CREATION_EMP_NO                         VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FB_REPORT_TARGET3_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FB_REPORT_TARGET3 ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FB_REPORT_TARGET3
	Where	CREATION_EMP_NO = AR_CREATION_EMP_NO;
End;
/

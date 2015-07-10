Create Or Replace Procedure SP_T_BRAIN_SLIP_BODY_I
(
	AR_BRAIN_SLIP_SEQ1                         NUMBER,
	AR_BRAIN_SLIP_SEQ2                         NUMBER,
	AR_BRAIN_SLIP_LINE                         NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_BRAIN_SORT_SEQ                          NUMBER,
	AR_ACC_CODE                                VARCHAR2,
	AR_ACC_POSITION                            VARCHAR2,
	AR_SUMMARY_CODE                            VARCHAR2,
	AR_SUMMARY1                                VARCHAR2,
	AR_SUMMARY2                                VARCHAR2,
	AR_BRAIN_CLS                               VARCHAR2,
	AR_BRAIN_REPEAT_CLS                        VARCHAR2,
	AR_BRAIN_DEL_CLS                           VARCHAR2,
	AR_MAIN_ACC_CODE_TAG                       VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BRAIN_SLIP_BODY_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BRAIN_SLIP_BODY ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-05-30)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	lnCnt				Number;
Begin
	If AR_MAIN_ACC_CODE_TAG = 'T' Then	--���� ��ǥ�������� �ؾ� �Ѵٸ�
		Select
			Count(*)
		Into
			lnCnt
		From	T_MAIN_ACC_CODE
		Where	MAIN_ACC_CODE = AR_ACC_CODE;
		If lnCnt <> 1 Then
			Raise_Application_Error(-20009,'�ͼӿ� ���� �������� ���ΰ� ������ ��������� �ݵ�� �����ڵ�� ��ǥ������ �����Ͽ��� �մϴ�.');
		End If;
	End If;
	Insert Into T_BRAIN_SLIP_BODY
	(
		BRAIN_SLIP_SEQ1,
		BRAIN_SLIP_SEQ2,
		BRAIN_SLIP_LINE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		BRAIN_SORT_SEQ,
		ACC_CODE,
		ACC_POSITION,
		SUMMARY_CODE,
		SUMMARY1,
		SUMMARY2,
		BRAIN_CLS,
		BRAIN_REPEAT_CLS,
		BRAIN_DEL_CLS,
		MAIN_ACC_CODE_TAG
	)
	Values
	(
		AR_BRAIN_SLIP_SEQ1,
		AR_BRAIN_SLIP_SEQ2,
		AR_BRAIN_SLIP_LINE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_BRAIN_SORT_SEQ,
		AR_ACC_CODE,
		AR_ACC_POSITION,
		AR_SUMMARY_CODE,
		AR_SUMMARY1,
		AR_SUMMARY2,
		AR_BRAIN_CLS,
		AR_BRAIN_REPEAT_CLS,
		AR_BRAIN_DEL_CLS,
		AR_MAIN_ACC_CODE_TAG
	);
End;
/
Create Or Replace Procedure SP_T_BRAIN_SLIP_BODY_U
(
	AR_BRAIN_SLIP_SEQ1                         NUMBER,
	AR_BRAIN_SLIP_SEQ2                         NUMBER,
	AR_BRAIN_SLIP_LINE                         NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_BRAIN_SORT_SEQ                          NUMBER,
	AR_ACC_CODE                                VARCHAR2,
	AR_ACC_POSITION                            VARCHAR2,
	AR_SUMMARY_CODE                            VARCHAR2,
	AR_SUMMARY1                                VARCHAR2,
	AR_SUMMARY2                                VARCHAR2,
	AR_BRAIN_CLS                               VARCHAR2,
	AR_BRAIN_REPEAT_CLS                        VARCHAR2,
	AR_BRAIN_DEL_CLS                           VARCHAR2,
	AR_MAIN_ACC_CODE_TAG                       VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BRAIN_SLIP_BODY_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BRAIN_SLIP_BODY ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-05-30)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	lnCnt				Number;
Begin
	If AR_MAIN_ACC_CODE_TAG = 'T' Then	--���� ��ǥ�������� �ؾ� �Ѵٸ�
		Select
			Count(*)
		Into
			lnCnt
		From	T_MAIN_ACC_CODE
		Where	MAIN_ACC_CODE = AR_ACC_CODE;
		If lnCnt <> 1 Then
			Raise_Application_Error(-20009,'�ͼӿ� ���� �������� ���ΰ� ������ ��������� �ݵ�� �����ڵ�� ��ǥ������ �����Ͽ��� �մϴ�.');
		End If;
	End If;
	Update T_BRAIN_SLIP_BODY
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		BRAIN_SORT_SEQ = AR_BRAIN_SORT_SEQ,
		ACC_CODE = AR_ACC_CODE,
		ACC_POSITION = AR_ACC_POSITION,
		SUMMARY_CODE = AR_SUMMARY_CODE,
		SUMMARY1 = AR_SUMMARY1,
		SUMMARY2 = AR_SUMMARY2,
		BRAIN_CLS = AR_BRAIN_CLS,
		BRAIN_REPEAT_CLS = AR_BRAIN_REPEAT_CLS,
		BRAIN_DEL_CLS = AR_BRAIN_DEL_CLS,
		MAIN_ACC_CODE_TAG = AR_MAIN_ACC_CODE_TAG
	Where	BRAIN_SLIP_SEQ1 = AR_BRAIN_SLIP_SEQ1
	And	BRAIN_SLIP_SEQ2 = AR_BRAIN_SLIP_SEQ2
	And	BRAIN_SLIP_LINE = AR_BRAIN_SLIP_LINE;
End;
/
Create Or Replace Procedure SP_T_BRAIN_SLIP_BODY_D
(
	AR_BRAIN_SLIP_SEQ1                         NUMBER,
	AR_BRAIN_SLIP_SEQ2                         NUMBER,
	AR_BRAIN_SLIP_LINE                         NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BRAIN_SLIP_BODY_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BRAIN_SLIP_BODY ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-05-30)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_BRAIN_SLIP_BODY
	Where	BRAIN_SLIP_SEQ1 = AR_BRAIN_SLIP_SEQ1
	And	BRAIN_SLIP_SEQ2 = AR_BRAIN_SLIP_SEQ2
	And	BRAIN_SLIP_LINE = AR_BRAIN_SLIP_LINE;
End;
/

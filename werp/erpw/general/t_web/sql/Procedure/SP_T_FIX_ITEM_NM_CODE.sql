Create Or Replace Procedure SP_T_FIX_ITEM_NM_CODE_I
(
	AR_ASSET_CLS_CODE                          VARCHAR2,
	AR_ITEM_CODE                               VARCHAR2,
	AR_ITEM_NM_CODE                            VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ITEM_NM_NAME                            VARCHAR2,
	AR_SRVLIFE                                 NUMBER,
	AR_DEPREC_RAT                              NUMBER,
	AR_DEPREC_CLS                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIX_ITEM_NM_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIX_ITEM_NM_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-05-12)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FIX_ITEM_NM_CODE
	(
		ASSET_CLS_CODE,
		ITEM_CODE,
		ITEM_NM_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ITEM_NM_NAME,
		SRVLIFE,
		DEPREC_RAT,
		DEPREC_CLS
	)
	Values
	(
		AR_ASSET_CLS_CODE,
		AR_ITEM_CODE,
		AR_ITEM_NM_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ITEM_NM_NAME,
		AR_SRVLIFE,
		AR_DEPREC_RAT,
		AR_DEPREC_CLS
	);
End;
/
Create Or Replace Procedure SP_T_FIX_ITEM_NM_CODE_U
(
	AR_ASSET_CLS_CODE                          VARCHAR2,
	AR_ITEM_CODE                               VARCHAR2,
	AR_ITEM_NM_CODE                            VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_ITEM_NM_NAME                            VARCHAR2,
	AR_SRVLIFE                                 NUMBER,
	AR_DEPREC_RAT                              NUMBER,
	AR_DEPREC_CLS                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIX_ITEM_NM_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIX_ITEM_NM_CODE ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-05-12)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FIX_ITEM_NM_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ITEM_NM_NAME = AR_ITEM_NM_NAME,
		SRVLIFE = AR_SRVLIFE,
		DEPREC_RAT = AR_DEPREC_RAT,
		DEPREC_CLS = AR_DEPREC_CLS
	Where	ASSET_CLS_CODE = AR_ASSET_CLS_CODE
	And	ITEM_CODE = AR_ITEM_CODE
	And	ITEM_NM_CODE = AR_ITEM_NM_CODE;
End;
/
Create Or Replace Procedure SP_T_FIX_ITEM_NM_CODE_D
(
	AR_ASSET_CLS_CODE                          VARCHAR2,
	AR_ITEM_CODE                               VARCHAR2,
	AR_ITEM_NM_CODE                            VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIX_ITEM_NM_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIX_ITEM_NM_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-05-12)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FIX_ITEM_NM_CODE
	Where	ASSET_CLS_CODE = AR_ASSET_CLS_CODE
	And	ITEM_CODE = AR_ITEM_CODE
	And	ITEM_NM_CODE = AR_ITEM_NM_CODE;
End;
/

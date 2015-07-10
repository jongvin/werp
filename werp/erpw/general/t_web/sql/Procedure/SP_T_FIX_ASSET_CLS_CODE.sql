Create Or Replace Procedure SP_T_FIX_ASSET_CLS_CODE_I
(
	AR_ASSET_CLS_CODE                          VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ASSET_CLS_NAME                          VARCHAR2,
	AR_ASSET_ACC_CODE                          VARCHAR2,
	AR_DEPREC_CLS                              VARCHAR2,
	AR_SRVLIFE                                 NUMBER,
	AR_DISLIFE                                 NUMBER,
	AR_SUM_ACC_CODE                            VARCHAR2,
	AR_SELL_PORF_ACC_CODE                      VARCHAR2,
	AR_SELL_LOSS_ACC_CODE                      VARCHAR2,
	AR_APPR_PROF_ACC_CODE                      VARCHAR2,
	AR_APPR_LOSS_ACC_CODE                      VARCHAR2,
	AR_CAP_EXP_ACC_CODE                        VARCHAR2,
	AR_VAT_ACC_CODE                            VARCHAR2,
	AR_CAP_EXP_VAT_ACC_CODE                    VARCHAR2,
	AR_SELL_ACC_CODE                           VARCHAR2,
	AR_TRA_ACC_CODE				 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIX_ASSET_CLS_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIX_ASSET_CLS_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-02-27)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FIX_ASSET_CLS_CODE
	(
		ASSET_CLS_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ASSET_CLS_NAME,
		ASSET_ACC_CODE,
		DEPREC_CLS,
		SRVLIFE,
		DISLIFE,
		SUM_ACC_CODE,
		SELL_PORF_ACC_CODE,
		SELL_LOSS_ACC_CODE,
		APPR_PROF_ACC_CODE,
		APPR_LOSS_ACC_CODE,
		CAP_EXP_ACC_CODE,
		VAT_ACC_CODE,
		CAP_EXP_VAT_ACC_CODE,
		SELL_ACC_CODE,
		TRA_ACC_CODE
	)
	Values
	(
		AR_ASSET_CLS_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ASSET_CLS_NAME,
		AR_ASSET_ACC_CODE,
		AR_DEPREC_CLS,
		AR_SRVLIFE,
		AR_DISLIFE,
		AR_SUM_ACC_CODE,
		AR_SELL_PORF_ACC_CODE,
		AR_SELL_LOSS_ACC_CODE,
		AR_APPR_PROF_ACC_CODE,
		AR_APPR_LOSS_ACC_CODE,
		AR_CAP_EXP_ACC_CODE,
		AR_VAT_ACC_CODE,
		AR_CAP_EXP_VAT_ACC_CODE,
		AR_SELL_ACC_CODE,
		AR_TRA_ACC_CODE
	);
End;
/
Create Or Replace Procedure SP_T_FIX_ASSET_CLS_CODE_U
(
	AR_ASSET_CLS_CODE                          VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_ASSET_CLS_NAME                          VARCHAR2,
	AR_ASSET_ACC_CODE                          VARCHAR2,
	AR_DEPREC_CLS                              VARCHAR2,
	AR_SRVLIFE                                 NUMBER,
	AR_DISLIFE                                 NUMBER,
	AR_SUM_ACC_CODE                            VARCHAR2,
	AR_SELL_PORF_ACC_CODE                      VARCHAR2,
	AR_SELL_LOSS_ACC_CODE                      VARCHAR2,
	AR_APPR_PROF_ACC_CODE                      VARCHAR2,
	AR_APPR_LOSS_ACC_CODE                      VARCHAR2,
	AR_CAP_EXP_ACC_CODE                        VARCHAR2,
	AR_VAT_ACC_CODE                            VARCHAR2,
	AR_CAP_EXP_VAT_ACC_CODE                    VARCHAR2,
	AR_SELL_ACC_CODE                           VARCHAR2,
	AR_TRA_ACC_CODE				 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIX_ASSET_CLS_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIX_ASSET_CLS_CODE ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-02-27)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FIX_ASSET_CLS_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ASSET_CLS_NAME = AR_ASSET_CLS_NAME,
		ASSET_ACC_CODE = AR_ASSET_ACC_CODE,
		DEPREC_CLS = AR_DEPREC_CLS,
		SRVLIFE = AR_SRVLIFE,
		DISLIFE = AR_DISLIFE,
		SUM_ACC_CODE = AR_SUM_ACC_CODE,
		SELL_PORF_ACC_CODE = AR_SELL_PORF_ACC_CODE,
		SELL_LOSS_ACC_CODE = AR_SELL_LOSS_ACC_CODE,
		APPR_PROF_ACC_CODE = AR_APPR_PROF_ACC_CODE,
		APPR_LOSS_ACC_CODE = AR_APPR_LOSS_ACC_CODE,
		CAP_EXP_ACC_CODE = AR_CAP_EXP_ACC_CODE,
		VAT_ACC_CODE = AR_VAT_ACC_CODE,
		CAP_EXP_VAT_ACC_CODE = AR_CAP_EXP_VAT_ACC_CODE,
		SELL_ACC_CODE = AR_SELL_ACC_CODE,
		TRA_ACC_CODE  = AR_TRA_ACC_CODE
	Where	ASSET_CLS_CODE = AR_ASSET_CLS_CODE;
End;
/
Create Or Replace Procedure SP_T_FIX_ASSET_CLS_CODE_D
(
	AR_ASSET_CLS_CODE                          VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIX_ASSET_CLS_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIX_ASSET_CLS_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-02-27)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FIX_ASSET_CLS_CODE
	Where	ASSET_CLS_CODE = AR_ASSET_CLS_CODE;
End;
/

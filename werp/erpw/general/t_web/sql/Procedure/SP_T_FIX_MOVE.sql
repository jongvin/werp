Create Or Replace Procedure SP_T_FIX_MOVE_I
(
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_MOVE_SEQ                                NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_MOVE_DT_FROM                            VARCHAR2,
	AR_MOVE_DT_TO                              VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_EMP_NO                                  VARCHAR2,
	AR_MNG_MAIN                                VARCHAR2,
	AR_MNG_SUB                                 VARCHAR2,
	AR_REAL_MOVE_SEQ                           NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIX_MOVE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIX_MOVE ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-19)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	
	SP_T_FIX_MOVE_REAL_MOVE_SEQ2(AR_FIX_ASSET_SEQ, AR_MOVE_SEQ,AR_CRTUSERNO, AR_MOVE_DT_FROM, AR_MOVE_DT_TO, AR_DEPT_CODE,AR_EMP_NO,AR_MNG_MAIN,AR_MNG_SUB,AR_REAL_MOVE_SEQ);
End;
/
CREATE OR REPLACE Procedure SP_T_FIX_MOVE_U
(
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_MOVE_SEQ                                NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_MOVE_DT_FROM                            VARCHAR2,
	AR_MOVE_DT_TO                              VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_EMP_NO                                  VARCHAR2,
	AR_MNG_MAIN                                VARCHAR2,
	AR_MNG_SUB                                 VARCHAR2,
	AR_REAL_MOVE_SEQ                           NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIX_MOVE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIX_MOVE ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-19)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
Begin
	SP_T_FIX_DEPREC_CHECK(AR_FIX_ASSET_SEQ);
	Update T_FIX_MOVE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		MOVE_DT_FROM = F_T_StringToDate(AR_MOVE_DT_FROM),
		MOVE_DT_TO = F_T_StringToDate(AR_MOVE_DT_TO),
		DEPT_CODE = AR_DEPT_CODE,
		EMP_NO = AR_EMP_NO,
		MNG_MAIN = AR_MNG_MAIN,
		MNG_SUB = AR_MNG_SUB--,
		--REAL_MOVE_SEQ = AR_REAL_MOVE_SEQ
	Where	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ
	And	MOVE_SEQ = AR_MOVE_SEQ;
	--Raise_Application_Error(-20009, AR_REAL_MOVE_SEQ);
	SP_T_FIX_MOVE_REAL_MOVE_SEQ(AR_FIX_ASSET_SEQ, AR_MOVE_SEQ,AR_MODUSERNO, AR_MOVE_DT_FROM, AR_MOVE_DT_TO, AR_DEPT_CODE,AR_EMP_NO,AR_MNG_MAIN,AR_MNG_SUB,AR_REAL_MOVE_SEQ);
End;
/

CREATE OR REPLACE Procedure SP_T_FIX_MOVE_D
(
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_MOVE_SEQ                                NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIX_MOVE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIX_MOVE ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-19)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
Begin
	SP_T_FIX_DEPREC_CHECK(AR_FIX_ASSET_SEQ);
	Delete T_FIX_MOVE
	Where	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ
	And	MOVE_SEQ = AR_MOVE_SEQ;

	SP_T_FIX_MOVE_REAL_MOVE_SEQ(AR_FIX_ASSET_SEQ, AR_MOVE_SEQ,0, sysdate, sysdate, '1', '1','1','1',0);
End;
/

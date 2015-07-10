
CREATE OR REPLACE Procedure SP_T_FIX_SHEET_PRC
(
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_SALE_DT                                 VARCHAR2,
	AR_DEPREC_FINISH                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIX_SHEET_PRC
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIX_SHEET ���̺� Update
/* 4. ��  ��  ��  �� : �����  �ۼ�(2006-03-14)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
Begin
	Update T_FIX_SHEET
	Set
		  SALE_DT = F_T_StringToDate(AR_SALE_DT),
		  DEPREC_FINISH = AR_DEPREC_FINISH
	Where FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ;
End;
/


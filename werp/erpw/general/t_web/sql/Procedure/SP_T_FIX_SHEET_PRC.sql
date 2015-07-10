
CREATE OR REPLACE Procedure SP_T_FIX_SHEET_PRC
(
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_SALE_DT                                 VARCHAR2,
	AR_DEPREC_FINISH                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_SHEET_PRC
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_SHEET 테이블 Update
/* 4. 변  경  이  력 : 한재원  작성(2006-03-14)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
Begin
	Update T_FIX_SHEET
	Set
		  SALE_DT = F_T_StringToDate(AR_SALE_DT),
		  DEPREC_FINISH = AR_DEPREC_FINISH
	Where FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ;
End;
/


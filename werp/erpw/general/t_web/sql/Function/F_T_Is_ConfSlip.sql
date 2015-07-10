CREATE OR REPLACE Function F_T_Is_ConfSlip
(
	AR_SLIP_ID						T_ACC_SLIP_HEAD.SLIP_ID%Type
)
Return NUMBER
Is
	lsCnt NUMBER;
/**************************************************************************/
/* 1. 프 로 그 램 id : F_T_Check_Slip
/* 2. 유형(시나리오) : Function
/* 3. 기  능  정  의 : 전표오류 체크
/* 4. 변  경  이  력 : 최언회 작성(2005-12-07)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
Begin
	SELECT
		COUNT(*)
	INTO lsCnt
	FROM
		T_ACC_SLIP_HEAD
	WHERE
		SLIP_ID = AR_SLIP_ID
		AND KEEP_DT_TRANS IS NOT NULL;
	Return lsCnt;
End;
/

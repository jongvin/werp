Create Or Replace Procedure SP_T_CARD_EXPENSE_DATA_USE
(
	AR_SEQNO                                   NUMBER,
	AR_USAGEGUBUN                              VARCHAR2,
	AR_MEMO                                    VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_CARD_EXPENSE_DATA_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_CARD_EXPENSE_DATA 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-22)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_CARD_EXPENSE_DATA
	Set
		USAGEGUBUN = AR_USAGEGUBUN,
		MEMO = AR_MEMO
	Where	SEQNO = AR_SEQNO;
End;
/

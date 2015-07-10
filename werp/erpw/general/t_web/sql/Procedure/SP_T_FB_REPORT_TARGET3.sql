Create Or Replace Procedure SP_T_FB_REPORT_TARGET3_I
(
	AR_CREATION_EMP_NO                         VARCHAR2,
	AR_PAY_SEQ                                 NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FB_REPORT_TARGET3_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FB_REPORT_TARGET3 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-16)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
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
/* 1. 프 로 그 램 id : SP_T_FB_REPORT_TARGET3_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FB_REPORT_TARGET3 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-16)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
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
/* 1. 프 로 그 램 id : SP_T_FB_REPORT_TARGET3_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FB_REPORT_TARGET3 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-16)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
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
/* 1. 프 로 그 램 id : SP_T_FB_REPORT_TARGET3_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FB_REPORT_TARGET3 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-16)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FB_REPORT_TARGET3
	Where	CREATION_EMP_NO = AR_CREATION_EMP_NO;
End;
/

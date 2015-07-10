Create Or Replace Procedure SP_T_BRAIN_SLIP_HEAD_I
(
	AR_BRAIN_SLIP_SEQ1                         NUMBER,
	AR_BRAIN_SLIP_SEQ2                         NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_BRAIN_SLIP_NAME2                        VARCHAR2,
	AR_USE_CLS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BRAIN_SLIP_HEAD_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BRAIN_SLIP_HEAD 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2005-12-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_BRAIN_SLIP_HEAD
	(
		BRAIN_SLIP_SEQ1,
		BRAIN_SLIP_SEQ2,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		BRAIN_SLIP_NAME2,
		USE_CLS
	)
	Values
	(
		AR_BRAIN_SLIP_SEQ1,
		AR_BRAIN_SLIP_SEQ2,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_BRAIN_SLIP_NAME2,
		AR_USE_CLS
	);
End;
/
Create Or Replace Procedure SP_T_BRAIN_SLIP_HEAD_U
(
	AR_BRAIN_SLIP_SEQ1                         NUMBER,
	AR_BRAIN_SLIP_SEQ2                         NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_BRAIN_SLIP_NAME2                        VARCHAR2,
	AR_USE_CLS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BRAIN_SLIP_HEAD_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BRAIN_SLIP_HEAD 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2005-12-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_BRAIN_SLIP_HEAD
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		BRAIN_SLIP_NAME2 = AR_BRAIN_SLIP_NAME2,
		USE_CLS = AR_USE_CLS
	Where	BRAIN_SLIP_SEQ1 = AR_BRAIN_SLIP_SEQ1
	And	BRAIN_SLIP_SEQ2 = AR_BRAIN_SLIP_SEQ2;
End;
/
Create Or Replace Procedure SP_T_BRAIN_SLIP_HEAD_D
(
	AR_BRAIN_SLIP_SEQ1                         NUMBER,
	AR_BRAIN_SLIP_SEQ2                         NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BRAIN_SLIP_HEAD_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BRAIN_SLIP_HEAD 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2005-12-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	--최영희님의 요청에 의해 추가된 내용입니다.
	--수정자 : 김흥수
	--수정일 : 2006.05.24
	--요청내용 : 브레인즈 코드를 삭제할 때 에러가 나지 않도록 해달라(내용상으로는 하위 항목이 있어도 지울 수 있게 해달라는 의미임)
	
	Delete	T_BRAIN_SLIP_BODY
	Where	BRAIN_SLIP_SEQ1 = AR_BRAIN_SLIP_SEQ1
	And	BRAIN_SLIP_SEQ2 = AR_BRAIN_SLIP_SEQ2;
	--수정사항 끝 
	Delete T_BRAIN_SLIP_HEAD
	Where	BRAIN_SLIP_SEQ1 = AR_BRAIN_SLIP_SEQ1
	And	BRAIN_SLIP_SEQ2 = AR_BRAIN_SLIP_SEQ2;
End;
/

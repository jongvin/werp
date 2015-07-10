Create Or Replace Procedure SP_T_CARD_MEMBER_HISTORY_I
(
	AR_CARD_SEQ                                NUMBER,
	AR_USESTARTDATE                            VARCHAR2,
	AR_USEENDDATE                              VARCHAR2,
	AR_CARDNUMBER                              VARCHAR2,
	AR_CARDOWNEREMPNO                          VARCHAR2,
	AR_CARDSUBSTITUTEEMPNO                     VARCHAR2,
	AR_CHANGEREASON                            VARCHAR2,
	AR_FIRSTREGISTEREMPNO                      VARCHAR2,
	AR_FIRSTREGISTERDATE                       VARCHAR2,
	AR_LASTMODIFYEMPNO                         VARCHAR2,
	AR_LASTMODIFYDATE                          VARCHAR2,
	AR_ATTRIBUTE1                              VARCHAR2,
	AR_ATTRIBUTE2                              VARCHAR2,
	AR_ATTRIBUTE3                              VARCHAR2,
	AR_BANK_MAIN_CODE                          VARCHAR2,
	AR_ACCNO                                   VARCHAR2,
	AR_ACCNO_OWNER                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_CARD_MEMBER_HISTORY_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_CARD_MEMBER_HISTORY 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-02)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_CARD_MEMBER_HISTORY
	(
		CARD_SEQ,
		USESTARTDATE,
		USEENDDATE,
		CARDNUMBER,
		CARDOWNEREMPNO,
		CARDSUBSTITUTEEMPNO,
		CHANGEREASON,
		FIRSTREGISTEREMPNO,
		FIRSTREGISTERDATE,
		LASTMODIFYEMPNO,
		LASTMODIFYDATE,
		ATTRIBUTE1,
		ATTRIBUTE2,
		ATTRIBUTE3,
		BANK_MAIN_CODE,
		ACCNO,
		ACCNO_OWNER
	)
	Values
	(
		AR_CARD_SEQ,
		Replace(AR_USESTARTDATE,'-',''),
		Replace(AR_USEENDDATE,'-',''),
		AR_CARDNUMBER,
		AR_CARDOWNEREMPNO,
		AR_CARDSUBSTITUTEEMPNO,
		AR_CHANGEREASON,
		AR_FIRSTREGISTEREMPNO,
		SysDate,
		Null,
		Null,
		AR_ATTRIBUTE1,
		AR_ATTRIBUTE2,
		AR_ATTRIBUTE3,
		AR_BANK_MAIN_CODE,
		AR_ACCNO,
		AR_ACCNO_OWNER
	);
	Update	T_CARD_MEMBER_HISTORY a
	Set		a.CARDNUMBER = (
				Select
					Replace(b.CARDNO,'-','')
				From	T_ACC_CREDCARD b
				Where	a.CARD_SEQ = b.CARD_SEQ
			)
	Where	a.CARD_SEQ = AR_CARD_SEQ;
	Merge Into T_CARD_MEMBER_HISTORY t
	Using
	(
		Select
			a.CARD_SEQ ,
			a.USESTARTDATE,
			To_Char(To_Date(Nvl(Lead(a.USESTARTDATE) Over (Order By a.CARD_SEQ,a.USESTARTDATE),'40000101'),'YYYYMMDD') - 1,'YYYYMMDD') USEENDDATE
		From	T_CARD_MEMBER_HISTORY a
		Where	a.CARD_SEQ = AR_CARD_SEQ
		Order By
			a.CARD_SEQ ,
			a.USESTARTDATE	
	) s
	On
	(
		s.CARD_SEQ = t.CARD_SEQ
	And	s.USESTARTDATE = t.USESTARTDATE
	)
	When Matched Then
	Update
	Set	t.USEENDDATE = s.USEENDDATE
	When Not Matched Then
	Insert
	(CARD_SEQ,USESTARTDATE,USEENDDATE)
	Values
	(s.CARD_SEQ,s.USESTARTDATE,s.USEENDDATE);
End;
/
Create Or Replace Procedure SP_T_CARD_MEMBER_HISTORY_U
(
	AR_CARD_SEQ                                NUMBER,
	AR_USESTARTDATE                            VARCHAR2,
	AR_USEENDDATE                              VARCHAR2,
	AR_CARDNUMBER                              VARCHAR2,
	AR_CARDOWNEREMPNO                          VARCHAR2,
	AR_CARDSUBSTITUTEEMPNO                     VARCHAR2,
	AR_CHANGEREASON                            VARCHAR2,
	AR_FIRSTREGISTEREMPNO                      VARCHAR2,
	AR_FIRSTREGISTERDATE                       VARCHAR2,
	AR_LASTMODIFYEMPNO                         VARCHAR2,
	AR_LASTMODIFYDATE                          VARCHAR2,
	AR_ATTRIBUTE1                              VARCHAR2,
	AR_ATTRIBUTE2                              VARCHAR2,
	AR_ATTRIBUTE3                              VARCHAR2,
	AR_BANK_MAIN_CODE                          VARCHAR2,
	AR_ACCNO                                   VARCHAR2,
	AR_ACCNO_OWNER                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_CARD_MEMBER_HISTORY_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_CARD_MEMBER_HISTORY 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-02)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_CARD_MEMBER_HISTORY
	Set
		USEENDDATE = Replace(AR_USEENDDATE,'-',''),
		CARDNUMBER = AR_CARDNUMBER,
		CARDOWNEREMPNO = AR_CARDOWNEREMPNO,
		CARDSUBSTITUTEEMPNO = AR_CARDSUBSTITUTEEMPNO,
		CHANGEREASON = AR_CHANGEREASON,
		LASTMODIFYEMPNO = AR_LASTMODIFYEMPNO,
		LASTMODIFYDATE = SysDate,
		ATTRIBUTE1 = AR_ATTRIBUTE1,
		ATTRIBUTE2 = AR_ATTRIBUTE2,
		ATTRIBUTE3 = AR_ATTRIBUTE3,
		BANK_MAIN_CODE = AR_BANK_MAIN_CODE,
		ACCNO = AR_ACCNO,
		ACCNO_OWNER = AR_ACCNO_OWNER
	Where	CARD_SEQ = AR_CARD_SEQ
	And	USESTARTDATE = Replace(AR_USESTARTDATE,'-','');
	Update	T_CARD_MEMBER_HISTORY a
	Set		a.CARDNUMBER = (
				Select
					Replace(b.CARDNO,'-','')
				From	T_ACC_CREDCARD b
				Where	a.CARD_SEQ = b.CARD_SEQ
			)
	Where	a.CARD_SEQ = AR_CARD_SEQ;
	Merge Into T_CARD_MEMBER_HISTORY t
	Using
	(
		Select
			a.CARD_SEQ ,
			a.USESTARTDATE,
			To_Char(To_Date(Nvl(Lead(a.USESTARTDATE) Over (Order By a.CARD_SEQ,a.USESTARTDATE),'40000101'),'YYYYMMDD') - 1,'YYYYMMDD') USEENDDATE
		From	T_CARD_MEMBER_HISTORY a
		Where	a.CARD_SEQ = AR_CARD_SEQ
		Order By
			a.CARD_SEQ ,
			a.USESTARTDATE	
	) s
	On
	(
		s.CARD_SEQ = t.CARD_SEQ
	And	s.USESTARTDATE = t.USESTARTDATE
	)
	When Matched Then
	Update
	Set	t.USEENDDATE = s.USEENDDATE
	When Not Matched Then
	Insert
	(CARD_SEQ,USESTARTDATE,USEENDDATE)
	Values
	(s.CARD_SEQ,s.USESTARTDATE,s.USEENDDATE);
End;
/
Create Or Replace Procedure SP_T_CARD_MEMBER_HISTORY_D
(
	AR_CARD_SEQ                                NUMBER,
	AR_USESTARTDATE                            VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_CARD_MEMBER_HISTORY_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_CARD_MEMBER_HISTORY 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-02)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_CARD_MEMBER_HISTORY
	Where	CARD_SEQ = AR_CARD_SEQ
	And	USESTARTDATE = Replace(AR_USESTARTDATE,'-','');
	Merge Into T_CARD_MEMBER_HISTORY t
	Using
	(
		Select
			a.CARD_SEQ ,
			a.USESTARTDATE,
			To_Char(To_Date(Nvl(Lead(a.USESTARTDATE) Over (Order By a.CARD_SEQ,a.USESTARTDATE),'40000101'),'YYYYMMDD') - 1,'YYYYMMDD') USEENDDATE
		From	T_CARD_MEMBER_HISTORY a
		Where	a.CARD_SEQ = AR_CARD_SEQ
		Order By
			a.CARD_SEQ ,
			a.USESTARTDATE	
	) s
	On
	(
		s.CARD_SEQ = t.CARD_SEQ
	And	s.USESTARTDATE = t.USESTARTDATE
	)
	When Matched Then
	Update
	Set	t.USEENDDATE = s.USEENDDATE
	When Not Matched Then
	Insert
	(CARD_SEQ,USESTARTDATE,USEENDDATE)
	Values
	(s.CARD_SEQ,s.USESTARTDATE,s.USEENDDATE);
End;
/

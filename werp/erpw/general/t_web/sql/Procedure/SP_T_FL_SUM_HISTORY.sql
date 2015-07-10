Create Or Replace Procedure SP_T_FL_SUM_HISTORY_I
(
	AR_WORK_DT                                 VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_START_DT_TIME                           VARCHAR2,
	AR_END_DT_TIME                             VARCHAR2,
	AR_EMP_NO                                  VARCHAR2,
	AR_NAME                                    VARCHAR2,
	AR_ERRM                                    VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_SUM_HISTORY_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_SUM_HISTORY 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-05-01)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FL_SUM_HISTORY
	(
		WORK_DT,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE
	)
	Values
	(
		F_T_StringToDate(AR_WORK_DT),
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL
	);
End;
/
Create Or Replace Procedure SP_T_FL_SUM_HISTORY_U
(
	AR_WORK_DT                                 VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_START_DT_TIME                           VARCHAR2,
	AR_END_DT_TIME                             VARCHAR2,
	AR_EMP_NO                                  VARCHAR2,
	AR_NAME                                    VARCHAR2,
	AR_ERRM                                    VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_SUM_HISTORY_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_SUM_HISTORY 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-05-01)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Null;
End;
/
Create Or Replace Procedure SP_T_FL_SUM_HISTORY_D
(
	AR_WORK_DT                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_SUM_HISTORY_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_SUM_HISTORY 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-05-01)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Raise_Application_Error(-20009,'작업내역 자체는 삭제가 불가능합니다.');
End;
/

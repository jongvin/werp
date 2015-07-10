CREATE OR REPLACE Procedure SP_T_LOG_ACC_SLIP_TRANS_I
(
	AR_SLIP_ID                                 NUMBER,
	AR_MODUSERNO                               NUMBER,
	AR_STATUS                                  VARCHAR2
)
Is
Begin
	Insert Into T_LOG_ACC_SLIP_TRANS   --전표이체 로그
	(
		SLIP_ID ,
      UPDATE_CLS ,
      MOD_TIME ,
      MOD_USERNO ,
      MAKE_SLIPNO ,
      MAKE_COMPANY ,
      MAKE_DEPT ,
      MAKE_DT ,
      MAKE_DT_TRANS ,
      MAKE_SEQ ,
      MAKE_PERS ,
      MAKE_NAME ,
      KEEP_SLIPNO ,
      KEEP_DT ,
      KEEP_DT_TRANS ,
      KEEP_SEQ
	)
	SELECT
		SLIP_ID,
		AR_STATUS,
		Sysdate,
		AR_MODUSERNO,
		MAKE_SLIPNO ,
		MAKE_COMP_CODE ,
		MAKE_DEPT_CODE ,
		MAKE_DT ,
		MAKE_DT_TRANS ,
		MAKE_SEQ ,
		MAKE_PERS ,
		MAKE_NAME ,
		KEEP_SLIPNO,
		KEEP_DT,
		KEEP_DT_TRANS,
		KEEP_SEQ
	FROM    T_ACC_SLIP_HEAD
	WHERE   SLIP_ID = AR_SLIP_ID;
End;
/
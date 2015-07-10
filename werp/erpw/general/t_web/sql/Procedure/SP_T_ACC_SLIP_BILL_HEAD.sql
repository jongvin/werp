Create Or Replace Procedure SP_T_ACC_SLIP_BILL_HEAD_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_NO                                 NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_WORK_DATE                               VARCHAR2,
	AR_TAX_YEAR                                VARCHAR2,
	AR_TAX_GI                                  VARCHAR2,
	AR_TAX_CONF                                VARCHAR2,
	AR_BASE_DT_F                               VARCHAR2,
	AR_BASE_DT_T                               VARCHAR2,
	AR_MISSING_PROCESS_DT_F                    VARCHAR2,
	AR_APPLY_TAG                               VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_SLIP_BILL_HEAD_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_SLIP_BILL_HEAD 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-02-16)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_ACC_SLIP_BILL_HEAD
	(
		COMP_CODE,
		WORK_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		WORK_DATE,
		TAX_YEAR,
		TAX_GI,
		TAX_CONF,
		BASE_DT_F,
		BASE_DT_T,
		MISSING_PROCESS_DT_F,
		APPLY_TAG,
		REMARKS
	)
	Values
	(
		AR_COMP_CODE,
		AR_WORK_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		F_T_StringToDate(AR_WORK_DATE),
		AR_TAX_YEAR,
		AR_TAX_GI,
		AR_TAX_CONF,
		F_T_StringToDate(AR_BASE_DT_F),
		F_T_StringToDate(AR_BASE_DT_T),
		F_T_StringToDate(AR_MISSING_PROCESS_DT_F),
		AR_APPLY_TAG,
		AR_REMARKS
	);
End;
/
CREATE OR REPLACE PROCEDURE Sp_T_Acc_Slip_Head_U
(
	AR_SLIP_ID                                 NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_MAKE_SLIPCLS                            VARCHAR2,
	AR_MAKE_SLIPNO                             VARCHAR2,
	AR_MAKE_COMP_CODE                          VARCHAR2,
	AR_MAKE_DEPT_CODE                          VARCHAR2,
	AR_MAKE_DT                                 VARCHAR2,
	AR_MAKE_DT_TRANS                           VARCHAR2,
	AR_MAKE_SEQ                                NUMBER,
	AR_INOUT_DEPT_CODE                         VARCHAR2,
	AR_MAKE_PERS                               NUMBER,
	AR_MAKE_NAME                               VARCHAR2,
	AR_GROUPWARE_SLIPSTATUS                    VARCHAR2,
	AR_KEEP_SLIPNO                             VARCHAR2,
	AR_KEEP_DT                                 VARCHAR2,
	AR_KEEP_DT_TRANS                           VARCHAR2,
	AR_KEEP_SEQ                                NUMBER,
	AR_KEEP_DEPT_CODE                          VARCHAR2,
	AR_KEEP_KEEPER                             NUMBER,
	AR_WORK_CODE                               VARCHAR2,
	AR_CHARGE_PERS                             VARCHAR2,
	AR_SLIP_KIND_TAG                           VARCHAR2,
	AR_TRANSFER_TAG                            VARCHAR2,
	AR_IGNORE_SET_RESET_TAG                    VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_SLIP_HEAD_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_SLIP_HEAD 테이블 Update
/* 4. 변  경  이  력 : 최언회 작성(2005-12-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
ln_Ret				T_ACC_MAKE_SLIPNO.Make_Seq%TYPE;
ls_Errm				VARCHAR2(2000);
lrSLIP_HEAD		T_ACC_SLIP_HEAD%ROWTYPE;
BEGIN
	BEGIN
		SELECT
			*
		INTO
			lrSLIP_HEAD
		FROM	T_ACC_SLIP_HEAD a
		WHERE	a.SLIP_ID = AR_SLIP_ID;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RAISE_APPLICATION_ERROR	(-20009, '해당 전표를 찾을 수 없습니다.');
	END;
	
	ln_Ret := lrSLIP_HEAD.MAKE_SEQ;
			
	IF
		AR_MAKE_DT_TRANS <> lrSLIP_HEAD.MAKE_DT_TRANS OR
		AR_MAKE_COMP_CODE <> lrSLIP_HEAD.MAKE_COMP_CODE
	THEN
		BEGIN
			SELECT
				NVL(MAX(Make_Seq),0) + 1
			INTO
				ln_Ret
			FROM	T_ACC_MAKE_SLIPNO
			WHERE	MAKE_COMP_CODE = AR_MAKE_COMP_CODE
			AND		MAKE_DT_TRANS = AR_MAKE_DT_TRANS;
			INSERT INTO T_ACC_MAKE_SLIPNO
			(
				MAKE_COMP_CODE,
				MAKE_DT_TRANS,
				MAKE_SEQ
			)
			VALUES
			(
				AR_MAKE_COMP_CODE,
				AR_MAKE_DT_TRANS,
				ln_Ret
			);
		EXCEPTION WHEN OTHERS THEN
			ls_Errm := SQLERRM;
			--ROLLBACK;
			RAISE_APPLICATION_ERROR(-20009,'발의 전표번호 생성중 에러발생 '||ls_Errm);
		END;
	END IF;
	
	UPDATE T_ACC_SLIP_HEAD
	SET
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		MAKE_SLIPCLS = AR_MAKE_SLIPCLS,
		MAKE_SLIPNO = F_T_Gen_Make_Slip_No( AR_MAKE_COMP_CODE, AR_MAKE_DT_TRANS, AR_SLIP_KIND_TAG, ln_Ret),--AR_MAKE_SLIPNO,
		MAKE_COMP_CODE = AR_MAKE_COMP_CODE,
		MAKE_DEPT_CODE = AR_MAKE_DEPT_CODE,
		MAKE_DT = F_T_Stringtodate(AR_MAKE_DT),
		MAKE_DT_TRANS = AR_MAKE_DT_TRANS,
		MAKE_SEQ = ln_Ret,--AR_MAKE_SEQ,
		INOUT_DEPT_CODE = AR_INOUT_DEPT_CODE,
		MAKE_PERS = AR_MAKE_PERS,
		MAKE_NAME = AR_MAKE_NAME,
		GROUPWARE_SLIPSTATUS = AR_GROUPWARE_SLIPSTATUS,
		KEEP_SLIPNO = AR_KEEP_SLIPNO,
		KEEP_DT = F_T_Stringtodate(AR_KEEP_DT),
		KEEP_DT_TRANS = AR_KEEP_DT_TRANS,
		KEEP_SEQ = AR_KEEP_SEQ,
		KEEP_DEPT_CODE = AR_KEEP_DEPT_CODE,
		KEEP_KEEPER = AR_KEEP_KEEPER,
		WORK_CODE = AR_WORK_CODE,
		CHARGE_PERS = AR_CHARGE_PERS,
		SLIP_KIND_TAG = AR_SLIP_KIND_TAG,
		TRANSFER_TAG = AR_TRANSFER_TAG,
		IGNORE_SET_RESET_TAG = AR_IGNORE_SET_RESET_TAG
	WHERE	SLIP_ID = AR_SLIP_ID;
END;
/
Create Or Replace Procedure SP_T_ACC_SLIP_BILL_HEAD_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_NO                                 NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_SLIP_BILL_HEAD_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_SLIP_BILL_HEAD 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-02-16)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_ACC_SLIP_BILL_HEAD
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_NO = AR_WORK_NO;
End;
/

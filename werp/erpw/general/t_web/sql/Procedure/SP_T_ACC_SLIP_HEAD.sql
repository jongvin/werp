CREATE OR REPLACE PROCEDURE Sp_T_Acc_Slip_Head_I
(
	AR_SLIP_ID                                 NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
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
/* 1. 프 로 그 램 id : SP_T_ACC_SLIP_HEAD_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_SLIP_HEAD 테이블 Insert
/* 4. 변  경  이  력 : 최언회 작성(2005-12-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
ln_Ret				T_ACC_MAKE_SLIPNO.Make_Seq%TYPE;
ls_Errm				VARCHAR2(2000);
BEGIN

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

	INSERT INTO T_ACC_SLIP_HEAD
	(
		SLIP_ID,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		MAKE_SLIPCLS,
		MAKE_SLIPNO,
		MAKE_COMP_CODE,
		MAKE_DEPT_CODE,
		MAKE_DT,
		MAKE_DT_TRANS,
		MAKE_SEQ,
		INOUT_DEPT_CODE,
		MAKE_PERS,
		MAKE_NAME,
		GROUPWARE_SLIPSTATUS,
		KEEP_SLIPNO,
		KEEP_DT,
		KEEP_DT_TRANS,
		KEEP_SEQ,
		KEEP_DEPT_CODE,
		KEEP_KEEPER,
		WORK_CODE,
		CHARGE_PERS,
		SLIP_KIND_TAG,
		TRANSFER_TAG,
		IGNORE_SET_RESET_TAG
	)
	VALUES
	(
		AR_SLIP_ID,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_MAKE_SLIPCLS,
		SUBSTR(AR_MAKE_DT_TRANS,3,6)||AR_SLIP_KIND_TAG||''||AR_MAKE_COMP_CODE||''||LPAD(ln_Ret,4,'0'),--AR_MAKE_SLIPNO,
		AR_MAKE_COMP_CODE,
		AR_MAKE_DEPT_CODE,
		F_T_Stringtodate(AR_MAKE_DT),
		AR_MAKE_DT_TRANS,
		ln_Ret,--AR_MAKE_SEQ,
		AR_INOUT_DEPT_CODE,
		AR_MAKE_PERS,
		AR_MAKE_NAME,
		AR_GROUPWARE_SLIPSTATUS,
		AR_KEEP_SLIPNO,
		F_T_Stringtodate(AR_KEEP_DT),
		AR_KEEP_DT_TRANS,
		AR_KEEP_SEQ,
		AR_KEEP_DEPT_CODE,
		AR_KEEP_KEEPER,
		AR_WORK_CODE,
		AR_CHARGE_PERS,
		AR_SLIP_KIND_TAG,
		AR_TRANSFER_TAG,
		AR_IGNORE_SET_RESET_TAG
	);
END;
/

Create Or Replace Procedure SP_T_ACC_SLIP_HEAD_U
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
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_SLIP_HEAD_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_SLIP_HEAD 테이블 Update
/* 4. 변  경  이  력 : 최언회 작성(2005-12-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_ACC_SLIP_HEAD
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		MAKE_SLIPCLS = AR_MAKE_SLIPCLS,
		MAKE_SLIPNO = AR_MAKE_SLIPNO,
		MAKE_COMP_CODE = AR_MAKE_COMP_CODE,
		MAKE_DEPT_CODE = AR_MAKE_DEPT_CODE,
		MAKE_DT = F_T_StringToDate(AR_MAKE_DT),
		MAKE_DT_TRANS = AR_MAKE_DT_TRANS,
		MAKE_SEQ = AR_MAKE_SEQ,
		INOUT_DEPT_CODE = AR_INOUT_DEPT_CODE,
		MAKE_PERS = AR_MAKE_PERS,
		MAKE_NAME = AR_MAKE_NAME,
		GROUPWARE_SLIPSTATUS = AR_GROUPWARE_SLIPSTATUS,
		KEEP_SLIPNO = AR_KEEP_SLIPNO,
		KEEP_DT = F_T_StringToDate(AR_KEEP_DT),
		KEEP_DT_TRANS = AR_KEEP_DT_TRANS,
		KEEP_SEQ = AR_KEEP_SEQ,
		KEEP_DEPT_CODE = AR_KEEP_DEPT_CODE,
		KEEP_KEEPER = AR_KEEP_KEEPER,
		WORK_CODE = AR_WORK_CODE,
		CHARGE_PERS = AR_CHARGE_PERS,
		SLIP_KIND_TAG = AR_SLIP_KIND_TAG,
		TRANSFER_TAG = AR_TRANSFER_TAG,
		IGNORE_SET_RESET_TAG = AR_IGNORE_SET_RESET_TAG
	Where	SLIP_ID = AR_SLIP_ID;
End;
/

CREATE OR REPLACE PROCEDURE Sp_T_Acc_Slip_Head_D
(
	AR_SLIP_ID	NUMBER,
	Ar_Mod_User_No	T_ACC_SLIP_HEAD .MODUSERNO%TYPE
)
IS
	lnCnt						T_ACC_SLIP_BODY.SLIP_ID%TYPE;
	lsErrm						VARCHAR2(2000);
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_SLIP_HEAD_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_SLIP_HEAD 테이블 Delete
/* 4. 변  경  이  력 : 최언회 작성(2005-12-07)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
BEGIN
	lsErrm := Pkg_T_Check_Slip.CheckDeleteMaster(AR_SLIP_ID);
	IF lsErrm IS NOT NULL THEN
		RAISE_APPLICATION_ERROR(-20009,REPLACE(lsErrm,'ORA-20009:',''));
	END IF;

	UPDATE
		T_ACC_SLIP_HEAD
	SET
		MODUSERNO = Ar_Mod_User_No,
		MODDATE = SYSDATE
	WHERE SLIP_ID = AR_SLIP_ID;

	-- 삭제로그기록 : 수정로그기록은 SP_T_CHECK_SLIP() 에서 처리..
	Sp_T_Log_Acc_Slip_Head_I(AR_SLIP_ID,'4',Ar_Mod_User_No);
	FOR lrA IN
	(
		SELECT
			SLIP_ID,
			SLIP_IDSEQ
		FROM
			T_ACC_SLIP_BODY
		WHERE
			SLIP_ID = AR_SLIP_ID
	)
	LOOP
		BEGIN
			Sp_T_Acc_Slip_Body_D(lrA.SLIP_ID, lrA.SLIP_IDSEQ);
		END;
	END LOOP;

	DELETE T_ACC_SLIP_HEAD WHERE SLIP_ID = AR_SLIP_ID;
END;
/


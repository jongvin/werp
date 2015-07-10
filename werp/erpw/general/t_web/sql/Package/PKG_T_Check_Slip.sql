CREATE OR REPLACE PACKAGE Pkg_T_Check_Slip
IS
 FUNCTION CheckDeleteMaster
 (
  Ar_Slip_Id    T_ACC_SLIP_HEAD .SLIP_ID%TYPE
 ) 
 RETURN VARCHAR2;
 FUNCTION CheckDeleteDetail
 (
  Ar_Slip_Id    T_ACC_SLIP_HEAD.SLIP_ID%TYPE,
  Ar_Slip_IdSeq   T_ACC_SLIP_BODY.SLIP_IDSEQ%TYPE
 )
 RETURN VARCHAR2;
 PROCEDURE DeleteMaster
 (
  Ar_Slip_Id    T_ACC_SLIP_HEAD.SLIP_ID%TYPE,
  Ar_Mod_User_No    T_ACC_SLIP_HEAD .MODUSERNO%TYPE DEFAULT NULL
 );
 PROCEDURE DeleteDetail
 (
  Ar_Slip_Id    T_ACC_SLIP_HEAD.SLIP_ID%TYPE,
  Ar_Slip_IdSeq   T_ACC_SLIP_BODY.SLIP_IDSEQ%TYPE
 );
END;
/


CREATE OR REPLACE PACKAGE BODY Pkg_T_Check_Slip
IS
	--ORA-NNNNNN 형식의 오라클 메세지에서 ORA-이부분을 제거한다.
	PROCEDURE	PrintError
	(
		Ar_Errm				VARCHAR2
	)
	IS
	BEGIN
		RAISE_APPLICATION_ERROR(-20009,Ar_Errm);
	END;
	FUNCTION	ChangeErrorMsg
	(
		Ar_Msg			VARCHAR2
	)
	RETURN VARCHAR2
	IS
	BEGIN
		RETURN REPLACE(Ar_Msg,'ORA-','Oracle Internal Error');
	END;
	--마감여부의 검증
	FUNCTION	IsClosed
	(
		Ar_make_comp_code	T_ACC_SLIP_HEAD.MAKE_COMP_CODE%TYPE,
		Ar_make_DEPT_CODE  T_ACC_SLIP_HEAD .make_DEPT_CODE%TYPE,
		Ar_MakeDt		DATE
	)
	RETURN VARCHAR2
	IS
		lsErrm						VARCHAR2(2000);
		lsClse_Cls					T_YEAR_CLOSE.CLSE_CLS%TYPE;
	BEGIN
		--년 마감 검증
		BEGIN
			SELECT
				CLSE_CLS
			INTO
				lsClse_Cls
			FROM	T_YEAR_CLOSE
			WHERE	ACCOUNT_FDT <= Ar_MakeDt
			AND		ACCOUNT_EDT >= Ar_MakeDt
			AND		COMP_CODE = Ar_make_comp_code;
			IF NVL(lsClse_Cls,'F') = 'T' THEN
				RETURN '회기가 이미 마감되었습니다.';
			END IF;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			RETURN '회기가 등록되지 않았습니다.';
		END;
		--월 마감 검증
		BEGIN
			SELECT
				CLSE_CLS
			INTO
				lsClse_Cls
			FROM	T_MONTH_CLOSE
			WHERE	CLSE_MONTH = TO_CHAR(Ar_MakeDt,'YYYYMM')
			AND		COMP_CODE = Ar_make_comp_code;
			IF NVL(lsClse_Cls,'F') = 'T' THEN
				RETURN '해당 월은 이미 마감되었습니다.';
			END IF;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			RETURN '월마감이 등록되지 않았습니다.';
		END;
		--일 마감 검증
		BEGIN
			SELECT
				CLSE_CLS
			INTO
				lsClse_Cls
			FROM	T_DAY_CLOSE
			WHERE	CLSE_DAY = TO_CHAR(Ar_MakeDt,'YYYYMMDD')
			AND		COMP_CODE = Ar_make_comp_code;
			IF NVL(lsClse_Cls,'F') = 'T' THEN
				RETURN '해당 일자는 이미 마감되었습니다.';
			END IF;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			RETURN '일마감이 등록되지 않았습니다.';
		END;
	 	-- 부서 입력기간 체크
		BEGIN
			SELECT
				 CASE
				 	 WHEN (F_T_Datetostring(Ar_MakeDt) BETWEEN F_T_Datetostring(NVL(INPUT_DT_F, '19000101')) AND F_T_Datetostring(NVL(INPUT_DT_T, '19000101')) )
					 THEN 'F' -- 입력기간
					 ELSE 'T' -- 입력마감
				END DEPT_CLSE_CLS
			INTO
				lsCLSE_CLS
			FROM
				T_DEPT_CODE_ORG A
			WHERE
				A.COMP_CODE = Ar_make_comp_code
				AND DEPT_CODE = Ar_make_DEPT_CODE;
	
			IF NVL(lsCLSE_CLS,'F') = 'T' THEN
				RETURN '부서의 입력기간이 종료되었습니다.';
			END IF;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			RETURN '부서정보가 등록되지 않았습니다.';
		END;
		RETURN NULL;
	EXCEPTION WHEN OTHERS THEN
		lsErrm := SQLERRM;
		RETURN ChangeErrorMsg(lsErrm);
	END;
	
	--유가증권 미수이자가 등록되어 있는지 여부(세부)
	FUNCTION	IsFinSecItrAmtCHK
	(
		Ar_Slip_Id				T_ACC_SLIP_HEAD.SLIP_ID%TYPE,
		Ar_Slip_IdSeq			T_ACC_SLIP_BODY.SLIP_IDSEQ%TYPE
	)
	RETURN VARCHAR2
	IS
		lsErrm						VARCHAR2(2000);
		lnCnt						NUMBER;
	BEGIN
		SELECT	1
		INTO	lnCnt
		FROM
			T_FIN_SECURTY A,
			T_FIN_SEC_ITR_AMT B
		WHERE
		A.SECU_NO = B.SECU_NO
		AND	A.SLIP_ID = Ar_Slip_Id
		AND	A.SLIP_IDSEQ = Ar_Slip_IdSeq
		AND	ROWNUM < 2;
	
		RETURN '해당유가증권의 미수이자가 존재합니다.';
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RETURN NULL;
	END;
	
	-- 반제전표 존재 체크... 설정전표삭제시 체크
	FUNCTION	IsRssetSlipCheck
	(
		Ar_Slip_Id				T_ACC_SLIP_HEAD.SLIP_ID%TYPE,
		Ar_Slip_IdSeq			T_ACC_SLIP_BODY.SLIP_IDSEQ%TYPE
	)
	RETURN VARCHAR2
	IS
		lsErrm						VARCHAR2(2000);
		lnCnt						NUMBER;
	BEGIN
		
		SELECT 1
		INTO	 lnCnt
		FROM	 T_Acc_Slip_Body
		WHERE	 SLIP_ID <> RESET_SLIP_ID
		AND 	 	SLIP_IDSEQ <> RESET_SLIP_IDSEQ
		AND 	 RESET_SLIP_ID = AR_SLIP_ID
		AND 	 RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ
		AND 	 ROWNUM < 2;
	
		RETURN '현 전표에 대한 반제전표가 존재합니다.<br>삭제할 수 없습니다.';
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RETURN NULL;
	END;
	
	--전표 상단의 삭제 가능여부 검증
	--return 값이 null이면 삭제 가능이며
	--아니면 삭제 불가능한 이유를 담은 메세지 이다.
	FUNCTION	CheckDeleteMaster
	(
		Ar_Slip_Id				T_ACC_SLIP_HEAD.SLIP_ID%TYPE
	)
	RETURN VARCHAR2
	IS
		lsErrm						VARCHAR2(2000);
		lrSlipHead					T_ACC_SLIP_HEAD%ROWTYPE;
	BEGIN
		--먼저 해당 전표 상단을 읽어온다.
		BEGIN
			SELECT
				*
			INTO
				lrSlipHead
			FROM	T_ACC_SLIP_HEAD
			WHERE	Slip_Id = Ar_Slip_Id;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			--RETURN '해당전표는 이미 삭제되어 있습니다.';
			RETURN NULL;
		END;
		--확정여부 검증
		IF lrSlipHead.KEEP_DT_TRANS IS NOT NULL THEN
			PrintError('해당 전표는 확정되어 삭제하실 수 없습니다.');
		END IF;
		--마감여부 검증
		lsErrm := IsClosed(
			lrSlipHead.MAKE_COMP_CODE,
			lrSlipHead.make_DEPT_CODE,
			lrSlipHead.MAKE_DT
		);
		IF lsErrm IS NOT NULL THEN
			PrintError(lsErrm);
		END IF;
		RETURN NULL;
	EXCEPTION WHEN OTHERS THEN
		lsErrm := SQLERRM;
		IF SQLCODE = -20009 THEN
			RETURN lsErrm;
		END IF;
		RETURN ChangeErrorMsg(lsErrm);
	END;

	FUNCTION	CheckDeleteDetail
	(
		Ar_Slip_Id				T_ACC_SLIP_HEAD.SLIP_ID%TYPE,
		Ar_Slip_IdSeq			T_ACC_SLIP_BODY.SLIP_IDSEQ%TYPE
	)
	RETURN VARCHAR2
	IS
		lrSlipHead					T_ACC_SLIP_HEAD%ROWTYPE;
		lsErrm						VARCHAR2(2000);
	BEGIN
		--먼저 해당 전표 상단을 읽어온다.
		BEGIN
			SELECT
				*
			INTO
				lrSlipHead
			FROM	T_ACC_SLIP_HEAD
			WHERE	Slip_Id = Ar_Slip_Id;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			RETURN '해당전표는 이미 삭제되어 있습니다.';
		END;
		--확정여부 검증
		IF lrSlipHead.KEEP_DT_TRANS IS NOT NULL THEN
			PrintError('해당 전표는 확정되어 삭제하실 수 없습니다.');
		END IF;
		--마감여부 검증
		lsErrm := IsClosed(
			lrSlipHead.MAKE_COMP_CODE,
			lrSlipHead.make_DEPT_CODE,
			lrSlipHead.MAKE_DT
		);
		IF lsErrm IS NOT NULL THEN
			PrintError(lsErrm);
		END IF;
		
		--유가증권 미수이자가 등록되어 있는지 여부(세부)
		lsErrm := IsFinSecItrAmtCHK(Ar_Slip_Id, Ar_Slip_IdSeq);
		IF lsErrm IS NOT NULL THEN
			PrintError(lsErrm);
		END IF;
		
		--반제전표 존재여부
		lsErrm := IsRssetSlipCheck(Ar_Slip_Id, Ar_Slip_IdSeq);
		IF lsErrm IS NOT NULL THEN
			PrintError(lsErrm);
		END IF;

		RETURN NULL;
	EXCEPTION WHEN OTHERS THEN
		lsErrm := SQLERRM;
		IF SQLCODE = -20009 THEN
			RETURN lsErrm;
		END IF;
		RETURN ChangeErrorMsg(lsErrm);
	END;
	PROCEDURE	DeleteMaster
	(
		Ar_Slip_Id				T_ACC_SLIP_HEAD.SLIP_ID%TYPE,
		Ar_Mod_User_No  T_ACC_SLIP_HEAD .MODUSERNO%TYPE DEFAULT NULL
	)
	IS
		lsErrm						VARCHAR2(2000);
	BEGIN
		lsErrm := CheckDeleteMaster(Ar_Slip_Id);
		IF lsErrm IS NOT NULL THEN
			RAISE_APPLICATION_ERROR(-20009,REPLACE(lsErrm,'ORA-20009:',''));
		END IF;
		Sp_T_Acc_Slip_Head_D(Ar_Slip_Id, Ar_Mod_User_No);
	END;
	PROCEDURE	DeleteDetail
	(
		Ar_Slip_Id				T_ACC_SLIP_HEAD.SLIP_ID%TYPE,
		Ar_Slip_IdSeq			T_ACC_SLIP_BODY.SLIP_IDSEQ%TYPE
	)
	IS
		lsErrm						VARCHAR2(2000);
	BEGIN
		lsErrm := CheckDeleteDetail(Ar_Slip_Id,Ar_Slip_IdSeq);
		IF lsErrm IS NOT NULL THEN
			RAISE_APPLICATION_ERROR(-20009,REPLACE(lsErrm,'ORA-20009:',''));
		END IF;
		Sp_T_Acc_Slip_Body_D(Ar_Slip_Id,Ar_Slip_IdSeq);
	END;
END;
/


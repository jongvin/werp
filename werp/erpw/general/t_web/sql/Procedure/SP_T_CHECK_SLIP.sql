CREATE OR REPLACE PROCEDURE Sp_T_Check_Slip
(
	AR_SLIP_ID                                 NUMBER,
	AR_CHECK_WORK				               VARCHAR2 DEFAULT 'N',		--관련업무 입력여부를 검증할 것인지 여부
	AR_CHECK_CONFIRMED_REMAIN		           VARCHAR2 DEFAULT 'Y',		--확정된 잔액만으로 잔액을 검증할 것인지 여부
	AR_UPDATE_CLS  							   VARCHAR2 DEFAULT '1'
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_CHECK_SLIP
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : 전표오류 체크
/* 4. 변  경  이  력 : 최언회 작성(2005-12-07)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
	lsMsg			VARCHAR2(4000);
BEGIN
	-- AR_UPDATE_CLS는 항상 '1'만 넘어온다. 확정/확정취소시 안넘김...
	IF AR_UPDATE_CLS<>'3' THEN -- 확정취소가 아니면 전표 무결성 체크...
		lsMsg := F_T_Check_Slip( AR_SLIP_ID, AR_CHECK_WORK, AR_CHECK_CONFIRMED_REMAIN );
		IF lsMsg <> 'T' THEN
			RAISE_APPLICATION_ERROR	(-20009, '전표생성오류!!!<br>'|| REPLACE(lsMsg,'ORA-',CHR(10)||'ORACLE Internal Error - '));
		ELSE
			Sp_T_Log_Acc_Slip_Head_I(AR_SLIP_ID,AR_UPDATE_CLS);
		END IF;
	ELSE -- 확정취소면 백업만....
		Sp_T_Log_Acc_Slip_Head_I(AR_SLIP_ID,AR_UPDATE_CLS);
	END IF;
	
	Pkg_T_Make_Remain_Keep.Make_Remain_Keep(AR_SLIP_ID);
END;
/

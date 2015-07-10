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
	--ORA-NNNNNN ������ ����Ŭ �޼������� ORA-�̺κ��� �����Ѵ�.
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
	--���������� ����
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
		--�� ���� ����
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
				RETURN 'ȸ�Ⱑ �̹� �����Ǿ����ϴ�.';
			END IF;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			RETURN 'ȸ�Ⱑ ��ϵ��� �ʾҽ��ϴ�.';
		END;
		--�� ���� ����
		BEGIN
			SELECT
				CLSE_CLS
			INTO
				lsClse_Cls
			FROM	T_MONTH_CLOSE
			WHERE	CLSE_MONTH = TO_CHAR(Ar_MakeDt,'YYYYMM')
			AND		COMP_CODE = Ar_make_comp_code;
			IF NVL(lsClse_Cls,'F') = 'T' THEN
				RETURN '�ش� ���� �̹� �����Ǿ����ϴ�.';
			END IF;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			RETURN '�������� ��ϵ��� �ʾҽ��ϴ�.';
		END;
		--�� ���� ����
		BEGIN
			SELECT
				CLSE_CLS
			INTO
				lsClse_Cls
			FROM	T_DAY_CLOSE
			WHERE	CLSE_DAY = TO_CHAR(Ar_MakeDt,'YYYYMMDD')
			AND		COMP_CODE = Ar_make_comp_code;
			IF NVL(lsClse_Cls,'F') = 'T' THEN
				RETURN '�ش� ���ڴ� �̹� �����Ǿ����ϴ�.';
			END IF;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			RETURN '�ϸ����� ��ϵ��� �ʾҽ��ϴ�.';
		END;
	 	-- �μ� �Է±Ⱓ üũ
		BEGIN
			SELECT
				 CASE
				 	 WHEN (F_T_Datetostring(Ar_MakeDt) BETWEEN F_T_Datetostring(NVL(INPUT_DT_F, '19000101')) AND F_T_Datetostring(NVL(INPUT_DT_T, '19000101')) )
					 THEN 'F' -- �Է±Ⱓ
					 ELSE 'T' -- �Է¸���
				END DEPT_CLSE_CLS
			INTO
				lsCLSE_CLS
			FROM
				T_DEPT_CODE_ORG A
			WHERE
				A.COMP_CODE = Ar_make_comp_code
				AND DEPT_CODE = Ar_make_DEPT_CODE;
	
			IF NVL(lsCLSE_CLS,'F') = 'T' THEN
				RETURN '�μ��� �Է±Ⱓ�� ����Ǿ����ϴ�.';
			END IF;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			RETURN '�μ������� ��ϵ��� �ʾҽ��ϴ�.';
		END;
		RETURN NULL;
	EXCEPTION WHEN OTHERS THEN
		lsErrm := SQLERRM;
		RETURN ChangeErrorMsg(lsErrm);
	END;
	
	--�������� �̼����ڰ� ��ϵǾ� �ִ��� ����(����)
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
	
		RETURN '�ش����������� �̼����ڰ� �����մϴ�.';
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RETURN NULL;
	END;
	
	-- ������ǥ ���� üũ... ������ǥ������ üũ
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
	
		RETURN '�� ��ǥ�� ���� ������ǥ�� �����մϴ�.<br>������ �� �����ϴ�.';
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RETURN NULL;
	END;
	
	--��ǥ ����� ���� ���ɿ��� ����
	--return ���� null�̸� ���� �����̸�
	--�ƴϸ� ���� �Ұ����� ������ ���� �޼��� �̴�.
	FUNCTION	CheckDeleteMaster
	(
		Ar_Slip_Id				T_ACC_SLIP_HEAD.SLIP_ID%TYPE
	)
	RETURN VARCHAR2
	IS
		lsErrm						VARCHAR2(2000);
		lrSlipHead					T_ACC_SLIP_HEAD%ROWTYPE;
	BEGIN
		--���� �ش� ��ǥ ����� �о�´�.
		BEGIN
			SELECT
				*
			INTO
				lrSlipHead
			FROM	T_ACC_SLIP_HEAD
			WHERE	Slip_Id = Ar_Slip_Id;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			--RETURN '�ش���ǥ�� �̹� �����Ǿ� �ֽ��ϴ�.';
			RETURN NULL;
		END;
		--Ȯ������ ����
		IF lrSlipHead.KEEP_DT_TRANS IS NOT NULL THEN
			PrintError('�ش� ��ǥ�� Ȯ���Ǿ� �����Ͻ� �� �����ϴ�.');
		END IF;
		--�������� ����
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
		--���� �ش� ��ǥ ����� �о�´�.
		BEGIN
			SELECT
				*
			INTO
				lrSlipHead
			FROM	T_ACC_SLIP_HEAD
			WHERE	Slip_Id = Ar_Slip_Id;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			RETURN '�ش���ǥ�� �̹� �����Ǿ� �ֽ��ϴ�.';
		END;
		--Ȯ������ ����
		IF lrSlipHead.KEEP_DT_TRANS IS NOT NULL THEN
			PrintError('�ش� ��ǥ�� Ȯ���Ǿ� �����Ͻ� �� �����ϴ�.');
		END IF;
		--�������� ����
		lsErrm := IsClosed(
			lrSlipHead.MAKE_COMP_CODE,
			lrSlipHead.make_DEPT_CODE,
			lrSlipHead.MAKE_DT
		);
		IF lsErrm IS NOT NULL THEN
			PrintError(lsErrm);
		END IF;
		
		--�������� �̼����ڰ� ��ϵǾ� �ִ��� ����(����)
		lsErrm := IsFinSecItrAmtCHK(Ar_Slip_Id, Ar_Slip_IdSeq);
		IF lsErrm IS NOT NULL THEN
			PrintError(lsErrm);
		END IF;
		
		--������ǥ ���翩��
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


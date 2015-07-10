CREATE OR REPLACE PROCEDURE Sp_T_Check_Slip
(
	AR_SLIP_ID                                 NUMBER,
	AR_CHECK_WORK				               VARCHAR2 DEFAULT 'N',		--���þ��� �Է¿��θ� ������ ������ ����
	AR_CHECK_CONFIRMED_REMAIN		           VARCHAR2 DEFAULT 'Y',		--Ȯ���� �ܾ׸����� �ܾ��� ������ ������ ����
	AR_UPDATE_CLS  							   VARCHAR2 DEFAULT '1'
)
IS
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_CHECK_SLIP
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : ��ǥ���� üũ
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-12-07)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	lsMsg			VARCHAR2(4000);
BEGIN
	-- AR_UPDATE_CLS�� �׻� '1'�� �Ѿ�´�. Ȯ��/Ȯ����ҽ� �ȳѱ�...
	IF AR_UPDATE_CLS<>'3' THEN -- Ȯ����Ұ� �ƴϸ� ��ǥ ���Ἲ üũ...
		lsMsg := F_T_Check_Slip( AR_SLIP_ID, AR_CHECK_WORK, AR_CHECK_CONFIRMED_REMAIN );
		IF lsMsg <> 'T' THEN
			RAISE_APPLICATION_ERROR	(-20009, '��ǥ��������!!!<br>'|| REPLACE(lsMsg,'ORA-',CHR(10)||'ORACLE Internal Error - '));
		ELSE
			Sp_T_Log_Acc_Slip_Head_I(AR_SLIP_ID,AR_UPDATE_CLS);
		END IF;
	ELSE -- Ȯ����Ҹ� �����....
		Sp_T_Log_Acc_Slip_Head_I(AR_SLIP_ID,AR_UPDATE_CLS);
	END IF;
	
	Pkg_T_Make_Remain_Keep.Make_Remain_Keep(AR_SLIP_ID);
END;
/

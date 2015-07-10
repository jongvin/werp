Create Or Replace Procedure SP_T_FIX_DEPREC_CHECK
(
	AR_FIX_ASSET_SEQ                               NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_YEAR_CLOSE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_YEAR_CLOSE ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-25)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
ln_CNT Number;

Begin
	select count(*)
	Into	ln_CNT
	from t_fix_sum
	where fix_asset_seq = AR_FIX_ASSET_SEQ;
	if ln_CNT > 0 Then
		Raise_Application_Error(-20009,'������ ����۾��� ����� ���¿��� <br>��ġ������ ����,������ �� �����ϴ�.');
	end if;
End;
/

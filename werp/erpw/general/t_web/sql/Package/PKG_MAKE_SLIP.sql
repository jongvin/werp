Create Or Replace Package PKG_MAKE_SLIP
Is
/*
	�ڵ���ǥ�� �����ϱ� ���� ���� ��Ű�� �Դϴ�.
	�⺻ �۾� �ܰ��
	1. New_Head�� ȣ���Ͽ� �⺻���� ������ ��ǥ ������ڵ带 �޽��ϴ�.
	2. �߰��� ������ �κ��� ������ �����մϴ�.
	3. Insert_Head�� ȣ���Ͽ� ��ǥ ����� �Է��մϴ�.
	4. ���� ���� ���α׷��� ������ ���� ��ǥ ������ �����մϴ�
	4-1. New_Body�� ȣ���Ͽ� �⺻ ���ڵ带 �����մϴ�.
	4-2. ���� ���α׷� ������ ���� �߰� ������ �����մϴ�
	4-3. Insert_Body�� ȣ���Ͽ� ��ǥ ������ �Է��մϴ�.
	4-4. 4-1~4-3 ������ �ݺ��մϴ�. �̶� �߿��� ���� Ar_Make_SlipLine�� ���� ��Ű�� å���� ���� ���α׷��� �ִٴ� ���Դϴ�.
	5. ��ǥ �۾��� �Ϸ�Ǹ� Check_Slip�� ȣ���Ͽ� ��ǥ�� �����մϴ�.

	�׿ܿ� ���� ��ƿ��Ƽ �Լ����� �����˴ϴ�.
	�� �� �Ͻʽÿ�.^^
	�ۼ��� : 2006-01-27 �����
*/
	Procedure	Check_Slip
	(
		Ar_Slip_Id					T_Acc_Slip_Head.Slip_Id%Type
	);
	Procedure	Insert_Head
	(
		Ar_Head						T_ACC_SLIP_HEAD%RowType
	);
	Procedure	Insert_Body
	(
		Ar_Body						T_ACC_SLIP_BODY%RowType
	);
	/*
A : �Ϲ� , 
B : �ڵ� , 
C : ��� , 
D : ��� , 
E : ���� , 
F : ����, 
G : �극����,  
S : ��������ǥ�� ������ǥ , 
Z : ����, 
W : ����Ȱ��, 
N : ���κ긴������
	*/
	Function	New_Head
	(
		Ar_Make_Comp_Code			T_Acc_Slip_Head.Make_Comp_Code%Type,		--�ۼ� �����
		Ar_Make_Dept_Code			T_Acc_Slip_Head.Make_Dept_Code%Type,		--�ۼ� �μ�
		Ar_Make_Dt					T_Acc_Slip_Head.MAKE_DT%Type,				--�ۼ���
		Ar_Make_SlipCls				T_Acc_Slip_Head.Make_SlipCls%Type,			--��ǥ���� 1 : ��ü , 2 : ���� , 3 : �ڱ�
		Ar_Slip_Kind_Tag			T_Acc_Slip_Head.Slip_Kind_Tag%Type,			--A : �Ϲ� , B : �ڵ� , C : ��� , D : ��� , E : ���� , F : ����, G : �극����,  S : ��������ǥ�� ������ǥ , Z : ����, W : ����Ȱ��, N : ���κ긴������
		Ar_Make_Pers				T_Acc_Slip_Head.Make_Pers%Type,				--�ۼ��ڻ��
		Ar_WORK_CODE				T_Acc_Slip_Head.WORK_CODE%Type,				--�ڵ���ǥ�ڵ� ���̺� ���� T_WORK_CODE
		Ar_CHARGE_PERS				T_Acc_Slip_Head.CHARGE_PERS%Type,			--ȸ�� Ȯ�� ����� ���
		Ar_CRTUSERNO				T_Acc_Slip_Head.CRTUSERNO%Type				--�Է��� ���
	)
	Return T_ACC_SLIP_HEAD%RowType;
	Function	New_Body
	(
		Ar_Head		In Out NoCopy	T_ACC_SLIP_HEAD%RowType,					--��ǥ ��� ���ڵ�
		Ar_Make_SlipLine			T_ACC_SLIP_BODY.Make_SlipLine%Type,			--��ǥ�¼�
		Ar_ACC_CODE					T_ACC_SLIP_BODY.ACC_CODE%Type,				--�����ڵ�
		Ar_CLASS_CODE				T_ACC_SLIP_BODY.CLASS_CODE%Type,			--�ι��ڵ�
		Ar_VAT_CODE					T_ACC_SLIP_BODY.VAT_CODE%Type				--�ΰ��� �ڵ�
	)
	Return T_ACC_SLIP_BODY%RowType;
	--�ڵ���ǥ �ڵ带 ����Ͽ� �ش� �ڵ���ǥ�� ���� ����ڸ� ���س���.
	Function	Get_CHARGE_PERS
	(
		Ar_WORK_CODE				T_Acc_Slip_Head.WORK_CODE%Type,				--�ڵ���ǥ�ڵ� ���̺� ���� T_WORK_CODE
		Ar_Comp_Code				T_COMPANY.COMP_CODE%Type					--�ڵ���ǥ�� ��������� ���̺� ����
	)
	Return T_Acc_Slip_Head.CHARGE_PERS%Type;
	--��ǥ�� �Ϲ� ���� �μ��� ���Ѵ�
	Function	Get_Normal_Dept_Code
	(
		Ar_Comp_Code			Varchar2
	)
	Return Varchar2;
	--��ǥ�� �ڱݰ��� ���� �μ��� ���Ѵ�
	Function	Get_Fin_Dept_Code
	(
		Ar_Comp_Code			Varchar2
	)
	Return Varchar2;
	-- �⺻ �ι��ڵ带 ���Ѵ�.
	Function	Get_Class_Code
	(
		Ar_Dept_Code			Varchar2
	)
	Return T_CLASS_CODE.CLASS_CODE%Type;
	-- ���� �ŷ�ó ��ȣ�� �����´�
	Function	Get_Dflt_Cust_Seq
	Return t_cust_code.CUST_SEQ%Type;
	-- �ŷ�ó�ڵ�� ���� �ŷ�ó SEQ�� ���Ѵ�.
	Function	Get_Cust_Seq
	(
		Ar_Cust_Code			Varchar2
	)
	Return t_cust_code.CUST_SEQ%Type;
	-- �ŷ�ó SEQ�ι��� �ŷ�ó ���� ���Ѵ�.
	Function	Get_Cust_Name
	(
		Ar_Cust_Seq				t_cust_code.CUST_SEQ%Type
	)
	Return t_cust_code.Cust_Name%Type;
	--�μ��κ��� ������ڵ带 ���Ѵ�.
	Function	Get_Comp_Code
	(
		Ar_Dept_Code			Varchar2
	)
	Return T_COMPANY_ORG.COMP_CODE%Type;
	Function	IsCashAccCode
	(
		Ar_Acc_Code				Varchar2
	)
	Return Boolean;
	Procedure	CopySlipBody
	(
		Ar_Src			In Out NoCopy	T_ACC_SLIP_BODY%RowType,
		Ar_Dst			In Out NoCopy	T_ACC_SLIP_BODY%RowType
	);
	Procedure	CopySlipBodyFromTemp
	(
		Ar_Src			In Out NoCopy	T_WORK_ACC_SLIP_BODY%RowType,
		Ar_Dst			In Out NoCopy	T_ACC_SLIP_BODY%RowType
	);
	Function	IsRemainAccCode
	(
		Ar_Acc_Code				Varchar2
	)
	Return Boolean;
End;
/
Create Or Replace Package Body PKG_MAKE_SLIP
Is
	DFLT_CUST_CODE_NAME		constant			v_t_code_list.CODE_GROUP_ID%Type := 'DFLT_CUST_CODE';
	Procedure	Check_Slip
	(
		Ar_Slip_Id					T_Acc_Slip_Head.Slip_Id%Type
	)
	Is
	Begin
		SP_T_CHECK_SLIP(Ar_Slip_Id);
	End;
	Procedure	Insert_Head
	(
		Ar_Head						T_ACC_SLIP_HEAD%RowType
	)
	Is
	Begin
		Insert Into T_ACC_SLIP_HEAD Values Ar_Head;
	End;
	Procedure	Insert_Body
	(
		Ar_Body						T_ACC_SLIP_BODY%RowType
	)
	Is
	Begin
		Insert Into T_ACC_SLIP_BODY_INS
		(
			SLIP_ID,
			SLIP_IDSEQ,
			MAKE_SLIPLINE,
			ACC_CODE,
			DB_AMT,
			CR_AMT,
			SUMMARY_CODE,
			TAX_COMP_CODE,
			COMP_CODE,
			DEPT_CODE,
			CLASS_CODE,
			VAT_CODE,
			VAT_DT,
			SUPAMT,
			VATAMT,
			CUST_SEQ,
			CUST_NAME,
			BANK_CODE,
			ACCNO,
			RESET_SLIP_ID,
			RESET_SLIP_IDSEQ,
			MAKE_COMP_CODE,
			MAKE_DEPT_CODE,
			MAKE_DT,
			KEEP_DT,
			ORG_SLIP_ID,
			ORG_SLIP_IDSEQ,
			BRAIN_GRP_SEQ,
			BRAIN_SLIP_SEQ1,
			BRAIN_SLIP_SEQ2,
			BRAIN_SLIP_LINE,
			SLIP_KIND_TAG,
			TRANSFER_TAG,
			IGNORE_SET_RESET_TAG,
			CRTUSERNO,
			CRTDATE,
			MODUSERNO,
			MODDATE,
			SUMMARY1,
			SUMMARY2,
			CARD_SEQ,
			CHK_NO,
			BILL_NO,
			REC_BILL_NO,
			CP_NO,
			SECU_NO,
			LOAN_NO,
			LOAN_REFUND_NO,
			LOAN_REFUND_SEQ,
			DEPOSIT_ACCNO,
			PAYMENT_SEQ,
			PAY_CON_CASH,
			PAY_CON_BILL,
			PAY_CON_BILL_DT,
			PAY_CON_BILL_DAYS,
			EMP_NO,
			ANTICIPATION_DT,
			MNG_ITEM_CHAR1,
			MNG_ITEM_CHAR2,
			MNG_ITEM_CHAR3,
			MNG_ITEM_CHAR4,
			MNG_ITEM_NUM1,
			MNG_ITEM_NUM2,
			MNG_ITEM_NUM3,
			MNG_ITEM_NUM4,
			MNG_ITEM_DT1,
			MNG_ITEM_DT2,
			MNG_ITEM_DT3,
			MNG_ITEM_DT4,
			FIX_ASSET_SEQ
		)
		Values
		(
			Ar_Body.SLIP_ID,
			Ar_Body.SLIP_IDSEQ,
			Ar_Body.MAKE_SLIPLINE,
			Ar_Body.ACC_CODE,
			Ar_Body.DB_AMT,
			Ar_Body.CR_AMT,
			Ar_Body.SUMMARY_CODE,
			Ar_Body.TAX_COMP_CODE,
			Ar_Body.COMP_CODE,
			Ar_Body.DEPT_CODE,
			Ar_Body.CLASS_CODE,
			Ar_Body.VAT_CODE,
			Ar_Body.VAT_DT,
			Ar_Body.SUPAMT,
			Ar_Body.VATAMT,
			Ar_Body.CUST_SEQ,
			Ar_Body.CUST_NAME,
			Ar_Body.BANK_CODE,
			Ar_Body.ACCNO,
			Ar_Body.RESET_SLIP_ID,
			Ar_Body.RESET_SLIP_IDSEQ,
			Ar_Body.MAKE_COMP_CODE,
			Ar_Body.MAKE_DEPT_CODE,
			Ar_Body.MAKE_DT,
			Ar_Body.KEEP_DT,
			Ar_Body.ORG_SLIP_ID,
			Ar_Body.ORG_SLIP_IDSEQ,
			Ar_Body.BRAIN_GRP_SEQ,
			Ar_Body.BRAIN_SLIP_SEQ1,
			Ar_Body.BRAIN_SLIP_SEQ2,
			Ar_Body.BRAIN_SLIP_LINE,
			Ar_Body.SLIP_KIND_TAG,
			Ar_Body.TRANSFER_TAG,
			Ar_Body.IGNORE_SET_RESET_TAG,
			Ar_Body.CRTUSERNO,
			Ar_Body.CRTDATE,
			Ar_Body.MODUSERNO,
			Ar_Body.MODDATE,
			Ar_Body.SUMMARY1,
			Ar_Body.SUMMARY2,
			Ar_Body.CARD_SEQ,
			Ar_Body.CHK_NO,
			Ar_Body.BILL_NO,
			Ar_Body.REC_BILL_NO,
			Ar_Body.CP_NO,
			Ar_Body.SECU_NO,
			Ar_Body.LOAN_NO,
			Ar_Body.LOAN_REFUND_NO,
			Ar_Body.LOAN_REFUND_SEQ,
			Ar_Body.DEPOSIT_ACCNO,
			Ar_Body.PAYMENT_SEQ,
			Ar_Body.PAY_CON_CASH,
			Ar_Body.PAY_CON_BILL,
			Ar_Body.PAY_CON_BILL_DT,
			Ar_Body.PAY_CON_BILL_DAYS,
			Ar_Body.EMP_NO,
			Ar_Body.ANTICIPATION_DT,
			Ar_Body.MNG_ITEM_CHAR1,
			Ar_Body.MNG_ITEM_CHAR2,
			Ar_Body.MNG_ITEM_CHAR3,
			Ar_Body.MNG_ITEM_CHAR4,
			Ar_Body.MNG_ITEM_NUM1,
			Ar_Body.MNG_ITEM_NUM2,
			Ar_Body.MNG_ITEM_NUM3,
			Ar_Body.MNG_ITEM_NUM4,
			Ar_Body.MNG_ITEM_DT1,
			Ar_Body.MNG_ITEM_DT2,
			Ar_Body.MNG_ITEM_DT3,
			Ar_Body.MNG_ITEM_DT4,
			Ar_Body.FIX_ASSET_SEQ
		);
	End;
	Function	New_Head
	(
		Ar_Make_Comp_Code			T_Acc_Slip_Head.Make_Comp_Code%Type,		--�ۼ� �����
		Ar_Make_Dept_Code			T_Acc_Slip_Head.Make_Dept_Code%Type,		--�ۼ� �μ�
		Ar_Make_Dt					T_Acc_Slip_Head.MAKE_DT%Type,				--�ۼ���
		Ar_Make_SlipCls				T_Acc_Slip_Head.Make_SlipCls%Type,			--��ǥ���� 1 : ��ü , 2 : ���� , 3 : ����
		Ar_Slip_Kind_Tag			T_Acc_Slip_Head.Slip_Kind_Tag%Type,			--A : �Ϲ� , B : �ڵ� , C : ����/����/������ , D : ��� , Z : ����
		Ar_Make_Pers				T_Acc_Slip_Head.Make_Pers%Type,				--�ۼ��ڻ��
		Ar_WORK_CODE				T_Acc_Slip_Head.WORK_CODE%Type,				--�ڵ���ǥ�ڵ� ���̺� ���� T_WORK_CODE
		Ar_CHARGE_PERS				T_Acc_Slip_Head.CHARGE_PERS%Type,			--ȸ�� Ȯ�� ����� ���
		Ar_CRTUSERNO				T_Acc_Slip_Head.CRTUSERNO%Type				--�Է��� ���
	)
	Return T_ACC_SLIP_HEAD%RowType
	Is
		lrRet						T_ACC_SLIP_HEAD%RowType;
	Begin
		lrRet.CRTUSERNO := Ar_CRTUSERNO;
		lrRet.CRTDATE := SysDate;
		lrRet.MAKE_SLIPCLS := Ar_Make_SlipCls;
		lrRet.MAKE_COMP_CODE := Ar_Make_Comp_Code;
		lrRet.MAKE_DEPT_CODE := Ar_Make_Dept_Code;
		lrRet.MAKE_DT := Ar_Make_Dt;
		lrRet.MAKE_DT_TRANS := To_Char(Ar_Make_Dt,'YYYYMMDD');
		lrRet.MAKE_PERS := Ar_Make_Pers;
		lrRet.GROUPWARE_SLIPSTATUS := 'N';
		lrRet.WORK_CODE := Ar_WORK_CODE;
		lrRet.SLIP_KIND_TAG := Ar_Slip_Kind_Tag;
		lrRet.TRANSFER_TAG := 'F';
		lrRet.IGNORE_SET_RESET_TAG := 'F';
		Begin
			Select
				DEPT_CODE
			Into
				lrRet.INOUT_DEPT_CODE
			From	T_COMPANY_ORG
			Where	COMP_CODE = Ar_Make_Comp_Code;
		Exception When No_Data_Found Then
			Raise_Application_Error(-20009,'�ۼ� ������� ã�� �� �����ϴ�.');
		End;
		If lrRet.INOUT_DEPT_CODE Is Null Then
			Raise_Application_Error(-20009,'����� ������ �ⳳ�μ��� ������ �Ǿ� ���� �ʽ��ϴ�.');
		End If;
		lrRet.CHARGE_PERS := Ar_CHARGE_PERS;
		If lrRet.CHARGE_PERS Is Null Then
			lrRet.CHARGE_PERS := Get_CHARGE_PERS(lrRet.WORK_CODE,Ar_Make_Comp_Code);
			If lrRet.CHARGE_PERS Is Null Then
				Raise_Application_Error(-20009,'�ڵ���ǥ�� ���õ� ȸ�� ����ڸ� ã�� �� �����ϴ�.');
			End If;
		End If;
		Begin
			Select
				a.NAME
			Into
				lrRet.MAKE_NAME
			From	Z_AUTHORITY_USER a
			Where	a.EMPNO = lrRet.MAKE_PERS;
		Exception When No_Data_Found Then
			Raise_Application_Error(-20009,'�ش� ����� ����� ã�� �� �����ϴ�. ��� ('||lrRet.MAKE_PERS||')');
		End;
		lrRet.MAKE_SEQ := F_T_Get_New_Make_Seq(lrRet.MAKE_COMP_CODE,lrRet.MAKE_DT_TRANS);
		lrRet.MAKE_SLIPNO := F_T_GEN_MAKE_SLIP_NO(lrRet.MAKE_COMP_CODE,lrRet.MAKE_DT_TRANS,lrRet.SLIP_KIND_TAG,lrRet.MAKE_SEQ);
		Select
			SQ_T_SLIP_ID.NextVal
		Into
			lrRet.SLIP_ID
		From	Dual;
		Return lrRet;
	End;
	Function	New_Body
	(
		Ar_Head		In Out NoCopy	T_ACC_SLIP_HEAD%RowType,					--��ǥ ��� ���ڵ�
		Ar_Make_SlipLine			T_ACC_SLIP_BODY.Make_SlipLine%Type,			--��ǥ�¼�
		Ar_ACC_CODE					T_ACC_SLIP_BODY.ACC_CODE%Type,				--�����ڵ�
		Ar_CLASS_CODE				T_ACC_SLIP_BODY.CLASS_CODE%Type,			--�ι��ڵ�
		Ar_VAT_CODE					T_ACC_SLIP_BODY.VAT_CODE%Type				--�ΰ��� �ڵ�
	)
	Return T_ACC_SLIP_BODY%RowType
	Is
		lrRet						T_ACC_SLIP_BODY%RowType;
		lrAcc						T_ACC_CODE%RowType;
	Begin
		Begin
			Select
				*
			Into
				lrAcc
			From	T_ACC_CODE
			Where	ACC_CODE = Ar_ACC_CODE;
		Exception When No_Data_Found Then
			Raise_Application_Error(-20009,'������ ã�� �� �����ϴ�.'||Ar_ACC_CODE);
		End;
		lrRet.SLIP_ID := Ar_Head.SLIP_ID;
		lrRet.MAKE_SLIPLINE := Ar_Make_SlipLine;
		lrRet.ACC_CODE := Ar_ACC_CODE;
		lrRet.DB_AMT := 0;
		lrRet.CR_AMT := 0;
		lrRet.TAX_COMP_CODE := Ar_Head.MAKE_COMP_CODE;
		lrRet.COMP_CODE := Ar_Head.MAKE_COMP_CODE;
		lrRet.DEPT_CODE := Ar_Head.MAKE_DEPT_CODE;
		lrRet.CLASS_CODE := Ar_CLASS_CODE;
		lrRet.VAT_CODE := Ar_VAT_CODE;
		lrRet.SUPAMT := 0;
		lrRet.VATAMT := 0;
		lrRet.CRTUSERNO := Ar_Head.CRTUSERNO;
		lrRet.CRTDATE := SysDate;
		lrRet.VAT_CODE := '50';	--�������� ��û�� ���� ������ 
		Select
			SQ_T_SLIP_IDSEQ.NextVal
		Into
			lrRet.SLIP_IDSEQ
		From	Dual;
		If lrAcc.ACC_REMAIN_MNG = 'T' Then
			lrRet.RESET_SLIP_ID := lrRet.SLIP_ID;
			lrRet.RESET_SLIP_IDSEQ := lrRet.SLIP_IDSEQ;
		End If;
		Return lrRet;
	End;
	--�ڵ���ǥ �ڵ带 ����Ͽ� �ش� �ڵ���ǥ�� ���� ����ڸ� ���س���.
	Function	Get_CHARGE_PERS
	(
		Ar_WORK_CODE				T_Acc_Slip_Head.WORK_CODE%Type,				--�ڵ���ǥ�ڵ� ���̺� ���� T_WORK_CODE
		Ar_Comp_Code				T_COMPANY.COMP_CODE%Type					--�ڵ���ǥ�� ��������� ���̺� ����
	)
	Return T_Acc_Slip_Head.CHARGE_PERS%Type
	Is
		lsTemp						T_Acc_Slip_Head.CHARGE_PERS%Type;
	Begin
		Select
			CHARGE_PERS
		Into
			lsTemp
		From	T_WORK_CHARGE_PERS a
		Where	WORK_CODE = Ar_WORK_CODE
		And		COMP_CODE = Ar_Comp_Code;
		Return lsTemp;
	Exception When No_Data_Found Then
		Return Null;
	End;
	--��ǥ�� �Ϲ� ���� �μ��� ���Ѵ�
	Function	Get_Normal_Dept_Code
	(
		Ar_Comp_Code			Varchar2
	)
	Return Varchar2
	Is
		lsRet				T_DEPT_CODE.DEPT_CODE%Type;
	Begin
		Select
			ACC_DEPT_CODE
		Into
			lsRet
		From	T_COMPANY_ORG
		Where	COMP_CODE = Ar_Comp_Code;
		Return lsRet;
	End;
	--��ǥ�� �ڱݰ��� ���� �μ��� ���Ѵ�
	Function	Get_Fin_Dept_Code
	(
		Ar_Comp_Code			Varchar2
	)
	Return Varchar2
	Is
		lsRet				T_DEPT_CODE.DEPT_CODE%Type;
	Begin
		Select
			FIN_DEPT_CODE
		Into
			lsRet
		From	T_COMPANY_ORG
		Where	COMP_CODE = Ar_Comp_Code;
		Return lsRet;
	End;
	-- �⺻ �ι��ڵ带 ���Ѵ�.
	Function	Get_Class_Code
	(
		Ar_Dept_Code			Varchar2
	)
	Return T_CLASS_CODE.CLASS_CODE%Type
	Is
		lsRet				T_CLASS_CODE.CLASS_CODE%Type;
	Begin
		Select
			CLASS_CODE
		Into
			lsRet
		From	T_DEPT_CLASS_CODE
		Where	DEPT_CODE = Ar_Dept_Code
		And		DFLT_TAG = 'T'
		And		RowNum < 2;
		Return lsRet;
	Exception When No_Data_Found Then
		Return Null;
	End;
	Function	Get_Dflt_Cust_Seq
	Return t_cust_code.CUST_SEQ%Type
	Is
		lnSeq						t_cust_code.CUST_SEQ%Type;
		lsCode						v_t_code_list.CODE_LIST_ID%Type;
	Begin
		Select
			CODE_LIST_ID
		Into
			lsCode
		From	v_t_code_list
		Where	CODE_GROUP_ID = DFLT_CUST_CODE_NAME
		And		RowNum < 2;
		Return Get_Cust_Seq(lsCode);
	Exception When No_Data_Found Then
		Return Null;
	End;
	-- �ŷ�ó�ڵ�� ���� �ŷ�ó SEQ�� ���Ѵ�.
	Function	Get_Cust_Seq
	(
		Ar_Cust_Code			Varchar2
	)
	Return t_cust_code.CUST_SEQ%Type
	Is
		lnSeq						t_cust_code.CUST_SEQ%Type;
	Begin
		Select
			CUST_SEQ
		Into
			lnSeq
		From	t_cust_code
		Where	CUST_CODE = Ar_Cust_Code
		And		RowNum = 1;
		Return lnSeq;
	Exception When No_Data_Found Then
		Return Null;
	End;
	-- �ŷ�ó SEQ�ι��� �ŷ�ó ���� ���Ѵ�.
	Function	Get_Cust_Name
	(
		Ar_Cust_Seq				t_cust_code.CUST_SEQ%Type
	)
	Return t_cust_code.Cust_Name%Type
	Is
		lsRet					t_cust_code.Cust_Name%Type;
	Begin
		Select
			CUST_NAME
		Into
			lsRet
		From	t_cust_code
		Where	CUST_SEQ = Ar_Cust_Seq;
		Return lsRet;
	Exception When No_Data_Found Then
		Return Null;
	End;
	--�μ��κ��� ������ڵ带 ���Ѵ�.
	Function	Get_Comp_Code
	(
		Ar_Dept_Code			Varchar2
	)
	Return T_COMPANY_ORG.COMP_CODE%Type
	Is
		lsRet					T_COMPANY_ORG.COMP_CODE%Type;
	Begin
		Select
			COMP_CODE
		Into
			lsRet
		From	T_DEPT_CODE_ORG
		Where	DEPT_CODE = Ar_Dept_Code;
		Return lsRet;
	Exception When No_Data_Found Then
		Return Null;
	End;
	Function	IsCashAccCode
	(
		Ar_Acc_Code				Varchar2
	)
	Return Boolean
	Is
		lsAccCode				T_ACC_CODE.ACC_CODE%Type;
	Begin
		Begin
			Select
				a.CODE_LIST_ID
			Into
				lsAccCode
			From	V_T_CODE_LIST a
			Where	a.CODE_GROUP_ID = 'CASH_ACC_CODE'
			And		RowNum < 2;
		Exception When No_Data_Found Then
			Raise_Application_Error(-20009,'�����ڵ忡 ���ݰ����ڵ尡 ��ϵǾ� ���� �ʽ��ϴ�.(CASH_ACC_CODE).');
		End;
		If lsAccCode = Ar_Acc_Code Then
			Return True;
		Else
			Return False;
		End If;
	End;
	Procedure	CopySlipBody
	(
		Ar_Src			In Out NoCopy	T_ACC_SLIP_BODY%RowType,
		Ar_Dst			In Out NoCopy	T_ACC_SLIP_BODY%RowType
	)
	Is
	Begin
		Ar_Dst.ACC_CODE				:=	Ar_Src.ACC_CODE;
		Ar_Dst.DB_AMT				:=	Ar_Src.DB_AMT;
		Ar_Dst.CR_AMT				:=	Ar_Src.CR_AMT;
		Ar_Dst.SUMMARY_CODE			:=	Ar_Src.SUMMARY_CODE;
		Ar_Dst.TAX_COMP_CODE		:=	Ar_Src.TAX_COMP_CODE;
		Ar_Dst.COMP_CODE			:=	Ar_Src.COMP_CODE;
		Ar_Dst.DEPT_CODE			:=	Ar_Src.DEPT_CODE;
		Ar_Dst.CLASS_CODE			:=	Ar_Src.CLASS_CODE;
		Ar_Dst.VAT_CODE				:=	Ar_Src.VAT_CODE;
		Ar_Dst.VAT_DT				:=	Ar_Src.VAT_DT;
		Ar_Dst.SUPAMT				:=	Ar_Src.SUPAMT;
		Ar_Dst.VATAMT				:=	Ar_Src.VATAMT;
		Ar_Dst.CUST_SEQ				:=	Ar_Src.CUST_SEQ;
		Ar_Dst.CUST_NAME			:=	Ar_Src.CUST_NAME;
		Ar_Dst.BANK_CODE			:=	Ar_Src.BANK_CODE;
		Ar_Dst.ACCNO				:=	Ar_Src.ACCNO;
		Ar_Dst.RESET_SLIP_ID		:=	Ar_Src.RESET_SLIP_ID;
		Ar_Dst.RESET_SLIP_IDSEQ		:=	Ar_Src.RESET_SLIP_IDSEQ;
		Ar_Dst.MAKE_COMP_CODE		:=	Ar_Src.MAKE_COMP_CODE;
		Ar_Dst.MAKE_DEPT_CODE		:=	Ar_Src.MAKE_DEPT_CODE;
		Ar_Dst.SLIP_KIND_TAG		:=	Ar_Src.SLIP_KIND_TAG;
		Ar_Dst.TRANSFER_TAG			:=	Ar_Src.TRANSFER_TAG;
		Ar_Dst.IGNORE_SET_RESET_TAG	:=	Ar_Src.IGNORE_SET_RESET_TAG;
		Ar_Dst.SUMMARY1				:=	Ar_Src.SUMMARY1;
		Ar_Dst.SUMMARY2				:=	Ar_Src.SUMMARY2;
		Ar_Dst.CARD_SEQ				:=	Ar_Src.CARD_SEQ;
		Ar_Dst.CHK_NO				:=	Ar_Src.CHK_NO;
		Ar_Dst.BILL_NO				:=	Ar_Src.BILL_NO;
		Ar_Dst.REC_BILL_NO			:=	Ar_Src.REC_BILL_NO;
		Ar_Dst.CP_NO				:=	Ar_Src.CP_NO;
		Ar_Dst.SECU_NO				:=	Ar_Src.SECU_NO;
		Ar_Dst.LOAN_NO				:=	Ar_Src.LOAN_NO;
		Ar_Dst.LOAN_REFUND_NO		:=	Ar_Src.LOAN_REFUND_NO;
		Ar_Dst.LOAN_REFUND_SEQ		:=	Ar_Src.LOAN_REFUND_SEQ;
		Ar_Dst.DEPOSIT_ACCNO		:=	Ar_Src.DEPOSIT_ACCNO;
		Ar_Dst.PAYMENT_SEQ			:=	Ar_Src.PAYMENT_SEQ;
		Ar_Dst.PAY_CON_CASH			:=	Ar_Src.PAY_CON_CASH;
		Ar_Dst.PAY_CON_BILL			:=	Ar_Src.PAY_CON_BILL;
		Ar_Dst.PAY_CON_BILL_DT		:=	Ar_Src.PAY_CON_BILL_DT;
		Ar_Dst.PAY_CON_BILL_DAYS	:=	Ar_Src.PAY_CON_BILL_DAYS;
		Ar_Dst.EMP_NO				:=	Ar_Src.EMP_NO;
		Ar_Dst.ANTICIPATION_DT		:=	Ar_Src.ANTICIPATION_DT;
		Ar_Dst.MNG_ITEM_CHAR1		:=	Ar_Src.MNG_ITEM_CHAR1;
		Ar_Dst.MNG_ITEM_CHAR2		:=	Ar_Src.MNG_ITEM_CHAR2;
		Ar_Dst.MNG_ITEM_CHAR3		:=	Ar_Src.MNG_ITEM_CHAR3;
		Ar_Dst.MNG_ITEM_CHAR4		:=	Ar_Src.MNG_ITEM_CHAR4;
		Ar_Dst.MNG_ITEM_NUM1		:=	Ar_Src.MNG_ITEM_NUM1;
		Ar_Dst.MNG_ITEM_NUM2		:=	Ar_Src.MNG_ITEM_NUM2;
		Ar_Dst.MNG_ITEM_NUM3		:=	Ar_Src.MNG_ITEM_NUM3;
		Ar_Dst.MNG_ITEM_NUM4		:=	Ar_Src.MNG_ITEM_NUM4;
		Ar_Dst.MNG_ITEM_DT1			:=	Ar_Src.MNG_ITEM_DT1;
		Ar_Dst.MNG_ITEM_DT2			:=	Ar_Src.MNG_ITEM_DT2;
		Ar_Dst.MNG_ITEM_DT3			:=	Ar_Src.MNG_ITEM_DT3;
		Ar_Dst.MNG_ITEM_DT4			:=	Ar_Src.MNG_ITEM_DT4;
		Ar_Dst.FIX_ASSET_SEQ		:=	Ar_Src.FIX_ASSET_SEQ;
	End;
	Procedure	CopySlipBodyFromTemp
	(
		Ar_Src			In Out NoCopy	T_WORK_ACC_SLIP_BODY%RowType,
		Ar_Dst			In Out NoCopy	T_ACC_SLIP_BODY%RowType
	)
	Is
	Begin
		Ar_Dst.ACC_CODE				:=	Ar_Src.ACC_CODE;
		Ar_Dst.DB_AMT				:=	Ar_Src.DB_AMT;
		Ar_Dst.CR_AMT				:=	Ar_Src.CR_AMT;
		Ar_Dst.SUMMARY_CODE			:=	Ar_Src.SUMMARY_CODE;
		Ar_Dst.TAX_COMP_CODE		:=	Ar_Src.TAX_COMP_CODE;
		Ar_Dst.COMP_CODE			:=	Ar_Src.COMP_CODE;
		Ar_Dst.DEPT_CODE			:=	Ar_Src.DEPT_CODE;
		Ar_Dst.CLASS_CODE			:=	Ar_Src.CLASS_CODE;
		Ar_Dst.VAT_CODE				:=	Ar_Src.VAT_CODE;
		Ar_Dst.VAT_DT				:=	Ar_Src.VAT_DT;
		Ar_Dst.SUPAMT				:=	Ar_Src.SUPAMT;
		Ar_Dst.VATAMT				:=	Ar_Src.VATAMT;
		Ar_Dst.CUST_SEQ				:=	Ar_Src.CUST_SEQ;
		Ar_Dst.CUST_NAME			:=	Ar_Src.CUST_NAME;
		Ar_Dst.BANK_CODE			:=	Ar_Src.BANK_CODE;
		Ar_Dst.ACCNO				:=	Ar_Src.ACCNO;
		Ar_Dst.RESET_SLIP_ID		:=	Ar_Src.RESET_SLIP_ID;
		Ar_Dst.RESET_SLIP_IDSEQ		:=	Ar_Src.RESET_SLIP_IDSEQ;
		Ar_Dst.MAKE_COMP_CODE		:=	Ar_Src.MAKE_COMP_CODE;
		Ar_Dst.MAKE_DEPT_CODE		:=	Ar_Src.MAKE_DEPT_CODE;
		Ar_Dst.SLIP_KIND_TAG		:=	Ar_Src.SLIP_KIND_TAG;
		Ar_Dst.TRANSFER_TAG			:=	Ar_Src.TRANSFER_TAG;
		Ar_Dst.IGNORE_SET_RESET_TAG	:=	Ar_Src.IGNORE_SET_RESET_TAG;
		Ar_Dst.SUMMARY1				:=	Ar_Src.SUMMARY1;
		Ar_Dst.SUMMARY2				:=	Ar_Src.SUMMARY2;
		Ar_Dst.CARD_SEQ				:=	Ar_Src.CARD_SEQ;
		Ar_Dst.CHK_NO				:=	Ar_Src.CHK_NO;
		Ar_Dst.BILL_NO				:=	Ar_Src.BILL_NO;
		Ar_Dst.REC_BILL_NO			:=	Ar_Src.REC_BILL_NO;
		Ar_Dst.CP_NO				:=	Ar_Src.CP_NO;
		Ar_Dst.SECU_NO				:=	Ar_Src.SECU_NO;
		Ar_Dst.LOAN_NO				:=	Ar_Src.LOAN_NO;
		Ar_Dst.LOAN_REFUND_NO		:=	Ar_Src.LOAN_REFUND_NO;
		Ar_Dst.LOAN_REFUND_SEQ		:=	Ar_Src.LOAN_REFUND_SEQ;
		Ar_Dst.DEPOSIT_ACCNO		:=	Ar_Src.DEPOSIT_ACCNO;
		Ar_Dst.PAYMENT_SEQ			:=	Ar_Src.PAYMENT_SEQ;
		Ar_Dst.PAY_CON_CASH			:=	Ar_Src.PAY_CON_CASH;
		Ar_Dst.PAY_CON_BILL			:=	Ar_Src.PAY_CON_BILL;
		Ar_Dst.PAY_CON_BILL_DT		:=	Ar_Src.PAY_CON_BILL_DT;
		Ar_Dst.PAY_CON_BILL_DAYS	:=	Ar_Src.PAY_CON_BILL_DAYS;
		Ar_Dst.EMP_NO				:=	Ar_Src.EMP_NO;
		Ar_Dst.ANTICIPATION_DT		:=	Ar_Src.ANTICIPATION_DT;
		Ar_Dst.MNG_ITEM_CHAR1		:=	Ar_Src.MNG_ITEM_CHAR1;
		Ar_Dst.MNG_ITEM_CHAR2		:=	Ar_Src.MNG_ITEM_CHAR2;
		Ar_Dst.MNG_ITEM_CHAR3		:=	Ar_Src.MNG_ITEM_CHAR3;
		Ar_Dst.MNG_ITEM_CHAR4		:=	Ar_Src.MNG_ITEM_CHAR4;
		Ar_Dst.MNG_ITEM_NUM1		:=	Ar_Src.MNG_ITEM_NUM1;
		Ar_Dst.MNG_ITEM_NUM2		:=	Ar_Src.MNG_ITEM_NUM2;
		Ar_Dst.MNG_ITEM_NUM3		:=	Ar_Src.MNG_ITEM_NUM3;
		Ar_Dst.MNG_ITEM_NUM4		:=	Ar_Src.MNG_ITEM_NUM4;
		Ar_Dst.MNG_ITEM_DT1			:=	Ar_Src.MNG_ITEM_DT1;
		Ar_Dst.MNG_ITEM_DT2			:=	Ar_Src.MNG_ITEM_DT2;
		Ar_Dst.MNG_ITEM_DT3			:=	Ar_Src.MNG_ITEM_DT3;
		Ar_Dst.MNG_ITEM_DT4			:=	Ar_Src.MNG_ITEM_DT4;
		Ar_Dst.FIX_ASSET_SEQ		:=	Ar_Src.FIX_ASSET_SEQ;
	End;
	Function	IsRemainAccCode
	(
		Ar_Acc_Code				Varchar2
	)
	Return Boolean
	Is
		lrAccCode				T_ACC_CODE%RowType;
	Begin
		Select
			*
		Into
			lrAccCode
		From	T_ACC_CODE
		Where	ACC_CODE = Ar_Acc_Code;
		If lrAccCode.ACC_REMAIN_MNG = 'T' Then
			Return True;
		Else
			return False;
		End If;
	Exception When No_Data_Found Then
		Return False;
	End;
End;
/

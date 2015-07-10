--�������� ������ ��ǥ ������ SP
Create Or Replace Procedure SP_T_MAKE_DATA_SALE
(
	Ar_COMP_CODE				Varchar2,
	Ar_WORK_NO					Number,
	Ar_CRTUSERNO				Varchar2
)
Is
	lrRec						T_SET_SALE_SLIP%RowType;
	lrData						T_SET_SALE_SLIP_LIST%RowType;
	lsSaleAccCode				T_ACC_CODE.ACC_CODE%Type;
	lnPreRemainAmt				Number;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_SALE_SLIP
		Where	COMP_CODE = Ar_COMP_CODE
		And		WORK_NO = Ar_WORK_NO;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'������ �ڷḦ ã�� �� �����ϴ�.');
	End;
	If lrRec.WORK_DT Is Null Then
		Raise_Application_Error(-20009,'��������� �Է����� �ʾҽ��ϴ�.');
	End If;
	If lrRec.SLIP_ID Is Not Null Then
		Raise_Application_Error(-20009,'�̹� ��ǥ�� ����� �ڷ��Դϴ�.');
	End If;
	--�۾�����
	--1. ���� �ڷ� ����
	--2. ������ �������� ��ȸ�⺸�� ū ��¥�̸鼭 ������ ������������ ��������� ���常 ���ؿ´�.
	--3. �ش� ���庰�� ���� �ݾ��� �����Ѵ�.
	
	--1. ���� �ڷ� ����
	Delete	T_SET_SALE_SLIP_LIST
	Where	COMP_CODE = Ar_COMP_CODE
	And		WORK_NO = Ar_WORK_NO;
	--2. ������ �������� ��ȸ�⺸�� ū ��¥�̸鼭 ������ ������������ ��������� ���常 ���ؿ´�.
	For lrA In
	(
		Select
			a.DEPT_CODE,
			a.CONS_AMT,
			a.BUDG_AMT,
			a.F_CONS_AMT,
			a.F_BUDG_AMT,
			a.AS_AMT,
			F_SUM_PRE_RESULT_AMT(a.DEPT_CODE,To_Char(lrRec.WORK_DT,'YYYYMM')) PR_COST_AMT
		From	T_DEPT_CODE a
		Where	a.DEPT_PROJ_TAG = 'P'
		And		a.ACC_CLOST_DT_SYS >= Trunc(lrRec.WORK_DT,'YYYY')
		And		a.COST_DESC_TAG = '1'
	)
	Loop
		lrData.COMP_CODE := Ar_COMP_CODE;
		lrData.WORK_NO := Ar_WORK_NO;
		lrData.DEPT_CODE := lrA.DEPT_CODE;
		lrData.CONS_AMT := lrA.CONS_AMT;
		lrData.BUDG_AMT := lrA.BUDG_AMT;
		lrData.F_CONS_AMT := lrA.F_CONS_AMT;
		lrData.F_BUDG_AMT := lrA.F_BUDG_AMT;
		lrData.AS_AMT := lrA.AS_AMT;
		lrData.PR_COST_AMT := lrA.PR_COST_AMT;
		--3. �ش� ���庰�� ���� �ݾ��� �����Ѵ�.
		--�������� ����
		Begin
			Select
				Nvl(a.PY_DB_AMT,0) PY_COST_SUM,
				Nvl(a.DB_SUM,0) - Nvl(a.PM_DB_AMT,0) NM_COST_AMT,
				Nvl(a.DB_SUM,0) - Nvl(a.PY_DB_AMT,0) NY_COST_SUM,
				Nvl(a.DB_SUM,0) COST_SUM
			Into
				lrData.PY_COST_SUM,
				lrData.NM_COST_AMT,
				lrData.NY_COST_SUM,
				lrData.COST_SUM
			From
				(
					Select
						Sum(Case When a.CONF_YMD < To_Char(Trunc(lrRec.WORK_DT,'YYYY'),'YYYYMMDD') Then
							a.DR_SUM
						Else
							0
						End) PY_DB_AMT,
						Sum(Case When a.CONF_YMD < To_Char(Trunc(lrRec.WORK_DT,'MM'),'YYYYMMDD') Then
							a.DR_SUM
						Else
							0
						End) PM_DB_AMT,
						Sum(a.DR_SUM) DB_SUM
					From	T_ACC_TRANS_DAILY_SUM a
					Where	a.DEPT_CODE = lrA.DEPT_CODE
					And		a.ACC_CODE = '400000000'
					And		a.CONF_YMD <= To_Char(Last_Day(lrRec.WORK_DT),'YYYYMMDD')
				) a;
		Exception When No_Data_Found Then
			lrData.PY_COST_SUM := 0;
			lrData.NM_COST_AMT := 0;
			lrData.NY_COST_SUM := 0;
			lrData.COST_SUM := 0;
		End;

		Begin
			Select
				b.SALE_ACC_CODE
			Into
				lsSaleAccCode
			From	T_DEPT_CODE_ORG a,
					T_SET_COST_CONV_CODE b
			Where	a.COST_CONV_CODE = b.COST_CONV_CODE
			And		a.DEPT_CODE = lrA.DEPT_CODE;
		Exception When No_Data_Found Then
			Raise_Application_Error(-20009,'�ش������� ����� ���� �Ǵ� ������ü���������� �������� �ʾҽ��ϴ�.'||lrA.DEPT_CODE||F_T_Get_Dept_Name(lrA.DEPT_CODE));
		End;
		If lsSaleAccCode Is Null Then
			Raise_Application_Error(-20009,'�ش������� ����� ���� �Ǵ� ������ü���������� �������� �ʾҽ��ϴ�.'||lrA.DEPT_CODE||F_T_Get_Dept_Name(lrA.DEPT_CODE));
		End If;
		--�����������
		Begin
			Select
				Nvl(a.PY_CR_AMT,0) - Nvl(a.PY_DB_AMT,0) PY_SALE_SUM,
				Nvl(a.PM_CR_AMT,0) - Nvl(a.PM_DB_AMT,0) - Nvl(a.PY_CR_AMT,0) + Nvl(a.PY_DB_AMT,0) NYPM_SALE_SUM,
				Nvl(a.CR_SUM,0) - Nvl(a.DB_SUM,0) - Nvl(a.PM_CR_AMT,0) + Nvl(a.PM_DB_AMT,0) NM_SALE_P_AMT
			Into
				lrData.PY_SALE_SUM,
				lrData.NYPM_SALE_SUM,
				lrData.NM_SALE_P_AMT
			From
				(
					Select
						Sum(Case When a.MAKE_DT < Trunc(lrRec.WORK_DT,'YYYY') Then
							a.CR_AMT
						Else
							0
						End) PY_CR_AMT,
						Sum(Case When a.MAKE_DT < Trunc(lrRec.WORK_DT,'YYYY') Then
							a.DB_AMT
						Else
							0
						End) PY_DB_AMT,
						Sum(Case When a.MAKE_DT < Trunc(lrRec.WORK_DT,'MM') Then
							a.CR_AMT
						Else
							0
						End) PM_CR_AMT,
						Sum(Case When a.MAKE_DT < Trunc(lrRec.WORK_DT,'MM') Then
							a.DB_AMT
						Else
							0
						End) PM_DB_AMT,
						Sum(a.CR_AMT) CR_SUM,
						Sum(a.DB_AMT) DB_SUM
					From	T_ACC_SLIP_BODY1 a
					Where	a.DEPT_CODE = lrA.DEPT_CODE
					And		a.MAKE_DT <= Last_Day(lrRec.WORK_DT)
					And		a.TRANSFER_TAG = 'F'
					And		a.KEEP_DT Is Not Null
					And		a.ACC_CODE = lsSaleAccCode
				) a;
		Exception When No_Data_Found Then
			lrData.PY_SALE_SUM := 0;
			lrData.NYPM_SALE_SUM := 0;
			lrData.NM_SALE_P_AMT := 0;
		End;
		--��� ���ݰ�꼭 �����
		Begin
			Select
				Nvl(Sum(a.DB_AMT),0)
			Into
				lrData.NM_REQ_SALE_AMT
			From	T_ACC_SLIP_BODY1 a
			Where	a.DEPT_CODE = lrA.DEPT_CODE
			And		a.MAKE_DT Between Trunc(lrRec.WORK_DT,'MM') And Last_Day(lrRec.WORK_DT)
			And		a.TRANSFER_TAG = 'F'
			And		a.KEEP_DT Is Not Null
			And		a.ACC_CODE In (
				select
					a.CODE_LIST_ID
				from	v_t_code_list a
				where	a.CODE_GROUP_ID = 'NP_ACC_CODE'
			);
		Exception When No_Data_Found Then
			lrData.NM_REQ_SALE_AMT := 0;
		End;
		--��������� ����
		--���� ����� := ���ޱݾ� * ������
		lrData.SALE_SUM := Trunc(Nvl(lrData.CONS_AMT,0) * Nvl(lrData.COST_SUM,0) / nullif(Nvl(lrData.BUDG_AMT,0) + Nvl(lrData.AS_AMT,0),0));
		--���� ��� ������ 0�̸� ��� ������ 0�̵ȴ�.
		--�� ������� ���޾� �ʰ��� �� ������ ������ �ȴ�.
		If Nvl(lrData.SALE_SUM,0) > Nvl(lrData.CONS_AMT,0) Or Nvl(lrData.NM_COST_AMT,0) <> 0 Then
			lrData.NM_SALE_AMT := Nvl(lrData.SALE_SUM,0) - (Nvl(lrData.PY_SALE_SUM,0) + Nvl(lrData.NYPM_SALE_SUM,0));
		Else
			lrData.NM_SALE_AMT := 0;
		End If;
		--��� ����
		lrData.NY_SALE_AMT := Nvl(lrData.NM_SALE_AMT,0) + Nvl(lrData.NYPM_SALE_SUM,0);
		lrData.SALE_SUM := Nvl(lrData.PY_SALE_SUM,0) + Nvl(lrData.NYPM_SALE_SUM,0) + Nvl(lrData.NM_SALE_AMT,0);
		--�������� ���
		lrData.PR_SALE_SUM := Trunc(Nvl(lrData.CONS_AMT,0) * Nvl(lrData.COST_SUM,0) / nullif(Nvl(lrData.PR_COST_AMT,0) + Nvl(lrData.AS_AMT,0),0));
		--����̼��� ��꼭 �ܾ�
		Begin
			Select
				Nvl(Sum(a.DB_AMT),0) - Nvl(Sum(a.CR_AMT),0)
			Into
				lrData.NP_REMAIN_AMT
			From	T_ACC_SLIP_BODY1 a
			Where	a.DEPT_CODE = lrA.DEPT_CODE
			And		a.MAKE_DT <= Last_Day(lrRec.WORK_DT)
			And		a.TRANSFER_TAG = 'F'
			And		a.KEEP_DT Is Not Null
			And		a.ACC_CODE In (
				select
					a.CODE_LIST_ID
				from	v_t_code_list a
				where	a.CODE_GROUP_ID = 'NP_ACC_CODE'
			);
		Exception When No_Data_Found Then
			lrData.NP_REMAIN_AMT := 0;
		End;
		--����̼��� ������ �ܾ�
		Begin
			Select
				Nvl(Sum(a.DB_AMT),0) - Nvl(Sum(a.CR_AMT),0)
			Into
				lrData.NP_R_REMAIN_AMT
			From	T_ACC_SLIP_BODY1 a
			Where	a.DEPT_CODE = lrA.DEPT_CODE
			And		a.MAKE_DT < Trunc(lrRec.WORK_DT,'MM')
			And		a.TRANSFER_TAG = 'F'
			And		a.KEEP_DT Is Not Null
			And		a.ACC_CODE In (
				select
					a.CODE_LIST_ID
				from	v_t_code_list a
				where	a.CODE_GROUP_ID = 'NPR_ACC_CODE'
			);
		Exception When No_Data_Found Then
			lrData.NP_R_REMAIN_AMT := 0;
		End;
		--���缱���� ��꼭 �ܾ�
		Begin
			Select
				Nvl(Sum(a.CR_AMT),0) - Nvl(Sum(a.DB_AMT),0)
			Into
				lrData.PP_REMAIN_AMT
			From	T_ACC_SLIP_BODY1 a
			Where	a.DEPT_CODE = lrA.DEPT_CODE
			And		a.MAKE_DT <= Last_Day(lrRec.WORK_DT)
			And		a.TRANSFER_TAG = 'F'
			And		a.KEEP_DT Is Not Null
			And		a.ACC_CODE In (
				select
					a.CODE_LIST_ID
				from	v_t_code_list a
				where	a.CODE_GROUP_ID = 'PP_ACC_CODE'
			);
		Exception When No_Data_Found Then
			lrData.PP_REMAIN_AMT := 0;
		End;
		--���缱���� ������ �ܾ�
		Begin
			Select
				Nvl(Sum(a.CR_AMT),0) - Nvl(Sum(a.DB_AMT),0)
			Into
				lrData.PP_R_REMAIN_AMT
			From	T_ACC_SLIP_BODY1 a
			Where	a.DEPT_CODE = lrA.DEPT_CODE
			And		a.MAKE_DT < Trunc(lrRec.WORK_DT,'MM')
			And		a.TRANSFER_TAG = 'F'
			And		a.KEEP_DT Is Not Null
			And		a.ACC_CODE In (
				select
					a.CODE_LIST_ID
				from	v_t_code_list a
				where	a.CODE_GROUP_ID = 'PPR_ACC_CODE'
			);
		Exception When No_Data_Found Then
			lrData.PP_R_REMAIN_AMT := 0;
		End;
		--���� �̼��ܾ� - �����ܾ��� ���Ѵ�.
		lnPreRemainAmt := Nvl(lrData.NP_REMAIN_AMT,0) + Nvl(lrData.NP_R_REMAIN_AMT,0) - Nvl(lrData.PP_R_REMAIN_AMT,0);
		--���� �̼��ܾ� - �����ܾ׿��� ��� ����� �������� ���Ѵ�.
		lnPreRemainAmt := lnPreRemainAmt + Nvl(lrData.NM_SALE_AMT,0) - Nvl(lrData.NM_SALE_P_AMT,0);
		If lnPreRemainAmt > 0 Then	--���� �ݾ��� 0���� ũ�ٸ� �̼��߻��̴�.
			lrData.NP_AMT := lnPreRemainAmt;
		Else
			lrData.PP_AMT := Abs(lnPreRemainAmt);
		End If;
		Insert Into T_SET_SALE_SLIP_LIST Values lrData;
	End Loop;
End;
/

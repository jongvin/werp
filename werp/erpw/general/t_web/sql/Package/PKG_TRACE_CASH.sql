Create Or Replace Package PKG_TRACE_CASH
Is
	--Ư�� �Ⱓ�� ���� ��ǥ�� �������Ѵ�.
	Procedure	TraceCashSlip
	(
		Ar_From_Dt				Date,
		Ar_To_Dt				Date
	);
	--Ư���Ⱓ�� Ư�� ������� ������ǥ�� �������Ѵ�.
	Procedure	TraceCashSlip_Company
	(
		Ar_From_Dt				Date,
		Ar_To_Dt				Date,
		Ar_Comp_Code			T_COMPANY.COMP_CODE%Type
	);
	--Ư���Ⱓ�� Ư�� ������� Ư�� �ͼ� �μ��� ������ǥ�� �������Ѵ�.
	Procedure	TraceCashSlip_Dept
	(
		Ar_From_Dt				Date,
		Ar_To_Dt				Date,
		Ar_Comp_Code			T_COMPANY.COMP_CODE%Type,
		Ar_Dept_Code			T_DEPT_CODE.DEPT_CODE%Type
	);
	--Ư�� ��ǥ�� �ҼӵǾ� �ִ� ���� ��ǥ�� ���� �����Ѵ�
	Procedure	TraceCashSlip_Head
	(
		Ar_Slip_Id				T_ACC_SLIP_BODY.SLIP_ID%Type
	);
	--Ư�� ��ǥ Ư�� �¼��� ���� ��ǥ�̸� �̸� �������Ѵ�.
	Procedure	TraceCashSlip_Body
	(
		Ar_Slip_Id				T_ACC_SLIP_BODY.SLIP_ID%Type,
		Ar_Slip_IdSeq			T_ACC_SLIP_BODY.SLIP_IDSEQ%Type
	);
End;
/
Create Or Replace Package Body PKG_TRACE_CASH
Is
	G_CASH_SLIP_ID				T_FL_TRACE_CASH_SLIP.CASH_SLIP_ID%Type;
	G_CASH_SLIP_IDSEQ			T_FL_TRACE_CASH_SLIP.CASH_SLIP_IDSEQ%Type;
	G_CASH_DT					Date;
	Type	T_Nums Is Table Of Number
		Index By Binary_Integer;
	Type	T_Acc_Codes Is Table Of T_FL_TRACE_CASH_SLIP.ACC_CODE%Type
		Index By Binary_Integer;
	Type	T_Comp_Codes Is Table Of T_FL_TRACE_CASH_SLIP.COMP_CODE%Type
		Index By Binary_Integer;
	Type	T_Dept_Codes Is Table Of T_FL_TRACE_CASH_SLIP.DEPT_CODE%Type
		Index By Binary_Integer;
	Type	T_Dates Is Table Of Date
		Index By Binary_Integer;
	Procedure	InsertData
	(
		Ar_Trace_Slip_Id		T_FL_TRACE_CASH_SLIP.TRACE_SLIP_ID%Type,
		Ar_Trace_Slip_IdSeq		T_FL_TRACE_CASH_SLIP.TRACE_SLIP_IDSEQ%Type,
		Ar_Comp_Code			T_FL_TRACE_CASH_SLIP.COMP_CODE%Type,
		Ar_Dept_Code			T_FL_TRACE_CASH_SLIP.DEPT_CODE%Type,
		Ar_Acc_Code				T_FL_TRACE_CASH_SLIP.ACC_CODE%Type,
		Ar_DB_Amt				T_FL_TRACE_CASH_SLIP.DB_AMT%Type,
		Ar_CR_Amt				T_FL_TRACE_CASH_SLIP.CR_AMT%Type,
		Ar_Result_Tag			T_FL_TRACE_CASH_SLIP.RESULT_TAG%Type,
		Ar_Make_Dt				Date
	)
	Is
	Begin
		Insert Into T_FL_TRACE_CASH_SLIP
		(
			CASH_SLIP_ID,
			CASH_SLIP_IDSEQ,
			TRACE_SLIP_ID,
			TRACE_SLIP_IDSEQ,
			TRACE_NO,
			COMP_CODE,
			DEPT_CODE,
			ACC_CODE,
			DB_AMT,
			CR_AMT,
			RESULT_TAG,
			MAKE_DT,
			CASH_DT
		)
		Values
		(
			G_CASH_SLIP_ID,
			G_CASH_SLIP_IDSEQ,
			Ar_Trace_Slip_Id,
			Ar_Trace_Slip_IdSeq,
			SQ_T_TRACE_NO.NextVal,
			Ar_Comp_Code,
			Ar_Dept_Code,
			Ar_Acc_Code,
			Ar_DB_Amt,
			Ar_CR_Amt,
			Ar_Result_Tag,
			Ar_Make_Dt,
			G_CASH_DT
		);
	End;
	--�����ǥ�� �������Ѵ�.
	Procedure	TraceFacingSlip
	(
		Ar_Slip_Id				T_ACC_SLIP_BODY.SLIP_ID%Type,
		Ar_Slip_IdSeq			T_ACC_SLIP_BODY.SLIP_IDSEQ%Type,
		Ar_Amt					Number
	)
	Is
		lt_SLIP_ID				T_Nums;
		lt_SLIP_IDSEQ			T_Nums;
		lt_RESET_SLIP_IDSEQ1	T_Nums;
		lt_RESET_AMT			T_Nums;
		lt_BF_AMT				T_Nums;
		lt_REMAIN_AMT			T_Nums;
		lt_DB_AMT				T_Nums;
		lt_CR_AMT				T_Nums;
		lt_RESET_SLIP_ID		T_Nums;
		lt_RESET_SLIP_IDSEQ2	T_Nums;
		lt_COMP_CODE			T_Comp_Codes;
		lt_DEPT_CODE			T_Dept_Codes;
		lt_ACC_CODE				T_Acc_Codes;
		lt_MAKE_DT				T_Dates;
		liFirst					Number;
		liLast					Number;
		lnSubstAmt				Number;
		lnRemainAmt				Number := Nvl(Ar_Amt,0);
		liSign					Number := Sign(Nvl(Ar_Amt,0));
	Begin
		--1. �ش� ��ǥ�� �����ǥ�� ��ȸ�Ѵ�.
		--2. �ش� ��ǥ�� �����ǥ �� �̹� �ݾ��� �ٸ� ������ǥ�� ���� �ݾ��� �����Ǿ� �ִ� ��ǥ�� �� �ݾ� ��ŭ�� ���ϰ� �����Ѵ�.
		--3. �־��� ���� ���ݾ��� �����Ǹ� 2�� ������ �ߴ��Ѵ�.
		--4. ���� 2�� ������ ���� �� �ش� ��ǥ�� ���� ��ǥ�̸� �������� ���� �������� �����Ѵ�.
		If lnRemainAmt = 0 Then
			Return;
		End If;
		Begin
			Select
				a.SLIP_ID ,
				a.SLIP_IDSEQ ,
				a.RESET_SLIP_IDSEQ1 ,
				a.RESET_AMT,
				a.BF_AMT,
				Nvl(a.RESET_AMT,0) - Nvl(a.BF_AMT,0) REMAIN_AMT,
				a.DB_AMT,
				a.CR_AMT,
				a.RESET_SLIP_ID,
				a.RESET_SLIP_IDSEQ2,
				a.COMP_CODE,
				a.DEPT_CODE,
				a.ACC_CODE,
				a.MAKE_DT
			Bulk Collect Into
				lt_SLIP_ID,
				lt_SLIP_IDSEQ,
				lt_RESET_SLIP_IDSEQ1,
				lt_RESET_AMT,
				lt_BF_AMT,
				lt_REMAIN_AMT,
				lt_DB_AMT,
				lt_CR_AMT,
				lt_RESET_SLIP_ID,
				lt_RESET_SLIP_IDSEQ2,
				lt_COMP_CODE,
				lt_DEPT_CODE,
				lt_ACC_CODE,
				lt_MAKE_DT
			From
				(
					Select
						a.SLIP_ID ,
						a.SLIP_IDSEQ ,
						a.RESET_SLIP_IDSEQ RESET_SLIP_IDSEQ1,
						a.RESET_AMT,
						b.DB_AMT,
						b.CR_AMT,
						b.RESET_SLIP_ID,
						b.RESET_SLIP_IDSEQ RESET_SLIP_IDSEQ2,
						b.ACC_CODE,
						b.COMP_CODE,
						b.DEPT_CODE,
						b.MAKE_DT,
						(
							Select
								Nvl(Sum(Abs(c.DB_AMT)),0) +
								Nvl(Sum(Abs(c.CR_AMT)),0)
							From	T_FL_TRACE_CASH_SLIP c
							Where	a.SLIP_ID = c.TRACE_SLIP_ID
							And		a.RESET_SLIP_IDSEQ = c.TRACE_SLIP_IDSEQ
						) BF_AMT
					From	T_ACC_SLIP_REMAIN_KEEP a,
							T_ACC_SLIP_BODY1 b
					Where	a.SLIP_ID = Ar_Slip_Id
					And		a.SLIP_IDSEQ = Ar_Slip_IdSeq
					And		a.SLIP_ID = b.SLIP_ID
					And		a.RESET_SLIP_IDSEQ = b.SLIP_IDSEQ
					Order By
						b.MAKE_SLIPLINE
				) a
			Where	Nvl(a.RESET_AMT,0) > Nvl(a.BF_AMT,0);	--�ܾ��� �����͸�...
		Exception When No_Data_Found Then
			Null;
		End;
		If lt_SLIP_ID.Count <= 0 Then
			Return;
		End If;
		liFirst := lt_SLIP_ID.First;
		liLast := lt_SLIP_ID.Last;
		For liI In liFirst..liLast Loop
			Exit When Sign(lnRemainAmt) = 0 Or Sign(lnRemainAmt) <> liSign;		--�ܾ��� ��ȣ�� �ٲ���ų� �ݾ��� 0�̸� ����
			If Abs(lnRemainAmt) > lt_REMAIN_AMT(liI) Then
				lnSubstAmt := lt_REMAIN_AMT(liI);
				lnRemainAmt := Abs(lnRemainAmt) - lnSubstAmt;
			Else
				lnSubstAmt := Abs(lnRemainAmt);
				lnRemainAmt := 0;
			End If;
			If lt_RESET_SLIP_ID(liI) Is Not Null And lt_RESET_SLIP_IDSEQ2(liI) Is Not Null And lt_RESET_SLIP_IDSEQ2(liI) <> lt_RESET_SLIP_IDSEQ1(liI) Then	--���� �� ��ǥ�� ������ǥ���
				InsertData(lt_SLIP_ID(liI),lt_RESET_SLIP_IDSEQ1(liI),lt_COMP_CODE(liI),lt_DEPT_CODE(liI),lt_ACC_CODE(liI),Sign(lt_DB_AMT(liI)) * lnSubstAmt,Sign(lt_CR_AMT(liI)) * lnSubstAmt,'F',lt_MAKE_DT(liI));
				TraceFacingSlip(lt_RESET_SLIP_ID(liI),lt_RESET_SLIP_IDSEQ2(liI),lnSubstAmt);
			Else
				InsertData(lt_SLIP_ID(liI),lt_RESET_SLIP_IDSEQ1(liI),lt_COMP_CODE(liI),lt_DEPT_CODE(liI),lt_ACC_CODE(liI),Sign(lt_DB_AMT(liI)) * lnSubstAmt,Sign(lt_CR_AMT(liI)) * lnSubstAmt,'T',lt_MAKE_DT(liI));
			End If;
		End Loop;
	End;

	--Ư�� �Ⱓ�� ���� ��ǥ�� �������Ѵ�.
	Procedure	TraceCashSlip
	(
		Ar_From_Dt				Date,
		Ar_To_Dt				Date
	)
	Is
	Begin
		Delete	T_FL_TRACE_CASH_SLIP a
		Where	a.MAKE_DT Between Ar_From_Dt And Ar_To_Dt;
		For lrA In (
						Select
							a.SLIP_ID ,
							a.SLIP_IDSEQ,
							a.DB_AMT ,
							a.CR_AMT ,
							a.MAKE_DT,
							a.KEEP_DT,
							a.TRANSFER_TAG,
							Nvl(a.DB_AMT,0) + Nvl(a.CR_AMT,0) AMT
						From	T_ACC_SLIP_BODY1 a
						Where	a.MAKE_DT Between Ar_From_Dt And Ar_To_Dt
						And		a.ACC_CODE In
								(
									Select
										b.ACC_CODE
									From	T_FL_CASH_ACC_CODE b
								)
						And		a.KEEP_DT Is Not Null
						Order By
							a.MAKE_DT,
							a.SLIP_ID,
							a.MAKE_SLIPLINE
					)
		Loop
			If lrA.KEEP_DT Is Not Null And lrA.TRANSFER_TAG = 'F' Then		--Ȯ���Ǿ��� �̿���ǥ�� �ƴ϶��
				G_CASH_SLIP_ID := lrA.SLIP_ID;
				G_CASH_SLIP_IDSEQ := lrA.SLIP_IDSEQ;
				G_CASH_DT := lrA.MAKE_DT;
				TraceFacingSlip(G_CASH_SLIP_ID,G_CASH_SLIP_IDSEQ,lrA.AMT);
			End If;
		End Loop;
	End;
	--Ư���Ⱓ�� Ư�� ������� ������ǥ�� �������Ѵ�.
	Procedure	TraceCashSlip_Company
	(
		Ar_From_Dt				Date,
		Ar_To_Dt				Date,
		Ar_Comp_Code			T_COMPANY.COMP_CODE%Type
	)
	Is
	Begin
		Delete	T_FL_TRACE_CASH_SLIP a
		Where	a.MAKE_DT Between Ar_From_Dt And Ar_To_Dt
		And		a.COMP_CODE = Ar_Comp_Code;
		For lrA In (
						Select
							a.SLIP_ID ,
							a.SLIP_IDSEQ,
							a.DB_AMT ,
							a.CR_AMT ,
							a.MAKE_DT,
							a.KEEP_DT,
							a.TRANSFER_TAG,
							Nvl(a.DB_AMT,0) + Nvl(a.CR_AMT,0) AMT
						From	T_ACC_SLIP_BODY1 a
						Where	a.MAKE_DT Between Ar_From_Dt And Ar_To_Dt
						And		a.COMP_CODE = Ar_Comp_Code
						And		a.ACC_CODE In
								(
									Select
										b.ACC_CODE
									From	T_FL_CASH_ACC_CODE b
								)
						And		a.KEEP_DT Is Not Null
						Order By
							a.MAKE_DT,
							a.SLIP_ID,
							a.MAKE_SLIPLINE
					)
		Loop
			If lrA.KEEP_DT Is Not Null And lrA.TRANSFER_TAG = 'F' Then		--Ȯ���Ǿ��� �̿���ǥ�� �ƴ϶��
				G_CASH_SLIP_ID := lrA.SLIP_ID;
				G_CASH_SLIP_IDSEQ := lrA.SLIP_IDSEQ;
				G_CASH_DT := lrA.MAKE_DT;
				TraceFacingSlip(G_CASH_SLIP_ID,G_CASH_SLIP_IDSEQ,lrA.AMT);
			End If;
		End Loop;
	End;
	--Ư���Ⱓ�� Ư�� ������� Ư�� �ͼ� �μ��� ������ǥ�� �������Ѵ�.
	Procedure	TraceCashSlip_Dept
	(
		Ar_From_Dt				Date,
		Ar_To_Dt				Date,
		Ar_Comp_Code			T_COMPANY.COMP_CODE%Type,
		Ar_Dept_Code			T_DEPT_CODE.DEPT_CODE%Type
	)
	Is
	Begin
		Delete	T_FL_TRACE_CASH_SLIP a
		Where	a.MAKE_DT Between Ar_From_Dt And Ar_To_Dt
		And		a.COMP_CODE = Ar_Comp_Code
		And		a.DEPT_CODE = Ar_Dept_Code;
		For lrA In (
						Select
							a.SLIP_ID ,
							a.SLIP_IDSEQ,
							a.DB_AMT ,
							a.CR_AMT ,
							a.MAKE_DT,
							a.KEEP_DT,
							a.TRANSFER_TAG,
							Nvl(a.DB_AMT,0) + Nvl(a.CR_AMT,0) AMT
						From	T_ACC_SLIP_BODY1 a
						Where	a.MAKE_DT Between Ar_From_Dt And Ar_To_Dt
						And		a.COMP_CODE = Ar_Comp_Code
						And		a.DEPT_CODE = Ar_Dept_Code
						And		a.ACC_CODE In
								(
									Select
										b.ACC_CODE
									From	T_FL_CASH_ACC_CODE b
								)
						And		a.KEEP_DT Is Not Null
						Order By
							a.MAKE_DT,
							a.SLIP_ID,
							a.MAKE_SLIPLINE
					)
		Loop
			If lrA.KEEP_DT Is Not Null And lrA.TRANSFER_TAG = 'F' Then		--Ȯ���Ǿ��� �̿���ǥ�� �ƴ϶��
				G_CASH_SLIP_ID := lrA.SLIP_ID;
				G_CASH_SLIP_IDSEQ := lrA.SLIP_IDSEQ;
				G_CASH_DT := lrA.MAKE_DT;
				TraceFacingSlip(G_CASH_SLIP_ID,G_CASH_SLIP_IDSEQ,lrA.AMT);
			End If;
		End Loop;
	End;
	--Ư�� ��ǥ�� �ҼӵǾ� �ִ� ���� ��ǥ�� ���� �����Ѵ�
	Procedure	TraceCashSlip_Head
	(
		Ar_Slip_Id				T_ACC_SLIP_BODY.SLIP_ID%Type
	)
	Is
	Begin
		Delete	T_FL_TRACE_CASH_SLIP a
		Where	a.CASH_SLIP_ID = Ar_Slip_Id;
		For lrA In (
						Select
							a.SLIP_ID ,
							a.SLIP_IDSEQ,
							a.DB_AMT ,
							a.CR_AMT ,
							a.MAKE_DT,
							a.KEEP_DT,
							a.TRANSFER_TAG,
							Nvl(a.DB_AMT,0) + Nvl(a.CR_AMT,0) AMT
						From	T_ACC_SLIP_BODY1 a
						Where	a.SLIP_ID = Ar_Slip_Id
						And		a.ACC_CODE In
								(
									Select
										b.ACC_CODE
									From	T_FL_CASH_ACC_CODE b
								)
						And		a.KEEP_DT Is Not Null
						Order By
							a.MAKE_DT,
							a.SLIP_ID,
							a.MAKE_SLIPLINE
					)
		Loop
			If lrA.KEEP_DT Is Not Null And lrA.TRANSFER_TAG = 'F' Then		--Ȯ���Ǿ��� �̿���ǥ�� �ƴ϶��
				G_CASH_SLIP_ID := lrA.SLIP_ID;
				G_CASH_SLIP_IDSEQ := lrA.SLIP_IDSEQ;
				G_CASH_DT := lrA.MAKE_DT;
				TraceFacingSlip(G_CASH_SLIP_ID,G_CASH_SLIP_IDSEQ,lrA.AMT);
			End If;
		End Loop;
	End;
	--Ư�� ��ǥ Ư�� �¼��� ���� ��ǥ�̸� �̸� �������Ѵ�.
	Procedure	TraceCashSlip_Body
	(
		Ar_Slip_Id				T_ACC_SLIP_BODY.SLIP_ID%Type,
		Ar_Slip_IdSeq			T_ACC_SLIP_BODY.SLIP_IDSEQ%Type
	)
	Is
	Begin
		Delete	T_FL_TRACE_CASH_SLIP a
		Where	a.CASH_SLIP_ID = Ar_Slip_Id
		And		a.CASH_SLIP_IDSEQ = Ar_Slip_IdSeq;
		For lrA In (
						Select
							a.SLIP_ID ,
							a.SLIP_IDSEQ,
							a.DB_AMT ,
							a.CR_AMT ,
							a.MAKE_DT,
							Nvl(a.DB_AMT,0) + Nvl(a.CR_AMT,0) AMT
						From	T_ACC_SLIP_BODY1 a
						Where	a.SLIP_ID = Ar_Slip_Id
						And		a.SLIP_IDSEQ = Ar_Slip_IdSeq
						And		a.ACC_CODE In
								(
									Select
										b.ACC_CODE
									From	T_FL_CASH_ACC_CODE b
								)
						And		a.KEEP_DT Is Not Null
					)
		Loop
			G_CASH_SLIP_ID := lrA.SLIP_ID;
			G_CASH_SLIP_IDSEQ := lrA.SLIP_IDSEQ;
			G_CASH_DT := lrA.MAKE_DT;
			TraceFacingSlip(G_CASH_SLIP_ID,G_CASH_SLIP_IDSEQ,lrA.AMT);
		End Loop;
	End;
End;
/

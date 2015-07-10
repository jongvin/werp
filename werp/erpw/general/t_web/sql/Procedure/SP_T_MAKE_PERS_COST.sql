Create Or Replace Procedure SP_T_MAKE_PERS_COST
(
	Ar_Comp_Code				Varchar2,
	Ar_Dept_Code				Varchar2,
	Ar_Work_Dt					Varchar2,
	Ar_Work_No					Number,
	Ar_CrtUserNo				Varchar2
)
Is
	lddt_Work_Dt				Date;
	ln_Seq					Number;
Begin
	lddt_Work_Dt := F_T_STRINGTODATE(Ar_Work_Dt);
	--먼저 조건에 만족하지 않는 자료를 삭제한다.
	Delete	T_FIN_PERSON_COST_LIST a
	Where	COMP_CODE = Ar_Comp_Code
	And		WORK_NO = Ar_Work_No
	And		Not Exists
	(
		Select
			Null
		From	T_ACC_SLIP_BODY1 b
		Where	a.TARGET_SLIP_ID = b.SLIP_ID
		And		a.TARGET_SLIP_IDSEQ = b.SLIP_IDSEQ
		And		b.KEEP_DT Is Not Null
		And		b.TRANSFER_TAG <> 'T'
		And		b.MAKE_DEPT_CODE = b.DEPT_CODE
		And		b.ACC_CODE In
				(
					Select
						x.CODE_LIST_ID
					From	V_T_CODE_LIST x
					Where	x.CODE_GROUP_ID = 'COST_SAVING_ACC'
				)
		And		Nvl(b.CR_AMT,0) <> 0
		And		b.MAKE_DT = lddt_Work_Dt
		And		b.COMP_CODE = Ar_Comp_Code
	);
	For lrA In
			(
				Select
					a.SLIP_ID ,
					a.SLIP_IDSEQ,
					a.CR_AMT,
					a.CUST_SEQ,
					a.CUST_NAME,
					a.EMP_NO,
					b.IN_BANK_MAIN_CODE_2,
					b.IN_ACC_NO_2,
					c.NAME
				From	T_ACC_SLIP_BODY a,
						T_FIN_EMP_IN_ACC_NO b,
						Z_AUTHORITY_USER c
				Where	a.ACC_CODE In
				(
					Select
						x.CODE_LIST_ID
					From	V_T_CODE_LIST x
					Where	x.CODE_GROUP_ID = 'COST_SAVING_ACC'
				)
				And		a.MAKE_DEPT_CODE = a.DEPT_CODE
				And		Nvl(a.CR_AMT,0) <> 0
				And		a.MAKE_DT = lddt_Work_Dt
				And		a.TRANSFER_TAG <> 'T'
				And		a.KEEP_DT Is Not Null
				And		a.EMP_NO = b.ERMP_NO (+)
				And		b.ERMP_NO = c.EMPNO (+)
				And		a.COMP_CODE = Ar_Comp_Code
				And		Not Exists
				(
					Select
						Null
					From	T_FIN_PERSON_COST_LIST y
					Where	y.TARGET_SLIP_ID = a.SLIP_ID
					And		y.TARGET_SLIP_IDSEQ = a.SLIP_IDSEQ
				)
				Order By
					a.SLIP_ID,
					a.MAKE_SLIPLINE
			)
	Loop
		Select
			SQ_T_PERSON_COST_SEQ.NextVal
		Into
			ln_Seq
		From	Dual;
		Insert Into T_FIN_PERSON_COST_LIST
		(
			COMP_CODE,
			WORK_NO,
			SEQ,
			CRTUSERNO,
			CRTDATE,
			TARGET_SLIP_ID,
			TARGET_SLIP_IDSEQ,
			EXEC_AMT,
			ERMP_NO,
			CUST_SEQ,
			CUST_NAME,
			IN_BANK_MAIN_CODE,
			IN_ACC_NO,
			IN_TARGET_TAG,
			IN_ACC_NO_OWNER
		)
		Values
		(
			Ar_Comp_Code,
			Ar_Work_No,
			ln_Seq,
			Ar_CrtUserNo,
			SysDate,
			lrA.SLIP_ID,
			lrA.SLIP_IDSEQ,
			lrA.CR_AMT,
			lrA.EMP_NO,
			lrA.CUST_SEQ,
			lrA.CUST_NAME,
			lrA.IN_BANK_MAIN_CODE_2,
			lrA.IN_ACC_NO_2,
			'2',			--사원
			lrA.NAME
		);
	End Loop;
End;
/

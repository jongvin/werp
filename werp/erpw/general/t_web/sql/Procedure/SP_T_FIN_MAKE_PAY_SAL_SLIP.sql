Create Or Replace Procedure SP_T_MAKE_PAY_SAL
(
	AR_COMP_CODE				VARCHAR2,
	AR_WORK_SEQ					NUMBER,
	AR_CRTUSERNO				VARCHAR2
)
Is
	lrRec						T_FIN_PAY_SAL%RowType;
	lsCompCode					T_COMPANY.COMP_CODE%Type;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_FIN_PAY_SAL
		Where	COMP_CODE = AR_COMP_CODE
		And		WORK_SEQ = AR_WORK_SEQ;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'관련 급여작업 정보가 없습니다.');
	End;
	--먼저 해당 일의 작업 내용을 삭제 합니다.
	Delete	T_FIN_PAY_SAL_LIST
	Where	COMP_CODE = AR_COMP_CODE
	And		WORK_SEQ = AR_WORK_SEQ;
	If lrRec.PAYGBN = '$' Then
		If lrRec.IGNORE_COMP_TAG = 'T' Then
			Insert Into T_FIN_PAY_SAL_LIST
			(
				COMP_CODE,
				WORK_SEQ,
				SEQ,
				CRTUSERNO,
				CRTDATE,
				EMP_NO,
				IN_OUT_TAG,
				SUDANGCD,
				DEPT_CODE,
				SAFE_MNG_TAG,
				AMT
			)
			Select
				AR_COMP_CODE COMP_CODE,
				AR_WORK_SEQ WORK_SEQ,
				SQ_T_SEQ_SAL.NextVal SEQ,
				AR_CRTUSERNO CRTUSERNO,
				SysDate CRTDATE,
				x.EMPNO EMP_NO,
				x.IN_OUT_TAG IN_OUT_TAG,
				x.SUDANGCD,
				y.DEPT_CODE DEPT_CODE,
				Nvl(y.SAFE_MNG_TAG,'F') SAFE_MNG_TAG,
				x.AMT AMT
			From
				(
					Select
						'1' IN_OUT_TAG,
						a.EMPNO,
						a.SUDANGCD,
						a.AMT
					From	GLIS003VV a,
							T_FIN_SUD_ACC_CODE b
					Where	a.YYMM = lrRec.WORK_YM
					And		a.PAYGBN = '1'
					And		a.SUDANGCD = '950'
					And		a.SUDANGCD = b.SUDANGCD
					And		b.INCLUDE_TAG = 'T'
					Union All
					Select
						'2',
						a.EMPNO,
						a.SUBSCD,
						- a.AMT
					From	GLIS004VV a,
							T_FIN_SUB_ACC_CODE b
					Where	a.YYMM = lrRec.WORK_YM
					And		a.PAYGBN = '1'
					And		a.SUBSCD = '950'
					And		a.SUBSCD = b.SUBSCD
					And		b.INCLUDE_TAG = 'T'
				) x,
				(
					Select
						a.EMPNO,
						b.DEPT_CODE,
						b.SAFE_MNG_TAG
					From	Z_AUTHORITY_USER a,
							(
								Select
									a.EMP_NO ,
									a.DEPT_CODE ,
									a.SAFE_MNG_TAG
								From
									(
										Select
											a.EMP_NO ,
											a.ORDER_SEQ ,
											a.DEPT_CODE ,
											a.ORDER_DT ,
											a.SAFE_MNG_TAG,
											Row_Number() Over (Partition By a.EMP_NO Order By a.EMP_NO,a.ORDER_DT desc , a.ORDER_SEQ desc ) RN
										From	T_FIN_EMP_ORDER a
									) a
								Where	rn = 1
							) b
					Where	a.EMPNO = b.EMP_NO (+)
				) y
			Where	x.EMPNO = y.EMPNO;
		Else
			Insert Into T_FIN_PAY_SAL_LIST
			(
				COMP_CODE,
				WORK_SEQ,
				SEQ,
				CRTUSERNO,
				CRTDATE,
				EMP_NO,
				IN_OUT_TAG,
				SUDANGCD,
				DEPT_CODE,
				SAFE_MNG_TAG,
				AMT
			)
			Select
				AR_COMP_CODE COMP_CODE,
				AR_WORK_SEQ WORK_SEQ,
				SQ_T_SEQ_SAL.NextVal SEQ,
				AR_CRTUSERNO CRTUSERNO,
				SysDate CRTDATE,
				x.EMPNO EMP_NO,
				x.IN_OUT_TAG IN_OUT_TAG,
				x.SUDANGCD,
				y.DEPT_CODE DEPT_CODE,
				Nvl(y.SAFE_MNG_TAG,'F') SAFE_MNG_TAG,
				x.AMT AMT
			From
				(
					Select
						'1' IN_OUT_TAG,
						EMPNO,
						SUDANGCD,
						AMT
					From	GLIS003VV
					Where	YYMM = lrRec.WORK_YM
					And		PAYGBN = lrRec.PAYGBN
					Union All
					Select
						'2',
						EMPNO,
						SUBSCD,
						- AMT
					From	GLIS004VV
					Where	YYMM = lrRec.WORK_YM
					And		PAYGBN = lrRec.PAYGBN
				) x,
				(
					Select
						a.EMPNO,
						b.DEPT_CODE,
						b.SAFE_MNG_TAG
					From	Z_AUTHORITY_USER a,
							(
								Select
									a.EMP_NO ,
									a.DEPT_CODE ,
									a.SAFE_MNG_TAG
								From
									(
										Select
											a.EMP_NO ,
											a.ORDER_SEQ ,
											a.DEPT_CODE ,
											a.ORDER_DT ,
											a.SAFE_MNG_TAG,
											Row_Number() Over (Partition By a.EMP_NO Order By a.EMP_NO,a.ORDER_DT desc , a.ORDER_SEQ desc ) RN
										From	T_FIN_EMP_ORDER a
									) a
								Where	rn = 1
							) b,
							T_DEPT_CODE_ORG c
					Where	a.EMPNO = b.EMP_NO
					And		b.DEPT_CODE = c.DEPT_CODE
					And		c.COMP_CODE = AR_COMP_CODE
				) y
			Where	x.EMPNO = y.EMPNO;
		End If;
	Else
		If lrRec.IGNORE_COMP_TAG = 'T' Then
			Insert Into T_FIN_PAY_SAL_LIST
			(
				COMP_CODE,
				WORK_SEQ,
				SEQ,
				CRTUSERNO,
				CRTDATE,
				EMP_NO,
				IN_OUT_TAG,
				SUDANGCD,
				DEPT_CODE,
				SAFE_MNG_TAG,
				AMT
			)
			Select
				AR_COMP_CODE COMP_CODE,
				AR_WORK_SEQ WORK_SEQ,
				SQ_T_SEQ_SAL.NextVal SEQ,
				AR_CRTUSERNO CRTUSERNO,
				SysDate CRTDATE,
				x.EMPNO EMP_NO,
				x.IN_OUT_TAG IN_OUT_TAG,
				x.SUDANGCD,
				y.DEPT_CODE DEPT_CODE,
				Nvl(y.SAFE_MNG_TAG,'F') SAFE_MNG_TAG,
				x.AMT AMT
			From
				(
					Select
						'1' IN_OUT_TAG,
						a.EMPNO,
						a.SUDANGCD,
						a.AMT
					From	GLIS003VV a,
							T_FIN_SUD_ACC_CODE b
					Where	a.YYMM = lrRec.WORK_YM
					And		a.PAYGBN = lrRec.PAYGBN
					And		a.SUDANGCD = b.SUDANGCD
					And		b.INCLUDE_TAG = 'T'
					Union All
					Select
						'2',
						a.EMPNO,
						a.SUBSCD,
						- a.AMT
					From	GLIS004VV a,
							T_FIN_SUB_ACC_CODE b
					Where	a.YYMM = lrRec.WORK_YM
					And		a.PAYGBN = lrRec.PAYGBN
					And		a.SUBSCD = b.SUBSCD
					And		b.INCLUDE_TAG = 'T'
				) x,
				(
					Select
						a.EMPNO,
						b.DEPT_CODE,
						b.SAFE_MNG_TAG
					From	Z_AUTHORITY_USER a,
							(
								Select
									a.EMP_NO ,
									a.DEPT_CODE ,
									a.SAFE_MNG_TAG
								From
									(
										Select
											a.EMP_NO ,
											a.ORDER_SEQ ,
											a.DEPT_CODE ,
											a.ORDER_DT ,
											a.SAFE_MNG_TAG,
											Row_Number() Over (Partition By a.EMP_NO Order By a.EMP_NO,a.ORDER_DT desc , a.ORDER_SEQ desc ) RN
										From	T_FIN_EMP_ORDER a
									) a
								Where	rn = 1
							) b
					Where	a.EMPNO = b.EMP_NO (+)
				) y
			Where	x.EMPNO = y.EMPNO;
		Else
			Insert Into T_FIN_PAY_SAL_LIST
			(
				COMP_CODE,
				WORK_SEQ,
				SEQ,
				CRTUSERNO,
				CRTDATE,
				EMP_NO,
				IN_OUT_TAG,
				SUDANGCD,
				DEPT_CODE,
				SAFE_MNG_TAG,
				AMT
			)
			Select
				AR_COMP_CODE COMP_CODE,
				AR_WORK_SEQ WORK_SEQ,
				SQ_T_SEQ_SAL.NextVal SEQ,
				AR_CRTUSERNO CRTUSERNO,
				SysDate CRTDATE,
				x.EMPNO EMP_NO,
				x.IN_OUT_TAG IN_OUT_TAG,
				x.SUDANGCD,
				y.DEPT_CODE DEPT_CODE,
				Nvl(y.SAFE_MNG_TAG,'F') SAFE_MNG_TAG,
				x.AMT AMT
			From
				(
					Select
						'1' IN_OUT_TAG,
						EMPNO,
						SUDANGCD,
						AMT
					From	GLIS003VV
					Where	YYMM = lrRec.WORK_YM
					And		PAYGBN = lrRec.PAYGBN
					Union All
					Select
						'2',
						EMPNO,
						SUBSCD,
						- AMT
					From	GLIS004VV
					Where	YYMM = lrRec.WORK_YM
					And		PAYGBN = lrRec.PAYGBN
				) x,
				(
					Select
						a.EMPNO,
						b.DEPT_CODE,
						b.SAFE_MNG_TAG
					From	Z_AUTHORITY_USER a,
							(
								Select
									a.EMP_NO ,
									a.DEPT_CODE ,
									a.SAFE_MNG_TAG
								From
									(
										Select
											a.EMP_NO ,
											a.ORDER_SEQ ,
											a.DEPT_CODE ,
											a.ORDER_DT ,
											a.SAFE_MNG_TAG,
											Row_Number() Over (Partition By a.EMP_NO Order By a.EMP_NO,a.ORDER_DT desc , a.ORDER_SEQ desc ) RN
										From	T_FIN_EMP_ORDER a
									) a
								Where	rn = 1
							) b,
							T_DEPT_CODE_ORG c
					Where	a.EMPNO = b.EMP_NO
					And		b.DEPT_CODE = c.DEPT_CODE
					And		c.COMP_CODE = AR_COMP_CODE
				) y
			Where	x.EMPNO = y.EMPNO;
		End If;
	End If;
End;
/

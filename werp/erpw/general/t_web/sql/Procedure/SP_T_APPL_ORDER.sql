Create Or Replace Procedure SP_T_APPL_ORDER
(
	Ar_Emp_No			Varchar2,
	Ar_CrtUserNo		Varchar2
)
Is
	lrTarget			T_FIN_EMP_ORDER%RowType;
Begin
	For lrA In (
			Select
				a.EMPNO,
				F_T_STRINGTODATE(a.YMDFR) YMDFR,
				b.DEPT_CODE,
				a.DEPT,
				a.SDEPTNM
			From	PORD001VV a,
					T_DEPT_CODE_ORG b
			Where	a.EMPNO = Ar_Emp_No
			And		a.DEPT = b.LEGA_DEPT (+)
			Order By
				a.YMDFR
		)
	Loop
		If lrA.DEPT_CODE Is Null Then
			--Raise_Application_Error(-20009,'부서정보에 신인사 부서코드 정보가 설정되어 있지 않습니다. '||lrA.SDEPTNM);
			Null;
		Else
			--먼저 기존자료에 해당일자 발령이 있는지 알아보고 있다면 엎어친다.
			Begin
				Select
					*
				Into
					lrTarget
				From	T_FIN_EMP_ORDER a
				Where	a.EMP_NO = Ar_Emp_No
				And		a.ORDER_DT = lrA.YMDFR
				And		a.ORDER_SEQ = (
					Select
						Max(b.ORDER_SEQ)
					From	T_FIN_EMP_ORDER b
					Where	a.EMP_NO = b.EMP_NO
					And		a.ORDER_DT = b.ORDER_DT
				);
				Update	T_FIN_EMP_ORDER
				Set		DEPT_CODE = lrA.DEPT_CODE
				Where	EMP_NO = Ar_Emp_No
				And		ORDER_SEQ = lrTarget.ORDER_SEQ;
			Exception When No_Data_Found Then
				Insert Into T_FIN_EMP_ORDER
				(
					EMP_NO,
					ORDER_SEQ,
					DEPT_CODE,
					ORDER_DT,
					SAFE_MNG_TAG,
					WORK_TAG
				)
				Values
				(
					lrA.EMPNO,
					SQ_T_ORDER_SEQ.NextVal,
					lrA.DEPT_CODE,
					lrA.YMDFR,
					'F',
					'1'
				);
			End;
		End If;
	End Loop;
End;
/

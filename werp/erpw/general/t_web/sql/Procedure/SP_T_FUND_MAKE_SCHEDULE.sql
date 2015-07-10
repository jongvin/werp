Create Or Replace Procedure SP_T_FUND_MAKE_SCHEDULE
(
	Ar_LOAN_NO					Varchar2,
	Ar_CRTUSERNO				Varchar2
)
Is
	ln_Count					Number;
	ln_Tot						Number;
	ln_LastSeq					Number;
	lr_T_FIN_LOAN_SHEET			T_FIN_LOAN_SHEET%RowType;
	ln_Day						Number;
	ln_RefundYear				Number;
	ln_Months					Number;
	lddt_TRANS_DT				Date;
	Function	UserIsNumber
	(
		Ar_Var					Varchar2
	)
	Return Boolean
	Is
		ln_Ret				Number;
	Begin
		If Ar_Var Is Null Then
			Return True;
		End If;
		ln_Ret := To_Number(Ar_Var);
		Return True;
	Exception When Others Then
		Return False;
	End;
	Function	SafeToNumber
	(
		Ar_Var					Varchar2
	)
	Return Number
	Is
		ln_Ret				Number;
	Begin
		If Ar_Var Is Null Then
			Return 0;
		End If;
		ln_Ret := To_Number(Ar_Var);
		Return ln_Ret;
	Exception When Others Then
		Return 0;
	End;
Begin
	Select
		Count(*)
	Into
		ln_Count
	From	T_FIN_LOAN_REFUND_LIST
	Where	LOAN_NO = Ar_LOAN_NO
	And		REFUND_INTR_DT Is Not Null
	And		(Nvl(REFUND_AMT,0) <> 0 Or Nvl(INTR_AMT,0) <> 0);
	If ln_Count > 0 Then
		Raise_Application_Error(-20009,'실제 상환 또는 이자지급 내역이 있으므로 상환예정을 생성할 수 없습니다.');
	End If;
	Delete	T_FIN_LOAN_REFUND_LIST
	Where	LOAN_NO = Ar_LOAN_NO
	And		REFUND_INTR_DT Is Null;
	Begin
		Select
			*
		Into
			lr_T_FIN_LOAN_SHEET
		From	T_FIN_LOAN_SHEET
		Where	LOAN_NO = Ar_LOAN_NO;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'차입대장을 찾을 수 없습니다.');
	End;
	If lr_T_FIN_LOAN_SHEET.LOAN_FDT Is Null Then
		Raise_Application_Error(-20009,'차입일을 입력하셔야 합니다.');
	End If;
	If lr_T_FIN_LOAN_SHEET.LOAN_EXPR_DT Is Null Then
		Raise_Application_Error(-20009,'만기일을 입력하셔야 합니다.');
	End If;
	If lr_T_FIN_LOAN_SHEET.ORG_REFUND_MONTH Is Null Then
		Raise_Application_Error(-20009,'상환주기를 입력하셔야 합니다.');
	End If;
	If lr_T_FIN_LOAN_SHEET.ORG_REFUND_FIRST_MONTH Is Null Then
		Raise_Application_Error(-20009,'최초상환일을 입력하셔야 합니다.');
	End If;
	If lr_T_FIN_LOAN_SHEET.INTR_REFUND_DAY Is Null Then
		Raise_Application_Error(-20009,'이자 지급일자를 입력하셔야 합니다.');
	End If;
	If lr_T_FIN_LOAN_SHEET.INTR_REFUND_FIRST_DT Is Null Then
		Raise_Application_Error(-20009,'이자 최초지급일을 입력하셔야 합니다.');
	End If;
	If lr_T_FIN_LOAN_SHEET.INTR_REFUND_DIV_MONTH Is Null Then
		Raise_Application_Error(-20009,'이자 납입주기를 입력하셔야 합니다.');
	End If;
	If Nvl(lr_T_FIN_LOAN_SHEET.LOAN_AMT,0) <= 0 Then
		Raise_Application_Error(-20009,'차입원금을 입력하셔야 합니다.');
	End If;
	If lr_T_FIN_LOAN_SHEET.LOAN_FDT > lr_T_FIN_LOAN_SHEET.LOAN_EXPR_DT Then
		Raise_Application_Error(-20009,'만기일이 차입일보다 먼저일 수 없습니다.');
	End If;
	If lr_T_FIN_LOAN_SHEET.INTR_REFUND_FIRST_DT > lr_T_FIN_LOAN_SHEET.LOAN_EXPR_DT Then
		Raise_Application_Error(-20009,'이자의 최초지급일이 만기일을 초과할 수 없습니다.');
	End If;
	If lr_T_FIN_LOAN_SHEET.ORG_REFUND_FIRST_MONTH > lr_T_FIN_LOAN_SHEET.LOAN_EXPR_DT Then
		Raise_Application_Error(-20009,'원금최초상환일이 만기일을 초과할 수 없습니다.');
	End If;
	ln_Day := SafeToNumber(lr_T_FIN_LOAN_SHEET.INTR_REFUND_DAY);
	If ln_Day <= 0 Or ln_Day > 31 Then
		Raise_Application_Error(-20009,'이자 납입일은 1~31 까지이어야 합니다.');
	End If;
	If Not UserIsNumber(lr_T_FIN_LOAN_SHEET.ORG_REFUND_MONTH) Then
		Raise_Application_Error(-20009,'상환주기는 개월수로 숫자형태로 입력하여야 합니다.');
	End If;
	ln_Months := SafeToNumber(lr_T_FIN_LOAN_SHEET.ORG_REFUND_MONTH);
	If ln_Months <= 0 Then
		Raise_Application_Error(-20009,'상환주기는 0보다 커야 합니다.');
	End If;
	ln_Months := SafeToNumber(lr_T_FIN_LOAN_SHEET.INTR_REFUND_DIV_MONTH);
	If ln_Months <= 0 Then
		Raise_Application_Error(-20009,'이자 납입 주기는 0보다 커야 합니다.');
	End If;
	Insert Into T_FIN_LOAN_REFUND_LIST
	(
		LOAN_NO,
		LOAN_REFUND_SEQ,
		CRTUSERNO,
		CRTDATE,
		TRANS_DT,
		REFUND_SCH_DT,
		REFUND_SCH_ORG_AMT,
		REFUND_SCH_INTR_AMT
	)
	With base_table_a As
	(
		Select
			a.LOAN_NO,
			a.LOAN_AMT,
			a.LOAN_FDT ,
			a.REAL_INTR_RATE,
			Case When Add_Months(a.INTR_REFUND_FIRST_DT,(Level-1) * To_Number(a.INTR_REFUND_DIV_MONTH)) >= a.LOAN_EXPR_DT Then
				a.LOAN_EXPR_DT
			Else
				Add_Months(a.INTR_REFUND_FIRST_DT,(Level-1) * To_Number(a.INTR_REFUND_DIV_MONTH))
			End INTR_DT
		From	T_FIN_LOAN_SHEET a
		Start With	a.LOAN_NO = Ar_LOAN_NO
		Connect by Add_Months(a.INTR_REFUND_FIRST_DT,(Level-1) * To_Number(a.INTR_REFUND_DIV_MONTH)) < Add_Months(a.LOAN_EXPR_DT,To_Number(a.INTR_REFUND_DIV_MONTH))
	),
	base_table_b As
	(
		Select
			LOAN_NO ,
			TRANS_DT,
			REFUND_SCH_DT,
			Decode(CNT,LV,LOAN_AMT - Sum(refund_amt) Over ( Order By lv) + refund_amt,refund_amt) REFUND_SCH_ORG_AMT
		From
			(
				Select
					a.LOAN_NO ,
					Case When Add_Months(a.ORG_REFUND_FIRST_MONTH,(Level-1) * To_Number(a.ORG_REFUND_MONTH)) >= a.LOAN_EXPR_DT Then
						a.LOAN_EXPR_DT
					Else
						Add_Months(a.ORG_REFUND_FIRST_MONTH,(Level-1) * To_Number(a.ORG_REFUND_MONTH))
					End TRANS_DT,
					Case When Add_Months(a.ORG_REFUND_FIRST_MONTH,(Level-1) * To_Number(a.ORG_REFUND_MONTH)) >= a.LOAN_EXPR_DT Then
						a.LOAN_EXPR_DT
					Else
						Add_Months(a.ORG_REFUND_FIRST_MONTH,(Level-1) * To_Number(a.ORG_REFUND_MONTH))
					End REFUND_SCH_DT,
					Count(*) Over () cnt,
					level lv,
					a.LOAN_AMT,
					Trunc(a.LOAN_AMT / Count(*) Over ()) refund_amt
				From	T_FIN_LOAN_SHEET a
				Start With a.LOAN_NO = Ar_LOAN_NO
				Connect By Add_Months(a.ORG_REFUND_FIRST_MONTH,(Level-1) * To_Number(a.ORG_REFUND_MONTH)) < Add_Months(a.LOAN_EXPR_DT,To_Number(a.ORG_REFUND_MONTH))
			)
		Order By
			lv
	)
	Select
		LOAN_NO,
		SQ_T_LOAN_REFUND_SEQ.NextVal LOAN_REFUND_SEQ,
		Ar_CRTUSERNO CRTUSERNO,
		SysDate CRTDATE,
		BASE_DATE TRANS_DT,
		BASE_DATE REFUND_SCH_DT,
		REFUND_SCH_ORG_AMT,
		Case
			When INTR_DT Is Not Null Then
				Sum(INTR) Over ( Partition By INTR_DT_F) 
			Else
				Null
		End REFUND_SCH_INTR_AMT
	From
		(
			Select
				LOAN_NO,
				BASE_DATE,
				INTR_DT,
				INTR_DT_F,
				REFUND_SCH_ORG_AMT,
				Trunc((Nvl(lag(REFUND_SCH_ORG_AMT_REMAIN) Over ( Order By BASE_DATE),LOAN_AMT)) * REAL_INTR_RATE * (BASE_DATE - Nvl(BASE_DATE_BF,LOAN_FDT)) / 100 / 365) INTR
			From
				(
					select 
						LOAN_NO,
						BASE_DATE,
						LOAN_FDT,
						INTR_DT,
						Min(INTR_DT) Over (Order By BASE_DATE desc ) INTR_DT_F,
						TRANS_DT,
						REAL_INTR_RATE,
						LOAN_AMT,
						BASE_DATE_BF,
						REFUND_SCH_ORG_AMT_REMAIN,
						REFUND_SCH_ORG_AMT
					from
						(
							Select
								d.LOAN_NO,
								a.BASE_DATE,
								d.LOAN_FDT,
								b.INTR_DT,
								c.TRANS_DT,
								d.REAL_INTR_RATE,
								d.LOAN_AMT,
								c.REFUND_SCH_ORG_AMT,
								Lag(a.BASE_DATE) Over (Order By a.BASE_DATE) BASE_DATE_BF,
								Nvl(d.LOAN_AMT,0) - Nvl(Sum(c.REFUND_SCH_ORG_AMT) Over (Order By a.BASE_DATE),0) REFUND_SCH_ORG_AMT_REMAIN
							From
								(
									Select
										LOAN_NO,
										INTR_DT BASE_DATE
									From	base_table_a a
									Union
									Select
										b.LOAN_NO,
										b.TRANS_DT
									From	base_table_b b
								) a,
								base_table_a b,
								base_table_b c,
								T_FIN_LOAN_SHEET d
							Where	a.BASE_DATE = b.INTR_DT (+)
							And		a.BASE_DATE = c.TRANS_DT (+)
							And		a.LOAN_NO = b.LOAN_NO (+)
							And		a.LOAN_NO = c.LOAN_NO (+)
							And		a.LOAN_NO = d.LOAN_NO
						)
						order by 
							BASE_DATE desc
				)
				order by 
					BASE_DATE
		);
End;
/

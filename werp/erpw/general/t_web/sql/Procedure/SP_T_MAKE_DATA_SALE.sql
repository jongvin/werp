--공사매출액 진행율 전표 생성용 SP
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
		Raise_Application_Error(-20009,'집계대상 자료를 찾을 수 없습니다.');
	End;
	If lrRec.WORK_DT Is Null Then
		Raise_Application_Error(-20009,'집계대상월을 입력하지 않았습니다.');
	End If;
	If lrRec.SLIP_ID Is Not Null Then
		Raise_Application_Error(-20009,'이미 전표가 발행된 자료입니다.');
	End If;
	--작업순서
	--1. 기존 자료 삭제
	--2. 현장의 마감일이 당회기보다 큰 날짜이면서 현장의 원가명세구분이 공사원가인 현장만 구해온다.
	--3. 해당 현장별로 각종 금액을 산출한다.
	
	--1. 기존 자료 삭제
	Delete	T_SET_SALE_SLIP_LIST
	Where	COMP_CODE = Ar_COMP_CODE
	And		WORK_NO = Ar_WORK_NO;
	--2. 현장의 마감일이 당회기보다 큰 날짜이면서 현장의 원가명세구분이 공사원가인 현장만 구해온다.
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
		--3. 해당 현장별로 각종 금액을 산출한다.
		--누적원가 산출
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
			Raise_Application_Error(-20009,'해당현장의 매출액 계정 또는 원가대체계정구분이 설정되지 않았습니다.'||lrA.DEPT_CODE||F_T_Get_Dept_Name(lrA.DEPT_CODE));
		End;
		If lsSaleAccCode Is Null Then
			Raise_Application_Error(-20009,'해당현장의 매출액 계정 또는 원가대체계정구분이 설정되지 않았습니다.'||lrA.DEPT_CODE||F_T_Get_Dept_Name(lrA.DEPT_CODE));
		End If;
		--기존매출산출
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
		--당월 세금계산서 발행분
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
		--누적매출액 산출
		--누적 매출액 := 도급금액 * 진행율
		lrData.SALE_SUM := Trunc(Nvl(lrData.CONS_AMT,0) * Nvl(lrData.COST_SUM,0) / nullif(Nvl(lrData.BUDG_AMT,0) + Nvl(lrData.AS_AMT,0),0));
		--만약 당월 원가가 0이면 당월 매출은 0이된다.
		--단 매출액이 도급액 초과시 그 차액이 매출이 된다.
		If Nvl(lrData.SALE_SUM,0) > Nvl(lrData.CONS_AMT,0) Or Nvl(lrData.NM_COST_AMT,0) <> 0 Then
			lrData.NM_SALE_AMT := Nvl(lrData.SALE_SUM,0) - (Nvl(lrData.PY_SALE_SUM,0) + Nvl(lrData.NYPM_SALE_SUM,0));
		Else
			lrData.NM_SALE_AMT := 0;
		End If;
		--당년 매출
		lrData.NY_SALE_AMT := Nvl(lrData.NM_SALE_AMT,0) + Nvl(lrData.NYPM_SALE_SUM,0);
		lrData.SALE_SUM := Nvl(lrData.PY_SALE_SUM,0) + Nvl(lrData.NYPM_SALE_SUM,0) + Nvl(lrData.NM_SALE_AMT,0);
		--추정매출 계산
		lrData.PR_SALE_SUM := Trunc(Nvl(lrData.CONS_AMT,0) * Nvl(lrData.COST_SUM,0) / nullif(Nvl(lrData.PR_COST_AMT,0) + Nvl(lrData.AS_AMT,0),0));
		--공사미수금 계산서 잔액
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
		--공사미수금 진행율 잔액
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
		--공사선수금 계산서 잔액
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
		--공사선수금 진행율 잔액
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
		--기존 미수잔액 - 선수잔액을 구한다.
		lnPreRemainAmt := Nvl(lrData.NP_REMAIN_AMT,0) + Nvl(lrData.NP_R_REMAIN_AMT,0) - Nvl(lrData.PP_R_REMAIN_AMT,0);
		--기존 미수잔액 - 선수잔액에서 당월 매출액 차감액을 더한다.
		lnPreRemainAmt := lnPreRemainAmt + Nvl(lrData.NM_SALE_AMT,0) - Nvl(lrData.NM_SALE_P_AMT,0);
		If lnPreRemainAmt > 0 Then	--만약 금액이 0보다 크다면 미수발생이다.
			lrData.NP_AMT := lnPreRemainAmt;
		Else
			lrData.PP_AMT := Abs(lnPreRemainAmt);
		End If;
		Insert Into T_SET_SALE_SLIP_LIST Values lrData;
	End Loop;
End;
/

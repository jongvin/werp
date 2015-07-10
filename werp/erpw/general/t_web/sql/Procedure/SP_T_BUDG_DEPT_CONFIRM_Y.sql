CREATE OR REPLACE Procedure SP_T_BUDG_DEPT_CONFIRM_Y
(
	Ar_COMP_CODE					Varchar2,
	Ar_CLSE_ACC_ID					Varchar2,
	Ar_DEPT_CODE					Varchar2,
	Ar_CHG_SEQ						Number,
	Ar_CRTUSERNO					Varchar2
)
Is
	ls_BUDG_CODE_NAME				T_BUDG_CODE.BUDG_CODE_NAME%Type;
	lb_Found						Boolean;
Begin
	 If Ar_CHG_SEQ = 0 Then
		Begin
	
			Select
				c.BUDG_CODE_NAME
			Into
				ls_BUDG_CODE_NAME
			From
				(
					Select
						a.COMP_CODE ,
						a.CLSE_ACC_ID ,
						a.DEPT_CODE ,
						a.CHG_SEQ ,
						a.BUDG_CODE_NO ,
						a.RESERVED_SEQ,
						Nvl(a.BUDG_ITEM_ASSIGN_AMT,0) BUDG_ITEM_ASSIGN_AMT,
						Nvl(Sum(b.BUDG_MONTH_ASSIGN_AMT),0) BUDG_MONTH_ASSIGN_AMT
					From	T_BUDG_DEPT_ITEM_H a,
							T_BUDG_MONTH_AMT_H b
					Where	a.COMP_CODE = b.COMP_CODE (+)
					And		a.CLSE_ACC_ID = b.CLSE_ACC_ID (+)
					And		a.DEPT_CODE = b.DEPT_CODE (+)
					And		a.CHG_SEQ = b.CHG_SEQ (+)
					And		a.BUDG_CODE_NO = b.BUDG_CODE_NO (+)
					And		a.RESERVED_SEQ = b.RESERVED_SEQ (+)
					And		a.COMP_CODE = Ar_COMP_CODE
					And		a.CLSE_ACC_ID = Ar_CLSE_ACC_ID
					And		a.DEPT_CODE = Ar_DEPT_CODE
					And		a.CHG_SEQ = Ar_CHG_SEQ
					Group By
						a.COMP_CODE ,
						a.CLSE_ACC_ID ,
						a.DEPT_CODE ,
						a.CHG_SEQ ,
						a.BUDG_CODE_NO ,
						a.RESERVED_SEQ ,
						a.BUDG_ITEM_ASSIGN_AMT
				) a,
				T_BUDG_CODE c
			Where	a.BUDG_ITEM_ASSIGN_AMT <> a.BUDG_MONTH_ASSIGN_AMT
			And		a.BUDG_CODE_NO = c.BUDG_CODE_NO
			And		RowNum < 2;
			lb_Found := true;
		Exception When No_Data_Found Then
			ls_BUDG_CODE_NAME := Null;
			lb_Found := false;
		End;
		If lb_Found Then
			Raise_Application_Error(-20009,'예산항목 : '||ls_BUDG_CODE_NAME||'의 예산 금액과 월별 분할 금액의 합이 서로 달라 확정하실 수 없습니다.');
		End If;
	End If;
	Update	T_BUDG_DEPT_H
	Set		CONFIRM_TAG = 'T',
			MODUSERNO = Ar_CRTUSERNO,
			MODDATE = Sysdate
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		DEPT_CODE = AR_DEPT_CODE
	And		CHG_SEQ = AR_CHG_SEQ;
	--변경차수> 0
	If Ar_CHG_SEQ > 0 Then
	   
	   SP_T_BUDG_DEPT_CHG_CONFIRM_Y(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_DEPT_CODE,Ar_CHG_SEQ);
	End If;
	--최초신청액처리 - 배정액을 최초신청액에 넣어준다
	If Ar_CHG_SEQ = 0 Then

	   SP_T_BUDG_FIRST_BUDG_AMT(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_DEPT_CODE,Ar_CHG_SEQ);
	End If;
	
	SP_T_BUDG_LAST_CONFIRM(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_DEPT_CODE,Ar_CRTUSERNO);
End;
/

Create Or Replace Procedure SP_T_FIN_MAKE_NP_DATA
(
	Ar_Work_No					Number,
	Ar_CrtUserNo				Varchar2
)
Is
	lrRec						T_FIN_SEC_NP_ITR_WORK%Rowtype;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_FIN_SEC_NP_ITR_WORK
		Where	Work_No = Ar_Work_No;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'유가증권 미수이자 전표발행작업을 찾을 수 없습니다.');
	End;
	If lrRec.SLIP_ID Is Not Null Then
		Raise_Application_Error(-20009,'이미 전표가 발행되어 있습니다.');
	End If;
	If lrRec.CALC_DT_FROM Is Null Or lrRec.CALC_DT_TO Is Null Then
		Raise_Application_Error(-20009,'이작업을 하기전에 먼저 이자계산 기간을 입력하여 저장한 후 작업을 하시기 바랍니다.');
	End If;
	If lrRec.TARGET_COMP_CODE Is Null Then
		Raise_Application_Error(-20009,'이작업을 하기전에 먼저 작업대상 사업장을 입력하여 저장한 후 작업을 하시기 바랍니다.');
	End If;
	SP_T_FIN_ONLY_MAKE_NP_DATA(Ar_Work_No,Ar_CrtUserNo);
	SP_T_FIN_REAL_MAKE_NP_DATA(Ar_Work_No,Ar_CrtUserNo);
End;
/

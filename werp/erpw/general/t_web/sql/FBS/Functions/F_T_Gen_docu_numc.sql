Create Or Replace Function F_T_Gen_docu_numc
(
	Ar_Bank_Code			Varchar2,
	Ar_Docu_Code			Varchar2,
	Ar_Upmu_Code			Varchar2,
	Ar_Send_Date			Varchar2
)
Return Varchar2
Is
	Pragma autonomous_transaction;
	lsTemp					Varchar2(7) := Ar_Docu_Code || Ar_Upmu_Code;
	ls_Docu_Code			Varchar2(4) := Ar_Docu_Code;
	ls_Upmu_Code			Varchar2(3) := Ar_Upmu_Code;
	ls_Ret					Varchar2(6);
Begin
	If lsTemp = FBS_MAIN_PKG.FB_DOCU_TATR_T Then		--타행이체라면
		ls_Docu_Code := SubStrb(FBS_MAIN_PKG.FB_DOCU_DATR_T,1,4);
		ls_Upmu_Code := SubStrb(FBS_MAIN_PKG.FB_DOCU_DATR_T,5,3);
	ElsIf lsTemp = FBS_MAIN_PKG.FB_DOCU_TATR_B Then		--타행이체라면
		ls_Docu_Code := SubStrb(FBS_MAIN_PKG.FB_DOCU_DATR_B,1,4);
		ls_Upmu_Code := SubStrb(FBS_MAIN_PKG.FB_DOCU_DATR_B,5,3);
	End If;
	Lock Table T_FB_DOCU_NUMC In EXCLUSIVE Mode;
	Select
		To_Char(To_Number(Nvl(Max(DOCU_NUMC),'000000')) + 1,'FM000000')
	Into
		ls_Ret
	From	T_FB_DOCU_NUMC
	Where	BANK_CODE = Ar_Bank_Code
	And		DOCU_CODE = ls_Docu_Code
	And		UPMU_CODE = ls_Upmu_Code
	And		SEND_DATE = Ar_Send_Date;
	If ls_Ret = '000001' Then
		Insert Into T_FB_DOCU_NUMC
		(
			BANK_CODE,
			DOCU_CODE,
			UPMU_CODE,
			SEND_DATE,
			DOCU_NUMC
		)
		Values
		(
			Ar_Bank_Code,
			ls_Docu_Code,
			ls_Upmu_Code,
			Ar_Send_Date,
			ls_Ret
		);
	Else
		Update	T_FB_DOCU_NUMC
		Set		DOCU_NUMC = ls_Ret
		Where	BANK_CODE = Ar_Bank_Code
		And		DOCU_CODE = ls_Docu_Code
		And		UPMU_CODE = ls_Upmu_Code
		And		SEND_DATE = Ar_Send_Date;
	End If;
	Commit;
	Return ls_Ret;
Exception When Others Then
	Rollback;
	Return Null;
End;
/

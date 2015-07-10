Create Or Replace Procedure SP_T_MAKE_FBS_C_DATA
(
	Ar_Comp_Code			Varchar2,
	Ar_Date_From			Varchar2,
	Ar_Date_To				Varchar2
)
Is
Begin
	SP_T_MAKE_FBS_C_DATA_CD(Ar_Comp_Code,Ar_Date_From,Ar_Date_To);
	SP_T_MAKE_FBS_C_DATA_PE(Ar_Comp_Code,Ar_Date_From,Ar_Date_To);
	SP_T_MAKE_FBS_C_DATA_PH(Ar_Comp_Code,Ar_Date_From,Ar_Date_To);
	SP_T_MAKE_FBS_C_DATA_SE(Ar_Comp_Code,Ar_Date_From,Ar_Date_To);
End;
/

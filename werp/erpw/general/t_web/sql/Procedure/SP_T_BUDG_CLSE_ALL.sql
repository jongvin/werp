CREATE OR REPLACE Procedure SP_T_BUDG_CLSE_ALL
(
	Ar_COMP_CODE					Varchar2,
	Ar_CLSE_ACC_ID					Varchar2,
	Ar_REQ_CLSE_DT					Varchar2,
	Ar_REQ_CLSE_CLS					Varchar2,
	Ar_CRTUSERNO					NUMBER
)
Is
	
	lsErrm							Varchar2(2000);
Begin
	
	If Ar_REQ_CLSE_CLS ='T' Then
		UPDATE  T_BUDG_CLOSE
		SET		REQ_CLSE_CLS  = Ar_REQ_CLSE_CLS,
			       REQ_CLSE_DT = F_T_StringToDate(Ar_REQ_CLSE_DT)
		WHERE   COMP_CODE  = Ar_COMP_CODE
		AND	      CLSE_ACC_ID = Ar_CLSE_ACC_ID;
	else
		UPDATE  T_BUDG_CLOSE
		SET		REQ_CLSE_CLS  = Ar_REQ_CLSE_CLS,
				REQ_CLSE_DT   = null
		WHERE   COMP_CODE  = Ar_COMP_CODE
		AND	      CLSE_ACC_ID = Ar_CLSE_ACC_ID;
	end If;
	
End;
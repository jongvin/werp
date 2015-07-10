CREATE OR REPLACE Procedure SP_T_APPLY_OR_CANCEL_FIX_DEP
(
	AR_Work_Seq				Number,
	AR_Fix_Asset_Seq		Number,
	AR_Comp_Code			Varchar2,
	AR_Clse_Acc_Id			Varchar2,
	Ar_MODUSERNO			Number,
	Ar_Apply_Tag			Varchar2
)
Is
ls_tran_cls					varchar2(1);
Begin
	select trans_cls
	into ls_tran_cls
	from t_fix_deprec_cal
	where work_seq = AR_Work_Seq;
	
	If Ar_Apply_Tag = 'T' Then
	   If ls_tran_cls = 'T' Then
	   	  Raise_Application_Error(-20009,'이미 적용되었습니다');
	   End if;
	else  
	   If ls_tran_cls = 'F' Then
	   	  Raise_Application_Error(-20009,'이미 적용취소되었습니다');
	   End if;	
	end if;
	If Ar_Apply_Tag = 'T' Then
		Merge Into T_FIX_SHEET t
		Using
		(
			Select
				a.FIX_ASSET_SEQ ,
				a.WORK_SEQ ,
				a.MODUSERNO ,
				a.MODDATE ,
				a.SUM_CNT ,
				a.START_ASSET_AMT ,
				a.CURR_ASSET_INC_AMT ,
				a.CURR_ASSET_SUB_AMT ,
				a.START_APPROP_AMT ,
				a.CURR_APPROP_SUB_AMT ,
				a.CURR_DEPREC_AMT ,
				a.DEPREC_RAT ,
				a.BEFORE_WORK_SEQ ,
				a.BEFORE_BASE_AMT ,
				a.BEFORE_OLD_DEPREC_AMT ,
				a.BEFORE_DEPREC_FINISH ,
				a.BEFORE_INC_SUM_AMT ,
				a.BEFORE_SUB_SUM_AMT ,
				a.BASE_AMT ,
				a.OLD_DEPREC_AMT ,
				a.DEPREC_FINISH ,
				a.INC_SUM_AMT ,
				a.SUB_SUM_AMT 
			From	T_FIX_SUM a
			Where	a.WORK_SEQ = AR_Work_Seq
		) s
		On
		(
			t.FIX_ASSET_SEQ = s.FIX_ASSET_SEQ
		)
		When Matched Then
		Update 
		Set
			BASE_AMT = s.BASE_AMT,
			OLD_DEPREC_AMT = s.OLD_DEPREC_AMT,
			DEPREC_FINISH = s.DEPREC_FINISH,
			INC_SUM_AMT = s.INC_SUM_AMT,
			SUB_SUM_AMT = s.SUB_SUM_AMT,
			ASSET_CNT = s.SUM_CNT,
			WORK_SEQ = s.WORK_SEQ
		When Not Matched Then
		Insert
		(
			FIX_ASSET_SEQ
		)
		values
		(
			s.FIX_ASSET_SEQ
		);
		Update T_FIX_DEPREC_CAL z
		Set
			z.TRANS_CLS = 'T'
		Where	z.WORK_SEQ = AR_Work_Seq;	
	Else
		Merge Into T_FIX_SHEET t
		Using
		(
			Select
				a.FIX_ASSET_SEQ ,
				a.WORK_SEQ ,
				a.MODUSERNO ,
				a.MODDATE ,
				a.SUM_CNT ,
				a.START_ASSET_AMT ,
				a.CURR_ASSET_INC_AMT ,
				a.CURR_ASSET_SUB_AMT ,
				a.START_APPROP_AMT ,
				a.CURR_APPROP_SUB_AMT ,
				a.CURR_DEPREC_AMT ,
				a.DEPREC_RAT ,
				a.BEFORE_WORK_SEQ ,
				a.BEFORE_BASE_AMT ,
				a.BEFORE_ASSET_CNT ,
				a.BEFORE_OLD_DEPREC_AMT ,
				a.BEFORE_DEPREC_FINISH ,
				a.BEFORE_INC_SUM_AMT ,
				a.BEFORE_SUB_SUM_AMT ,
				a.BASE_AMT ,
				a.OLD_DEPREC_AMT ,
				a.DEPREC_FINISH ,
				a.INC_SUM_AMT ,
				a.SUB_SUM_AMT
			From	T_FIX_SUM a
			Where	a.WORK_SEQ = AR_Work_Seq
		) s
		On
		(
			t.FIX_ASSET_SEQ = s.FIX_ASSET_SEQ
		)
		When Matched Then
		Update
		Set
			BASE_AMT = s.BEFORE_BASE_AMT,
			OLD_DEPREC_AMT = s.BEFORE_OLD_DEPREC_AMT,
			DEPREC_FINISH = s.BEFORE_DEPREC_FINISH,
			INC_SUM_AMT = s.BEFORE_INC_SUM_AMT,
			SUB_SUM_AMT = s.BEFORE_SUB_SUM_AMT,
			ASSET_CNT = s.BEFORE_ASSET_CNT,
			WORK_SEQ = s.BEFORE_WORK_SEQ
		When Not Matched Then
		Insert
		(
			FIX_ASSET_SEQ
		)
		values
		(
			s.FIX_ASSET_SEQ
		);
		Update T_FIX_DEPREC_CAL z
		Set
			z.TRANS_CLS = 'F'
		Where	z.WORK_SEQ = AR_Work_Seq;
	End If;
	
End;
/

CREATE OR REPLACE Procedure SP_T_FIX_MOVE_REAL_MOVE_SEQ
(
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_MOVE_SEQ                                NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_MOVE_DT_FROM                            VARCHAR2,
	AR_MOVE_DT_TO                              VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_EMP_NO                                  VARCHAR2,
	AR_MNG_MAIN                                VARCHAR2,
	AR_MNG_SUB                                 VARCHAR2,
	AR_REAL_MOVE_SEQ                           NUMBER
)
Is
lsErrm										   Varchar2(2000);
lnErrNo										   Number;		
Begin
	
	--Raise_Application_Error(-20009, AR_FIX_ASSET_SEQ || ' ' || AR_MOVE_SEQ || ' ' || AR_MOVE_DT_FROM || ' ' || AR_DEPT_CODE);
	MERGE Into T_FIX_MOVE t
	Using
	(
		SELECT  fix_asset_seq,
				move_seq,
				move_dt_from,
				row_number() OVER (ORDER BY move_dt_from ASC, move_seq asc) real_move_seq
		from 	t_fix_move
		Where	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ
	) f
	On
	(
			f.FIX_ASSET_SEQ    = t.FIX_ASSET_SEQ
			and f.move_seq     = t.move_seq
			and f.move_dt_from =  t.move_dt_from
	)
	When Matched Then
		
		Update
		set
			t.REAL_MOVE_SEQ = f.REAL_MOVE_SEQ
			--t.MOVE_DT_FROM = AR_MOVE_DT_FROM
	When Not Matched Then
		 Insert
		 (
			t.FIX_ASSET_SEQ,
			t.MOVE_SEQ,
			t.CRTUSERNO,
			t.CRTDATE,
			t.MODUSERNO,
			t.MODDATE,
			t.MOVE_DT_FROM,
			t.MOVE_DT_TO,
			t.DEPT_CODE,
			t.EMP_NO,
			t.MNG_MAIN,
			t.MNG_SUB,
			t.REAL_MOVE_SEQ
		 )
		 Values
		 (
			AR_FIX_ASSET_SEQ,
			AR_MOVE_SEQ,
			AR_CRTUSERNO,
			SYSDATE,
			NULL,
			NULL,
			F_T_StringToDate(AR_MOVE_DT_FROM),
			F_T_StringToDate(AR_MOVE_DT_TO),
			AR_DEPT_CODE,
			AR_EMP_NO,
			AR_MNG_MAIN,
			AR_MNG_SUB,
			AR_REAL_MOVE_SEQ
		 );
	
	Exception When Others Then
			lsErrm := SqlErrm;
			lnErrNo:= SQLCODE;
			lsErrm := Replace(lsErrm,'ORA-20009:','');
			Raise_Application_Error(-20009,'배치정보 등록에러'||chr(10) || lnErrNo || ':' || lsErrm || ' ' || AR_REAL_MOVE_SEQ);  
    
			
End;
/

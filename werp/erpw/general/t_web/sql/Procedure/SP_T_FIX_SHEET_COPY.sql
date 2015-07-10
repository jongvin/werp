CREATE OR REPLACE Procedure SP_T_FIX_SHEET_COPY
(
	AR_FIX_ASSET_SEQ                           NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_SHEET_COPY
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_SHEET 테이블 COPY
/* 4. 변  경  이  력 : 한재원 작성(2006-01-17)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
ln_move_seq								          NUMBER;
ln_fix_asset_seq								   NUMBER;
ls_dept_code									   Varchar2(10);
ls_get_dt									   Date;		
lsErrm										   Varchar2(2000);
lnErrNo Number;	
begin
	 select dept_code,
	 		get_dt
			into ls_dept_code,
			ls_get_dt
	 from	t_fix_sheet
	 where fix_asset_seq = AR_FIX_ASSET_SEQ;									   								
Begin
	SELECT SQ_T_FIX_SHEET.NEXTVAL fix_asset_seq
	Into   ln_fix_asset_seq
	FROM   DUAL;
	
	insert into t_fix_sheet(
	   fix_asset_seq,
	   asset_cls_code,
	   item_code,
	   item_nm_code,
	   fix_asset_no,
	   asset_mng_no,
	   comp_code,
	   get_dt,
	   cust_seq,
	   asset_name,
	   base_amt,
	   old_deprec_amt,
	   get_cost_amt,
	   inc_sum_amt,
	   sub_sum_amt,
	   fixed_cls,
	   fixtures_cls,
	   etc_asset_tag,
	   dispose_year,
	   capital_out_amt,
	   gain_out_amt,
	   use_remark,
	   mng_dept_code,
	   dept_code,
	   item_nm_seq,
	   chg_get_amt,
	   sale_dt,
	   work_seq,
	   start_asset_amt,
	   curr_asset_inc_amt,
	   curr_asset_sub_amt,
	   start_approp_amt,
	   curr_approp_sub_amt,
	   curr_deprec_amt,
	   remark,
	   cust_seq2,
	   estimate_amt1,
	   estimate_amt2,
	   foreign_amt,
	   money_cls
)
select ln_fix_asset_seq,
	   asset_cls_code,
	   item_code,
	   item_nm_code,
	   (
	   	Select 
				TO_NUMBER(NVL(MAX(a.FIX_ASSET_NO),0) +1) FIX_ASSET_NO 
			From	T_FIX_SHEET a 
			Where	a.COMP_CODE = b.COMP_CODE   
			And	a.ASSET_CLS_CODE = b.ASSET_CLS_CODE   
			And	a.ITEM_CODE =  b.ITEM_CODE  
			And	a.ITEM_NM_CODE = b.ITEM_NM_CODE
	   ) fix_asset_no,
	   asset_cls_code || item_code || item_nm_code || lpad((
	   	Select 
				TO_NUMBER(NVL(MAX(a.FIX_ASSET_NO),0) +1) FIX_ASSET_NO 
			From	T_FIX_SHEET a 
			Where	a.COMP_CODE = b.COMP_CODE   
			And	a.ASSET_CLS_CODE = b.ASSET_CLS_CODE   
			And	a.ITEM_CODE =  b.ITEM_CODE  
			And	a.ITEM_NM_CODE = b.ITEM_NM_CODE
	   ),4,'0') asset_mng_no2,
	   comp_code,
	   get_dt,
	   nvl(cust_seq, '') cust_seq,
	   asset_name || '복사',
	   base_amt,
	   old_deprec_amt,
	   get_cost_amt,
	   inc_sum_amt,
	   sub_sum_amt,
	   fixed_cls,
	   fixtures_cls,
	   etc_asset_tag,
	   dispose_year,
	   capital_out_amt,
	   gain_out_amt,
	   use_remark,
	   mng_dept_code,
	   dept_code,
	   0 item_nm_seq,
	   chg_get_amt,
	   sale_dt,
	   '',
	   start_asset_amt,
	   curr_asset_inc_amt,
	   curr_asset_sub_amt,
	   start_approp_amt,
	   curr_approp_sub_amt,
	   curr_deprec_amt,
	   remark,
	   nvl(cust_seq2, '') cust_seq2,
	   estimate_amt1,
	   estimate_amt2,
	   foreign_amt,
	   money_cls
from t_fix_sheet b
where b.fix_asset_seq = AR_FIX_ASSET_SEQ;
end;

begin
	
	SELECT SQ_T_FIX_MOVE.NEXTVAL MOVE_SEQ
	Into   ln_move_seq
	FROM   DUAL;
		
	Insert into T_FIX_MOVE
	(
	 	FIX_ASSET_SEQ,
		MOVE_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		MOVE_DT_FROM,
		MOVE_DT_TO,
		DEPT_CODE,
		EMP_NO,
		MNG_MAIN,
		MNG_SUB,
		REAL_MOVE_SEQ
	) values
	(
	  	ln_fix_asset_seq,
		ln_move_seq,
		null,
		sysdate,
		null,
		null,
		ls_get_dt,
		null,
		ls_dept_code,
		null,
		null,
		null,
		0
	);
	Exception When Others Then
			lsErrm := SqlErrm;
			lnErrNo:= SQLCODE;
			lsErrm := Replace(lsErrm,'ORA-20009:','');
			Raise_Application_Error(-20009,'기본자산정보' ||ln_move_seq||'등록에러'||chr(10) || lnErrNo || ':' || lsErrm);  
End;
end;
/


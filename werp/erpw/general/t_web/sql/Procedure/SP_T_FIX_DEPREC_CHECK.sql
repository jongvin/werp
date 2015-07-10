Create Or Replace Procedure SP_T_FIX_DEPREC_CHECK
(
	AR_FIX_ASSET_SEQ                               NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_YEAR_CLOSE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_YEAR_CLOSE 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2005-11-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
ln_CNT Number;

Begin
	select count(*)
	Into	ln_CNT
	from t_fix_sum
	where fix_asset_seq = AR_FIX_ASSET_SEQ;
	if ln_CNT > 0 Then
		Raise_Application_Error(-20009,'감가상각 계산작업이 수행된 상태에서 <br>배치내역을 수정,삭제할 수 없습니다.');
	end if;
End;
/

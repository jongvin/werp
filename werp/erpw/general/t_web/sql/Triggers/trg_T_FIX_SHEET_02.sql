Create Or Replace Trigger trg_T_FIX_SHEET_02
After DELETE on T_FIX_SHEET
--For Each row
Begin
	delete from t_fix_furni_sum_temp
	where  fix_asset_seq = ( select fix_asset_seq 
					    from t_fix_sheet_temp a
	    				    where not exists (select *
					    				  from t_fix_sheet b
			                  				 where a.fix_asset_seq = b.fix_asset_seq));
	delete from t_fix_sum_temp
	where  fix_asset_seq = ( select fix_asset_seq 
					    from t_fix_sheet_temp a
	    				    where not exists (select *
					    				      from t_fix_sheet b
			                  				  where a.fix_asset_seq = b.fix_asset_seq));
    delete from t_fix_sheet_temp
	where  fix_asset_seq = ( select fix_asset_seq 
					    from t_fix_sheet_temp a
	    				    where not exists (select *
					    				  from t_fix_sheet b
			                  				 where a.fix_asset_seq = b.fix_asset_seq));
			               
	--delete from t_fix_deprec_cal_temp
	--where work_seq
	--where  fix_asset_seq = ( select fix_asset_seq 
					       --from t_fix_sheet_temp a
	    				      -- where not exists (select *
					    				   -- from t_fix_sheet b
			                  				   -- where a.fix_asset_seq = b.fix_asset_seq);
			               
			               
End;
/

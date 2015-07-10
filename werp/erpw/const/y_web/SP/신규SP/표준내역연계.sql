		UPDATE y_budget_detail  a
		  SET (a.mat_code ) = 
						 ( SELECT b.mat_code
							  from y_stand_detail b
							 where a.detail_code    = b.detail_code
							   and b.mat_code is not null
							   )
		 WHERE EXISTS (SELECT b.mat_code
							  from y_stand_detail b
							 where a.detail_code    = b.detail_code
							   and b.mat_code is not null );
		UPDATE y_chg_budget_detail  a
		  SET (a.mat_code ) = 
						 ( SELECT b.mat_code
							  from y_stand_detail b
							 where a.detail_code    = b.detail_code
							   and b.mat_code is not null )
		 WHERE EXISTS (SELECT b.mat_code
							  from y_stand_detail b
							 where a.detail_code    = b.detail_code
							   and b.mat_code is not null );

commit;
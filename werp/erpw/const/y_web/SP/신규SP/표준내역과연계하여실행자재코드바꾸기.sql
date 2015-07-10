		UPDATE y_budget_detail  a
		  SET (a.mat_code ) = 
						 ( SELECT b.mat_code
							  from y_stand_detail b
							 where a.detail_code    = b.detail_code
								and a.mat_code is  null)
		 WHERE EXISTS (SELECT b.mat_code
							  from y_stand_detail b
							 where a.detail_code    = b.detail_code
								and a.mat_code is  null);
		UPDATE y_chg_budget_detail  a
		  SET (a.mat_code ) = 
						 ( SELECT b.mat_code
							  from y_stand_detail b
							 where a.detail_code    = b.detail_code
								and a.mat_code is  null)
		 WHERE EXISTS (SELECT b.mat_code
							  from y_stand_detail b
							 where a.detail_code    = b.detail_code
								and a.mat_code is  null);

commit work;
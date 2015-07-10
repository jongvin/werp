CREATE OR REPLACE Procedure SP_T_CALCPROCESS_TEMP
(
	AR_WORK_SEQ                             NUMBER,
	Ar_MODUSERNO							NUMBER
)
Is
/***************************************************/
/* 이 프로그램은 대보시스템(주) 의 재산입니다.
/* 최초작성자 : 한재원
/* 최초작성일 : 2006-01-19
/* 최종수정자 :
/* 최종수정일 :
/***************************************************/
/***************************************************/
/* 1. 받아야 할 인자를 설정한다.
/* 2. 계산에 필요한 값을 Select 한다.
/* 3. 감가상각을 계산한다.
/* 4. T_FIX_SUM_TEMP 에 계산한 값을 저장한다.
/***************************************************/
	lr_T_FIX_DEPREC_CAL_TEMP				T_FIX_DEPREC_CAL_TEMP%RowType;
Begin
	Select
		*
	Into
		lr_T_FIX_DEPREC_CAL_TEMP
	From	T_FIX_DEPREC_CAL_TEMP
	Where	WORK_SEQ = AR_WORK_SEQ;
	
	If lr_T_FIX_DEPREC_CAL_TEMP.CAL_CLS = 'A' Then		--월상각
		Merge Into T_FIX_SUM_TEMP t
		Using
		(
			Select
				y.FIX_ASSET_SEQ ,
				y.WORK_SEQ ,
				Ar_MODUSERNO MODUSERNO,
				Sysdate MODDATE,
				y.SUM_CNT SUM_CNT,
				y.START_ASSET_AMT ,
				y.INC_AMT CURR_ASSET_INC_AMT,
				y.SUB_AMT CURR_ASSET_SUB_AMT,
				y.BEFORE_OLD_DEPREC_AMT START_APPROP_AMT,
				y.APPROP_SUBAMT CURR_APPROP_SUB_AMT,
				case
					When y.DEPREC_CLS = '2' And ((Nvl(y.BEFORE_BASE_AMT,0) - Nvl(y.DEPREC_AMT,0) < 1000) Or
							(Nvl(Nvl(y.BEFORE_BASE_AMT,0) / nullif(y.START_ASSET_AMT,0),0) < 0.05)) Then
						y.BEFORE_BASE_AMT - 1000
					When Nvl(y.BEFORE_BASE_AMT,0) - Nvl(y.DEPREC_AMT,0) < 0 Then
						y.BEFORE_BASE_AMT
					Else
						y.DEPREC_AMT
				End CURR_DEPREC_AMT ,
				y.DEPREC_RAT,
				nvl(y.BEFORE_WORK_SEQ, AR_WORK_SEQ) BEFORE_WORK_SEQ ,
				y.BEFORE_BASE_AMT ,
				y.BEFORE_OLD_DEPREC_AMT ,
				y.DEPREC_FINISH BEFORE_DEPREC_FINISH,
				y.BEFORE_INC_SUM_AMT ,
				y.BEFORE_SUB_SUM_AMT ,
				case
					When y.DEPREC_CLS = '2' And ((y.BEFORE_BASE_AMT - y.DEPREC_AMT < 1000) Or
							(Nvl(Nvl(y.BEFORE_BASE_AMT,0) / nullif(y.START_ASSET_AMT,0),0) < 0.05)) Then
						1000
					When Nvl(y.BEFORE_BASE_AMT,0) - Nvl(y.DEPREC_AMT,0) < 0 Then
						0
					Else
						Nvl(y.BEFORE_BASE_AMT,0) - Nvl(y.DEPREC_AMT,0)
				End BASE_AMT,
				Nvl(y.BEFORE_OLD_DEPREC_AMT,0) +
				(case
					When y.DEPREC_CLS = '2' And ((Nvl(y.BEFORE_BASE_AMT,0) - Nvl(y.DEPREC_AMT,0) < 1000) Or
							(Nvl(Nvl(y.BEFORE_BASE_AMT,0) / nullif(y.START_ASSET_AMT,0),0) < 0.05)) Then
						y.BEFORE_BASE_AMT - 1000
					When Nvl(y.BEFORE_BASE_AMT,0) - Nvl(y.DEPREC_AMT,0) < 0 Then
						y.BEFORE_BASE_AMT
					Else
						y.DEPREC_AMT
				End) OLD_DEPREC_AMT,
				case
					When y.DEPREC_CLS = '2' And ((y.BEFORE_BASE_AMT - y.DEPREC_AMT < 1000) Or
							(Nvl(Nvl(y.BEFORE_BASE_AMT,0) / nullif(y.START_ASSET_AMT,0),0) < 0.05)) Then
						'2'
					When Nvl(y.BEFORE_BASE_AMT,0) - Nvl(y.DEPREC_AMT,0) < 0 Then
						'2'
					Else
						'1'
				End DEPREC_FINISH,
				Nvl(y.BEFORE_INC_SUM_AMT,0) + Nvl(y.INC_AMT,0) INC_SUM_AMT,
				Nvl(y.BEFORE_SUB_SUM_AMT,0) + Nvl(y.SUB_AMT,0) SUB_SUM_AMT,
				y.ASSET_CNT BEFORE_ASSET_CNT
			From
				(
					Select
						a.FIX_ASSET_SEQ ,
						d.WORK_SEQ,
						a.DEPREC_CLS ,
						a.GET_DT ,
						Nvl(a.ASSET_CNT,0) +  Nvl(x.ASSET_CNT,0) SUM_CNT,
						Nvl(a.GET_COST_AMT,0) + Nvl(a.INC_SUM_AMT,0) - Nvl(a.SUB_SUM_AMT,0) REAL_START_AMT,
						x.INC_AMT,
						x.SUB_AMT,
						x.CHG_AMT,
						a.OLD_DEPREC_AMT BEFORE_OLD_DEPREC_AMT,
						a.DEPREC_FINISH,
						x.APPROP_SUBAMT,
						ROUND(1* (Nvl(a.GET_COST_AMT,0) + Nvl(a.INC_SUM_AMT,0) - Nvl(a.SUB_SUM_AMT,0) + Nvl(x.CHG_AMT,0))
							* (Decode(a.DEPREC_CLS,'1',c.DEPREC_AMT,'2',c.DEPREC_RAT5) / 12 )) DEPREC_AMT,
						Decode(a.DEPREC_CLS,'1',c.DEPREC_AMT,'2',c.DEPREC_RAT5) DEPREC_RAT,
						a.WORK_SEQ BEFORE_WORK_SEQ,
						a.BASE_AMT BEFORE_BASE_AMT,
						a.INC_SUM_AMT BEFORE_INC_SUM_AMT,
						a.SUB_SUM_AMT BEFORE_SUB_SUM_AMT,
						decode(To_Char(a.GET_DT, 'yyyy'),To_Char(d.WORK_FROM_DT,'yyyy'),0,
						Nvl(a.GET_COST_AMT,0) + Nvl(a.INC_SUM_AMT,0) - Nvl(a.SUB_SUM_AMT,0)) + Nvl(x.CHG_AMT,0) START_ASSET_AMT1 ,
						decode(To_Char(a.GET_DT, 'yyyy'),To_Char(d.WORK_FROM_DT,'yyyy'),
						Nvl(a.GET_COST_AMT,0) + Nvl(a.INC_SUM_AMT,0) - Nvl(a.SUB_SUM_AMT,0),0)  + Nvl(x.CHG_AMT,0) START_ASSET_AMT2 ,
						Nvl(a.GET_COST_AMT,0) + Nvl(a.INC_SUM_AMT,0) - Nvl(a.SUB_SUM_AMT,0) + Nvl(x.CHG_AMT,0) START_ASSET_AMT ,
						a.ASSET_CNT
					From	T_FIX_SHEET_TEMP a ,
							T_FIX_SUM_TEMP b ,
							T_FIX_DEPREC_RAT c ,
							T_FIX_DEPREC_CAL_TEMP d,
							(
								Select
									a.FIX_ASSET_SEQ ,
									Sum(Decode(a.INCREDU_CLS,
											'1',1,
											'2',-1,
											'3',-1,
											'4',-1,
											'5',1,
											'6',-1,1) * NVL(a.INCSUB_CNT,0)) ASSET_CNT,
									Sum(Decode(a.INCREDU_CLS,
											'1',1,
											'2',-1,
											'3',-1,
											'4',-1,
											'5',1,
											'6',-1,1) * NVL(a.INCSUB_AMT,0)) CHG_AMT,
									Sum(Decode(a.INCREDU_CLS,
											'1',1,
											'5',1,0) * NVL(a.INCSUB_AMT,0)) INC_AMT,
									Sum(Decode(a.INCREDU_CLS,
											'2',1,
											'3',1,
											'4',1,
											'6',1,0) * NVL(a.INCSUB_AMT,0)) SUB_AMT,
									Sum(a.APPROP_SUBAMT) APPROP_SUBAMT
								From	T_FIX_INCREDU a ,
										T_FIX_SUM_TEMP b ,
										T_FIX_DEPREC_CAL_TEMP d
								Where	a.FIX_ASSET_SEQ = b.FIX_ASSET_SEQ
								And		b.WORK_SEQ = d.WORK_SEQ
								And		b.WORK_SEQ = AR_WORK_SEQ
								And		a.INCREDU_DT between d.WORK_FROM_DT	And	d.WORK_TO_DT
								Group By
									a.FIX_ASSET_SEQ
							) x
					Where	a.SRVLIFE = c.SRVLIFE (+)
					And		a.FIX_ASSET_SEQ = x.FIX_ASSET_SEQ (+)
					And		a.FIX_ASSET_SEQ = b.FIX_ASSET_SEQ
					And		b.WORK_SEQ = d.WORK_SEQ
					And		b.WORK_SEQ = AR_WORK_SEQ
				) y
		) s
		On
		(
				s.FIX_ASSET_SEQ = t.FIX_ASSET_SEQ
			And	s.WORK_SEQ = t.WORK_SEQ
		)
		When Matched Then
		Update
		Set
			t.MODUSERNO = s.MODUSERNO ,
			t.MODDATE = s.MODDATE ,
			t.SUM_CNT = Nvl(s.SUM_CNT,0) ,
			t.START_ASSET_AMT = Nvl(s.START_ASSET_AMT,0) ,
			t.CURR_ASSET_INC_AMT = Nvl(s.CURR_ASSET_INC_AMT,0) ,
			t.CURR_ASSET_SUB_AMT = Nvl(s.CURR_ASSET_SUB_AMT,0) ,
			t.START_APPROP_AMT = Nvl(s.START_APPROP_AMT,0) ,
			t.CURR_APPROP_SUB_AMT = Nvl(s.CURR_APPROP_SUB_AMT,0) ,
			t.CURR_DEPREC_AMT = Nvl(s.CURR_DEPREC_AMT,0) ,
			t.DEPREC_RAT = Nvl(s.DEPREC_RAT,0) ,
			t.BEFORE_WORK_SEQ = s.BEFORE_WORK_SEQ ,
			t.BEFORE_BASE_AMT = Nvl(s.BEFORE_BASE_AMT,0) ,
			t.BEFORE_OLD_DEPREC_AMT = Nvl(s.BEFORE_OLD_DEPREC_AMT,0) ,
			t.BEFORE_DEPREC_FINISH = s.BEFORE_DEPREC_FINISH ,
			t.BEFORE_INC_SUM_AMT = Nvl(s.BEFORE_INC_SUM_AMT,0) ,
			t.BEFORE_SUB_SUM_AMT = Nvl(s.BEFORE_SUB_SUM_AMT,0) ,
			t.BASE_AMT = Nvl(s.BASE_AMT,0) ,
			t.OLD_DEPREC_AMT = Nvl(s.OLD_DEPREC_AMT,0) ,
			t.DEPREC_FINISH = s.DEPREC_FINISH ,
			t.INC_SUM_AMT = Nvl(s.INC_SUM_AMT,0) ,
			t.SUB_SUM_AMT = Nvl(s.SUB_SUM_AMT,0),
			t.BEFORE_ASSET_CNT =  Nvl(s.BEFORE_ASSET_CNT,0)
		When Not Matched Then
		Insert
		(
			FIX_ASSET_SEQ,
			WORK_SEQ,
			CRTUSERNO,
			CRTDATE,
			SUM_CNT,
			START_ASSET_AMT,
			CURR_ASSET_INC_AMT,
			CURR_ASSET_SUB_AMT,
			START_APPROP_AMT,
			CURR_APPROP_SUB_AMT,
			CURR_DEPREC_AMT,
			DEPREC_RAT,
			BEFORE_WORK_SEQ,
			BEFORE_BASE_AMT,
			BEFORE_OLD_DEPREC_AMT,
			BEFORE_DEPREC_FINISH,
			BEFORE_INC_SUM_AMT,
			BEFORE_SUB_SUM_AMT,
			BASE_AMT,
			OLD_DEPREC_AMT,
			DEPREC_FINISH,
			INC_SUM_AMT,
			SUB_SUM_AMT,
			BEFORE_ASSET_CNT
		)
		values
		(
			s.FIX_ASSET_SEQ,
			s.WORK_SEQ,
			s.MODUSERNO,
			s.MODDATE,
			Nvl(s.SUM_CNT,0),
			Nvl(s.START_ASSET_AMT,0),
			Nvl(s.CURR_ASSET_INC_AMT,0),
			Nvl(s.CURR_ASSET_SUB_AMT,0),
			Nvl(s.START_APPROP_AMT,0),
			Nvl(s.CURR_APPROP_SUB_AMT,0),
			Nvl(s.CURR_DEPREC_AMT,0),
			Nvl(s.DEPREC_RAT,0),
			s.BEFORE_WORK_SEQ,
			Nvl(s.BEFORE_BASE_AMT,0),
			Nvl(s.BEFORE_OLD_DEPREC_AMT,0),
			s.BEFORE_DEPREC_FINISH,
			Nvl(s.BEFORE_INC_SUM_AMT,0),
			Nvl(s.BEFORE_SUB_SUM_AMT,0),
			Nvl(s.BASE_AMT,0),
			Nvl(s.OLD_DEPREC_AMT,0),
			s.DEPREC_FINISH,
			Nvl(s.INC_SUM_AMT,0),
			Nvl(s.SUB_SUM_AMT,0),
			Nvl(s.BEFORE_ASSET_CNT,0) 
		);
		
		--부서별상각액처리 추가 - 월
		Merge Into T_FIX_FURNI_SUM t
		Using
		(
			Select
				y.FIX_ASSET_SEQ,
				y.WORK_SEQ ,
				y.DEPT_CODE,
				y.WORK_FROM_DT SUM_DT_FROM,
				0 MODUSERNO,
				null MODDATE,
				y.WORK_TO_DT SUM_DT_TO,
				case
					When y.DEPREC_CLS = '2' And ((Nvl(y.BEFORE_BASE_AMT,0) - Nvl(y.DEPREC_AMT,0) < 1000) Or
							(Nvl(Nvl(y.BEFORE_BASE_AMT,0) / nullif(y.START_ASSET_AMT,0),0) < 0.05)) Then
						y.BEFORE_BASE_AMT - 1000
					When Nvl(y.BEFORE_BASE_AMT,0) - Nvl(y.DEPREC_AMT,0) < 0 Then
						y.BEFORE_BASE_AMT
					Else
						y.DEPREC_AMT
				End DEPREC_AMT
				--to_number(DEPREC_AMT) DEPREC_AMT --여기까지
				
			From
				(
					Select
						a.FIX_ASSET_SEQ ,
						d.WORK_SEQ,
						a.DEPREC_CLS , 
							Round(1* ( Nvl(a.GET_COST_AMT,0) + Nvl(a.INC_SUM_AMT,0) - Nvl(a.SUB_SUM_AMT,0) + Nvl(x.CHG_AMT,0))
							* (Decode(a.DEPREC_CLS,'1',c.DEPREC_AMT,'2',c.DEPREC_RAT5) / 12 )) DEPREC_AMT,
								
						a.BASE_AMT BEFORE_BASE_AMT,
						decode(To_Char(a.GET_DT, 'yyyy'),To_Char(d.WORK_FROM_DT,'yyyy'),0,
							   Nvl(a.GET_COST_AMT,0) + Nvl(a.INC_SUM_AMT,0) - Nvl(a.SUB_SUM_AMT,0)) + Nvl(x.CHG_AMT,0) START_ASSET_AMT1 ,
						       decode(To_Char(a.GET_DT, 'yyyy'),To_Char(d.WORK_FROM_DT,'yyyy'),
							   Nvl(a.GET_COST_AMT,0) + Nvl(a.INC_SUM_AMT,0) - Nvl(a.SUB_SUM_AMT,0),0)  + Nvl(x.CHG_AMT,0) START_ASSET_AMT2 ,
							   Nvl(a.GET_COST_AMT,0) + Nvl(a.INC_SUM_AMT,0) - Nvl(a.SUB_SUM_AMT,0) + Nvl(x.CHG_AMT,0) START_ASSET_AMT ,
						a.ASSET_CNT,
					    e.DEPT_CODE,
						e.WORK_FROM_DT,
						e.WORK_TO_DT
					From	T_FIX_SHEET_TEMP a ,
							T_FIX_SUM_TEMP b ,
							T_FIX_DEPREC_RAT c ,
							T_FIX_DEPREC_CAL_TEMP d,
							(
							    select  
										c.work_seq,
										a.fix_asset_seq,
										b.dept_code,
										work_from_dt,
										work_to_dt,
										b.move_seq,
										b.move_dt_from,
										b.move_dt_to
								from    T_FIX_SHEET_TEMP a,
										(select
												a.fix_asset_seq,
												a.dept_code,
												max(move_seq) move_seq,
												max(move_dt_from)  move_dt_from,
												max(move_dt_to)  move_dt_to
										 from t_fix_move a
										 group by 
												 a.fix_asset_seq,
												 a.dept_code) b,
										T_FIX_DEPREC_CAL_TEMP c,
										T_FIX_SUM_TEMP d
										where	a.fix_asset_seq =  b.fix_asset_seq
										and		a.fix_asset_seq =  d.fix_asset_seq
										and		c.work_seq = d.work_seq
										--and		move_dt_from >= work_from_dt   
										and     (move_dt_to <= work_to_dt or move_dt_from >= work_from_dt)
										and	    c.WORK_SEQ = AR_WORK_SEQ
							) e,
							(
								Select
									a.FIX_ASSET_SEQ ,
									Sum(Decode(a.INCREDU_CLS,
											'1',1,
											'2',-1,
											'3',-1,
											'4',-1,
											'5',1,
											'6',-1,1) * NVL(a.INCSUB_CNT,0)) ASSET_CNT,
									Sum(Decode(a.INCREDU_CLS,
											'1',1,
											'2',-1,
											'3',-1,
											'4',-1,
											'5',1,
											'6',-1,1) * NVL(a.INCSUB_AMT,0)) CHG_AMT,
									Sum(Decode(a.INCREDU_CLS,
											'1',1,
											'5',1,0) * NVL(a.INCSUB_AMT,0)) INC_AMT,
									Sum(Decode(a.INCREDU_CLS,
											'2',1,
											'3',1,
											'4',1,
											'6',1,0) * NVL(a.INCSUB_AMT,0)) SUB_AMT,
									Sum(a.APPROP_SUBAMT) APPROP_SUBAMT
								From	T_FIX_INCREDU a ,
										T_FIX_SUM_TEMP b ,
										T_FIX_DEPREC_CAL_TEMP d
								Where	a.FIX_ASSET_SEQ = b.FIX_ASSET_SEQ
								And		b.WORK_SEQ = d.WORK_SEQ
								And		b.WORK_SEQ = AR_WORK_SEQ
								And		a.INCREDU_DT between d.WORK_FROM_DT	And	d.WORK_TO_DT
								Group By
									a.FIX_ASSET_SEQ
							) x
					Where	a.SRVLIFE = c.SRVLIFE (+)
					And		a.FIX_ASSET_SEQ = x.FIX_ASSET_SEQ (+)
					And		a.FIX_ASSET_SEQ = b.FIX_ASSET_SEQ
					And		b.WORK_SEQ = d.WORK_SEQ
					And		b.WORK_SEQ = AR_WORK_SEQ
					And		a.FIX_ASSET_SEQ = e.FIX_ASSET_SEQ(+)
					Order by move_dt_from 
				) y
		) s
		On
		(
				s.FIX_ASSET_SEQ = t.FIX_ASSET_SEQ
			And	s.WORK_SEQ = t.WORK_SEQ
			And	s.DEPT_CODE = t.DEPT_CODE
			And	s.SUM_DT_FROM = t.SUM_DT_FROM
		)
		When Matched Then
		Update
		Set
			t.MODUSERNO = s.MODUSERNO ,
			t.MODDATE = s.MODDATE ,
			t.DEPREC_AMT = Nvl(s.DEPREC_AMT,0)
	
		When Not Matched Then
		Insert
		(
			FIX_ASSET_SEQ,
			WORK_SEQ,
			DEPT_CODE,
			SUM_DT_FROM,
			CRTUSERNO,
			CRTDATE,
			SUM_DT_TO,
			DEPREC_AMT

		)
		values
		(
			s.FIX_ASSET_SEQ,
			s.WORK_SEQ,
			s.DEPT_CODE,
			s.SUM_DT_FROM,
			s.MODUSERNO,
			s.MODDATE,
			s.SUM_DT_TO,
			Nvl(s.DEPREC_AMT,0)

		);
	Else
		-- 일상각
		Merge Into T_FIX_SUM_TEMP t
		Using
		(
			Select
				y.FIX_ASSET_SEQ ,
				y.WORK_SEQ ,
				Ar_MODUSERNO MODUSERNO,
				Sysdate MODDATE,
				y.SUM_CNT SUM_CNT,
				y.START_ASSET_AMT ,
				y.INC_AMT CURR_ASSET_INC_AMT,
				y.SUB_AMT CURR_ASSET_SUB_AMT,
				y.BEFORE_OLD_DEPREC_AMT START_APPROP_AMT,
				y.APPROP_SUBAMT CURR_APPROP_SUB_AMT,
				case
					When y.DEPREC_CLS = '2' And ((Nvl(y.BEFORE_BASE_AMT,0) - Nvl(y.DEPREC_AMT,0) < 1000) Or
							(Nvl(Nvl(y.BEFORE_BASE_AMT,0) / nullif(y.START_ASSET_AMT,0),0) < 0.05)) Then
						y.BEFORE_BASE_AMT - 1000
					When Nvl(y.BEFORE_BASE_AMT,0) - Nvl(y.DEPREC_AMT,0) < 0 Then
						y.BEFORE_BASE_AMT
					Else
						y.DEPREC_AMT
				End CURR_DEPREC_AMT , -- 당기 상각액
				y.DEPREC_RAT,
				nvl(y.BEFORE_WORK_SEQ, AR_WORK_SEQ) BEFORE_WORK_SEQ,
				y.BEFORE_BASE_AMT ,
				y.BEFORE_OLD_DEPREC_AMT ,
				y.DEPREC_FINISH BEFORE_DEPREC_FINISH,
				y.BEFORE_INC_SUM_AMT ,
				y.BEFORE_SUB_SUM_AMT ,
				case
					When y.DEPREC_CLS = '2' And ((y.BEFORE_BASE_AMT - y.DEPREC_AMT < 1000) Or
							(Nvl(Nvl(y.BEFORE_BASE_AMT,0) / nullif(y.START_ASSET_AMT,0),0) < 0.05)) Then
						1000
					When Nvl(y.BEFORE_BASE_AMT,0) - Nvl(y.DEPREC_AMT,0) < 0 Then
						0
					Else
						Nvl(y.BEFORE_BASE_AMT,0) - Nvl(y.DEPREC_AMT,0)
				End BASE_AMT, --장부가액
				Nvl(y.BEFORE_OLD_DEPREC_AMT,0) +
				(case
					When y.DEPREC_CLS = '2' And ((Nvl(y.BEFORE_BASE_AMT,0) - Nvl(y.DEPREC_AMT,0) < 1000) Or
							(Nvl(Nvl(y.BEFORE_BASE_AMT,0) / nullif(y.START_ASSET_AMT,0),0) < 0.05)) Then
						y.BEFORE_BASE_AMT - 1000
					When Nvl(y.BEFORE_BASE_AMT,0) - Nvl(y.DEPREC_AMT,0) < 0 Then
						y.BEFORE_BASE_AMT
					Else
						y.DEPREC_AMT
				End) OLD_DEPREC_AMT,
				case
					When y.DEPREC_CLS = '2' And ((y.BEFORE_BASE_AMT - y.DEPREC_AMT < 1000) Or
							(Nvl(Nvl(y.BEFORE_BASE_AMT,0) / nullif(y.START_ASSET_AMT,0),0) < 0.05)) Then
						'2'
					When Nvl(y.BEFORE_BASE_AMT,0) - Nvl(y.DEPREC_AMT,0) < 0 Then
						'2'
					Else
						'1'
				End DEPREC_FINISH,
				Nvl(y.BEFORE_INC_SUM_AMT,0) + Nvl(y.INC_AMT,0) INC_SUM_AMT,
				Nvl(y.BEFORE_SUB_SUM_AMT,0) + Nvl(y.SUB_AMT,0) SUB_SUM_AMT,
				y.ASSET_CNT BEFORE_ASSET_CNT
			From
				(
					Select
						a.FIX_ASSET_SEQ ,
						d.WORK_SEQ,
						a.DEPREC_CLS ,
						a.GET_DT ,
						Nvl(a.ASSET_CNT,0) +  Nvl(x.ASSET_CNT,0) SUM_CNT,
						Nvl(a.GET_COST_AMT,0) + Nvl(a.INC_SUM_AMT,0) - Nvl(a.SUB_SUM_AMT,0) REAL_START_AMT,
						x.INC_AMT,
						x.SUB_AMT,
						x.CHG_AMT,
						a.OLD_DEPREC_AMT BEFORE_OLD_DEPREC_AMT,
						a.DEPREC_FINISH,
						x.APPROP_SUBAMT,
						(ROUND(( d.WORK_TO_DT - Decode(To_Char(a.GET_DT,'YYYY'),To_Char(d.WORK_TO_DT,'YYYY'),a.GET_DT, Trunc(d.WORK_TO_DT,'YYYY') ))
						 * (Nvl(a.GET_COST_AMT,0) + Nvl(a.INC_SUM_AMT,0) - Nvl(a.SUB_SUM_AMT,0) + Nvl(x.CHG_AMT,0))
							* Decode(a.DEPREC_CLS,'1',c.DEPREC_AMT,'2',c.DEPREC_RAT5) / 365 ))  DEPREC_AMT,
						Decode(a.DEPREC_CLS,'1',c.DEPREC_AMT,'2',c.DEPREC_RAT5) DEPREC_RAT,
						a.WORK_SEQ BEFORE_WORK_SEQ,
						a.BASE_AMT BEFORE_BASE_AMT,
						a.INC_SUM_AMT BEFORE_INC_SUM_AMT,
						a.SUB_SUM_AMT BEFORE_SUB_SUM_AMT,
						decode(To_Char(a.GET_DT, 'yyyy'),To_Char(d.WORK_FROM_DT,'yyyy'),0,
						Nvl(a.GET_COST_AMT,0) + Nvl(a.INC_SUM_AMT,0) - Nvl(a.SUB_SUM_AMT,0)) + Nvl(x.CHG_AMT,0) START_ASSET_AMT1 ,
						decode(To_Char(a.GET_DT, 'yyyy'),To_Char(d.WORK_FROM_DT,'yyyy'),
						Nvl(a.GET_COST_AMT,0) + Nvl(a.INC_SUM_AMT,0) - Nvl(a.SUB_SUM_AMT,0),0)  + Nvl(x.CHG_AMT,0) START_ASSET_AMT2 ,
						Nvl(a.GET_COST_AMT,0) + Nvl(a.INC_SUM_AMT,0) - Nvl(a.SUB_SUM_AMT,0) + Nvl(x.CHG_AMT,0) START_ASSET_AMT ,
						a.ASSET_CNT
					From	T_FIX_SHEET_TEMP a ,
							T_FIX_SUM_TEMP b ,
							T_FIX_DEPREC_RAT c ,
							T_FIX_DEPREC_CAL_TEMP d,
							(
								Select
									a.FIX_ASSET_SEQ ,
									Sum(Decode(a.INCREDU_CLS,
											'1',1,
											'2',-1,
											'3',-1,
											'4',-1,
											'5',1,
											'6',-1,1) * NVL(a.INCSUB_CNT,0)) ASSET_CNT,
									Sum(Decode(a.INCREDU_CLS,
											'1',1,
											'2',-1,
											'3',-1,
											'4',-1,
											'5',1,
											'6',-1,1) * NVL(a.INCSUB_AMT,0)) CHG_AMT,
									Sum(Decode(a.INCREDU_CLS,
											'1',1,
											'5',1,0) * NVL(a.INCSUB_AMT,0)) INC_AMT,
									Sum(Decode(a.INCREDU_CLS,
											'2',1,
											'3',1,
											'4',1,
											'6',1,0) * NVL(a.INCSUB_AMT,0)) SUB_AMT,
									Sum(a.APPROP_SUBAMT) APPROP_SUBAMT
								From	T_FIX_INCREDU a ,
										T_FIX_SUM_TEMP b ,
										T_FIX_DEPREC_CAL_TEMP d
								Where	a.FIX_ASSET_SEQ = b.FIX_ASSET_SEQ
								And		b.WORK_SEQ = d.WORK_SEQ
								And		b.WORK_SEQ = AR_WORK_SEQ
								And		a.INCREDU_DT between d.WORK_FROM_DT	And	d.WORK_TO_DT
								Group By
									a.FIX_ASSET_SEQ
							) x
					Where	a.SRVLIFE = c.SRVLIFE (+)
					And		a.FIX_ASSET_SEQ = x.FIX_ASSET_SEQ (+)
					And		a.FIX_ASSET_SEQ = b.FIX_ASSET_SEQ
					And		b.WORK_SEQ = d.WORK_SEQ
					And		b.WORK_SEQ = AR_WORK_SEQ
				) y
		) s
		On
		(
				s.FIX_ASSET_SEQ = t.FIX_ASSET_SEQ
			And	s.WORK_SEQ = t.WORK_SEQ
		)
		When Matched Then
		Update
		Set
			t.MODUSERNO = s.MODUSERNO ,
			t.MODDATE = s.MODDATE ,
			t.SUM_CNT = Nvl(s.SUM_CNT,0) ,
			t.START_ASSET_AMT = Nvl(s.START_ASSET_AMT,0) ,
			t.CURR_ASSET_INC_AMT = Nvl(s.CURR_ASSET_INC_AMT,0) ,
			t.CURR_ASSET_SUB_AMT = Nvl(s.CURR_ASSET_SUB_AMT,0) ,
			t.START_APPROP_AMT = Nvl(s.START_APPROP_AMT,0) ,
			t.CURR_APPROP_SUB_AMT = Nvl(s.CURR_APPROP_SUB_AMT,0) ,
			t.CURR_DEPREC_AMT = Nvl(s.CURR_DEPREC_AMT,0) ,
			t.DEPREC_RAT = Nvl(s.DEPREC_RAT,0) ,
			t.BEFORE_WORK_SEQ = s.BEFORE_WORK_SEQ ,
			t.BEFORE_BASE_AMT = Nvl(s.BEFORE_BASE_AMT,0) ,
			t.BEFORE_OLD_DEPREC_AMT = Nvl(s.BEFORE_OLD_DEPREC_AMT,0) ,
			t.BEFORE_DEPREC_FINISH = s.BEFORE_DEPREC_FINISH ,
			t.BEFORE_INC_SUM_AMT = Nvl(s.BEFORE_INC_SUM_AMT,0) ,
			t.BEFORE_SUB_SUM_AMT = Nvl(s.BEFORE_SUB_SUM_AMT,0) ,
			t.BASE_AMT = Nvl(s.BASE_AMT,0) ,
			t.OLD_DEPREC_AMT = Nvl(s.OLD_DEPREC_AMT,0) ,
			t.DEPREC_FINISH = s.DEPREC_FINISH ,
			t.INC_SUM_AMT = Nvl(s.INC_SUM_AMT,0) ,
			t.SUB_SUM_AMT = Nvl(s.SUB_SUM_AMT,0) 
		When Not Matched Then
		Insert
		(
			FIX_ASSET_SEQ,
			WORK_SEQ,
			CRTUSERNO,
			CRTDATE,
			SUM_CNT,
			START_ASSET_AMT,
			CURR_ASSET_INC_AMT,
			CURR_ASSET_SUB_AMT,
			START_APPROP_AMT,
			CURR_APPROP_SUB_AMT,
			CURR_DEPREC_AMT,
			DEPREC_RAT,
			BEFORE_WORK_SEQ,
			BEFORE_BASE_AMT,
			BEFORE_OLD_DEPREC_AMT,
			BEFORE_DEPREC_FINISH,
			BEFORE_INC_SUM_AMT,
			BEFORE_SUB_SUM_AMT,
			BASE_AMT,
			OLD_DEPREC_AMT,
			DEPREC_FINISH,
			INC_SUM_AMT,
			SUB_SUM_AMT 
		)
		values
		(
			s.FIX_ASSET_SEQ,
			s.WORK_SEQ,
			s.MODUSERNO,
			s.MODDATE,
			Nvl(s.SUM_CNT,0),
			Nvl(s.START_ASSET_AMT,0),
			Nvl(s.CURR_ASSET_INC_AMT,0),
			Nvl(s.CURR_ASSET_SUB_AMT,0),
			Nvl(s.START_APPROP_AMT,0),
			Nvl(s.CURR_APPROP_SUB_AMT,0),
			Nvl(s.CURR_DEPREC_AMT,0),
			Nvl(s.DEPREC_RAT,0),
			s.BEFORE_WORK_SEQ,
			Nvl(s.BEFORE_BASE_AMT,0),
			Nvl(s.BEFORE_OLD_DEPREC_AMT,0),
			s.BEFORE_DEPREC_FINISH,
			Nvl(s.BEFORE_INC_SUM_AMT,0),
			Nvl(s.BEFORE_SUB_SUM_AMT,0),
			Nvl(s.BASE_AMT,0),
			Nvl(s.OLD_DEPREC_AMT,0),
			s.DEPREC_FINISH,
			Nvl(s.INC_SUM_AMT,0),
			Nvl(s.SUB_SUM_AMT,0) 
		);
		
		--부서별상각액 계산
		Merge Into T_FIX_FURNI_SUM t
		Using
		(
			Select
				y.FIX_ASSET_SEQ ,
				y.WORK_SEQ ,
				y.DEPT_CODE,
				y.MOVE_DT_FROM SUM_DT_FROM,
				Ar_MODUSERNO MODUSERNO,
				Sysdate MODDATE,
				y.MOVE_DT_TO SUM_DT_TO,
				--case
					--When --y.DEPREC_CLS = '2' And ((Nvl(y.BEFORE_BASE_AMT,0) - Nvl(y.DEPREC_AMT,0) < 1000) Or
							--(Nvl(Nvl(y.BEFORE_BASE_AMT,0) / nullif(y.START_ASSET_AMT,0),0) < 0.05)) Then
						--y.BEFORE_BASE_AMT - 1000
					--When Nvl(y.BEFORE_BASE_AMT,0) - Nvl(y.DEPREC_AMT,0) < 0 Then
						--y.BEFORE_BASE_AMT
					--Else
						--y.DEPREC_AMT
				--End 
				DEPREC_AMT
			From
				(
					Select
						a.FIX_ASSET_SEQ ,
						d.WORK_SEQ,
						a.DEPREC_CLS ,
						 (ROUND(Decode(To_Char(e.move_dt_from,'YYYYMM'),To_Char(d.WORK_TO_DT,'YYYYMM'),d.WORK_TO_DT - e.move_dt_from, lead(e.move_dt_from) over (order by e.move_dt_from) - e.move_dt_from) 
						 * (Nvl(a.GET_COST_AMT,0) + Nvl(a.INC_SUM_AMT,0) - Nvl(a.SUB_SUM_AMT,0) + Nvl(x.CHG_AMT,0))
							* Decode(a.DEPREC_CLS,'1',c.DEPREC_AMT,'2',c.DEPREC_RAT5) / 365 ))  DEPREC_AMT,
	
						e.DEPT_CODE,
						e.MOVE_DT_FROM,
						e.MOVE_DT_TO,
						add_months(d.WORK_TO_DT,-1)
					From	T_FIX_SHEET_TEMP a ,
							T_FIX_SUM_TEMP b ,
							T_FIX_DEPREC_RAT c ,
							T_FIX_DEPREC_CAL_TEMP d,
							--배치현황 
							(
							    select
									  b.work_seq,
									  a.fix_asset_seq,
									  move_dt_from,
									  MOVE_DT_TO,
								      dept_code
								from
									(
									select fix_asset_seq,
										   move_dt_from,
										   MOVE_DT_TO,
										   dept_code
									from t_fix_move a
									where (fix_asset_seq, to_char(a.move_dt_from, 'YYYYMM'), move_seq) 
										  in
											(
											select  
													b.fix_asset_seq,
													to_char(c.move_dt_from, 'YYYYMM') move_dt_from,
													max(c.move_seq) move_seq
											from    T_FIX_DEPREC_CAL_TEMP a,
													T_FIX_SUM_TEMP b,
													t_fix_move c,
													T_FIX_SHEET_TEMP d
											where   a.work_seq = b.work_seq
											and		b.fix_asset_seq =  d.fix_asset_seq
											and	    b.fix_asset_seq =  c.fix_asset_seq
											and		move_dt_from   <=  work_to_dt
											or		move_dt_from   >=  work_from_dt
											and	    a.WORK_SEQ      =  AR_WORK_SEQ
											group by 
												  	 b.fix_asset_seq,
												  	 to_char(c.move_dt_from, 'YYYYMM')
											)
									) a,
									T_FIX_DEPREC_CAL_TEMP b,
									T_FIX_SUM_TEMP c
								where   b.work_seq = c.work_seq
								and		a.fix_asset_seq =  c.fix_asset_seq
							) e,
							(
								Select
									a.FIX_ASSET_SEQ ,
									Sum(Decode(a.INCREDU_CLS,
											'1',1,
											'2',-1,
											'3',-1,
											'4',-1,
											'5',1,
											'6',-1,1) * NVL(a.INCSUB_CNT,0)) ASSET_CNT,
									Sum(Decode(a.INCREDU_CLS,
											'1',1,
											'2',-1,
											'3',-1,
											'4',-1,
											'5',1,
											'6',-1,1) * NVL(a.INCSUB_AMT,0)) CHG_AMT,
									Sum(Decode(a.INCREDU_CLS,
											'1',1,
											'5',1,0) * NVL(a.INCSUB_AMT,0)) INC_AMT,
									Sum(Decode(a.INCREDU_CLS,
											'2',1,
											'3',1,
											'4',1,
											'6',1,0) * NVL(a.INCSUB_AMT,0)) SUB_AMT,
									Sum(a.APPROP_SUBAMT) APPROP_SUBAMT
								From	T_FIX_INCREDU a ,
										T_FIX_SUM_TEMP b ,
										T_FIX_DEPREC_CAL_TEMP d
								Where	a.FIX_ASSET_SEQ = b.FIX_ASSET_SEQ
								And		b.WORK_SEQ = d.WORK_SEQ
								And		b.WORK_SEQ = AR_WORK_SEQ
								And		a.INCREDU_DT between d.WORK_FROM_DT	And	d.WORK_TO_DT
								Group By
									a.FIX_ASSET_SEQ
							) x
					Where	a.SRVLIFE = c.SRVLIFE (+)
					And		a.FIX_ASSET_SEQ = x.FIX_ASSET_SEQ (+)
					And		a.FIX_ASSET_SEQ = b.FIX_ASSET_SEQ
					And		b.WORK_SEQ = d.WORK_SEQ
					And		b.WORK_SEQ = AR_WORK_SEQ
					--And		b.WORK_SEQ = e.WORK_SEQ --여기까지 작업
					And		a.FIX_ASSET_SEQ = e.FIX_ASSET_SEQ(+)
					Order by move_dt_from 
				) y
		) s
		On
		(
				s.FIX_ASSET_SEQ = t.FIX_ASSET_SEQ
			And	s.WORK_SEQ  = t.WORK_SEQ
			And	s.DEPT_CODE = t.DEPT_CODE
			And	s.SUM_DT_FROM = t.SUM_DT_FROM
		)
		When Matched Then
		Update
		Set
			t.MODUSERNO = s.MODUSERNO ,
			t.MODDATE = s.MODDATE ,
			t.DEPREC_AMT = Nvl(s.DEPREC_AMT,0)
		When Not Matched Then
		Insert
		(
			FIX_ASSET_SEQ,
			WORK_SEQ,
			DEPT_CODE,
			SUM_DT_FROM,
			CRTUSERNO,
			CRTDATE,
			SUM_DT_TO,
			DEPREC_AMT

		)
		values
		(
			s.FIX_ASSET_SEQ,
			s.WORK_SEQ,
			s.DEPT_CODE,
			s.SUM_DT_FROM,
			s.MODUSERNO,
			s.MODDATE,
			s.SUM_DT_TO,
			Nvl(s.DEPREC_AMT,0)

		);
	End If;
End;
/

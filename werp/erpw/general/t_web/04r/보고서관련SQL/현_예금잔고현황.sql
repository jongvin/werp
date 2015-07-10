--현금 및 예금 잔고 현황
Select 
	1 SEQ, 
	a.MAKE_COMP_CODE , 
	a.ACC_CODE, 
	'현      금'ACC_NAME, 
	'' ACC_REMAIN_POSITION, 
	'' MNG_ITEM, 
	'' BANK_CODE, 
	'현      금' ACCT_NAME, 
	Sum( 
		Case 
			When a.MAKE_DT <   :MAKE_DT_F   Then 
				Nvl(a.DB_AMT,0) - Nvl(a.CR_AMT,0) 
			Else 
				0 
		End 
	) PRE_REMAIN_AMT, 
	Sum( 
		Case 
			When a.MAKE_DT >=   :MAKE_DT_F   Then 
				Nvl(a.DB_AMT,0) 
			Else 
				0 
		End 
	) SET_AMT, 
	Sum( 
		Case 
			When a.MAKE_DT >=   :MAKE_DT_F   Then 
				Nvl(a.CR_AMT,0) 
			Else 
				0 
		End 
	) RESET_AMT, 
	Nvl(Sum(a.DB_AMT),0) - Nvl(Sum(a.CR_AMT),0) REMAIN_AMT, 
	''  BANK_NAME 
From	T_ACC_SLIP_BODY1 a 
Where	a.MAKE_COMP_CODE = 	 :MAKE_COMP_CODE
And		a.MAKE_DT <=    :MAKE_DT_T
And		a.KEEP_DT Is Not Null  
And		a.TRANSFER_TAG ='F' 
And		a.ACC_CODE In ( Select	b.CODE_LIST_ID	From	V_T_CODE_LIST b	Where	b.CODE_GROUP_ID = 'CASH_ACC_CODE') 
Group By 
	a.MAKE_COMP_CODE , 
	a.ACC_CODE 
Union All 
Select 
	2 SEQ, 
	a.MAKE_COMP_CODE , 
	a.ACC_CODE, 
	a.ACC_NAME, 
	a.ACC_REMAIN_POSITION, 
	a.MNG_ITEM, 
	a.BANK_CODE, 
	b1.ACCT_NAME, 
	Decode(a.ACC_REMAIN_POSITION,'D',Nvl(Sum(a.DB_AMT_PRE),0) - Nvl(Sum(a.CR_AMT_PRE),0), 
			Nvl(Sum(a.CR_AMT_PRE),0) - Nvl(Sum(a.DB_AMT_PRE),0) ) PRE_REMAIN_AMT, 
	Decode(a.ACC_REMAIN_POSITION,'D',Nvl(Sum(a.DB_AMT),0), 
			Nvl(Sum(a.CR_AMT),0)) SET_AMT, 
	Decode(a.ACC_REMAIN_POSITION,'D',Nvl(Sum(a.CR_AMT),0), 
			Nvl(Sum(a.DB_AMT),0)) RESET_AMT, 
	Decode(a.ACC_REMAIN_POSITION,'D',Nvl(Sum(a.DB_AMT_PRE),0) - Nvl(Sum(a.CR_AMT_PRE),0) + Nvl(Sum(a.DB_AMT),0) - Nvl(Sum(a.CR_AMT),0) , 
			Nvl(Sum(a.CR_AMT_PRE),0) - Nvl(Sum(a.DB_AMT_PRE),0) +Nvl(Sum(a.CR_AMT),0) - Nvl(Sum(a.DB_AMT),0) ) REMAIN_AMT , 
	b.BANK_NAME 
From 
	( 
		Select 
			c.MAKE_COMP_CODE, 
			a.ACC_CODE, 
			a.ACC_NAME, 
			a.ACC_REMAIN_POSITION, 
			c.ACCNO MNG_ITEM, 
			c.BANK_CODE, 
			Sum( 
				Case When c.MAKE_DT <  :MAKE_DT_F   Then 
						c.DB_AMT 
					Else 
						0 
				End 
			) DB_AMT_PRE, 
			Sum( 
				Case When c.MAKE_DT <   :MAKE_DT_F   Then 
						c.CR_AMT 
					Else 
						0 
				End 
			) CR_AMT_PRE, 
			Sum( 
				Case When c.MAKE_DT >=   :MAKE_DT_F   Then 
						c.DB_AMT 
					Else 
						0 
				End 
			) DB_AMT, 
			Sum( 
				Case When c.MAKE_DT >=   :MAKE_DT_F   Then 
						c.CR_AMT 
					Else 
						0 
				End 
			) CR_AMT 
		From	T_ACC_CODE a, 
				T_ACC_SLIP_BODY1 c 
		Where	a.ACCNO_MNG = 'T' 
		And		a.FUND_INPUT_CLS = 'T' 
		And		a.ACC_CODE = c.ACC_CODE 
		And		c.MAKE_COMP_CODE =  :MAKE_COMP_CODE
		And		c.KEEP_DT Is Not Null  
		And		c.MAKE_DT <=  :MAKE_DT_T
		And		a.ACC_CODE In ( Select	b.CODE_LIST_ID	From	V_T_CODE_LIST b	Where	b.CODE_GROUP_ID = 'SAVING_ACC_CODE') 
		And		c.TRANSFER_TAG ='F' 
		Group By 
			c.MAKE_COMP_CODE, 
			a.ACC_CODE, 
			a.ACC_NAME, 
			a.ACC_REMAIN_POSITION, 
			c.BANK_CODE , 
			c.ACCNO 
	) a, 
	T_BANK_CODE b, 
	T_ACCNO_CODE b1, 
	t_company_org c 
Where	a.MAKE_COMP_CODE = c.COMP_CODE 
And		a.MNG_ITEM = b1.ACCNO 
And		b1.BANK_CODE = b.BANK_CODE 
Having	Decode(a.ACC_REMAIN_POSITION,'D',Nvl(Sum(a.DB_AMT_PRE),0) - Nvl(Sum(a.CR_AMT_PRE),0), 
			Nvl(Sum(a.CR_AMT_PRE),0) - Nvl(Sum(a.DB_AMT_PRE),0) ) <> 0 
Or		Decode(a.ACC_REMAIN_POSITION,'D',Nvl(Sum(a.DB_AMT),0), 
			Nvl(Sum(a.CR_AMT),0)) <> 0 
Or		Decode(a.ACC_REMAIN_POSITION,'D',Nvl(Sum(a.CR_AMT),0), 
			Nvl(Sum(a.DB_AMT),0)) <> 0 
Or		Decode(a.ACC_REMAIN_POSITION,'D',Nvl(Sum(a.DB_AMT_PRE),0) - Nvl(Sum(a.CR_AMT_PRE),0) + Nvl(Sum(a.DB_AMT),0) - Nvl(Sum(a.CR_AMT),0) , 
			Nvl(Sum(a.CR_AMT_PRE),0) - Nvl(Sum(a.DB_AMT_PRE),0) +Nvl(Sum(a.CR_AMT),0) - Nvl(Sum(a.DB_AMT),0) ) <> 0 
Group By 
	a.MAKE_COMP_CODE, 
	a.ACC_CODE, 
	a.ACC_NAME, 
	a.ACC_REMAIN_POSITION, 
	a.MNG_ITEM, 
	a.BANK_CODE, 
	b1.ACCT_NAME, 
	b.BANK_NAME 
Order By 
	1, 
	2 , 
	3 , 
	7, 
	6 

--현금 잔고 화폐별 금액
Select 
	:MAKE_COMP_CODE  COMP_CODE , 
	F_T_DATETOSTRING(F_T_STRINGTODATE( :MAKE_DT_T )) WORK_DT , 
	a.CASH_CODE , 
	a.CASH_NAME, 
	b.CRTUSERNO , 
	b.CRTDATE , 
	b.MODUSERNO , 
	b.MODDATE , 
	a.UNIT_COST , 
	b.QTY , 
	b.AMT 
From	T_FIN_CASH_CODE a, 
		T_FIN_CASH_REMAIN b 
Where	a.CASH_CODE = b.CASH_CODE (+) 
And		b.COMP_CODE (+) = :MAKE_COMP_CODE
And		b.WORK_DT (+) = F_T_STRINGTODATE( :MAKE_DT_T ) 
Order By 
	a.UNIT_COST Desc 

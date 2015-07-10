CREATE OR REPLACE Procedure SP_T_BUDG_DEPT_CHG_CONFIRM_Y
(
	Ar_COMP_CODE					Varchar2,
	Ar_CLSE_ACC_ID					Varchar2,
	Ar_DEPT_CODE					Varchar2,
	Ar_CHG_SEQ						Number

)
Is
	Type T_ASSIGN_AMT Is Table Of T_BUDG_MONTH_REQ.BUDG_MONTH_ASSIGN_AMT%Type
		Index By Binary_Integer;
	Type T_BUDG_CODE_NO Is Table Of T_BUDG_MONTH_REQ.BUDG_CODE_NO%Type
		Index By Binary_Integer;
	Type T_RESERVED_SEQ Is Table Of T_BUDG_MONTH_REQ.RESERVED_SEQ%Type
		Index By Binary_Integer;
	Type T_BUDG_YM Is Table Of T_BUDG_MONTH_REQ.BUDG_YM%Type
		Index By Binary_Integer;
	Type T_R_BUDG_YM Is Table Of T_BUDG_MONTH_REQ.BUDG_YM%Type
		Index By Binary_Integer;
	Type T_REASON_CODE Is Table Of T_BUDG_MONTH_REQ.REASON_CODE%Type
		Index By Binary_Integer;
	Type T_CHG_AMT Is Table Of T_BUDG_MONTH_REQ.CHG_AMT%Type
		Index By Binary_Integer;
	Type T_R_CHG_AMT Is Table Of T_BUDG_MONTH_REQ.CHG_AMT%Type
		Index By Binary_Integer;
	lt_T_ASSIGN_AMT				T_ASSIGN_AMT;
	lt_T_BUDG_CODE_NO			T_BUDG_CODE_NO;
	lt_T_RESERVED_SEQ			T_RESERVED_SEQ;
	lt_T_BUDG_YM				T_BUDG_YM;
	lt_T_BUDG_CODE_NO2			T_BUDG_CODE_NO;
	lt_T_RESERVED_SEQ2			T_RESERVED_SEQ;
	lt_T_BUDG_YM2				T_BUDG_YM;
	lt_T_R_BUDG_YM				T_BUDG_YM;
	lt_T_REASON_CODE			T_REASON_CODE;
	lt_T_CHG_AMT				T_CHG_AMT;
	lt_T_R_CHG_AMT				T_R_CHG_AMT;
	liStart						Number;
	liEnd						Number;
	lkStart						Number;
	lkEnd						Number;
	lsErrm						Varchar2(2000);
	lnPrevChgSeq				Number;
Begin

	--SP_T_BUDG_CHK_CONFIRM_KIND_REQ(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_DEPT_CODE,  AR_CHG_SEQ );
	--먼저 기존 것 복사받은 후 처리한다.
	Begin
		Select
			Max(CHG_SEQ)
		Into
			lnPrevChgSeq
		From	T_BUDG_DEPT_H
		Where	COMP_CODE = Ar_COMP_CODE
		And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
		And		DEPT_CODE = Ar_DEPT_CODE
		And		CHG_SEQ < Ar_CHG_SEQ;
	Exception When No_Data_Found Then
		Null;
	End;
	If lnPrevChgSeq Is Not Null Then
		Merge Into T_BUDG_DEPT_ITEM_H t
		Using
		(
			Select
				COMP_CODE,
				CLSE_ACC_ID,
				DEPT_CODE,
				Ar_CHG_SEQ CHG_SEQ,
				BUDG_CODE_NO,
				RESERVED_SEQ,
				CRTUSERNO,
				CRTDATE,
				MODUSERNO,
				MODDATE,
				TARGET_DEPT_CODE,
				BUDG_ADD_AMT,
				BUDG_ITEM_REQ_AMT,
				BUDG_ITEM_ASSIGN_AMT,
				REMARKS
			From	T_BUDG_DEPT_ITEM_H
			Where	COMP_CODE = Ar_COMP_CODE
			And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
			And		DEPT_CODE = Ar_DEPT_CODE
			And		CHG_SEQ = lnPrevChgSeq
		) s
		On
		(
			s.COMP_CODE = t.COMP_CODE
		And	s.CLSE_ACC_ID = t.CLSE_ACC_ID
		And	s.DEPT_CODE = t.DEPT_CODE
		And	s.CHG_SEQ = t.CHG_SEQ
		And	s.BUDG_CODE_NO = t.BUDG_CODE_NO
		And	s.RESERVED_SEQ = t.RESERVED_SEQ
		)
		When Matched Then
		Update
		Set	t.TARGET_DEPT_CODE = s.TARGET_DEPT_CODE,
			t.BUDG_ADD_AMT = s.BUDG_ADD_AMT,
			t.BUDG_ITEM_REQ_AMT = s.BUDG_ITEM_REQ_AMT,
			t.BUDG_ITEM_ASSIGN_AMT = s.BUDG_ITEM_ASSIGN_AMT,
			t.REMARKS = s.REMARKS
		When Not Matched Then
		Insert
		(
			COMP_CODE,
			CLSE_ACC_ID,
			DEPT_CODE,
			CHG_SEQ,
			BUDG_CODE_NO,
			RESERVED_SEQ,
			CRTUSERNO,
			CRTDATE,
			MODUSERNO,
			MODDATE,
			TARGET_DEPT_CODE,
			BUDG_ADD_AMT,
			BUDG_ITEM_REQ_AMT,
			BUDG_ITEM_ASSIGN_AMT,
			REMARKS
		)
		Values
		(
			s.COMP_CODE,
			s.CLSE_ACC_ID,
			s.DEPT_CODE,
			s.CHG_SEQ,
			s.BUDG_CODE_NO,
			s.RESERVED_SEQ,
			s.CRTUSERNO,
			s.CRTDATE,
			s.MODUSERNO,
			s.MODDATE,
			s.TARGET_DEPT_CODE,
			s.BUDG_ADD_AMT,
			s.BUDG_ITEM_REQ_AMT,
			s.BUDG_ITEM_ASSIGN_AMT,
			s.REMARKS
		);
		Merge Into T_BUDG_MONTH_AMT_H t
		Using
		(
			Select
				COMP_CODE,
				CLSE_ACC_ID,
				DEPT_CODE,
				Ar_CHG_SEQ CHG_SEQ,
				BUDG_CODE_NO,
				RESERVED_SEQ,
				BUDG_YM,
				CRTUSERNO,
				CRTDATE,
				MODUSERNO,
				MODDATE,
				BUDG_MONTH_REQ_AMT,
				BUDG_MONTH_ASSIGN_AMT,
				REMARKS
			From	T_BUDG_MONTH_AMT_H
			Where	COMP_CODE = Ar_COMP_CODE
			And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
			And		DEPT_CODE = Ar_DEPT_CODE
			And		CHG_SEQ = lnPrevChgSeq
		) s
		On
		(
			s.COMP_CODE = t.COMP_CODE
		And	s.CLSE_ACC_ID = t.CLSE_ACC_ID
		And	s.DEPT_CODE = t.DEPT_CODE
		And	s.CHG_SEQ = t.CHG_SEQ
		And	s.BUDG_CODE_NO = t.BUDG_CODE_NO
		And	s.RESERVED_SEQ = t.RESERVED_SEQ
		And	s.BUDG_YM = t.BUDG_YM
		)
		When Matched Then
		Update
		Set	t.BUDG_MONTH_REQ_AMT = s.BUDG_MONTH_REQ_AMT,
			t.BUDG_MONTH_ASSIGN_AMT = s.BUDG_MONTH_ASSIGN_AMT,
			t.REMARKS = s.REMARKS
		When Not Matched Then
		Insert
		(
			COMP_CODE,
			CLSE_ACC_ID,
			DEPT_CODE,
			CHG_SEQ,
			BUDG_CODE_NO,
			RESERVED_SEQ,
			BUDG_YM,
			CRTUSERNO,
			CRTDATE,
			MODUSERNO,
			MODDATE,
			BUDG_MONTH_REQ_AMT,
			BUDG_MONTH_ASSIGN_AMT,
			REMARKS
		)
		Values
		(
			s.COMP_CODE,
			s.CLSE_ACC_ID,
			s.DEPT_CODE,
			s.CHG_SEQ,
			s.BUDG_CODE_NO,
			s.RESERVED_SEQ,
			s.BUDG_YM,
			s.CRTUSERNO,
			s.CRTDATE,
			s.MODUSERNO,
			s.MODDATE,
			s.BUDG_MONTH_REQ_AMT,
			s.BUDG_MONTH_ASSIGN_AMT,
			s.REMARKS
		);
		
	End If;
	Select
		BUDG_CODE_NO,
		RESERVED_SEQ,
		BUDG_YM,
		REASON_CODE,
		sum(BUDG_MONTH_ASSIGN_AMT),
		sum(CHG_AMT)
	Bulk Collect Into
		lt_T_BUDG_CODE_NO,
		lt_T_RESERVED_SEQ,
		lt_T_BUDG_YM,
		lt_T_REASON_CODE,
		lt_T_ASSIGN_AMT,
		lt_T_CHG_AMT
	From	T_BUDG_MONTH_REQ a
	Where (CONFIRM_KIND = '1' Or CONFIRM_KIND = '2')
	And	   a.COMP_CODE       = AR_COMP_CODE
	And     a.CLSE_ACC_ID     = AR_CLSE_ACC_ID
	And		a.DEPT_CODE       = AR_DEPT_CODE
	And		a.CHG_SEQ         = AR_CHG_SEQ
	group by
		  BUDG_CODE_NO,
		  RESERVED_SEQ,
		  BUDG_YM,
		  REASON_CODE;

	--차월이월시 차감되는 월의 금액을 구함
	Select
		b.BUDG_CODE_NO,
		b.RESERVED_SEQ,
		R_BUDG_YM,
		b.CHG_AMT
	Bulk Collect Into
		lt_T_BUDG_CODE_NO2,
		lt_T_RESERVED_SEQ2,
		lt_T_R_BUDG_YM,
		lt_T_R_CHG_AMT
	From 	T_BUDG_MONTH_REQ a,
			T_BUDG_MONTH_REQ_DETAIL b
	Where	a.COMP_CODE   = b.COMP_CODE
	And		a.CLSE_ACC_ID = b.CLSE_ACC_ID
	And		a.DEPT_CODE   = b.DEPT_CODE
	And		a.CHG_SEQ     = b.CHG_SEQ
	And		a.BUDG_CODE_NO = b.BUDG_CODE_NO
	And		a.RESERVED_SEQ = b.RESERVED_SEQ
	And		a.BUDG_YM      = b.BUDG_YM
	And		a.SEQ			= b.SEQ
	And		a.COMP_CODE    = AR_COMP_CODE
	And		a.CLSE_ACC_ID  = AR_CLSE_ACC_ID
	And		a.DEPT_CODE    = AR_DEPT_CODE
	And		a.CHG_SEQ      = AR_CHG_SEQ
	And		b.R_BUDG_YM Is Not Null;

	--추가예산일경우

	liStart := lt_T_ASSIGN_AMT.First;
	liEnd   := lt_T_ASSIGN_AMT.Last;

	lkStart := lt_T_R_BUDG_YM.First;
	lkEnd   := lt_T_R_BUDG_YM.Last;


	If lt_T_R_BUDG_YM.Count > 0 Then
		--차월이월일경우
		For lkI In lkStart..lkEnd Loop
			Begin
				Begin
					Insert Into T_BUDG_MONTH_AMT_H
					(
						COMP_CODE,
						CLSE_ACC_ID,
						DEPT_CODE,
						CHG_SEQ,
						BUDG_CODE_NO,
						RESERVED_SEQ,
						BUDG_YM,
						BUDG_MONTH_ASSIGN_AMT,
						BUDG_MONTH_REQ_AMT
					)
					Values
					(
						AR_COMP_CODE,
						AR_CLSE_ACC_ID,
						AR_DEPT_CODE,
						AR_CHG_SEQ,
						lt_T_BUDG_CODE_NO2(lkI),
						lt_T_RESERVED_SEQ2(lkI),
						lt_T_R_BUDG_YM(lkI),
						- lt_T_R_CHG_AMT(lkI),
						- lt_T_R_CHG_AMT(lkI)
					);
				Exception When Dup_Val_On_Index Then
					Update	T_BUDG_MONTH_AMT_H
					Set		BUDG_MONTH_ASSIGN_AMT = BUDG_MONTH_ASSIGN_AMT - lt_T_R_CHG_AMT(lkI),
							BUDG_MONTH_REQ_AMT = BUDG_MONTH_REQ_AMT - lt_T_R_CHG_AMT(lkI)
					Where	COMP_CODE 	 = AR_COMP_CODE
					And		CLSE_ACC_ID  = AR_CLSE_ACC_ID
					And		DEPT_CODE 	 = AR_DEPT_CODE
					And		CHG_SEQ 	 = AR_CHG_SEQ
					And		BUDG_CODE_NO =  lt_T_BUDG_CODE_NO2(lkI)
					And		RESERVED_SEQ =  lt_T_RESERVED_SEQ2(lkI)
					And		BUDG_YM =  lt_T_R_BUDG_YM(lkI);
				End;
			End;
		End Loop;
	End If;
	If lt_T_ASSIGN_AMT.Count > 0 Then
		For liI In liStart..liEnd Loop
			Begin
				--배정금액
				Begin
					Insert Into T_BUDG_DEPT_ITEM_H
					(
						COMP_CODE,
						CLSE_ACC_ID,
						DEPT_CODE,
						CHG_SEQ,
						BUDG_CODE_NO,
						RESERVED_SEQ
					)
					Values
					(
						AR_COMP_CODE,
						AR_CLSE_ACC_ID,
						AR_DEPT_CODE,
						AR_CHG_SEQ,
						lt_T_BUDG_CODE_NO(liI),
						lt_T_RESERVED_SEQ(liI)
					);
				Exception When Dup_Val_On_Index Then
					Null;
				End;
				Begin
					Insert Into T_BUDG_MONTH_AMT_H
					(
						COMP_CODE,
						CLSE_ACC_ID,
						DEPT_CODE,
						CHG_SEQ,
						BUDG_CODE_NO,
						RESERVED_SEQ,
						BUDG_YM,
						BUDG_MONTH_ASSIGN_AMT,
						BUDG_MONTH_REQ_AMT
					)
					Values
					(
						AR_COMP_CODE,
						AR_CLSE_ACC_ID,
						AR_DEPT_CODE,
						AR_CHG_SEQ,
						lt_T_BUDG_CODE_NO(liI),
						lt_T_RESERVED_SEQ(liI),
						lt_T_BUDG_YM(liI),
						lt_T_CHG_AMT(liI),
						lt_T_CHG_AMT(liI)
					);
				Exception When Dup_Val_On_Index Then
					Update	T_BUDG_MONTH_AMT_H
					Set		BUDG_MONTH_ASSIGN_AMT =  BUDG_MONTH_ASSIGN_AMT + lt_T_CHG_AMT(liI),
							BUDG_MONTH_REQ_AMT =  BUDG_MONTH_REQ_AMT + lt_T_CHG_AMT(liI)
					Where	COMP_CODE = AR_COMP_CODE
					And		CLSE_ACC_ID = AR_CLSE_ACC_ID
					And		DEPT_CODE = AR_DEPT_CODE
					And		CHG_SEQ = AR_CHG_SEQ
					And		BUDG_CODE_NO =  lt_T_BUDG_CODE_NO(liI)
					And		RESERVED_SEQ =  lt_T_RESERVED_SEQ(liI)
					And		BUDG_YM = lt_T_BUDG_YM(liI);
				End;
				Update	T_BUDG_DEPT_ITEM_H
				Set		BUDG_ITEM_ASSIGN_AMT = BUDG_ITEM_ASSIGN_AMT +  lt_T_CHG_AMT(liI),
						BUDG_ITEM_REQ_AMT = BUDG_ITEM_REQ_AMT +  lt_T_CHG_AMT(liI),
						BUDG_ADD_AMT = BUDG_ADD_AMT + lt_T_CHG_AMT(liI)
				Where	COMP_CODE = AR_COMP_CODE
				And		CLSE_ACC_ID = AR_CLSE_ACC_ID
				And		DEPT_CODE = AR_DEPT_CODE
				And		CHG_SEQ = AR_CHG_SEQ
				And		BUDG_CODE_NO =  lt_T_BUDG_CODE_NO(liI)
				And		RESERVED_SEQ =  lt_T_RESERVED_SEQ(liI);
			End;
		End Loop;
	End If;

	Insert INTO T_BUDG_CHG_REASON
	(
		COMP_CODE,
		CLSE_ACC_ID,
		DEPT_CODE,
		CHG_SEQ,
		BUDG_CODE_NO,
		RESERVED_SEQ,
		BUDG_YM,
		REASON_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		R_COMP_CODE,
		R_CLSE_ACC_ID,
		R_DEPT_CODE,
		R_CHG_SEQ,
		R_BUDG_CODE_NO,
		R_RESERVED_SEQ,
		R_BUDG_YM,
		REMARKS,
		REASON_CODE,
		CHG_AMT
	)
	SELECT
		a.COMP_CODE,
		a.CLSE_ACC_ID,
		a.DEPT_CODE,
		a.CHG_SEQ,
		a.BUDG_CODE_NO,
		a.RESERVED_SEQ,
		a.BUDG_YM,
		b.REASON_NO,
		a.CRTUSERNO,
		a.CRTDATE,
		a.MODUSERNO,
		a.MODDATE,
		R_COMP_CODE,
		R_CLSE_ACC_ID,
		R_DEPT_CODE,
		R_CHG_SEQ,
		R_BUDG_CODE_NO,
		R_RESERVED_SEQ,
		R_BUDG_YM,
		REMARKS,
		a.REASON_CODE,
		sum(b.CHG_AMT)
	FROM	T_BUDG_MONTH_REQ a,
			T_BUDG_MONTH_REQ_DETAIL b
	WHERE   a.COMP_CODE = b.COMP_CODE
	AND	    a.CLSE_ACC_ID = b.CLSE_ACC_ID
	AND	    a.DEPT_CODE = b.DEPT_CODE
	AND	    a.CHG_SEQ = b.CHG_SEQ
	And	    a.BUDG_CODE_NO = b.BUDG_CODE_NO
	And	    a.RESERVED_SEQ = b.RESERVED_SEQ
	And	    a.BUDG_YM = b.BUDG_YM
	And	    a.SEQ 	  = b.SEQ
	AND 	a.COMP_CODE = AR_COMP_CODE
	AND	    a.CLSE_ACC_ID = AR_CLSE_ACC_ID
	AND	    a.DEPT_CODE = AR_DEPT_CODE
	AND	    a.CHG_SEQ = AR_CHG_SEQ
	group by a.COMP_CODE,
			a.CLSE_ACC_ID,
			a.DEPT_CODE,
			a.CHG_SEQ,
			a.BUDG_CODE_NO,
			a.RESERVED_SEQ,
			a.BUDG_YM,
			b.REASON_NO,
			a.CRTUSERNO,
			a.CRTDATE,
			a.MODUSERNO,
			a.MODDATE,
			R_COMP_CODE,
			R_CLSE_ACC_ID,
			R_DEPT_CODE,
			R_CHG_SEQ,
			R_BUDG_CODE_NO,
			R_RESERVED_SEQ,
			R_BUDG_YM,
			REMARKS,
			a.REASON_CODE;

End;
/

Create Table TIA_ACC_SLIP_REMAIN_KEEP
(
	SLIP_ID                                  NUMBER Not Null , 
	SLIP_IDSEQ                               NUMBER Not Null , 
	RESET_SLIP_IDSEQ                         NUMBER Not Null , 
	RESET_AMT                                NUMBER
)
	PCTFREE	10
	INITRANS	1
	MAXTRANS	255
	TABLESPACE	DONGIL_DB_02
	STORAGE(
		INITIAL		65536
		MINEXTENTS		1
		MAXEXTENTS		2147483645
);

ALTER TABLE TIA_ACC_SLIP_REMAIN_KEEP
		ADD CONSTRAINT XPKTIA_ACC_SLIP_REMAIN_KEEP PRIMARY KEY (SLIP_ID,SLIP_IDSEQ,RESET_SLIP_IDSEQ)
USING INDEX 
	PCTFREE	10
	INITRANS	2
	MAXTRANS	255
	TABLESPACE	DONGIL_DB_02
	STORAGE(
		INITIAL		65536
		MINEXTENTS		1
		MAXEXTENTS		2147483645
);

CREATE  INDEX XIE1TIA_ACC_SLIP_REMAIN_KEEP ON TIA_ACC_SLIP_REMAIN_KEEP
(SLIP_ID ASC,RESET_SLIP_IDSEQ ASC)
	PCTFREE	10
	INITRANS	2
	MAXTRANS	255
	TABLESPACE	DONGIL_DB_02
	STORAGE(
		INITIAL		65536
		MINEXTENTS		1
		MAXEXTENTS		2147483645
);


Create Or Replace Package SKIA_Make_Remain_Keep
Is
	Type	R_Detail Is Record
	(
		r_Slip_Id				TIA_ACC_SLIP_BODY_T.SLIP_ID%Type,
		r_Slip_IdSeq			TIA_ACC_SLIP_BODY_T.SLIP_IDSEQ%Type,
		r_MAKE_SLIPLINE			TIA_ACC_SLIP_BODY_T.MAKE_SLIPLINE%Type,
		r_ACC_CODE				TIA_ACC_SLIP_BODY_T.ACC_CODE%Type,
		r_DB_AMT				TIA_ACC_SLIP_BODY_T.DB_AMT%Type,
		r_CR_AMT				TIA_ACC_SLIP_BODY_T.CR_AMT%Type,
		r_REMAIN_AMT			TIA_ACC_SLIP_REMAIN_KEEP.RESET_AMT%Type
	);
	Type	T_Detail Is Table Of R_Detail
		Index By Binary_Integer;
	Type	T_SlipDetail Is Table Of TIA_ACC_SLIP_BODY_T%RowType
		Index By Binary_Integer;
	Procedure Make_Remain_Keep
	(
		Ar_Slip_Id				Number
	);
End;
/

Create Or Replace Package Body SKIA_Make_Remain_Keep
Is
	Function	CreateDetail
	(
		lr_Slip_Elem			TIA_ACC_SLIP_BODY_T%RowType
	)
	Return R_Detail
	Is
		lrTemp					R_Detail;
	Begin
		lrTemp.r_Slip_Id := lr_Slip_Elem.Slip_Id;
		lrTemp.r_Slip_IdSeq := lr_Slip_Elem.Slip_IdSeq;
		lrTemp.r_MAKE_SLIPLINE := lr_Slip_Elem.MAKE_SLIPLINE;
		lrTemp.r_ACC_CODE := lr_Slip_Elem.ACC_CODE;
		lrTemp.r_DB_AMT := lr_Slip_Elem.DB_AMT;
		lrTemp.r_CR_AMT := lr_Slip_Elem.CR_AMT;
		If Nvl(lr_Slip_Elem.DB_AMT,0) > 0 Then
			lrTemp.r_REMAIN_AMT := Nvl(lr_Slip_Elem.DB_AMT,0);
		ElsIf Nvl(lr_Slip_Elem.CR_AMT,0) > 0 Then
			lrTemp.r_REMAIN_AMT := Nvl(lr_Slip_Elem.CR_AMT,0);
		ElsIf Nvl(lr_Slip_Elem.DB_AMT,0) < 0 Then
			lrTemp.r_REMAIN_AMT := Nvl(lr_Slip_Elem.DB_AMT,0) * -1;
		ElsIf Nvl(lr_Slip_Elem.CR_AMT,0) < 0 Then
			lrTemp.r_REMAIN_AMT := Nvl(lr_Slip_Elem.CR_AMT,0) * -1;
		End If;
		Return lrTemp;
	End;
	Function	GetSlipAmt
	(
		lr_Slip_Elem			TIA_ACC_SLIP_BODY_T%RowType
	)
	Return Number
	Is
		lnSlipAmt				Number := 0;
	Begin
		If Nvl(lr_Slip_Elem.DB_AMT,0) > 0 Then
			lnSlipAmt := Nvl(lr_Slip_Elem.DB_AMT,0);
		ElsIf Nvl(lr_Slip_Elem.CR_AMT,0) > 0 Then
			lnSlipAmt := Nvl(lr_Slip_Elem.CR_AMT,0);
		ElsIf Nvl(lr_Slip_Elem.DB_AMT,0) < 0 Then
			lnSlipAmt := Nvl(lr_Slip_Elem.DB_AMT,0) * -1;
		ElsIf Nvl(lr_Slip_Elem.CR_AMT,0) < 0 Then
			lnSlipAmt := Nvl(lr_Slip_Elem.CR_AMT,0) * -1;
		End If;
		Return lnSlipAmt;
	End;
	Procedure	InsertData
	(
		Ar_Slip_Id				Number,
		Ar_Slip_IdSeq			Number,
		Ar_Slip_IdSeq2			Number,
		Ar_Reset_Amt			Number
	)
	Is
	Begin
		Insert Into TIA_ACC_SLIP_REMAIN_KEEP
		(
			SLIP_ID,
			SLIP_IDSEQ,
			RESET_SLIP_IDSEQ,
			RESET_AMT
		)
		Values
		(
			Ar_Slip_Id,
			Ar_Slip_IdSeq,
			Ar_Slip_IdSeq2,
			Ar_Reset_Amt
		);
		Insert Into TIA_ACC_SLIP_REMAIN_KEEP
		(
			SLIP_ID,
			SLIP_IDSEQ,
			RESET_SLIP_IDSEQ,
			RESET_AMT
		)
		Values
		(
			Ar_Slip_Id,
			Ar_Slip_IdSeq2,
			Ar_Slip_IdSeq,
			Ar_Reset_Amt
		);
	End;
	Procedure	InsertDataRemain
	(
		Ar_Slip_Id				Number,
		Ar_Slip_IdSeq			Number,
		Ar_Reset_Amt			Number
	)
	Is
	Begin
		Insert Into TIA_ACC_SLIP_REMAIN_KEEP
		(
			SLIP_ID,
			SLIP_IDSEQ,
			RESET_SLIP_IDSEQ,
			RESET_AMT
		)
		Values
		(
			Ar_Slip_Id,
			Ar_Slip_IdSeq,
			-1,
			Ar_Reset_Amt
		);
	End;
	Procedure Make_Remain_Keep
	(
		Ar_Slip_Id				Number
	)Is
		lr_Slip_Elem			TIA_ACC_SLIP_BODY_T%RowType;
		lr_Slip_Detail			T_SlipDetail;
		lr_DB_Detail			T_Detail;
		lr_CR_Detail			T_Detail;
		lrReset					R_Detail;
		lrThis					R_Detail;
		lnSlipAmt				Number;
		lnResetAmt				Number;
	Begin
		Delete	TIA_ACC_SLIP_REMAIN_KEEP
		Where	SLIP_ID = Ar_Slip_Id;
		Select
			*
		Bulk Collect Into
			lr_Slip_Detail
		From	TIA_ACC_SLIP_BODY_T
		Where	SLIP_ID = Ar_Slip_Id
		Order By
			Slip_Id,
			MAKE_SLIPLINE,
			SLIP_IDSEQ;
		For liI In 1..lr_Slip_Detail.Count Loop
			lr_Slip_Elem := lr_Slip_Detail(liI);
			If Nvl(lr_Slip_Elem.DB_AMT,0) > 0 Or Nvl(lr_Slip_Elem.CR_AMT,0) < 0 Then	--차변금액임(양의 차변 또는 음의 대변)
				--먼저 기존의 것 중 잔액이 남아 있는 상대변이 있는지 검증한다.
				If lr_CR_Detail.Count > 0 Then		--기존 상대변 잔액이 있다.
					lrReset := lr_CR_Detail(lr_CR_Detail.First);
					--잔액비교
					lnSlipAmt := GetSlipAmt(lr_Slip_Elem);
					If Nvl(lrReset.r_REMAIN_AMT,0) > Nvl(lnSlipAmt,0) Then		--잔액이 더 크면
						--새로운 행을 둘 삽입한다.그 이유는 자기변 및 상대변에 각각 하나씩 자료가 만들어져야 나중에 SQL이 쉬우니까.
						lnResetAmt := lnSlipAmt;
						InsertData(Ar_Slip_Id,lrReset.r_Slip_IdSeq,lr_Slip_Elem.SLIP_IDSEQ,lnResetAmt);
						lrReset.r_REMAIN_AMT := Nvl(lrReset.r_REMAIN_AMT,0) - lnResetAmt;
						lr_CR_Detail(lr_CR_Detail.First) := lrReset;			--제자리에 다시 넣어두고
					ElsIf Nvl(lrReset.r_REMAIN_AMT,0) < Nvl(lnSlipAmt,0) Then	--잔액이 더 작으면
						lnResetAmt := Nvl(lrReset.r_REMAIN_AMT,0);
						InsertData(Ar_Slip_Id,lrReset.r_Slip_IdSeq,lr_Slip_Elem.SLIP_IDSEQ,lnResetAmt);
						lrThis := CreateDetail(lr_Slip_Elem);
						lrThis.r_REMAIN_AMT := Nvl(lrThis.r_REMAIN_AMT,0) - lnResetAmt;
						lr_DB_Detail(Nvl(lr_DB_Detail.Last,0) + 1) := lrThis;
						lr_CR_Detail.Delete(lr_CR_Detail.First);				--잔액이 없으니까 제거
					ElsIf Nvl(lrReset.r_REMAIN_AMT,0) = Nvl(lnSlipAmt,0) Then	--쌤쌤이면
						lnResetAmt := Nvl(lrReset.r_REMAIN_AMT,0);
						InsertData(Ar_Slip_Id,lrReset.r_Slip_IdSeq,lr_Slip_Elem.SLIP_IDSEQ,lnResetAmt);
						lr_CR_Detail.Delete(lr_CR_Detail.First);				--잔액이 없으니까 제거
					Else														--????
						Null;
					End If;
				Else			--기존 상대변 잔액이 없다
					lr_DB_Detail(Nvl(lr_DB_Detail.Last,0) + 1) := CreateDetail(lr_Slip_Elem);
				End If;
			ElsIf Nvl(lr_Slip_Elem.CR_AMT,0) > 0 Or Nvl(lr_Slip_Elem.DB_AMT,0) < 0 Then	--대변금액임(양의 대변 또는 음의 차변)
				If lr_DB_Detail.Count > 0 Then		--기존 상대변 잔액이 있다.
					lrReset := lr_DB_Detail(lr_DB_Detail.First);
					--잔액비교
					lnSlipAmt := GetSlipAmt(lr_Slip_Elem);
					If Nvl(lrReset.r_REMAIN_AMT,0) > Nvl(lnSlipAmt,0) Then		--잔액이 더 크면
						--새로운 행을 둘 삽입한다.그 이유는 자기변 및 상대변에 각각 하나씩 자료가 만들어져야 나중에 SQL이 쉬우니까.
						lnResetAmt := lnSlipAmt;
						InsertData(Ar_Slip_Id,lrReset.r_Slip_IdSeq,lr_Slip_Elem.SLIP_IDSEQ,lnResetAmt);
						lrReset.r_REMAIN_AMT := Nvl(lrReset.r_REMAIN_AMT,0) - lnResetAmt;
						lr_DB_Detail(lr_DB_Detail.First) := lrReset;			--제자리에 다시 넣어두고
					ElsIf Nvl(lrReset.r_REMAIN_AMT,0) < Nvl(lnSlipAmt,0) Then	--잔액이 더 작으면
						lnResetAmt := Nvl(lrReset.r_REMAIN_AMT,0);
						InsertData(Ar_Slip_Id,lrReset.r_Slip_IdSeq,lr_Slip_Elem.SLIP_IDSEQ,lnResetAmt);
						lrThis := CreateDetail(lr_Slip_Elem);
						lrThis.r_REMAIN_AMT := Nvl(lrThis.r_REMAIN_AMT,0) - lnResetAmt;
						lr_CR_Detail(Nvl(lr_CR_Detail.Last,0) + 1) := lrThis;
						lr_DB_Detail.Delete(lr_DB_Detail.First);				--잔액이 없으니까 제거
					ElsIf Nvl(lrReset.r_REMAIN_AMT,0) = Nvl(lnSlipAmt,0) Then	--쌤쌤이면
						lnResetAmt := Nvl(lrReset.r_REMAIN_AMT,0);
						InsertData(Ar_Slip_Id,lrReset.r_Slip_IdSeq,lr_Slip_Elem.SLIP_IDSEQ,lnResetAmt);
						lr_DB_Detail.Delete(lr_DB_Detail.First);				--잔액이 없으니까 제거
					Else														--????
						Null;
					End If;
				Else			--기존 상대변 잔액이 없다
					lr_CR_Detail(Nvl(lr_CR_Detail.Last,0) + 1) := CreateDetail(lr_Slip_Elem);
				End If;
			Else										--다 0임
				GoTo Skip_Rtn;
			End If;
<<Skip_Rtn>>
			Null;
		End Loop;
		If lr_DB_Detail.Count > 0 Then		--잔액이 남았다면
			Loop
				Exit When lr_DB_Detail.Count <= 0;
				lrThis := lr_DB_Detail(lr_DB_Detail.First);
				Loop
					Exit When lr_CR_Detail.Count <= 0;
					lrReset := lr_CR_Detail(lr_CR_Detail.First);
					If Nvl(lrThis.r_REMAIN_AMT,0) > Nvl(lrReset.r_REMAIN_AMT,0) Then
						lnResetAmt := Nvl(lrReset.r_REMAIN_AMT,0);
						lrThis.r_REMAIN_AMT := Nvl(lrThis.r_REMAIN_AMT,0) - lnResetAmt;
						InsertData(Ar_Slip_Id,lrThis.r_Slip_IdSeq,lrReset.r_Slip_IdSeq,lnResetAmt);
						lr_CR_Detail.delete(lr_CR_Detail.First);
						lr_DB_Detail(lr_DB_Detail.First) := lrThis;
					ElsIf Nvl(lrThis.r_REMAIN_AMT,0) = Nvl(lrReset.r_REMAIN_AMT,0) Then
						InsertData(Ar_Slip_Id,lrThis.r_Slip_IdSeq,lrReset.r_Slip_IdSeq,Nvl(lrThis.r_REMAIN_AMT,0));
						lr_CR_Detail.delete(lr_CR_Detail.First);
						lr_DB_Detail.delete(lr_DB_Detail.First);
						Exit;
					ElsIf Nvl(lrThis.r_REMAIN_AMT,0) < Nvl(lrReset.r_REMAIN_AMT,0) Then
						lnResetAmt := Nvl(lrThis.r_REMAIN_AMT,0);
						lrReset.r_REMAIN_AMT := Nvl(lrReset.r_REMAIN_AMT,0) - lnResetAmt;
						InsertData(Ar_Slip_Id,lrThis.r_Slip_IdSeq,lrReset.r_Slip_IdSeq,Nvl(lrThis.r_REMAIN_AMT,0));
						lr_DB_Detail.delete(lr_DB_Detail.First);
						lr_CR_Detail(lr_CR_Detail.First) := lrReset;
						Exit;
					End If;
				End Loop;
			End Loop;
		End If;
		If lr_CR_Detail.Count > 0 Then
			For liI In lr_CR_Detail.First..lr_CR_Detail.Last Loop
				InsertDataRemain(lr_CR_Detail(liI).r_Slip_Id,lr_CR_Detail(liI).r_Slip_IdSeq,lr_CR_Detail(liI).r_REMAIN_AMT);
			End Loop;
		End If;
		If lr_DB_Detail.Count > 0 Then
			For liI In lr_DB_Detail.First..lr_DB_Detail.Last Loop
				InsertDataRemain(lr_DB_Detail(liI).r_Slip_Id,lr_DB_Detail(liI).r_Slip_IdSeq,lr_DB_Detail(liI).r_REMAIN_AMT);
			End Loop;
		End If;
	End;
End;
/

declare
begin
	for lra in ( select * from (select distinct slip_id from tia_acc_slip_body_t
					where make_dt between to_date('20051130','yyyymmdd') and to_date('20051130','yyyymmdd')) where rownum < 101 ) Loop
		SKIA_Make_Remain_Keep.Make_Remain_Keep(lra.slip_id);
	end loop;
	commit;
end;
/

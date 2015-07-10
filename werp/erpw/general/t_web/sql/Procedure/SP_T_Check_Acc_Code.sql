Create Or Replace Procedure SP_T_Check_Acc_Code
Is
	lsAcc_Code				T_ACC_CODE.ACC_CODE%Type;		--T_ACC_CODE테이블의 ACC_CODE 컬럼과 같은 타입으로 선언
	lsAcc_Code1				T_ACC_CODE.ACC_CODE%Type;		--T_ACC_CODE테이블의 ACC_CODE 컬럼과 같은 타입으로 선언
	lsAcc_Code2				T_ACC_CODE.ACC_CODE%Type;		--T_ACC_CODE테이블의 ACC_CODE 컬럼과 같은 타입으로 선언
	lsAcc_Name1				T_ACC_CODE.ACC_NAME%Type;
	lsAcc_Name2				T_ACC_CODE.ACC_NAME%Type;
	Function	InternalGetAccName
	(
		as_acc_code				T_ACC_CODE.ACC_CODE%Type
	)
	Return Varchar2
	Is
		lsAcc_Name				T_ACC_CODE.ACC_NAME%Type;
	Begin
		Select
			Acc_Name
		Into
			lsAcc_Name
		From	T_ACC_CODE
		Where	ACC_CODE = as_acc_code;
		Return lsAcc_Name;
	Exception When No_Data_Found Then
		Return '';
	End;
Begin
	--입력여부 검증
	Begin
		Select
			Min(a.ACC_CODE)
		Into
			lsAcc_Code
		From	T_ACC_CODE a
		Where	a.FUND_INPUT_CLS = 'T'
		And		Exists
		(
			Select
				Null
			From	T_ACC_CODE b
			Where	a.ACC_CODE = b.COMPUTER_ACC
		);
	Exception When No_Data_Found Then
		lsAcc_Code := Null;
	End;
	If lsAcc_Code Is Not Null Then
		Raise_Application_Error(-20009,lsAcc_Code||' '||InternalGetAccName(lsAcc_Code) ||' 은(는) 하위 계정이 있으면서 입력여부가 설정되었습니다.');
	End If;
	Begin
		Select
			Min(Acc_Code)
		Into
			lsAcc_Code
		From
		(
			Select
				Acc_Code
			From	T_ACC_CODE a
			Minus
			(
				Select
					Acc_Code
				From	T_ACC_CODE a
				Where	a.ACC_LVL = 1
				And		Substrb(a.ACC_CODE,-8,8) = '00000000'
				And		a.ACC_CODE <> '000000000'
				Union
				Select
					Acc_Code
				From	T_ACC_CODE a
				Where	a.ACC_LVL = 2
				And		Substrb(a.ACC_CODE,-7,7) = '0000000'
				And		SubStrb(a.ACC_CODE,2,1) <> '0'
				Union
				Select
					Acc_Code
				From	T_ACC_CODE a
				Where	a.ACC_LVL = 3
				And		Substrb(a.ACC_CODE,-6,6) = '000000'
				And		SubStrb(a.ACC_CODE,3,1) <> '0'
				Union
				Select
					Acc_Code
				From	T_ACC_CODE a
				Where	a.ACC_LVL = 4
				And		Substrb(a.ACC_CODE,-4,4) = '0000'
				And		SubStrb(a.ACC_CODE,4,2) <> '00'
				Union
				Select
					Acc_Code
				From	T_ACC_CODE a
				Where	a.ACC_LVL = 5
				And		Substrb(a.ACC_CODE,-2,2) = '00'
				And		SubStrb(a.ACC_CODE,6,2) <> '00'
				Union
				Select
					Acc_Code
				From	T_ACC_CODE a
				Where	a.ACC_LVL = 6
				And		Substrb(a.ACC_CODE,-2,2) <> '00'
			)
		);
	Exception When No_Data_Found Then
		lsAcc_Code := Null;
	End;
	If lsAcc_Code Is Not Null Then
		Raise_Application_Error(-20009,lsAcc_Code||' '||InternalGetAccName(lsAcc_Code) ||' 은(는) 계정코드 형식과 계정 레벨이 일치하지 않습니다.');
	End If;
	Begin
		Select
			Min(Acc_Code) ACC_CODE
		Into
			lsAcc_Code
		From	T_ACC_CODE a
		Where	a.COMPUTER_ACC <> '000000000'
		And		a.COMPUTER_ACC Not In (Select	b.ACC_CODE From T_ACC_CODE b );		
	Exception When No_Data_Found Then
		lsAcc_Code := Null;
	End;
	If lsAcc_Code Is Not Null Then
		Raise_Application_Error(-20009,lsAcc_Code||' '||InternalGetAccName(lsAcc_Code) ||' 은(는) 상위계정을 찾을 수 없습니다.');
	End If;
	/*
	Begin
		Select
			CHILD_ACC_CODE,
			CHILD_ACC_NAME,
			PARENT_ACC_CODE,
			PARENT_ACC_NAME
		Into
			lsAcc_Code1,
			lsAcc_Name1,
			lsAcc_Code2,
			lsAcc_Name2
		From
			(
			Select
				k.ACC_CODE CHILD_ACC_CODE,
				k.ACC_NAME CHILD_ACC_NAME,
				k.COMPUTER_ACC,
				l.ACC_CODE PARENT_ACC_CODE,
				l.ACC_NAME PARENT_ACC_NAME,
				l.ACC_LVL,
				Max(l.ACC_LVL) Over(Partition By k.ACC_CODE) Max_Level
			From	T_ACC_CODE k,
					(
						Select
							a.ACC_CODE,
							SubStrb(a.ACC_CODE,1,Decode(a.ACC_LVL,
								1,1,
								2,2,
								3,3,
								4,5,
								5,7,
								6,9) ) ACC_HEAD,
								a.ACC_LVL,
								a.ACC_NAME
						From	T_ACC_CODE a
					) l
			Where	k.ACC_CODE <> l.ACC_CODE
			And		k.ACC_CODE	Like l.ACC_HEAD || '%'
			) ll
		Where	ll.ACC_LVL = ll.Max_Level
		And		ll.COMPUTER_ACC <> ll.PARENT_ACC_CODE
		And		RowNum < 2;
	Exception When No_Data_Found Then
		lsAcc_Code1 := Null;
		lsAcc_Code2 := Null;
		lsAcc_Name1 := Null;
		lsAcc_Name2 := Null;
	End;
	If lsAcc_Code1 Is Not Null Then
		Raise_Application_Error(-20009,lsAcc_Code1||' '||lsAcc_Name1 ||' 의 상위 계정은 '||lsAcc_Code2||' '||lsAcc_Name2||'이어야 합니다.');
	End If;
	*/
	SP_T_MAKE_ACC_CHILD;
End;
/

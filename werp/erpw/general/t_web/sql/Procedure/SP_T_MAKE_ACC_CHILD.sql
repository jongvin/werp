Create Or Replace Procedure SP_T_MAKE_ACC_CHILD
Is
Begin
	for lra in (
		select
			*
		from	t_acc_code a
		where	fund_input_cls = 'T'
		and		Not exists
		(
			Select
				Null
			From	T_ACC_CODE_CHILD b
			where	b.child_acc_code = a.acc_code
		)
	) loop
		SP_T_INSERT_ACC_CODE_CHILD(lra.acc_code,lra.acc_code);
		Insert Into t_acc_code_CHILD2
		(
			parent_acc_code,
			child_acc_code
		)
		Values
		(
			lra.acc_code,
			lra.acc_code
		);
	end loop;
	Merge Into T_ACC_CODE_TREE t
	Using
	(
		Select
			a.CHILD_ACC_CODE ACC_CODE,
			MAX(DECODE(b.ACC_LVL,1,a.PARENT_ACC_CODE,(Decode(c.ACC_LVL,1,a.CHILD_ACC_CODE)))) ACC_CODE1, 
			MAX(DECODE(b.ACC_LVL,2,a.PARENT_ACC_CODE,(Decode(c.ACC_LVL,2,a.CHILD_ACC_CODE)))) ACC_CODE2, 
			MAX(DECODE(b.ACC_LVL,3,a.PARENT_ACC_CODE,(Decode(c.ACC_LVL,3,a.CHILD_ACC_CODE)))) ACC_CODE3, 
			MAX(DECODE(b.ACC_LVL,4,a.PARENT_ACC_CODE,(Decode(c.ACC_LVL,4,a.CHILD_ACC_CODE)))) ACC_CODE4, 
			MAX(DECODE(b.ACC_LVL,5,a.PARENT_ACC_CODE,(Decode(c.ACC_LVL,5,a.CHILD_ACC_CODE)))) ACC_CODE5,
			MAX(DECODE(b.ACC_LVL,6,a.PARENT_ACC_CODE,(Decode(c.ACC_LVL,6,a.CHILD_ACC_CODE)))) ACC_CODE6
		From	T_ACC_CODE_CHILD a,
				T_ACC_CODE b,
				T_ACC_CODE c
		Where	a.PARENT_ACC_CODE = b.ACC_CODE
		And		a.CHILD_ACC_CODE = c.ACC_CODE
		Group by
			a.CHILD_ACC_CODE		
	) s
	On
	(
		s.ACC_CODE = t.ACC_CODE
	)
	When Matched Then
	Update
	Set		t.ACC_CODE1 = s.ACC_CODE1,
			t.ACC_CODE2 = s.ACC_CODE2,
			t.ACC_CODE3 = s.ACC_CODE3,
			t.ACC_CODE4 = s.ACC_CODE4,
			t.ACC_CODE5 = s.ACC_CODE5,
			t.ACC_CODE6 = s.ACC_CODE6
	When Not Matched Then
	Insert
	(ACC_CODE,ACC_CODE1,ACC_CODE2,ACC_CODE3,ACC_CODE4,ACC_CODE5,ACC_CODE6)
	Values
	(s.ACC_CODE,s.ACC_CODE1,s.ACC_CODE2,s.ACC_CODE3,s.ACC_CODE4,s.ACC_CODE5,s.ACC_CODE6);
End;
/

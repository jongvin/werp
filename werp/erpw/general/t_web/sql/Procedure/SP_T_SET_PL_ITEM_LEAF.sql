Create Or Replace Procedure SP_T_SET_PL_ITEM_LEAF
Is
Begin
	Update	T_PL_ITEM a
	Set		a.IS_LEAF_TAG = (
				Select
					Decode(Count(*),0,'T','F')
				From	T_PL_ITEM b
				Where	a.BIZ_PLAN_ITEM_NO = b.P_NO
			);
End;
/

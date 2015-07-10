Create Or Replace Procedure SP_T_SET_PL_MA_ITEM_LEAF
Is
Begin
	Update	T_PL_MA_ITEM a
	Set		a.IS_LEAF_TAG = (
				Select
					Decode(Count(*),0,'T','F')
				From	T_PL_MA_ITEM b
				Where	a.ITEM_NO = b.P_NO
			);
End;
/

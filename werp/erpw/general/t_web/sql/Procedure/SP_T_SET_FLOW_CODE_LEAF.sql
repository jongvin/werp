Create Or Replace Procedure SP_T_SET_FLOW_CODE_LEAF
Is
Begin
	Update	T_FL_FLOW_CODE a
	Set		a.IS_LEAF_TAG = (
				Select
					Decode(Count(*),0,'T','F')
				From	T_FL_FLOW_CODE b
				Where	a.FLOW_CODE = b.P_NO
			);
End;
/

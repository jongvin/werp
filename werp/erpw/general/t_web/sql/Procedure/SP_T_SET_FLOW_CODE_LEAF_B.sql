Create Or Replace Procedure SP_T_SET_FLOW_CODE_LEAF_B
Is
Begin
	Update	T_FL_FLOW_CODE_B a
	Set		a.IS_LEAF_TAG = (
				Select
					Decode(Count(*),0,'T','F')
				From	T_FL_FLOW_CODE_B b
				Where	a.FLOW_CODE_B = b.P_NO
			);
End;
/

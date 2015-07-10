Create Or Replace Procedure SP_T_FL_SET_ITR_TO_DATE
(
	AR_COMP_CODE							VARCHAR2
)
Is
Begin
	Merge Into T_FL_ITR_INFO t
	Using
	(
		Select
			a.COMP_CODE ,
			a.ITR_DATE_F ,
			Nvl(lead(a.ITR_DATE_F) Over (Order By a.COMP_CODE ,a.ITR_DATE_F),to_date('30000101','yyyymmdd') ) - 1 ITR_DATE_TO
		From	T_FL_ITR_INFO a
		Where	a.COMP_CODE = AR_COMP_CODE
		Order By
			a.COMP_CODE ,
			a.ITR_DATE_F
	) s
	On
	(
		s.COMP_CODE = t.COMP_CODE
	And	s.ITR_DATE_F = t.ITR_DATE_F
	)
	When Matched Then
	Update
	Set	t.ITR_DATE_TO = s.ITR_DATE_TO
	When Not Matched Then
	Insert	(COMP_CODE,ITR_DATE_F)
	Values	(s.COMP_CODE,s.ITR_DATE_F);
End;
/

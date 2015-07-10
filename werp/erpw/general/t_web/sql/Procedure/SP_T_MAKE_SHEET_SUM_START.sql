Create Or Replace Procedure SP_T_MAKE_SHEET_SUM_START
(
	Ar_Sheet_Code			T_SHEET_SUM_HEAD.SHEET_CODE%Type,
	Ar_COMP_CODE			T_SHEET_SUM_HEAD.COMP_CODE%Type,
	Ar_DEPT_CODE			T_SHEET_SUM_HEAD.DEPT_CODE%Type,
	Ar_CrtUserNo			T_SHEET_SUM_HEAD.CRTUSERNO%Type,
	Ar_Proj_Tag 			VARCHAR2
)
Is
/***************************************************/
/* �� ���α׷��� �뺸�ý���(��) �� ����Դϴ�.
/* �����ۼ��� : �־�ȸ
/* �����ۼ��� : 2005-05-04
/* ���������� :
/* ���������� :
/***************************************************/
-- �� ���α׷��� �繫��ǥ ���� ���� ���α׷��Դϴ�.
	Type	t_ArrayDEPT_CODE Is Table Of T_DEPT_CODE_ORG.DEPT_CODE%Type
		Index By Binary_Integer;
	r_ArrayDEPT_CODE				t_ArrayDEPT_CODE;
Begin
	If Ar_Proj_Tag = 'T' Then
		Begin
			Select
				A.DEPT_CODE
			Bulk Collect Into
				r_ArrayDEPT_CODE
			From	T_DEPT_CODE_ORG A
			Where	NVL(A.COMP_CODE, '000') LIKE Ar_COMP_CODE
			Order By
				A.DEPT_CODE;
		Exception When No_Data_Found Then
			Null;
		End;
		For liI In 1..r_ArrayDEPT_CODE.Count Loop
			SP_T_Make_SHEET_SUM_BODY(Ar_Sheet_Code, Ar_COMP_CODE, r_ArrayDEPT_CODE(liI), Ar_CrtUserNo);
		End Loop;
		SP_T_Make_SHEET_SUM_BODY(Ar_Sheet_Code, Ar_COMP_CODE, '%', Ar_CrtUserNo);
	Else
		SP_T_Make_SHEET_SUM_BODY(Ar_Sheet_Code, Ar_COMP_CODE, Ar_DEPT_CODE, Ar_CrtUserNo);
	End If;
End;
/

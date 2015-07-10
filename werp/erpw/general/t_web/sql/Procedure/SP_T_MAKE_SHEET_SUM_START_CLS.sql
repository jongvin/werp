Create Or Replace Procedure SP_T_MAKE_SHEET_SUM_START_CLS
(
	Ar_Sheet_Code			T_SHEET_SUM_HEAD_CLASS.SHEET_CODE%Type,
	Ar_COMP_CODE			T_SHEET_SUM_HEAD_CLASS.COMP_CODE%Type,
	Ar_CLASS_CODE			T_SHEET_SUM_HEAD_CLASS.CLASS_CODE%Type,
	Ar_CrtUserNo			T_SHEET_SUM_HEAD_CLASS.CRTUSERNO%Type,
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
	Type	t_ArrayCLASS_CODE Is Table Of T_CLASS_CODE.CLASS_CODE%Type
		Index By Binary_Integer;
	r_ArrayCLASS_CODE				t_ArrayCLASS_CODE;
Begin
   If Ar_Proj_Tag = 'T' Then
      Begin
   		Select
   			A.CLASS_CODE
   		Bulk Collect Into
   			r_ArrayCLASS_CODE
   		From	T_CLASS_CODE A
   		Order By
   			A.CLASS_CODE;
   	Exception When No_Data_Found Then
   		Null;
   	End;
   	For liI In 1..r_ArrayCLASS_CODE.Count Loop
   	   SP_T_Make_SHEET_SUM_BODY_CLS(Ar_Sheet_Code, Ar_COMP_CODE, r_ArrayCLASS_CODE(liI), Ar_CrtUserNo);
   	End Loop;
   	   SP_T_Make_SHEET_SUM_BODY_CLS(Ar_Sheet_Code, Ar_COMP_CODE, '%', Ar_CrtUserNo);
   Else
      SP_T_Make_SHEET_SUM_BODY_CLS(Ar_Sheet_Code, Ar_COMP_CODE, Ar_CLASS_CODE, Ar_CrtUserNo);
   End If;
End;
/

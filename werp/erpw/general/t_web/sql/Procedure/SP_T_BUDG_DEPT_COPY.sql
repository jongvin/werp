Create Or Replace Procedure SP_T_BUDG_DEPT_COPY
(
	AR_COMP_CODE                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_DEPT_COPY
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : SP_T_BUDG_DEPT_COPY
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-25)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	delete from t_budg_dept_info;
	
	Insert into t_budg_dept_info
       select *
	from v_t_budg_dept_info;
	  
End;
/

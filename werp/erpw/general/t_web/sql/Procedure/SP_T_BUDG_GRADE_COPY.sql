Create Or Replace Procedure SP_T_BUDG_GRADE_COPY
(
	AR_COMP_CODE                              VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_BUDG_CODE_NO                        NUMBER,
	AR_ITEM_NO                                  NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_GRADE_COPY
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : SP_T_BUDG_GRADE_COPY ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-25)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert into t_budg_item_grade_cost
	   (comp_code,
	    clse_acc_id,
	    budg_code_no,
	    item_no,
	    grade_code,
	    unit_cost
	   )
	   select AR_COMP_CODE,
	   	    AR_CLSE_ACC_ID,
	   	    AR_BUDG_CODE_NO,
	   	    AR_ITEM_NO,
	   	    code_list_id,
	   	    0
	   from v_t_code_list
	   where code_group_id ='GRADE_CODE'
	   and use_tag='T'
	   order by seq;
End;
/

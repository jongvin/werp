Create Or Replace Procedure SP_T_BUDG_GRADE_COPY
(
	AR_COMP_CODE                              VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_BUDG_CODE_NO                        NUMBER,
	AR_ITEM_NO                                  NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_GRADE_COPY
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : SP_T_BUDG_GRADE_COPY 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2005-11-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
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

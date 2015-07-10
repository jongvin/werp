Create Or Replace Procedure SP_T_BUDG_DEPT_COPY
(
	AR_COMP_CODE                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_DEPT_COPY
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : SP_T_BUDG_DEPT_COPY
/* 4. 변  경  이  력 : 한재원 작성(2005-11-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	delete from t_budg_dept_info;
	
	Insert into t_budg_dept_info
       select *
	from v_t_budg_dept_info;
	  
End;
/

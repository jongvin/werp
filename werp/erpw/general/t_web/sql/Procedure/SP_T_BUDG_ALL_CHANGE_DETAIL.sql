CREATE OR REPLACE Procedure SP_T_BUDG_ALL_CHANGE_DETAIL
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_ALL_CHG_SEQ                             NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_BUDG_APPLY_YM                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_ALL_CHANGE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BUDG_ALL_CHANGE ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-05)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Type T_DEPT_CODE1 Is Table Of T_BUDG_BF_BASE_AMT.DEPT_CODE%Type
		Index By Binary_Integer;
Type T_EMP_NO Is Table Of T_BUDG_BF_BASE_AMT.EMP_NO%Type
		Index By Binary_Integer;
Type T_BUDG_CODE_NO Is Table Of T_BUDG_ITEM_COST.BUDG_CODE_NO%Type
		Index By Binary_Integer;
Type T_ITEM_NO Is Table Of T_BUDG_ITEM_COST.ITEM_NO%Type
		Index By Binary_Integer;
Type T_UNIT_COST Is Table Of T_BUDG_ITEM_COST.UNIT_COST%Type
		Index By Binary_Integer;
Type T_DAY_CALC_TAG Is Table Of T_BUDG_ITEM_COST.DAY_CALC_TAG%Type
		Index By Binary_Integer;
Type T_UNIT_TAG Is Table Of T_BUDG_ITEM_COST.UNIT_TAG%Type
		Index By Binary_Integer;
Type T_GRADE_UNIT_TAG Is Table Of T_BUDG_ITEM_COST.GRADE_UNIT_TAG%Type
		Index By Binary_Integer;
Type T_GRADE_CODE Is Table Of T_BUDG_ITEM_GRADE_COST.GRADE_CODE%Type
		Index By Binary_Integer;
Type T_EMP_NAME Is Table Of T_BUDG_NOW_ORDER_STAT.EMP_NAME%Type
		Index By Binary_Integer;
Type T_ORDER_DT Is Table Of T_BUDG_NOW_ORDER_STAT.ORDER_DT%Type
		Index By Binary_Integer;
Type T_BF_ORDER_DEPT_CODE Is Table Of T_BUDG_NOW_ORDER_STAT.BF_ORDER_DEPT_CODE%Type
		Index By Binary_Integer;
Type T_BF_ORDER_GRADE_CODE Is Table Of T_BUDG_NOW_ORDER_STAT.BF_ORDER_GRADE_CODE%Type
		Index By Binary_Integer;
Type T_QTY Is Table Of T_BUDG_BF_BASE_AMT.QTY%Type
		Index By Binary_Integer;
Type T_AMT Is Table Of T_BUDG_BF_BASE_AMT.AMT%Type
		Index By Binary_Integer;
Type T_BUDG_YM Is Table Of T_BUDG_NOW_ORDER_STAT.EMP_NAME%Type
		Index By Binary_Integer;
		
lt_T_DEPT_CODE1				T_DEPT_CODE1;
lt_T_DEPT_CODE2				T_DEPT_CODE1;
lt_T_DEPT_CODE3				T_DEPT_CODE1;
lt_T_DEPT_CODE4				T_DEPT_CODE1;

lt_T_EMP_NO1				T_EMP_NO;
lt_T_EMP_NO2				T_EMP_NO;
lt_T_EMP_NO3				T_EMP_NO;
lt_T_EMP_NO4				T_EMP_NO;

lt_T_BUDG_CODE_NO1			T_BUDG_CODE_NO;
lt_T_BUDG_CODE_NO2			T_BUDG_CODE_NO;

lt_T_ITEM_NO1				T_ITEM_NO;
lt_T_ITEM_NO2				T_ITEM_NO;

lt_T_GRADE_CODE1			T_GRADE_CODE;
lt_T_GRADE_CODE2			T_GRADE_CODE;

lt_T_EMP_NAME1				T_EMP_NAME;
lt_T_EMP_NAME2				T_EMP_NAME;

lt_T_ORDER_DT1				T_ORDER_DT;
lt_T_ORDER_DT2				T_ORDER_DT;

lt_T_BF_ORDER_GRADE_CODE1	T_BF_ORDER_GRADE_CODE;
lt_T_BF_ORDER_GRADE_CODE2	T_BF_ORDER_GRADE_CODE;

lt_T_BF_ORDER_DEPT_CODE1	T_BF_ORDER_DEPT_CODE;
lt_T_BF_ORDER_DEPT_CODE2	T_BF_ORDER_DEPT_CODE;

lt_T_UNIT_COST1				T_UNIT_COST;
lt_T_UNIT_COST2				T_UNIT_COST;

lt_T_QTY1					T_QTY;
lt_T_QTY2					T_QTY;

lt_T_AMT1					T_AMT;
lt_T_AMT2					T_AMT; 

lt_T_BUDG_YM1				T_BUDG_YM;
lt_T_BUDG_YM2				T_BUDG_YM;

li1Start					Number;
li1End						Number;
li2Start					Number;
li2End						Number;
li3Start					Number;
li3End						Number;
li4Start					Number;
li4End						Number;
lsErrm						Varchar2(2000);
lnErrNo						Number;
Begin

	--�������ο���Ȳ, ���رݾ� �ֱ�
	--������ο���Ȳ, ��������رݾ׳ֱ�
	--�ο���Ȳ�� �λ������� �߷��������� �����ͼ� �־��ش�.
	--���رݾ��� �����ڵ庰 �׸񿡼� ������ �־��ش�.
	
	--�������ο���Ȳ
	Select
		DEPT_CODE,
		EMP_NO,
		GRADE_CODE,
		EMP_NAME
	Bulk Collect Into
		lt_T_DEPT_CODE1,
		lt_T_EMP_NO1,
		lt_T_GRADE_CODE1,
		lt_T_EMP_NAME1
	From	V_BUDG_021 a --������ �μ����ο� view
	Where	a.comp_code = AR_COMP_CODE
	and to_char(order_dt,'yyyy-mm') = (SELECT  to_char( ADD_MONTHS(SYSDATE,-1),'YYYY-MM') 
									  FROM dual ); 
	
	
	li1Start := lt_T_EMP_NO1.First; 
	li1End 	 := lt_T_EMP_NO1.Last;
	
	If lt_T_EMP_NO1.Count > 0 Then
		
		For li1 In li1Start..li1End Loop
			Begin
				
				SP_T_BUDG_BF_ORDER_STAT_I(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_ALL_CHG_SEQ,
				                          lt_T_DEPT_CODE1(li1), lt_T_EMP_NO1(li1), AR_CRTUSERNO, 
										  lt_T_GRADE_CODE1(li1), lt_T_EMP_NAME1(li1));     	
				--null;
			Exception When Others Then
				lsErrm := SqlErrm;
				lnErrNo:= SQLCODE;
				lsErrm := Replace(lsErrm,'ORA-20009:','');
				Raise_Application_Error(-20009,'�������ο���Ȳ��� :' ||lt_T_DEPT_CODE1(li1)||'�� ������ �ο���Ȳ ����'||chr(10) || lnErrNo || ':' || lsErrm);
			End;
		End Loop;
	End If;
	
	--�μ���������ο���Ȳ
	Select
		DEPT_CODE,
		EMP_NO,
		GRADE_CODE,
		EMP_NAME,
		ORDER_DT,
		BF_ORDER_DEPT_CODE,
		BF_ORDER_GRADE_CODE 
	Bulk Collect Into
		lt_T_DEPT_CODE2,
		lt_T_EMP_NO2,
		lt_T_GRADE_CODE2,
		lt_T_EMP_NAME2,
		lt_T_ORDER_DT2,
		lt_T_BF_ORDER_DEPT_CODE2,
		lt_T_BF_ORDER_GRADE_CODE2
	From	V_BUDG_021 a --�μ���������ο���Ȳ view
	Where	a.comp_code = AR_COMP_CODE
	and to_char(order_dt,'yyyy-mm') = to_char(sysdate,'YYYY-MM');
	
	
	li2Start := lt_T_EMP_NO2.First; 
	li2End 	 := lt_T_EMP_NO2.Last;
	
	If lt_T_EMP_NO2.Count > 0 Then
		
		For li2 In li2Start..li2End Loop
			Begin
			
				SP_T_BUDG_NOW_ORDER_STAT_I(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_ALL_CHG_SEQ, lt_T_DEPT_CODE2(li2), lt_T_EMP_NO2(li2), AR_CRTUSERNO, lt_T_GRADE_CODE2(li2),lt_T_EMP_NAME2(li2), lt_T_ORDER_DT2(li2), lt_T_BF_ORDER_DEPT_CODE2(li2), lt_T_BF_ORDER_GRADE_CODE2(li2));     	
				
			Exception When Others Then
				lsErrm := SqlErrm;
				lsErrm := Replace(lsErrm,'ORA-20009:','');
				Raise_Application_Error(-20009,'������ο���Ȳ��� :' ||lt_T_DEPT_CODE2(li2)||'�� ����� �ο���Ȳ ����'||chr(10)||lsErrm);
			End;
		End Loop;
	End If;
	
	--���������رݾ� 
	Select
		DEPT_CODE,
		EMP_NO,
		BUDG_CODE_NO,
		ITEM_NO,
		BUDG_YM,
		UNIT_COST,
		QTY,
		AMT
	Bulk Collect Into
		lt_T_DEPT_CODE3,
		lt_T_EMP_NO3,
		lt_T_BUDG_CODE_NO1,
		lt_T_ITEM_NO1,
		lt_T_BUDG_YM1,
		lt_T_UNIT_COST1,
		lt_T_QTY1,
		lt_T_AMT1
	From	V_BUDG_022 a --������ ���رݾ� view
	Where	a.comp_code = AR_COMP_CODE
	and to_char(order_dt,'yyyy-mm') = (SELECT  to_char( ADD_MONTHS(SYSDATE,-1),'YYYY-MM') 
									  FROM dual )
	and rn >= decode(substr(AR_BUDG_APPLY_YM, 6,2), 
	   		  				'10', 10,
			                '11', 11,
			                '12', 12,
			  				substr(AR_BUDG_APPLY_YM, 7,1));
	
	li3Start := lt_T_EMP_NO3.First; 
	li3End 	 := lt_T_EMP_NO3.Last;
	
	If lt_T_EMP_NO3.Count > 0 Then
		
		For li3 In li3Start..li3End Loop
			Begin
	
				SP_T_BUDG_BF_BASE_AMT_I(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_ALL_CHG_SEQ, 
				                        lt_T_DEPT_CODE3(li3), lt_T_EMP_NO3(li3), lt_T_BUDG_CODE_NO1(li3), 
				                        lt_T_ITEM_NO1(li3), lt_T_BUDG_YM1(li3), AR_CRTUSERNO, 
										lt_T_UNIT_COST1(li3), lt_T_QTY1(li3), lt_T_AMT1(li3));     	
					
			Exception When Others Then
				lsErrm := SqlErrm;
				lnErrNo := SqlCode;
				lsErrm := Replace(lsErrm,'ORA-20009:','');
				Raise_Application_Error(-20009,'���رݾ�Root :' ||lt_T_BUDG_YM1(li3)||'�� ������ ���رݾ� ����'||chr(10)||lsErrm || lnErrNo);
			End;
		End Loop;
	End If;
	
	--��������رݾ� 
	Select
		DEPT_CODE,
		EMP_NO,
		BUDG_CODE_NO,
		ITEM_NO,
		BUDG_YM,
		UNIT_COST,
		QTY,
		AMT
	Bulk Collect Into
		lt_T_DEPT_CODE4,
		lt_T_EMP_NO4,
		lt_T_BUDG_CODE_NO2,
		lt_T_ITEM_NO2,
		lt_T_BUDG_YM2,
		lt_T_UNIT_COST2,
		lt_T_QTY2,
		lt_T_AMT2
	From	V_BUDG_023 a --���رݾ� view
	Where	a.comp_code = AR_COMP_CODE
	and to_char(order_dt,'yyyy-mm') = to_char(sysdate,'YYYY-MM')
	and rn >= decode(substr(AR_BUDG_APPLY_YM, 6,2), 
	   		  				'10', 10,
			                '11', 11,
			                '12', 12,
			  				substr(AR_BUDG_APPLY_YM, 7,1));
	
	li4Start := lt_T_EMP_NO4.First; 
	li4End 	 := lt_T_EMP_NO4.Last;
	
	If lt_T_EMP_NO4.Count > 0 Then
		
		For li4 In li4Start..li4End Loop
			Begin
	
				SP_T_BUDG_NOW_APPL_AMT_I(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_ALL_CHG_SEQ, lt_T_DEPT_CODE4(li4), lt_T_EMP_NO4(li4), lt_T_BUDG_CODE_NO2(li4), lt_T_ITEM_NO2(li4), lt_T_BUDG_YM2(li4), AR_CRTUSERNO, lt_T_UNIT_COST2(li4), lt_T_QTY2(li4), lt_T_AMT2(li4));     	
				
			Exception When Others Then
				lsErrm := SqlErrm;
				lsErrm := Replace(lsErrm,'ORA-20009:','');
				Raise_Application_Error(-20009,'��������رݾ� :' ||lt_T_DEPT_CODE4(li4)||'�� ������ �ο���Ȳ ����'||chr(10)||lsErrm);
			End;
		End Loop;
	End If;
	 
End;
/

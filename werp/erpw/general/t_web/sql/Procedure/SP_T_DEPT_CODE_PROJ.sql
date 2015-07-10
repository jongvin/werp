Create Or Replace Procedure SP_T_DEPT_CODE_PROJ_I
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ACC_CLOSE_DT                            VARCHAR2,
	AR_BUDG_APPL_DT                            VARCHAR2,
	AR_CONS_AMT                                NUMBER,
	AR_BUDG_AMT                                NUMBER,
	AR_AS_AMT                                  NUMBER,
	AR_COST_DESC_TAG                           VARCHAR2,
	AR_COST_GUESS_AMT                          Number Default 0,
	AR_F_CONS_AMT                              Number Default 0,
	AR_F_BUDG_AMT                              Number Default 0
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_DEPT_CODE_PROJ_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_DEPT_CODE_ORG ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-01-06)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Raise_Application_Error(-20009,'�� ���α׷����δ� ���� �Ǵ� �μ��� ����Ͻ� ���� �����ϴ�.');
End;
/
Create Or Replace Procedure SP_T_DEPT_CODE_PROJ_U
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ACC_CLOSE_DT                            VARCHAR2,
	AR_BUDG_APPL_DT                            VARCHAR2,
	AR_CONS_AMT                                NUMBER,
	AR_BUDG_AMT                                NUMBER,
	AR_AS_AMT                                  NUMBER,
	AR_COST_DESC_TAG                           VARCHAR2,
	AR_COST_GUESS_AMT                          Number Default 0,
	AR_F_CONS_AMT                              Number Default 0,
	AR_F_BUDG_AMT                              Number Default 0
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_DEPT_CODE_PROJ_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_DEPT_CODE_ORG ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-01-06)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	lrRec									T_DEPT_BUDG_HIST%RowType;
	lbFound									Boolean;
Begin
	Update T_DEPT_CODE_ORG
	Set
		MODUSERNO = AR_CRTUSERNO,
		MODDATE = SYSDATE,
		ACC_CLOSE_DT = F_T_StringToDate(AR_ACC_CLOSE_DT),
		BUDG_APPL_DT = F_T_StringToDate(AR_BUDG_APPL_DT),
		CONS_AMT = AR_CONS_AMT,
		BUDG_AMT = AR_BUDG_AMT,
		AS_AMT = AR_AS_AMT,
		COST_DESC_TAG = AR_COST_DESC_TAG,
		COST_GUESS_AMT = AR_COST_GUESS_AMT,
		F_CONS_AMT = AR_F_CONS_AMT,
		F_BUDG_AMT = AR_F_BUDG_AMT
	Where	DEPT_CODE = AR_DEPT_CODE;
	lbFound := False;
	If Nvl(AR_CONS_AMT,0) <> 0 Or Nvl(AR_BUDG_AMT,0) <> 0 Then
		If AR_BUDG_APPL_DT Is Null Then
			Raise_Application_Error(-20009,'���ޱݾ� �Ǵ� ����ݾ��� �ִ� ���� �ݵ�� ����ݿ����� �Է��ϼž� �մϴ�.');
		End If;
		Begin
			Select
				*
			Into
				lrRec
			From	T_DEPT_BUDG_HIST a
			Where	a.DEPT_CODE = AR_DEPT_CODE
			And		a.BUDG_APPL_DT = 
			(
				Select
					Max(b.BUDG_APPL_DT)
				From	T_DEPT_BUDG_HIST b
				Where	a.DEPT_CODE = b.DEPT_CODE
			);
			lbFound := True;
		Exception When No_Data_Found Then
			lbFound := False;
		End;
		If lbFound Then
			If lrRec.BUDG_APPL_DT > F_T_StringToDate(AR_BUDG_APPL_DT) Then
				Raise_Application_Error(-20009,'���� ����ݿ��Ϻ��� �������� ����ݿ��� �Ͻ� �� �� �����ϴ�.');
			End If;
			If Nvl(AR_CONS_AMT,0) = Nvl(lrRec.CONS_AMT,0) And Nvl(AR_BUDG_AMT,0) = Nvl(lrRec.BUDG_AMT,0) Then	--�ݾ׺����� ���ٸ� ����ĥ �ʿ� ����.
				Null;
			End If;
			If lrRec.BUDG_APPL_DT = F_T_StringToDate(AR_BUDG_APPL_DT) Then	--�ݾ��� �ٲ���µ� �ݿ����� �� �ٲ����.
				Update	T_DEPT_BUDG_HIST
				Set		CONS_AMT = AR_CONS_AMT,
						BUDG_AMT = AR_BUDG_AMT
				Where	DEPT_CODE = Ar_DEPT_CODE
				And		BUDG_APPL_DT = lrRec.BUDG_APPL_DT;
			Else
				Insert Into T_DEPT_BUDG_HIST
				(
					DEPT_CODE,
					BUDG_APPL_DT,
					CRTUSERNO,
					CRTDATE,
					CONS_AMT,
					BUDG_AMT
				)
				Values
				(
					AR_DEPT_CODE,
					F_T_StringToDate(AR_BUDG_APPL_DT),
					AR_CRTUSERNO,
					SysDate,
					AR_CONS_AMT,
					AR_BUDG_AMT
				);
			End If;
		Else
			Insert Into T_DEPT_BUDG_HIST
			(
				DEPT_CODE,
				BUDG_APPL_DT,
				CRTUSERNO,
				CRTDATE,
				CONS_AMT,
				BUDG_AMT
			)
			Values
			(
				AR_DEPT_CODE,
				F_T_StringToDate(AR_BUDG_APPL_DT),
				AR_CRTUSERNO,
				SysDate,
				AR_CONS_AMT,
				AR_BUDG_AMT
			);
		End If;
	End If;
End;
/
Create Or Replace Procedure SP_T_DEPT_CODE_PROJ_D
(
	AR_DEPT_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_DEPT_CODE_PROJ_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_DEPT_CODE_ORG ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-01-06)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Raise_Application_Error(-20009,'�� ���α׷����δ� ���� �Ǵ� �μ��� �����Ͻ� ���� �����ϴ�.');
End;
/

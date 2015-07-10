Create Or Replace Procedure SP_T_FL_COPY_M_MARKET
(
	AR_WORK_DT                                 VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_M_MARKET_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_M_MARKET ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-21)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	lddtMax							Date;
Begin
	Select
		Max(WORK_DT)
	Into
		lddtMax
	From	T_FL_M_MARKET
	Where	WORK_DT < F_T_StringToDate(AR_WORK_DT);
	
	If lddtMax Is Null Then
		Raise_Application_Error(-20009,'���� ���� ���� �ڷḦ ã�� �� �����ϴ�.');
	End If;
	
	Delete T_FL_M_MARKET
	Where	WORK_DT = F_T_StringToDate(AR_WORK_DT);

	Insert Into T_FL_M_MARKET
	(
		M_MARKET_STAT_CODE,
		WORK_DT,
		CRTUSERNO,
		CRTDATE,
		ITR_RATIO,
		P_D_UD_TAG,
		P_D_UD_POS,
		P_M_UD_TAG,
		P_M_UD_POS,
		P_Y_UD_TAG,
		P_Y_UD_POS,
		P_ML_RATIO,
		P_YL_RATIO,
		P_D_RATIO
	)
	Select
		M_MARKET_STAT_CODE,
		F_T_StringToDate(AR_WORK_DT),
		AR_CRTUSERNO,
		SysDate,
		ITR_RATIO,
		P_D_UD_TAG,
		P_D_UD_POS,
		P_M_UD_TAG,
		P_M_UD_POS,
		P_Y_UD_TAG,
		P_Y_UD_POS,
		P_ML_RATIO,
		P_YL_RATIO,
		ITR_RATIO
	From	T_FL_M_MARKET
	Where	WORK_DT = lddtMax;
End;
/

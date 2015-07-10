<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Select Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
 
	CITGauceInfo GauceInfo = null;
	
	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;

	String	strSql = "";
	String	strAct = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MAIN"))
		{
			String strSHEET_CODE = CITCommon.toKOR(request.getParameter("SHEET_CODE"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			
			strSql  = " SELECT \n";
			strSql += " 	P.SHEET_NAME, \n";
			strSql += " 	P.PAST_ACC_ID, \n";
			strSql += " 	P.COMPANY_NAME, \n";
			strSql += " 	P.DEPT_NAME, \n";
			strSql += " 	P.CURR_ACC_ID_NAME, \n";
			strSql += " 	P.PAST_ACC_ID_NAME, \n";
			strSql += " 	P.PRE_SUB_01, \n";
			strSql += " 	P.PRE_SUB_02, \n";
			strSql += " 	P.PRE_SUB_03, \n";
			strSql += " 	P.PRE_SUB_04, \n";
			strSql += " 	P.PAST_ACC_FDT , \n";
			strSql += " 	P.PAST_ACC_EDT , \n";
			strSql += " 	P.CURR_ACC_ID , \n";
			strSql += " 	P.CURR_ACC_FDT , \n";
			strSql += " 	P.CURR_ACC_EDT, \n";
			strSql += " 	P.EDIT_DT, \n";
			strSql += " 	P.SHEET_CODE , \n";
			strSql += " 	P.COMP_CODE , \n";
			strSql += " 	P.DEPT_CODE , \n";
			strSql += " 	P.ITEM_CODE , \n";
			strSql += " 	P.ITEM_LVL , \n";
			strSql += " 	P.CRTUSERNO , \n";
			strSql += " 	P.CRTDATE , \n";
			strSql += " 	P.MODUSERNO , \n";
			strSql += " 	P.MODDATE , \n";
			strSql += " 	P.ITEM_NAME , \n";
			strSql += " 	P.BOLD_CLS , \n";
			strSql += " 	P.OUT_CLS , \n";
			strSql += " 	P.UPLINE_CLS , \n";
			strSql += " 	P.DOWNLINE_CLS , \n";
			strSql += " 	P.ITEM_ENG_NAME , \n";
			strSql += " 	P.POSITION , \n";
			strSql += " 	P.CURR_LEFT , \n";
			strSql += " 	P.CURR_RIGHT , \n";
			strSql += " 	P.PAST_LEFT , \n";
			strSql += " 	P.PAST_RIGHT , \n";
			strSql += " 	P.CURR_LEFT_REM, \n";
			strSql += " 	P.CURR_RIGHT_REM, \n";
			strSql += " 	P.DOWNLINE_LEFT , \n";
			strSql += " 	P.DOWNLINE_RIGHT , \n";
			strSql += " 	P.UPLINE_LEFT , \n";
			strSql += " 	P.UPLINE_RIGHT \n";
			strSql += " FROM \n";
			strSql += " 	( \n";
			strSql += " 		SELECT \n";
			strSql += " 			C.SHEET_NAME, \n";
			strSql += " 			D.PAST_ACC_ID, \n";
			strSql += " 			DECODE(A.COMP_CODE,'%','��ü',E.COMPANY_NAME) COMPANY_NAME, \n";
			strSql += " 			DECODE(A.DEPT_CODE,'%','��ü',F.DEPT_NAME) DEPT_NAME, \n";
			strSql += " 			'���('||D.CURR_ACC_ID||')��' CURR_ACC_ID_NAME, \n";
			strSql += " 			'����('||D.PAST_ACC_ID||')��' PAST_ACC_ID_NAME, \n";
			strSql += " 			'���('||D.CURR_ACC_ID||')�� '|| F_T_DATETOSTRING(D.CURR_ACC_EDT)||' ����' PRE_SUB_01, \n";
			strSql += " 			'����('||D.PAST_ACC_ID||')�� '||F_T_DATETOSTRING(D.PAST_ACC_EDT)||' ����' PRE_SUB_02, \n";
			strSql += " 			'���('||D.CURR_ACC_ID||')�� '||F_T_DATETOSTRING(D.CURR_ACC_FDT)||' ~ '||F_T_DATETOSTRING(D.CURR_ACC_EDT) PRE_SUB_03, \n";
			strSql += " 			'����('||D.PAST_ACC_ID||')�� '||F_T_DATETOSTRING(D.PAST_ACC_FDT)||' ~ '||F_T_DATETOSTRING(D.PAST_ACC_EDT) PRE_SUB_04, \n";
			strSql += " 			F_T_DATETOSTRING(D.PAST_ACC_FDT) PAST_ACC_FDT , \n";
			strSql += " 			F_T_DATETOSTRING(D.PAST_ACC_EDT) PAST_ACC_EDT , \n";
			strSql += " 			D.CURR_ACC_ID , \n";
			strSql += " 			F_T_DATETOSTRING(D.CURR_ACC_FDT) CURR_ACC_FDT , \n";
			strSql += " 			F_T_DATETOSTRING(D.CURR_ACC_EDT) CURR_ACC_EDT, \n";
			strSql += " 			F_T_DATETOSTRING(D.EDIT_DT) EDIT_DT, \n";
			strSql += " 			A.SHEET_CODE , \n";
			strSql += " 			A.COMP_CODE , \n";
			strSql += " 			A.DEPT_CODE , \n";
			strSql += " 			A.ITEM_CODE , \n";
			strSql += " 			B.ITEM_LVL , \n";
			strSql += " 			TO_CHAR(A.CRTUSERNO) CRTUSERNO , \n";
			strSql += " 			A.CRTDATE , \n";
			strSql += " 			TO_CHAR(A.MODUSERNO) MODUSERNO , \n";
			strSql += " 			A.MODDATE , \n";
			strSql += " 			A.ITEM_NAME , \n";
			strSql += " 			A.BOLD_CLS , \n";
			strSql += " 			A.OUT_CLS , \n";
			strSql += " 			A.UPLINE_CLS , \n";
			strSql += " 			A.DOWNLINE_CLS , \n";
			strSql += " 			A.ITEM_ENG_NAME , \n";
			strSql += " 			B.POSITION , \n";
			strSql += " 			A.CURR_LEFT , \n";
			strSql += " 			A.CURR_RIGHT , \n";
			strSql += " 			A.PAST_LEFT , \n";
			strSql += " 			A.PAST_RIGHT , \n";
			strSql += " 			DECODE(B.POSITION , 'L' , NVL( A.CURR_LEFT ,0) - NVL(A.CURR_RIGHT , 0) , 0 ) CURR_LEFT_REM, \n";
			strSql += " 			DECODE(B.POSITION , 'R' , NVL( A.CURR_RIGHT ,0) - NVL(A.CURR_LEFT , 0) , 0 ) CURR_RIGHT_REM, \n";
			strSql += " 			DECODE(A.DOWNLINE_CLS,'T',RPAD('��',300,'��'),'L',RPAD('��',300,'��'),'') DOWNLINE_LEFT , \n";
			strSql += " 			DECODE(A.DOWNLINE_CLS,'T',RPAD('��',300,'��'),'R',RPAD('��',300,'��'),'') DOWNLINE_RIGHT , \n";
			strSql += " 			DECODE(A.UPLINE_CLS,'T',RPAD('��',300,'��'),'L',RPAD('��',300,'��'),'') UPLINE_LEFT , \n";
			strSql += " 			DECODE(A.UPLINE_CLS,'T',RPAD('��',300,'��'),'R',RPAD('��',300,'��'),'') UPLINE_RIGHT \n";
			strSql += " 		FROM	T_SHEET_SUM_BODY A, \n";
			strSql += " 				T_SHEET_EXPR_HEAD B, \n";
			strSql += " 				T_SHEET_CODE C, \n";
			strSql += " 				T_SHEET_SUM_HEAD D, \n";
			strSql += " 				T_COMPANY_ORG E, \n";
			strSql += " 				T_DEPT_CODE_ORG F \n";
			strSql += " 		WHERE	A.SHEET_CODE =  ?  \n";
			strSql += " 		AND		A.COMP_CODE =  ?  \n";
			strSql += " 		AND		A.DEPT_CODE =  ?  \n";
			strSql += " 		AND		A.SHEET_CODE = B.SHEET_CODE \n";
			strSql += " 		AND		A.ITEM_CODE = B.ITEM_CODE \n";
			strSql += " 		AND		A.SHEET_CODE = C.SHEET_CODE \n";
			strSql += " 		AND		A.SHEET_CODE = D.SHEET_CODE \n";
			strSql += " 		AND		A.COMP_CODE = D.COMP_CODE \n";
			strSql += " 		AND		A.DEPT_CODE = D.DEPT_CODE \n";
			strSql += " 		AND		A.OUT_CLS <> 'F' \n";
			strSql += " 		AND		A.COMP_CODE = E.COMP_CODE (+) \n";
			strSql += " 		AND		A.DEPT_CODE = F.DEPT_CODE (+) \n";
			strSql += " 		UNION \n";
			strSql += " 		SELECT \n";
			strSql += " 			C.SHEET_NAME, \n";
			strSql += " 			D.PAST_ACC_ID, \n";
			strSql += " 			DECODE(A.COMP_CODE,'%','��ü',E.COMPANY_NAME) COMPANY_NAME, \n";
			strSql += " 			DECODE(A.DEPT_CODE,'%','��ü',F.DEPT_NAME) DEPT_NAME, \n";
			strSql += " 			'���('||D.CURR_ACC_ID||')��' CURR_ACC_ID_NAME, \n";
			strSql += " 			'����('||D.PAST_ACC_ID||')��' PAST_ACC_ID_NAME, \n";
			strSql += " 			'���('||D.CURR_ACC_ID||')�� '||F_T_DATETOSTRING(D.CURR_ACC_EDT)||' ����' PRE_SUB_01, \n";
			strSql += " 			'����('||D.PAST_ACC_ID||')�� '||F_T_DATETOSTRING(D.PAST_ACC_EDT)||' ����' PRE_SUB_02, \n";
			strSql += " 			'���('||D.CURR_ACC_ID||')�� '||F_T_DATETOSTRING(D.CURR_ACC_FDT)||' ~ '||F_T_DATETOSTRING(D.CURR_ACC_EDT) PRE_SUB_03, \n";
			strSql += " 			'����('||D.PAST_ACC_ID||')�� '||F_T_DATETOSTRING(D.PAST_ACC_FDT)||' ~ '||F_T_DATETOSTRING(D.PAST_ACC_EDT) PRE_SUB_04, \n";
			strSql += " 			F_T_DATETOSTRING(D.PAST_ACC_FDT) PAST_ACC_FDT , \n";
			strSql += " 			F_T_DATETOSTRING(D.PAST_ACC_EDT) PAST_ACC_EDT , \n";
			strSql += " 			D.CURR_ACC_ID , \n";
			strSql += " 			F_T_DATETOSTRING(D.CURR_ACC_FDT) CURR_ACC_FDT , \n";
			strSql += " 			F_T_DATETOSTRING(D.CURR_ACC_EDT) CURR_ACC_EDT, \n";
			strSql += " 			F_T_DATETOSTRING(D.EDIT_DT) EDIT_DT, \n";
			strSql += " 			A.SHEET_CODE , \n";
			strSql += " 			A.COMP_CODE , \n";
			strSql += " 			A.DEPT_CODE , \n";
			strSql += " 			'9999999999' ITEM_CODE , \n";
			strSql += " 			1 ITEM_LVL , \n";
			strSql += " 			TO_CHAR(A.CRTUSERNO) CRTUSERNO , \n";
			strSql += " 			A.CRTDATE , \n";
			strSql += " 			TO_CHAR(A.MODUSERNO) MODUSERNO , \n";
			strSql += " 			A.MODDATE , \n";
			strSql += " 			'          ��             ��' ITEM_NAME , \n";
			strSql += " 			'' BOLD_CLS , \n";
			strSql += " 			'T' OUT_CLS , \n";
			strSql += " 			'' UPLINE_CLS , \n";
			strSql += " 			'' DOWNLINE_CLS , \n";
			strSql += " 			'' ITEM_ENG_NAME , \n";
			strSql += " 			'' POSITION , \n";
			strSql += " 			SUM(A.CURR_LEFT) CURR_LEFT , \n";
			strSql += " 			SUM(A.CURR_RIGHT) CURR_RIGHT , \n";
			strSql += " 			SUM(A.PAST_LEFT) PAST_LEFT , \n";
			strSql += " 			SUM(A.PAST_RIGHT) PAST_RIGHT, \n";
			strSql += " 			SUM(DECODE(B.POSITION , 'L' , NVL( A.CURR_LEFT ,0) - NVL(A.CURR_RIGHT , 0) , 0 )) CURR_LEFT_REM, \n";
			strSql += " 			SUM(DECODE(B.POSITION , 'R' , NVL( A.CURR_RIGHT ,0) - NVL(A.CURR_LEFT , 0) , 0 )) CURR_RIGHT_REM, \n";
			strSql += " 			'' DOWNLINE_LEFT , \n";
			strSql += " 			'' DOWNLINE_RIGHT , \n";
			strSql += " 			'' UPLINE_LEFT , \n";
			strSql += " 			'' UPLINE_RIGHT \n";
			strSql += " 		FROM	T_SHEET_SUM_BODY A, \n";
			strSql += " 				T_SHEET_EXPR_HEAD B, \n";
			strSql += " 				T_SHEET_CODE C, \n";
			strSql += " 				T_SHEET_SUM_HEAD D, \n";
			strSql += " 				T_COMPANY_ORG E, \n";
			strSql += " 				T_DEPT_CODE_ORG F \n";
			strSql += " 		WHERE	A.SHEET_CODE =  ?  \n";
			strSql += " 		AND		A.COMP_CODE =  ?  \n";
			strSql += " 		AND		A.DEPT_CODE =  ?  \n";
			strSql += " 		AND		B.ITEM_LVL = '1' \n";
			strSql += " 		AND		A.SHEET_CODE = B.SHEET_CODE \n";
			strSql += " 		AND		A.ITEM_CODE = B.ITEM_CODE \n";
			strSql += " 		AND		A.SHEET_CODE = C.SHEET_CODE \n";
			strSql += " 		AND		A.SHEET_CODE = D.SHEET_CODE \n";
			strSql += " 		AND		A.COMP_CODE = D.COMP_CODE \n";
			strSql += " 		AND		A.DEPT_CODE = D.DEPT_CODE \n";
			strSql += " 		AND		A.OUT_CLS <> 'F' \n";
			strSql += " 		AND		A.COMP_CODE = E.COMP_CODE (+) \n";
			strSql += " 		AND		A.DEPT_CODE = F.DEPT_CODE (+) \n";
			strSql += " 		GROUP BY \n";
			strSql += " 			C.SHEET_NAME, \n";
			strSql += " 			D.PAST_ACC_ID, \n";
			strSql += " 			DECODE(A.COMP_CODE,'%','��ü',E.COMPANY_NAME), \n";
			strSql += " 			DECODE(A.DEPT_CODE,'%','��ü',F.DEPT_NAME), \n";
			strSql += " 			'���('||D.CURR_ACC_ID||')��', \n";
			strSql += " 			'����('||D.PAST_ACC_ID||')��', \n";
			strSql += " 			'���('||D.CURR_ACC_ID||')�� '||F_T_DATETOSTRING(D.CURR_ACC_EDT)||' ����', \n";
			strSql += " 			'����('||D.PAST_ACC_ID||')�� '||F_T_DATETOSTRING(D.PAST_ACC_EDT)||' ����', \n";
			strSql += " 			'���('||D.CURR_ACC_ID||')�� '||F_T_DATETOSTRING(D.CURR_ACC_FDT)||' ~ '||F_T_DATETOSTRING(D.CURR_ACC_EDT), \n";
			strSql += " 			'����('||D.PAST_ACC_ID||')�� '||F_T_DATETOSTRING(D.PAST_ACC_FDT)||' ~ '||F_T_DATETOSTRING(D.PAST_ACC_EDT), \n";
			strSql += " 			F_T_DATETOSTRING(D.PAST_ACC_FDT), \n";
			strSql += " 			F_T_DATETOSTRING(D.PAST_ACC_EDT), \n";
			strSql += " 			D.CURR_ACC_ID , \n";
			strSql += " 			F_T_DATETOSTRING(D.CURR_ACC_FDT), \n";
			strSql += " 			F_T_DATETOSTRING(D.CURR_ACC_EDT), \n";
			strSql += " 			F_T_DATETOSTRING(D.EDIT_DT), \n";
			strSql += " 			A.SHEET_CODE , \n";
			strSql += " 			A.COMP_CODE , \n";
			strSql += " 			A.DEPT_CODE , \n";
			strSql += " 			TO_CHAR(A.CRTUSERNO), \n";
			strSql += " 			A.CRTDATE , \n";
			strSql += " 			TO_CHAR(A.MODUSERNO), \n";
			strSql += " 			A.MODDATE \n";
			strSql += " 	) P \n";
			strSql += " ORDER BY \n";
			strSql += " 	P.SHEET_CODE , \n";
			strSql += " 	P.COMP_CODE , \n";
			strSql += " 	P.DEPT_CODE , \n";
			strSql += " 	P.ITEM_CODE \n";
			strSql += "  ";
			
			lrArgData.addColumn("1SHEET_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("3DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("4SHEET_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("5COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("6DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1SHEET_CODE", strSHEET_CODE);
			lrArgData.setValue("2COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("3DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("4SHEET_CODE", strSHEET_CODE);
			lrArgData.setValue("5COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("6DEPT_CODE", strDEPT_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				


				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("FULL_PROJ"))
		{
			String strSHEET_CODE = CITCommon.toKOR(request.getParameter("SHEET_CODE"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			
			strSql  = " SELECT \n";
			strSql += " 	A.ITEM_CODE ,  \n";
			strSql += " 	H.ITEM_NAME,  \n";
			strSql += " 	B.ITEM_LVL,  \n";
			strSql += " 	DECODE(A.DEPT_CODE,'%','ZZZZZZZ',A.DEPT_CODE) DEPT_CODE ,  \n";
			strSql += " 	DECODE(A.DEPT_CODE,'%','��      ��',C.DEPT_NAME) DEPT_NAME,  \n";
			strSql += " 	NVL(A.CURR_LEFT,0)+NVL(A.CURR_RIGHT,0) CURR_AMT,  \n";
			strSql += " 	NVL(A.PAST_LEFT,0)+NVL(A.PAST_RIGHT,0) PAST_AMT  \n";
			strSql += " FROM	T_SHEET_SUM_BODY A,  \n";
			strSql += " 		T_SHEET_EXPR_HEAD B,  \n";
			strSql += " 		T_DEPT_CODE_ORG C,  \n";
			strSql += "    		(  \n";
			strSql += " 			SELECT \n";
			strSql += " 				A.ITEM_CODE,  \n";
			strSql += " 				A.ITEM_NAME  \n";
			strSql += " 			FROM	T_SHEET_SUM_BODY A  \n";
			strSql += " 			WHERE	A.SHEET_CODE   =   ?  \n";
			strSql += " 			AND		A.COMP_CODE =   ?  \n";
			strSql += " 			AND		A.DEPT_CODE    =  '%'  \n";
			strSql += "    		)  H  \n";
			strSql += " WHERE	A.SHEET_CODE   = B.SHEET_CODE  \n";
			strSql += " AND		A.ITEM_CODE    = B.ITEM_CODE  \n";
			strSql += " AND		A.DEPT_CODE    = C.DEPT_CODE(+)  \n";
			strSql += " AND		A.ITEM_CODE    = H.ITEM_CODE  \n";
			strSql += " AND		A.SHEET_CODE   =  ?  \n";
			strSql += " AND		A.COMP_CODE =  ?  \n";
			strSql += " AND		A.OUT_CLS      <> 'F'  \n";
			strSql += " AND		NOT EXISTS \n";
			strSql += " 		( \n";
			strSql += " 			SELECT \n";
			strSql += " 				G.DEPT_CODE  \n";
			strSql += " 			FROM	T_SHEET_SUM_BODY G  \n";
			strSql += " 			WHERE	G.DEPT_CODE    =  A.DEPT_CODE  \n";
			strSql += " 			AND		G.SHEET_CODE   =   ?  \n";
			strSql += " 			AND		G.COMP_CODE =   ?  \n";
			strSql += " 			HAVING	(SUM(NVL(G.CURR_LEFT,0)) +  \n";
			strSql += "                                SUM(NVL(G.CURR_RIGHT,0))) = 0  \n";
			strSql += " 			GROUP BY \n";
			strSql += " 				G.SHEET_CODE)  \n";
			strSql += " ORDER BY \n";
			strSql += " 	A.ITEM_CODE,  \n";
			strSql += " 	A.DEPT_CODE  \n";
			strSql += "  ";
			
			lrArgData.addColumn("1SHEET_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("3SHEET_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("4COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("5SHEET_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("6COMP_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1SHEET_CODE", strSHEET_CODE);
			lrArgData.setValue("2COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("3SHEET_CODE", strSHEET_CODE);
			lrArgData.setValue("4COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("5SHEET_CODE", strSHEET_CODE);
			lrArgData.setValue("6COMP_CODE", strCOMP_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				


				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","FULL_PROJ Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("HEAD"))
		{
			String strSHEET_CODE = CITCommon.toKOR(request.getParameter("SHEET_CODE"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			
			strSql  = " Select  \n";
			strSql += " 	a.SHEET_CODE ,  \n";
			strSql += " 	a.COMP_CODE ,  \n";
			strSql += " 	a.DEPT_CODE ,  \n";
			strSql += " 	To_Char(a.CRTUSERNO) CRTUSERNO ,  \n";
			strSql += " 	a.CRTDATE ,  \n";
			strSql += " 	To_Char(a.MODUSERNO) MODUSERNO ,  \n";
			strSql += " 	a.MODDATE ,  \n";
			strSql += " 	a.PAST_ACC_ID ,  \n";
			strSql += " 	F_T_DATETOSTRING(a.PAST_ACC_FDT) PAST_ACC_FDT ,  \n";
			strSql += " 	F_T_DATETOSTRING(a.PAST_ACC_EDT) PAST_ACC_EDT ,  \n";
			strSql += " 	a.CURR_ACC_ID ,  \n";
			strSql += " 	F_T_DATETOSTRING(a.CURR_ACC_FDT) CURR_ACC_FDT ,  \n";
			strSql += " 	F_T_DATETOSTRING(a.CURR_ACC_EDT) CURR_ACC_EDT ,  \n";
			strSql += " 	AMTUNIT ,  \n";
			strSql += " 	F_T_DATETOSTRING(a.EDIT_DT) EDIT_DT ,  \n";
			strSql += " 	To_Char(a.EDIT_USERNO) EDIT_USERNO  \n";
			strSql += " From	T_SHEET_SUM_HEAD a  \n";
			strSql += " Where	a.SHEET_CODE =  ?  \n";
			strSql += " And		a.COMP_CODE =  ?  \n";
			strSql += " And		a.DEPT_CODE = ? \n";
			strSql += "  ";
			
			lrArgData.addColumn("1SHEET_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("3DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1SHEET_CODE", strSHEET_CODE);
			lrArgData.setValue("2COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("3DEPT_CODE", strDEPT_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				


				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","HEAD Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SHEET_CODE"))
		{

			
			strSql  = " Select \n";
			strSql += " 	a.SHEET_CODE , \n";
			strSql += " 	a.SHEET_TYPE , \n";
			strSql += " 	a.SHEET_NAME \n";
			strSql += " From	T_SHEET_CODE a \n";
			strSql += " Order By \n";
			strSql += " 	a.SHEET_CODE \n";
			strSql += "  ";
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				


				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","SHEET_CODE Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("MAKE"))
		{


			strSql  = "select \n";
			strSql  += "	RPad('X',40,'X') SHEET_CODE,RPad('X',40,'X') COMP_CODE,RPad('X',40,'X') DEPT_CODE, \n";
			strSql  += "	0 CRTUSERNO, 'F' PROJ_TAG \n";
			strSql  += "From	dual";


			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, new CITData());

				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null)
				{
					GauceInfo.response.writeException("USER", "900001","MAKE Select ����-> "+ ex.getMessage());
				}
				else
				{
					throw new Exception("USER-900001:MAKE Select ���� -> " + ex.getMessage());
				}
			}
		}
		else if (strAct.equals("COMPANY"))
		{


			strSql  = "Select \n";
			strSql  += "	a.COMP_CODE, \n";
			strSql  += "	a.COMPANY_NAME, \n";
			strSql  += "	9 SEQ \n";
			strSql  += "From	T_COMPANY a \n";
			strSql  += "Union \n";
			strSql  += "Select \n";
			strSql  += "	'%', \n";
			strSql  += "	'��ü', \n";
			strSql  += "	0 \n";
			strSql  += "From	Dual \n";
			strSql  += "Order By \n";
			strSql  += "	3,1";


			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);


				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null)
				{
					GauceInfo.response.writeException("USER", "900001","COMPANY Select ����-> "+ ex.getMessage());
				}
				else
				{
					throw new Exception("USER-900001:COMPANY Select ���� -> " + ex.getMessage());
				}
			}
		}
		else if (strAct.equals("DEPT_CODE"))
		{
			String	strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));

			strSql  = "Select \n";
			strSql  += "	a.DEPT_CODE \n";
			strSql  += "From	T_DEPT_CODE a \n";
			strSql  += "Where	NVL(A.COMP_CODE, '000') LIKE ? \n";

			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE",strCOMP_CODE);

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);


				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null)
				{
					GauceInfo.response.writeException("USER", "900001","COMPANY Select ����-> "+ ex.getMessage());
				}
				else
				{
					throw new Exception("USER-900001:COMPANY Select ���� -> " + ex.getMessage());
				}
			}
		}
		else if (strAct.equals("SHEET_DEL"))
		{
			String strSHEET_CODE   = CITCommon.toKOR(request.getParameter("SHEET_CODE"));
			String strCOMP_CODE  = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			
			strSql = "{call SP_T_SHEET_SUM_HEAD_ALL_D(?,?)}";
			
			
			lrArgData.addColumn("SHEET_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("SHEET_CODE",  strSHEET_CODE);
			lrArgData.setValue("COMP_CODE",  strCOMP_CODE);
			
			try
			{
				CITDatabase.executeProcedure(strSql, lrArgData);
			}
			catch (Exception ex)
			{
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","SCHINI Select ����-> "+ ex.getMessage());
				throw new Exception("USER-900001:SCHINI Select ���� -> " + ex.getMessage());
			}
		}
		else if (strAct.equals("ACC_ID"))
		{
			String strACCOUNT_FDT = CITCommon.toKOR(request.getParameter("ACCOUNT_FDT"));
			
			strSql  = " SELECT   F_T_DATETOSTRING(A.ACCOUNT_FDT) ACCOUNT_FDT, \n";
			strSql += "          F_T_DATETOSTRING(A.ACCOUNT_EDT) ACCOUNT_EDT, \n";
			strSql += "          A.CLSE_ACC_ID \n";
			strSql += " FROM     T_YEAR_CLOSE A \n";
			strSql += " WHERE    A.ACCOUNT_FDT <=  F_T_STRINGTODATE( ? ) \n";
			strSql += " AND      A.ACCOUNT_EDT >=  F_T_STRINGTODATE( ? ) \n";
			strSql += "  ";
			
			lrArgData.addColumn("1ACCOUNT_FDT", CITData.VARCHAR2);
			lrArgData.addColumn("2ACCOUNT_EDT", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1ACCOUNT_FDT", strACCOUNT_FDT);
			lrArgData.setValue("2ACCOUNT_EDT", strACCOUNT_FDT);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				


				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","ACC_ID Select ����-> "+ ex.getMessage());
			}
		}
	}
	catch (Exception ex)
	{
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "������ �ʱ�ȭ ���� -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITCommon.finalServerPage(GauceInfo);
		}
		catch (Exception ex)
		{
			if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
			GauceInfo.response.writeException("SYS", "100002", "������ ���� ���� -> " + ex.getMessage());
		}
	}
%>
<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-26)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
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
			String strWORK_DT_F = CITCommon.toKOR(request.getParameter("WORK_DT_F"));
			String strWORK_DT_T = CITCommon.toKOR(request.getParameter("WORK_DT_T"));
			
			strSql  = " Select \n";
			strSql += " 	a.WORK_NO , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	F_T_DATETOSTRING(a.WORK_DT) WORK_DT , \n";
			strSql += " 	a.DESCRIPTION , \n";
			strSql += " 	F_T_DATETOSTRING(a.CALC_DT_FROM) CALC_DT_FROM , \n";
			strSql += " 	F_T_DATETOSTRING(a.CALC_DT_TO) CALC_DT_TO , \n";
			strSql += " 	a.TARGET_COMP_CODE , \n";
			strSql += " 	a.NP_ITR_AMT , \n";
			strSql += " 	To_Char(a.SLIP_ID) SLIP_ID , \n";
			strSql += " 	To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ, \n";
			strSql += " 	b.MAKE_COMP_CODE , \n";
			strSql += " 	b.MAKE_DT , \n";
			strSql += " 	To_Char(b.MAKE_SEQ) MAKE_SEQ , \n";
			strSql += " 	b.SLIP_KIND_TAG , \n";
			strSql += " 	b.MAKE_SLIPNO \n";
			strSql += " From	T_FIN_SEC_NP_ITR_WORK a, \n";
			strSql += " 		T_ACC_SLIP_HEAD b \n";
			strSql += " Where	a.WORK_DT Between  ?  And  Last_Day(?)  \n";
			strSql += " And		a.SLIP_ID = b.SLIP_ID (+) \n";
			strSql += " Order By \n";
			strSql += " 	a.WORK_DT, \n";
			strSql += " 	a.WORK_NO ";
			
			lrArgData.addColumn("1WORK_DT_F", CITData.DATE);
			lrArgData.addColumn("2WORK_DT_T", CITData.DATE);
			lrArgData.addRow();
			lrArgData.setValue("1WORK_DT_F", strWORK_DT_F);
			lrArgData.setValue("2WORK_DT_T", strWORK_DT_T);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("WORK_NO", true);
				lrReturnData.setNotNull("WORK_DT", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SUB01"))
		{
			String strWORK_NO = CITCommon.toKOR(request.getParameter("WORK_NO"));
			
			strSql  = " Select \n";
			strSql += " 	a.WORK_NO , \n";
			strSql += " 	a.SECU_NO , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	To_Char(a.ITR_CALC_NO) ITR_CALC_NO, \n";
			strSql += " 	b.SEC_KIND_CODE , \n";
			strSql += " 	b.REAL_SECU_NO , \n";
			strSql += " 	b.COMP_CODE , \n";
			strSql += " 	F_T_DATETOSTRING(b.PUBL_DT) PUBL_DT , \n";
			strSql += " 	F_T_DATETOSTRING(b.GET_DT) GET_DT , \n";
			strSql += " 	b.GET_PLACE , \n";
			strSql += " 	b.PERSTOCK_AMT , \n";
			strSql += " 	F_T_DATETOSTRING(b.EXPR_DT) EXPR_DT , \n";
			strSql += " 	b.INTR_RATE, \n";
			strSql += " 	c.NP_ITR_AMT, \n";
			strSql += " 	d.COMPANY_NAME, \n";
			strSql += " 	e.SEC_KIND_NAME \n";
			strSql += " From	T_FIN_NP_ITR_TAR_SEC a, \n";
			strSql += " 		T_FIN_SECURTY b, \n";
			strSql += " 		T_FIN_SEC_ITR_AMT c, \n";
			strSql += " 		T_COMPANY_ORG d, \n";
			strSql += " 		T_FIN_SEC_KIND e \n";
			strSql += " Where	a.WORK_NO =  ?  \n";
			strSql += " And		a.SECU_NO = b.SECU_NO \n";
			strSql += " And		a.SECU_NO = c.SECU_NO (+) \n";
			strSql += " And		a.ITR_CALC_NO = c.ITR_CALC_NO (+) \n";
			strSql += " And		b.COMP_CODE = d.COMP_CODE (+) \n";
			strSql += " And		b.SEC_KIND_CODE = e.SEC_KIND_CODE (+) \n";
			strSql += " Order By \n";
			strSql += " 	b.COMP_CODE,b.REAL_SECU_NO \n";
			strSql += "  ";
			
			lrArgData.addColumn("1WORK_NO", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("1WORK_NO", strWORK_NO);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("WORK_NO", true);
				lrReturnData.setKey("SECU_NO", true);
				lrReturnData.setScale("INTR_RATE",2);

				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","SUB01 Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("WORK_NO"))
		{

			
			strSql  = " select SQ_T_WORK_NO.NextVal work_no from dual ";
			

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
				GauceInfo.response.writeException("USER", "900001","WORK_NO Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("MAKE"))
		{

			
			strSql  = " select -1 work_no ,'XXXXXXXXXXXXXXXXXXXXXX' COMP_CODE, 'XXXXXXXXXXXXXXXXXXXX' DEPT_CODE from dual ";
			

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
				GauceInfo.response.writeException("USER", "900001","WORK_NO Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("DATE"))
		{
			String strDT = CITCommon.toKOR(request.getParameter("DT"));
			
			strSql  = " Select \n";
			strSql += " 	F_T_DATETOSTRING(Trunc( ? ,'MM')) DT_F, \n";
			strSql += " 	F_T_DATETOSTRING(Last_Day( ? )) DT_T \n";
			strSql += " From	Dual ";
			
			lrArgData.addColumn("1DT", CITData.DATE);
			lrArgData.addColumn("2DT", CITData.DATE);
			lrArgData.addRow();
			lrArgData.setValue("1DT", strDT);
			lrArgData.setValue("2DT", strDT);
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
				GauceInfo.response.writeException("USER", "900001","DATE Select 오류-> "+ ex.getMessage());
			}
		}
	}
	catch (Exception ex)
	{
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
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
			GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
		}
	}
%>
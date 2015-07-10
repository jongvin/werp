<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-07)
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
			String strFLOW_CODE = CITCommon.toKOR(request.getParameter("FLOW_CODE"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strWORK_YM = CITCommon.toKOR(request.getParameter("WORK_YM"));
			
			strSql  = " Select \n";
			strSql += " 	b.MAKE_SLIPNO, \n";
			strSql += " 	c.MAKE_SLIPLINE, \n";
			strSql += " 	d.ACC_NAME, \n";
			strSql += " 	c.SUMMARY1 ||' '||c.SUMMARY2 SUMMARY, \n";
			strSql += " 	c.DB_AMT , \n";
			strSql += " 	c.CR_AMT , \n";
			strSql += " 	a.EXEC_AMT , \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.CLSE_ACC_ID , \n";
			strSql += " 	a.DEPT_CODE , \n";
			strSql += " 	a.WORK_YM , \n";
			strSql += " 	a.FLOW_CODE , \n";
			strSql += " 	a.APPLY_SEQ , \n";
			strSql += " 	c.SLIP_ID , \n";
			strSql += " 	c.SLIP_IDSEQ , \n";
			strSql += " 	a.TRACE_SLIP_ID , \n";
			strSql += " 	a.TRACE_SLIP_IDSEQ , \n";
			strSql += " 	b.MAKE_COMP_CODE , \n";
			strSql += " 	b.MAKE_SEQ , \n";
			strSql += " 	b.MAKE_DT_TRANS, \n";
			strSql += " 	b.SLIP_KIND_TAG , \n";
			strSql += " 	a.TRACE_NO , \n";
			strSql += " 	a.CASH_DT , \n";
			strSql += " 	e.FLOW_ITEM_NAME \n";
			strSql += " From	T_FL_MONTH_ACC_EXEC_SUM a, \n";
			strSql += " 		T_ACC_SLIP_HEAD b, \n";
			strSql += " 		T_ACC_SLIP_BODY c, \n";
			strSql += " 		T_ACC_CODE d, \n";
			strSql += " 		( \n";
			strSql += " 			Select \n";
			strSql += " 				a.FLOW_CODE , \n";
			strSql += " 				a.CRTUSERNO , \n";
			strSql += " 				a.CRTDATE , \n";
			strSql += " 				a.MODUSERNO , \n";
			strSql += " 				a.MODDATE , \n";
			strSql += " 				a.P_NO , \n";
			strSql += " 				a.FLOW_ITEM_NAME , \n";
			strSql += " 				a.FLOW_ITEM_KIND , \n";
			strSql += " 				a.LEVEL_SEQ , \n";
			strSql += " 				a.IS_LEAF_TAG , \n";
			strSql += " 				a.DEPT_PLN_FUNC_NO , \n";
			strSql += " 				a.DEPT_EXE_FUNC_NO , \n";
			strSql += " 				a.DEPT_FOR_FUNC_NO \n";
			strSql += " 			From	T_FL_FLOW_CODE a \n";
			strSql += " 			Connect By \n";
			strSql += " 				Prior	a.FLOW_CODE = a.P_NO \n";
			strSql += " 			Start With \n";
			strSql += " 				a.FLOW_CODE =  ?  \n";
			strSql += " 		) e \n";
			strSql += " Where	a.TRACE_SLIP_ID = b.SLIP_ID \n";
			strSql += " And		a.TRACE_SLIP_ID = c.SLIP_ID \n";
			strSql += " And		a.TRACE_SLIP_IDSEQ = c.SLIP_IDSEQ \n";
			strSql += " And		c.ACC_CODE = d.ACC_CODE \n";
			strSql += " And		a.FLOW_CODE = e.FLOW_CODE \n";
			strSql += " And		Nvl(a.EXEC_AMT,0) <> 0 \n";
			strSql += " And		a.COMP_CODE =  ?  \n";
			strSql += " And		a.CLSE_ACC_ID =  ?  \n";
			strSql += " And		a.DEPT_CODE =  ?  \n";
			strSql += " And		a.WORK_YM =  ?  \n";
			strSql += " Order By \n";
			strSql += " 	b.MAKE_SLIPNO, \n";
			strSql += " 	c.MAKE_SLIPLINE \n";
			strSql += "  ";
			
			lrArgData.addColumn("1FLOW_CODE", CITData.NUMBER);
			lrArgData.addColumn("2COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("3CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("4DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("5WORK_YM", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1FLOW_CODE", strFLOW_CODE);
			lrArgData.setValue("2COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("3CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("4DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("5WORK_YM", strWORK_YM);
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
				GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SUB01"))
		{
			String strWORK_YM = CITCommon.toKOR(request.getParameter("WORK_YM"));
			String strTRACE_SLIP_ID = CITCommon.toKOR(request.getParameter("TRACE_SLIP_ID"));
			String strTRACE_SLIP_IDSEQ = CITCommon.toKOR(request.getParameter("TRACE_SLIP_IDSEQ"));
			
			strSql  = " Select \n";
			strSql += " 	b.MAKE_SLIPCLS , \n";
			strSql += " 	b.MAKE_SLIPNO , \n";
			strSql += " 	b.MAKE_COMP_CODE , \n";
			strSql += " 	b.MAKE_DEPT_CODE , \n";
			strSql += " 	b.MAKE_DT , \n";
			strSql += " 	b.MAKE_DT_TRANS , \n";
			strSql += " 	b.MAKE_SEQ, \n";
			strSql += " 	b.SLIP_KIND_TAG, \n";
			strSql += " 	c.SLIP_ID , \n";
			strSql += " 	c.SLIP_IDSEQ , \n";
			strSql += " 	c.MAKE_SLIPLINE , \n";
			strSql += " 	c.ACC_CODE , \n";
			strSql += " 	c.DB_AMT , \n";
			strSql += " 	c.CR_AMT, \n";
			strSql += " 	c.SUMMARY1 || SUMMARY2 SUMMARY, \n";
			strSql += " 	d.ACC_NAME, \n";
			strSql += " 	Decode(To_Char(b.MAKE_DT,'YYYYMM'), ? ,'T','F') NOW_AMT_TAG, \n";
			strSql += " 	SubStrb(Decode(To_Char(b.MAKE_DT,'YYYYMM'), ? ,'당월적용금액','당월미적용'),1,50) NOW_AMT_TAG_NAME \n";
			strSql += " From	T_FL_TRACE_CASH_SLIP a, \n";
			strSql += " 		T_ACC_SLIP_HEAD b, \n";
			strSql += " 		T_ACC_SLIP_BODY c, \n";
			strSql += " 		T_ACC_CODE d \n";
			strSql += " Where	a.TRACE_SLIP_ID =  ?  \n";
			strSql += " And		a.TRACE_SLIP_IDSEQ =  ?  \n";
			strSql += " And		a.CASH_SLIP_ID = b.SLIP_ID \n";
			strSql += " And		a.CASH_SLIP_ID = c.SLIP_ID \n";
			strSql += " And		a.CASH_SLIP_IDSEQ = c.SLIP_IDSEQ \n";
			strSql += " And		c.ACC_CODE = d.ACC_CODE \n";
			strSql += " Order By \n";
			strSql += " 	b.MAKE_SLIPNO , \n";
			strSql += " 	c.MAKE_SLIPLINE \n";
			strSql += "  ";
			
			lrArgData.addColumn("1WORK_YM", CITData.VARCHAR2);
			lrArgData.addColumn("2WORK_YM", CITData.VARCHAR2);
			lrArgData.addColumn("3TRACE_SLIP_ID", CITData.VARCHAR2);
			lrArgData.addColumn("4TRACE_SLIP_IDSEQ", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1WORK_YM", strWORK_YM);
			lrArgData.setValue("2WORK_YM", strWORK_YM);
			lrArgData.setValue("3TRACE_SLIP_ID", strTRACE_SLIP_ID);
			lrArgData.setValue("4TRACE_SLIP_IDSEQ", strTRACE_SLIP_IDSEQ);
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
				GauceInfo.response.writeException("USER", "900001","SUB01 Select 오류-> "+ ex.getMessage());
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
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
			String strBIZ_PLAN_ITEM_NO = CITCommon.toKOR(request.getParameter("BIZ_PLAN_ITEM_NO"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
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
			strSql += " 	c.DEPT_CODE , \n";
			strSql += " 	a.WORK_YM , \n";
			strSql += " 	a.BIZ_PLAN_ITEM_NO , \n";
			strSql += " 	a.APPLY_SEQ , \n";
			strSql += " 	c.SLIP_ID , \n";
			strSql += " 	c.SLIP_IDSEQ , \n";
			strSql += " 	a.SLIP_ID TRACE_SLIP_ID , \n";
			strSql += " 	a.SLIP_IDSEQ TRACE_SLIP_IDSEQ , \n";
			strSql += " 	b.MAKE_COMP_CODE , \n";
			strSql += " 	b.MAKE_SEQ , \n";
			strSql += " 	b.MAKE_DT_TRANS, \n";
			strSql += " 	b.SLIP_KIND_TAG , \n";
			strSql += " 	F_T_DATETOSTRING(b.MAKE_DT) MAKE_DT , \n";
			strSql += " 	e.FLOW_ITEM_NAME \n";
			strSql += " From	T_PL_MONTH_ACC_EXEC_SUM a, \n";
			strSql += " 		T_ACC_SLIP_HEAD b, \n";
			strSql += " 		T_ACC_SLIP_BODY c, \n";
			strSql += " 		T_ACC_CODE d, \n";
			strSql += " 		( \n";
			strSql += " 			Select \n";
			strSql += " 				a.BIZ_PLAN_ITEM_NO , \n";
			strSql += " 				a.CRTUSERNO , \n";
			strSql += " 				a.CRTDATE , \n";
			strSql += " 				a.MODUSERNO , \n";
			strSql += " 				a.MODDATE , \n";
			strSql += " 				a.P_NO , \n";
			strSql += " 				a.BIZ_PLAN_ITEM_NAME FLOW_ITEM_NAME , \n";
			strSql += " 				a.ITEM_LEVEL_SEQ , \n";
			strSql += " 				a.IS_LEAF_TAG  \n";
			strSql += " 			From	T_PL_ITEM a \n";
			strSql += " 			Connect By \n";
			strSql += " 				Prior	a.BIZ_PLAN_ITEM_NO = a.P_NO \n";
			strSql += " 			Start With \n";
			strSql += " 				a.BIZ_PLAN_ITEM_NO =  ?  \n";
			strSql += " 		) e, \n";
			strSql += " 		T_DEPT_CODE_ORG f \n";
			strSql += " Where	a.SLIP_ID = b.SLIP_ID \n";
			strSql += " And		a.SLIP_ID = c.SLIP_ID \n";
			strSql += " And		a.SLIP_IDSEQ = c.SLIP_IDSEQ \n";
			strSql += " And		c.ACC_CODE = d.ACC_CODE \n";
			strSql += " And		a.BIZ_PLAN_ITEM_NO = e.BIZ_PLAN_ITEM_NO \n";
			strSql += " And		Nvl(a.EXEC_AMT,0) <> 0 \n";
			strSql += " And		a.COMP_CODE =  ?  \n";
			strSql += " And		a.CLSE_ACC_ID =  ?  \n";
			strSql += " And		a.WORK_YM =  ?  \n";
			strSql += " And		c.DEPT_CODE = f.DEPT_CODE (+) \n";
			strSql += " Order By \n";
			strSql += " 	b.MAKE_SLIPNO, \n";
			strSql += " 	c.MAKE_SLIPLINE \n";
			strSql += "  ";
			
			lrArgData.addColumn("1BIZ_PLAN_ITEM_NO", CITData.NUMBER);
			lrArgData.addColumn("2COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("3CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("4WORK_YM", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1BIZ_PLAN_ITEM_NO", strBIZ_PLAN_ITEM_NO);
			lrArgData.setValue("2COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("3CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("4WORK_YM", strWORK_YM);
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
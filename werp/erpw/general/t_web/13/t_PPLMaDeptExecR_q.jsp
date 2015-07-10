<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-06-07)
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
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strWORK_YM = CITCommon.toKOR(request.getParameter("WORK_YM"));
			String strITEM_NO = CITCommon.toKOR(request.getParameter("ITEM_NO"));
			
			strSql  = " Select \n";
			strSql += " 	a.WORK_YM, \n";
			strSql += " 	a.ITEM_NO, \n";
			strSql += " 	a.APPLY_SEQ, \n";
			strSql += " 	b.BIZ_PLAN_ITEM_NAME, \n";
			strSql += " 	c.ACC_CODE, \n";
			strSql += " 	d.ACC_NAME, \n";
			strSql += " 	Round(a.DVD_AMT) DVD_AMT , \n";
			strSql += " 	a.DVD_RAT_POSITION , \n";
			strSql += " 	a.DVD_RAT_BASE , \n";
			strSql += " 	a.SUM_AMT, \n";
			strSql += " 	Round(100 * a.DVD_RAT_POSITION / NullIf(a.DVD_RAT_BASE,0) ,2) DVD_RATIO, \n";
			strSql += " 	c.DVD_CODE, \n";
			strSql += " 	e.DVD_NAME \n";
			strSql += " From	T_PL_MA_MONTH_DVD a, \n";
			strSql += " 		T_PL_MA_ITEM b, \n";
			strSql += " 		T_PL_MA_ITEM_ACC_CODE c, \n";
			strSql += " 		T_ACC_CODE d, \n";
			strSql += " 		T_PL_MA_DVD_CODE e \n";
			strSql += " Where	a.ITEM_NO = b.ITEM_NO \n";
			strSql += " And		a.ITEM_NO = c.ITEM_NO \n";
			strSql += " And		a.APPLY_SEQ = c.APPLY_SEQ \n";
			strSql += " And		c.ACC_CODE = d.ACC_CODE \n";
			strSql += " And		a.DEPT_CODE =  ?   \n";
			strSql += " And		a.WORK_YM =  ?  \n";
			strSql += " And		a.ITEM_NO =  ?  \n";
			strSql += " And		c.DVD_CODE = e.DVD_CODE (+) \n";
			strSql += " Order By \n";
			strSql += " 	b.ITEM_NO, \n";
			strSql += " 	c.ACC_CODE \n";
			strSql += "  ";
			
			lrArgData.addColumn("1DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2WORK_YM", CITData.VARCHAR2);
			lrArgData.addColumn("3ITEM_NO", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("1DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("2WORK_YM", strWORK_YM);
			lrArgData.setValue("3ITEM_NO", strITEM_NO);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				lrReturnData.setScale("DVD_AMT",1);
				lrReturnData.setScale("DVD_RATIO",2);
				


				
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
		if (strAct.equals("SUB01"))
		{
			String strWORK_YM = CITCommon.toKOR(request.getParameter("WORK_YM"));
			String strITEM_NO = CITCommon.toKOR(request.getParameter("ITEM_NO"));
			String strAPPLY_SEQ = CITCommon.toKOR(request.getParameter("APPLY_SEQ"));
			
			strSql  = " Select \n";
			strSql += " 	a.WORK_YM , \n";
			strSql += " 	a.ITEM_NO , \n";
			strSql += " 	a.APPLY_SEQ , \n";
			strSql += " 	a.SLIP_ID , \n";
			strSql += " 	a.SLIP_IDSEQ , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.DEPT_CODE , \n";
			strSql += " 	a.SUM_TAR_CODE , \n";
			strSql += " 	a.DB_AMT , \n";
			strSql += " 	a.CR_AMT , \n";
			strSql += " 	a.APPL_AMT, \n";
			strSql += " 	c.DEPT_NAME, \n";
			strSql += " 	b1.MAKE_SLIPNO, \n";
			strSql += " 	b.MAKE_SLIPLINE, \n";
			strSql += " 	b.SUMMARY1 || ' ' || b.SUMMARY2 SUMMARY, \n";
			strSql += " 	b1.MAKE_COMP_CODE, \n";
			strSql += " 	b1.MAKE_DT_TRANS, \n";
			strSql += " 	b1.MAKE_SEQ, \n";
			strSql += " 	b1.SLIP_KIND_TAG, \n";
			strSql += " 	d.SUM_TAR_NAME \n";
			strSql += " From	T_PL_MA_MONTH_SUM a, \n";
			strSql += " 		T_ACC_SLIP_BODY b, \n";
			strSql += " 		T_ACC_SLIP_HEAD b1, \n";
			strSql += " 		T_DEPT_CODE c, \n";
			strSql += " 		T_PL_MA_SUM_TAR_CODE d \n";
			strSql += " where	a.WORK_YM =  ?  \n";
			strSql += " And		a.ITEM_NO =  ?  \n";
			strSql += " And		a.APPLY_SEQ =  ?  \n";
			strSql += " And		a.SLIP_ID = b.SLIP_ID \n";
			strSql += " And		a.SLIP_IDSEQ = b.SLIP_IDSEQ \n";
			strSql += " And		a.DEPT_CODE = c.DEPT_CODE \n";
			strSql += " And		b.SLIP_ID = b1.SLIP_ID \n";
			strSql += " And		a.SUM_TAR_CODE = d.SUM_TAR_CODE (+) \n";
			strSql += " Order By \n";
			strSql += " 	b1.MAKE_SLIPNO, \n";
			strSql += " 	b.MAKE_SLIPLINE \n";
			strSql += "  ";
			
			lrArgData.addColumn("1WORK_YM", CITData.VARCHAR2);
			lrArgData.addColumn("2ITEM_NO", CITData.NUMBER);
			lrArgData.addColumn("3APPLY_SEQ", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("1WORK_YM", strWORK_YM);
			lrArgData.setValue("2ITEM_NO", strITEM_NO);
			lrArgData.setValue("3APPLY_SEQ", strAPPLY_SEQ);
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

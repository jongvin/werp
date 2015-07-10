<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-21)
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
			
			strSql  = " Select \n";
			strSql += " 	a.DEPT_CODE , \n";
			strSql += " 	a.INSUR_NO , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	F_T_DATETOSTRING(a.INSUR_DT_F) INSUR_DT_F , \n";
			strSql += " 	F_T_DATETOSTRING(a.INSUR_DT_T) INSUR_DT_T , \n";
			strSql += " 	F_T_DATETOSTRING(a.SLIP_MAKE_DT) SLIP_MAKE_DT , \n";
			strSql += " 	a.INSUR_AMT , \n";
			strSql += " 	a.MONTH_DEC_AMT , \n";
			strSql += " 	To_Char(a.SLIP_ID) SLIP_ID , \n";
			strSql += " 	To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ , \n";
			strSql += " 	To_Char(a.CUST_SEQ) CUST_SEQ , \n";
			strSql += " 	c.CUST_NAME , \n";
			strSql += " 	F_T_CUST_MASK(c.CUST_CODE) CUST_CODE , \n";
			strSql += " 	b.MAKE_SLIPCLS , \n";
			strSql += " 	b.MAKE_SLIPNO , \n";
			strSql += " 	b.MAKE_COMP_CODE , \n";
			strSql += " 	b.MAKE_DEPT_CODE , \n";
			strSql += " 	b.MAKE_DT , \n";
			strSql += " 	b.MAKE_DT_TRANS , \n";
			strSql += " 	b.MAKE_SEQ, \n";
			strSql += " 	b.SLIP_KIND_TAG, \n";
			strSql += " 	(Select Nvl(Sum(sa.DEC_AMT),0) From T_SET_CONS_INSUR_DEC_AMT sa Where sa.DEPT_CODE = a.DEPT_CODE And sa.INSUR_NO = a.INSUR_NO ) SUM_AMT, \n";
			strSql += " 	a.REMARKS \n";
			strSql += " From	T_SET_CONS_INSUR a, \n";
			strSql += " 		T_ACC_SLIP_HEAD b, \n";
			strSql += " 		T_CUST_CODE c \n";
			strSql += " Where	a.SLIP_ID = b.SLIP_ID (+) \n";
			strSql += " And		a.DEPT_CODE Like '%' ||  ?  ||'%' \n";
			strSql += " And		a.CUST_SEQ = c.CUST_SEQ (+) \n";
			strSql += " Order By \n";
			strSql += " 	a.DEPT_CODE, \n";
			strSql += " 	a.INSUR_NO \n";
			strSql += "  ";
			
			lrArgData.addColumn("1DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1DEPT_CODE", strDEPT_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("DEPT_CODE", true);
				lrReturnData.setKey("INSUR_NO", true);
				lrReturnData.setNotNull("INSUR_DT_F", true);
				lrReturnData.setNotNull("INSUR_DT_T", true);
				lrReturnData.setNotNull("INSUR_AMT", true);
				lrReturnData.setNotNull("MONTH_DEC_AMT", true);
				
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
		else if (strAct.equals("COPY"))
		{
			
			strSql  = " Select 'XXXXXXXXXXXXXXXXXXXXXXXXXX' DEPT_CODE, 0 INSUR_NO From dual \n";
			
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
				GauceInfo.response.writeException("USER", "900001","COPY Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("REMOVE"))
		{
			
			strSql  = " Select 'XXXXXXXXXXXXXXXXXXXXXXXXXX' DEPT_CODE, 0 INSUR_NO From dual \n";
			
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
				GauceInfo.response.writeException("USER", "900001","COPY Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("INSUR_NO"))
		{
			
			strSql  = " Select SQ_T_INSUR_NO.NextVal INSUR_NO From dual \n";
			
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
				GauceInfo.response.writeException("USER", "900001","COPY Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("REMOVE_SLIP"))
		{
			
			strSql  = " Select 'XXXXXXXXXXXXXXXXXXXXXX' DEPT_CODE,0 INSUR_NO From dual \n";
			
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
				GauceInfo.response.writeException("USER", "900001","COPY Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("DEC_AMT"))
		{
			String strAMT = CITCommon.toKOR(request.getParameter("AMT"));
			String strSTART_DT = CITCommon.toKOR(request.getParameter("START_DT"));
			String strEND_DT = CITCommon.toKOR(request.getParameter("END_DT"));
			
			strSql  = " Select \n";
			strSql += " 	Trunc( ?  / NullIf(F_T_Relative_Months(F_T_StringToDate( ? ),F_T_StringToDate( ? )),0)) DEC_AMT From dual ";
			
			lrArgData.addColumn("1AMT", CITData.NUMBER);
			lrArgData.addColumn("2START_DT", CITData.VARCHAR2);
			lrArgData.addColumn("3END_DT", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1AMT", strAMT);
			lrArgData.setValue("2START_DT", strSTART_DT);
			lrArgData.setValue("3END_DT", strEND_DT);
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
				GauceInfo.response.writeException("USER", "900001","DEC_AMT Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SUB01"))
		{
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strINSUR_NO = CITCommon.toKOR(request.getParameter("INSUR_NO"));
			
			strSql  = " Select \n";
			strSql += " 	a.DEPT_CODE , \n";
			strSql += " 	a.INSUR_NO , \n";
			strSql += " 	a.DEC_NO , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.DEC_AMT , \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.WORK_NO , \n";
			strSql += " 	To_Char(a.SLIP_ID) SLIP_ID , \n";
			strSql += " 	To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ, \n";
			strSql += " 	b.MAKE_SLIPCLS , \n";
			strSql += " 	b.MAKE_SLIPNO , \n";
			strSql += " 	b.MAKE_COMP_CODE , \n";
			strSql += " 	b.MAKE_DEPT_CODE , \n";
			strSql += " 	b.MAKE_DT , \n";
			strSql += " 	b.MAKE_DT_TRANS , \n";
			strSql += " 	b.MAKE_SEQ, \n";
			strSql += " 	b.SLIP_KIND_TAG, \n";
			strSql += " 	F_T_DATETOSTRING(c.WORK_DT) WORK_DT \n";
			strSql += " From	T_SET_CONS_INSUR_DEC_AMT a, \n";
			strSql += " 		T_ACC_SLIP_HEAD b, \n";
			strSql += " 		T_SET_CONS_INSUR_DEC_WORK c \n";
			strSql += " Where	a.SLIP_ID = b.SLIP_ID (+) \n";
			strSql += " And		a.COMP_CODE = c.COMP_CODE \n";
			strSql += " And		a.WORK_NO = c.WORK_NO \n";
			strSql += " And		a.DEPT_CODE =  ?  \n";
			strSql += " And		a.INSUR_NO =  ?  \n";
			strSql += " Order By \n";
			strSql += " 	c.WORK_DT, \n";
			strSql += " 	c.WORK_NO ";
			
			lrArgData.addColumn("1DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2INSUR_NO", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("1DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("2INSUR_NO", strINSUR_NO);
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
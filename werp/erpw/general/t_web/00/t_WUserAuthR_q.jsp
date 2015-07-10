<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-25)
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
			String strSEARCH_CONDITION = CITCommon.toKOR(request.getParameter("SEARCH_CONDITION"));
			
			strSql  = " Select \n";
			strSql += " 	b.EMPNO, \n";
			strSql += " 	b.CRTUSERNO , \n";
			strSql += " 	b.CRTDATE , \n";
			strSql += " 	b.MODUSERNO , \n";
			strSql += " 	b.MODDATE, \n";
			strSql += " 	b.SLIP_TRANS_CLS, \n";
			strSql += " 	b.DEPT_CHG_CLS, \n";
			strSql += " 	b.ALL_DEPT_CLS, \n";
			strSql += " 	a.NAME \n";
			strSql += " From	Z_AUTHORITY_USER a, \n";
			strSql += " 		T_EMPNO_AUTH b \n";
			strSql += " Where	a.EMPNO = b.EMPNO \n";
			strSql += " And		a.EMPNO || a.NAME Like '%' ||Replace( ? ,' ','%') || '%' \n";
			strSql += " Order By \n";
			strSql += " 	b.EMPNO \n";
			strSql += "  ";
			
			lrArgData.addColumn("SEARCH_CONDITION", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("SEARCH_CONDITION", strSEARCH_CONDITION);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("EMPNO", true);

				
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
			String strEMPNO = CITCommon.toKOR(request.getParameter("EMPNO"));
			
			strSql  = " Select \n";
			strSql += " 	a.EMPNO , \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE, \n";
			strSql += " 	b.COMPANY_NAME \n";
			strSql += " From	T_EMPNO_AUTH_COMP a, \n";
			strSql += " 		T_COMPANY b \n";
			strSql += " Where	a.COMP_CODE = b.COMP_CODE \n";
			strSql += " And		a.EMPNO =  ?  \n";
			strSql += " Order By \n";
			strSql += " 	a.COMP_CODE \n";
			strSql += "  ";
			
			lrArgData.addColumn("EMPNO", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("EMPNO", strEMPNO);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("EMPNO", true);
				lrReturnData.setKey("COMP_CODE", true);

				
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
		else if (strAct.equals("SUB02"))
		{
			String strEMPNO = CITCommon.toKOR(request.getParameter("EMPNO"));
			
			strSql  = " Select \n";
			strSql += " 	?  EMPNO , \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE, \n";
			strSql += " 	a.COMPANY_NAME \n";
			strSql += " From	T_COMPANY a \n";
			strSql += " Where	Not Exists \n";
			strSql += " ( \n";
			strSql += " 	Select \n";
			strSql += " 		Null \n";
			strSql += " 	From	T_EMPNO_AUTH_COMP b \n";
			strSql += " 	Where	a.COMP_CODE = b.COMP_CODE \n";
			strSql += " 	And		b.EMPNO =  ?  \n";
			strSql += " ) \n";
			strSql += " Order By \n";
			strSql += " 	a.COMP_CODE \n";
			strSql += "  ";
			
			lrArgData.addColumn("EMPNO1", CITData.VARCHAR2);
			lrArgData.addColumn("EMPNO2", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("EMPNO1", strEMPNO);
			lrArgData.setValue("EMPNO2", strEMPNO);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("EMPNO", true);
				lrReturnData.setKey("COMP_CODE", true);

				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","SUB02 Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SUB03"))
		{
			String strEMPNO = CITCommon.toKOR(request.getParameter("EMPNO"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	a.EMPNO , \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.DEPT_CODE , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE, \n";
			strSql += " 	b.DEPT_NAME \n";
			strSql += " From	T_EMPNO_AUTH_DEPT a, \n";
			strSql += " 		T_DEPT_CODE b \n";
			strSql += " Where	a.DEPT_CODE = b.DEPT_CODE \n";
			strSql += " And		a.EMPNO =  ?  \n";
			strSql += " And		a.COMP_CODE =  ?  \n";
			strSql += " Order By \n";
			strSql += " 	a.DEPT_CODE \n";
			strSql += "  ";
			
			lrArgData.addColumn("EMPNO", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("EMPNO", strEMPNO);
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("EMPNO", true);
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("DEPT_CODE", true);

				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","SUB03 Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SUB04"))
		{
			String strEMPNO = CITCommon.toKOR(request.getParameter("EMPNO"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	? EMPNO , \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.DEPT_CODE , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE, \n";
			strSql += " 	a.DEPT_NAME \n";
			strSql += " From	T_DEPT_CODE a \n";
			strSql += " Where	a.COMP_CODE =  ?  \n";
			strSql += " And		Not Exists \n";
			strSql += " ( \n";
			strSql += " 	Select \n";
			strSql += " 		Null \n";
			strSql += " 	From	T_EMPNO_AUTH_DEPT b \n";
			strSql += " 	Where	a.DEPT_CODE = b.DEPT_CODE \n";
			strSql += " 	And		b.EMPNO =  ?  \n";
			strSql += " 	And		b.COMP_CODE =  ?  \n";
			strSql += " ) \n";
			strSql += " And		a.ACC_CLOSE_DT Is Null \n";
			strSql += " Order By \n";
			strSql += " 	a.DEPT_CODE \n";
			strSql += "  ";
			
			lrArgData.addColumn("EMPNO1", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE1", CITData.VARCHAR2);
			lrArgData.addColumn("EMPNO2", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE2", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("EMPNO1", strEMPNO);
			lrArgData.setValue("COMP_CODE1", strCOMP_CODE);
			lrArgData.setValue("EMPNO2", strEMPNO);
			lrArgData.setValue("COMP_CODE2", strCOMP_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("EMPNO", true);
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("DEPT_CODE", true);

				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","SUB04 Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("COPY"))
		{
			
			strSql  = " Select 'XXXXXXXXXXXXXXXXXXXXX' EMPNO_SRC,'XXXXXXXXXXXXXXXXXXXXX' EMPNO_DST from dual \n";
			
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
		else if (strAct.equals("SET"))
		{
			
			strSql  = " Select 'XXXXXXXXXXXXXXXXXXXXX' EMPNO, 'XXXXXXXXXXXXXXXXXXXXX' OPTIONS from dual \n";
			
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
				GauceInfo.response.writeException("USER", "900001","SET Select 오류-> "+ ex.getMessage());
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

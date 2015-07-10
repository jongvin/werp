<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-21)
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
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strDEPT_NAME = CITCommon.toKOR(request.getParameter("DEPT_NAME"));
			
			strSql  = " Select \n";
			strSql += " 	a.DEPT_CODE, \n";
			strSql += " 	a.DEPT_NAME, \n";
			strSql += " 	a.COMP_CODE, \n";
			strSql += " 	b.CRTUSERNO , \n";
			strSql += " 	b.CRTDATE , \n";
			strSql += " 	b.MODUSERNO , \n";
			strSql += " 	b.MODDATE , \n";
			strSql += " 	b.CHK_DEPT_CODE, \n";
			strSql += " 	c.DEPT_NAME CHK_DEPT_NAME \n";
			strSql += " From	T_DEPT_CODE_ORG a, \n";
			strSql += " 		T_BUDG_DEPT_MAP b, \n";
			strSql += " 		T_DEPT_CODE_ORG c \n";
			strSql += " Where	a.DEPT_CODE = b.DEPT_CODE (+) \n";
			strSql += " And	b.CHK_DEPT_CODE = c.DEPT_CODE (+) \n";
			strSql += " And      a.BUDG_CLS = 'T' \n";
			strSql += " And	a.COMP_CODE Like  '%'|| ? ||'%'  \n";
			strSql += " And	a.DEPT_NAME Like  '%'|| ? || '%' \n";
			strSql += " Order By \n";
			strSql += " 	a.DEPT_CODE \n";
			strSql += "  ";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("DEPT_NAME", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("DEPT_NAME", strDEPT_NAME);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("DEPT_CODE", true);

				
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
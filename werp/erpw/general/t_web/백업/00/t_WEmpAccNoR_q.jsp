<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-30)
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
			String strNAME = CITCommon.toKOR(request.getParameter("NAME"));
			
			strSql  = " Select \n";
			strSql += " 	a.EMPNO ERMP_NO, \n";
			strSql += " 	a.NAME, \n";
			strSql += " 	b.IN_BANK_MAIN_CODE_1 , \n";
			strSql += " 	b.IN_ACC_NO_1 , \n";
			strSql += " 	b.IN_BANK_MAIN_CODE_2 , \n";
			strSql += " 	b.IN_ACC_NO_2 , \n";
			strSql += " 	b.IN_BANK_MAIN_CODE_3 , \n";
			strSql += " 	b.IN_ACC_NO_3 \n";
			strSql += " From	Z_AUTHORITY_USER a, \n";
			strSql += " 		T_FIN_EMP_IN_ACC_NO b \n";
			strSql += " Where	a.EMPNO = b.ERMP_NO (+) \n";
			strSql += " And		a.EMPNO || a.NAME Like '%'||Replace(?,' ','%') ||'%' \n";
			strSql += " Order By \n";
			strSql += " 	a.NAME ";
			
			lrArgData.addColumn("1NAME", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1NAME", strNAME);
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
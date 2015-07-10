<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-20)
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

			
			strSql  = " Select \n";
			strSql += " 	a.SEC_KIND_CODE , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.SEC_KIND_NAME , \n";
			strSql += " 	a.SEC_ACC_CODE , \n";
			strSql += " 	a.ITRP_ACC_CODE , \n";
			strSql += " 	a.ITRB_ACC_CODE, \n";
			strSql += " 	b.ACC_NAME SEC_ACC_CODE_NAME, \n";
			strSql += " 	c.ACC_NAME ITRP_ACC_CODE_NAME, \n";
			strSql += " 	d.ACC_NAME ITRB_ACC_CODE_NAME \n";
			strSql += " From	T_FIN_SEC_KIND a, \n";
			strSql += " 		T_ACC_CODE b, \n";
			strSql += " 		T_ACC_CODE c, \n";
			strSql += " 		T_ACC_CODE d \n";
			strSql += " Where	a.SEC_ACC_CODE = b.ACC_CODE (+) \n";
			strSql += " And		a.ITRP_ACC_CODE = c.ACC_CODE (+) \n";
			strSql += " And		a.ITRB_ACC_CODE = d.ACC_CODE (+) \n";
			strSql += " Order By \n";
			strSql += " 	a.SEC_KIND_CODE \n";
			strSql += "  ";
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("SEC_KIND_CODE", true);
				lrReturnData.setNotNull("SEC_KIND_NAME", true);
				
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

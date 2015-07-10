<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2005-11-23)
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
									
			strSql  = " SELECT \n";
			strSql += "        A.TAX_COMP_CODE, \n";
			strSql += "        A.COMP_CODE, \n";
			strSql += "        B.COMPANY_NAME OVER_COMPANY_NAME, \n";
			strSql += "        F_T_Cust_Mask(A.BIZNO) BIZNO, \n";
			strSql += "        A.COMPANY_NAME, \n";
			strSql += "        F_T_Cust_Mask(A.BIZNO2) BIZNO2, \n";
			strSql += "        F_T_DateToString(A.OPEN_DT) OPEN_DT, \n";
			strSql += "        A.BOSS, \n";
			strSql += "        F_T_CUST_MASK(A.BOSS_NO) BOSS_NO, \n";
			strSql += "        A.BIZCOND, \n";
			strSql += "        A.BIZKND, \n";
			strSql += "        A.TELNO, \n";
			strSql += "        F_T_Zip_Mask(A.BIZPLACE_ZIPCODE) BIZPLACE_ZIPCODE, \n";
			strSql += "        A.BIZPLACE_ADDR1, \n";
			strSql += "        A.BIZPLACE_ADDR2, \n";
			strSql += "        A.TACOFF \n";
			strSql += " FROM   T_TAX_COMPANY A, \n";
			strSql += " 		   T_COMPANY B \n";
			strSql += " WHERE  B.COMP_CODE = A.COMP_CODE(+) \n";
			strSql += " AND	 A.COMP_CODE Like '%'|| ? ||'%' \n";
			strSql += " ORDER BY TAX_COMP_CODE ";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addRow();                                   
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);  
			
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("TAX_COMP_CODE", true);

				lrReturnData.setNotNull("COMP_CODE", true);
				lrReturnData.setNotNull("BIZNO", true);
				lrReturnData.setNotNull("COMPANY_NAME", true);
				lrReturnData.setNotNull("BOSS", true);
				
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
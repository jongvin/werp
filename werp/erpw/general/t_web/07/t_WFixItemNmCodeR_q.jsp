<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2006-01-16)
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

			String strASSET_CLS_CODE = CITCommon.toKOR(request.getParameter("ASSET_CLS_CODE"));
			String strITEM_CODE = CITCommon.toKOR(request.getParameter("ITEM_CODE"));
			
			strSql  = " select \n";
			strSql += " 	  a.ASSET_CLS_CODE, \n";
			strSql += " 	  a.ASSET_CLS_NAME, \n";
			strSql += " 	  b.ITEM_CODE, \n";
			strSql += " 	  b.ITEM_NAME, \n";
			strSql += " 	  c.ITEM_NM_CODE, \n";
			strSql += " 	  c.ITEM_NM_NAME, \n";
			strSql += " 	  TO_CHAR(c.SRVLIFE) SRVLIFE, \n";
			strSql += " 	  c.DEPREC_RAT, \n";
			strSql += " 	  c.DEPREC_CLS \n";
			strSql += " from  T_FIX_ASSET_CLS_CODE a, \n";
			strSql += " 	   T_FIX_ITEM_CODE b, \n";
			strSql += " 	   T_FIX_ITEM_NM_CODE c \n";
			strSql += " where a.ASSET_CLS_CODE = c.ASSET_CLS_CODE \n";
			strSql += " and     b.ITEM_CODE = c.ITEM_CODE \n";
			strSql += " and     b.ASSET_CLS_CODE = c.ASSET_CLS_CODE  \n";
			strSql += " and     c.ASSET_CLS_CODE = ? \n";
			strSql += " and     c.ITEM_CODE = ? \n";
			strSql += " Order by  ASSET_CLS_CODE, ITEM_CODE,ITEM_NM_CODE \n";
			
			lrArgData.addColumn("ASSET_CLS_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("ITEM_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("ASSET_CLS_CODE", strASSET_CLS_CODE);
			lrArgData.setValue("ITEM_CODE", strITEM_CODE);
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("ASSET_CLS_CODE", true);
				lrReturnData.setKey("ITEM_CODE", true);
				lrReturnData.setKey("ITEM_NM_CODE", true);
				lrReturnData.setNotNull("ITEM_NM_NAME", true);
				
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
		
		else if (strAct.equals("FIX_ASSET_CLS_CODE"))
		{

			strSql  = " select \n";
			strSql += " 	  a.ASSET_CLS_CODE, 	 \n";
			strSql += " 	  a.ASSET_CLS_NAME  \n";
			strSql += " from T_FIX_ASSET_CLS_CODE a \n";
			strSql += " ORDER by  ASSET_CLS_CODE";
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("ASSET_CLS_CODE", true);
				lrReturnData.setKey("ITEM_CODE", true);
				lrReturnData.setNotNull("ITEM_NAME", true);
				
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
		
		else if (strAct.equals("ITEM_CODE"))
		{
			String strASSET_CLS_CODE = CITCommon.toKOR(request.getParameter("ASSET_CLS_CODE"));
			
			strSql  = " select \n";
			strSql += " 	  a.ITEM_CODE, 	 \n";
			strSql += " 	  a.ITEM_NAME  \n";
			strSql += " from T_FIX_ITEM_CODE a \n";
			strSql += " where ASSET_CLS_CODE = ?    \n";
			strSql += " ORDER by  ITEM_CODE";
			
			lrArgData.addColumn("ASSET_CLS_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("ASSET_CLS_CODE", strASSET_CLS_CODE);
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("ASSET_CLS_CODE", true);
				lrReturnData.setKey("ITEM_CODE", true);
				lrReturnData.setNotNull("ITEM_NAME", true);
				
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
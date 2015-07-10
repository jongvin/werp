<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Select Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-21)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
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
			String strWORK_DT = CITCommon.toKOR(request.getParameter("WORK_DT"));
			
			strSql  = " select a.M_MARKET_STAT_CODE, \n";
			strSql += " 	   b.M_MARKET_STAT_NAME, \n";
			strSql += " 	   F_T_DATETOSTRING(WORK_DT) WORK_DT, \n";
			strSql += " 	   ITR_RATIO, \n";
			strSql += " 	   P_D_UD_TAG, \n";
			strSql += " 	   P_D_UD_POS, \n";
			strSql += " 	   P_M_UD_TAG, \n";
			strSql += " 	   P_M_UD_POS, \n";
			strSql += " 	   P_Y_UD_TAG, \n";
			strSql += " 	   P_Y_UD_POS, \n";
			strSql += " 	   P_ML_RATIO, \n";
			strSql += " 	   P_D_RATIO, \n";
			strSql += " 	   P_YL_RATIO \n";
			strSql += " from  t_fl_m_market a, \n";
			strSql += " 	  t_fl_m_market_stat_code b \n";
			strSql += " where b.m_market_stat_code = a.m_market_stat_code \n";
			strSql += " and	  WORK_DT = F_T_STRINGTODATE( ? ) ";
			
			lrArgData.addColumn("1WORK_DT", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1WORK_DT", strWORK_DT);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("M_MARKET_STAT_CODE", true);
				lrReturnData.setKey("M_MARKET_STAT_NAME", true);
				
				lrReturnData.setScale("ITR_RATIO",2);
				lrReturnData.setScale("P_D_UD_POS",2);
				lrReturnData.setScale("P_M_UD_POS",2);
				lrReturnData.setScale("P_Y_UD_POS",2);
				lrReturnData.setScale("P_ML_RATIO",2);
				lrReturnData.setScale("P_D_RATIO",2);
				lrReturnData.setScale("P_YL_RATIO",2);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN Select ����-> "+ ex.getMessage());
			}
		}
		if (strAct.equals("COPY"))
		{
			
			strSql  = " select 'XXXXXXXXXXXXXXXXXXX' WORK_DT From Dual \n";
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
				GauceInfo.response.writeException("USER", "900001","COPY Select ����-> "+ ex.getMessage());
			}
		}
	}
	catch (Exception ex)
	{
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "������ �ʱ�ȭ ���� -> " + ex.getMessage());
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
			GauceInfo.response.writeException("SYS", "100002", "������ ���� ���� -> " + ex.getMessage());
		}
	}
%>
<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WCommonCodeR_q(�����ڵ� ����� Select Query ������)
/* 2. ����(�ó�����) : Select Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-04)
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
			String strCODE_GROUP_ID = CITCommon.toKOR(request.getParameter("CODE_GROUP_ID"));
			String strCODE_GROUP_NAME = CITCommon.toKOR(request.getParameter("CODE_GROUP_NAME"));
			
			strSql  = " Select CODE_GROUP_NO, \n";
			strSql += "        CODE_GROUP_ID, \n";
			strSql += "        CODE_GROUP_NAME, \n";
			strSql += "        FLEX_FIELD, \n";
			strSql += "        OPEN_TAG, \n";
			strSql += "        REMARK \n";
			strSql += " From   T_CODE_GROUP \n";
			strSql += " Where  CODE_GROUP_ID Like '%'||?||'%' \n";
			strSql += "  And   CODE_GROUP_NAME Like '%'||?||'%' \n";
			strSql += " Order by CODE_GROUP_ID ";
			
			lrArgData.addColumn("CODE_GROUP_ID", CITData.VARCHAR2);
			lrArgData.addColumn("CODE_GROUP_NAME", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("CODE_GROUP_ID", strCODE_GROUP_ID);
			lrArgData.setValue("CODE_GROUP_NAME", strCODE_GROUP_NAME);
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("CODE_GROUP_ID", true);
				
				lrReturnData.setNotNull("CODE_GROUP_NAME", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","T_CODE_GROUP Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("GROUP_NO"))
		{
			strSql  = " Select SQ_T_CODE_GROUP.nextval as GROUP_NO from dual ";
			
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
				GauceInfo.response.writeException("USER", "900001","SQ_T_CODE_GROUP Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("LIST"))
		{
			String strCODE_GROUP_NO = CITCommon.toKOR(request.getParameter("CODE_GROUP_NO"));
			
			strSql  = " Select CODE_GROUP_NO, \n";
			strSql += "        CODE_LIST_ID, \n";
			strSql += "        CODE_LIST_NAME, \n";
			strSql += "        SEQ, \n";
			strSql += "        USE_TAG \n";
			strSql += " From   T_CODE_LIST \n";
			strSql += " Where  CODE_GROUP_NO = ? \n";
			strSql += " Order by SEQ ";
			
			lrArgData.addColumn("CODE_GROUP_NO", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("CODE_GROUP_NO", strCODE_GROUP_NO);
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("CODE_GROUP_NO", true);
				lrReturnData.setKey("CODE_LIST_ID", true);
				
				lrReturnData.setNotNull("CODE_LIST_NAME", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","T_CODE_LIST Select ����-> "+ ex.getMessage());
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
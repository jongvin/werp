<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WMngItemR_q.jsp(�����׸���)
/* 2. ����(�ó�����) : Select Page
/* 3. ��  ��  ��  �� : �����׸����� ���� Query Page
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-11-15)
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
			
			strSql  = " Select	a.MNG_ITEM , \n";
			strSql += " 			a.CRTUSERNO , \n";
			strSql += " 			a.CRTDATE , \n";
			strSql += " 			a.MODUSERNO , \n";
			strSql += " 			a.MODDATE , \n";
			strSql += " 			a.MNG_NAME , \n";
			strSql += " 			a.DATA_TYPE , \n";
			strSql += " 			a.SEQ , \n";
			strSql += " 			a.POPUP , \n";
			strSql += " 			a.REMARK , \n";
			strSql += " 			a.USE_TG \n";
			strSql += " From		T_MNG_ITEM_CODE a \n";
			strSql += " Order by	a.SEQ ";
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("MNG_ITEM", true);
				lrReturnData.setNotNull("MNG_NAME", true);
				lrReturnData.setNotNull("DATA_TYPE", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","T_MNG_ITEM_CODE Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("DATA_TYPE"))
		{

			
			strSql  = " Select \n";
			strSql += " 	a.CODE_LIST_ID, \n";
			strSql += " 	a.CODE_LIST_NAME, \n";
			strSql += " 	a.SEQ \n";
			strSql += " From	V_T_CODE_LIST a \n";
			strSql += " Where	a.CODE_GROUP_ID = 'DATA_TYPE' \n";
			strSql += " And		a.USE_TAG = 'T' \n";
			strSql += " Order By a.SEQ ";
			

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
				GauceInfo.response.writeException("USER", "900001","V_T_CODE_LIST Select ����-> "+ ex.getMessage());
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
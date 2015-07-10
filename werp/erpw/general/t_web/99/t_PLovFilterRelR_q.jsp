<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_PLovFilterRelR_q.jsp(�����˾��� ���Ͱ�����)
/* 2. ����(�ó�����) : Select Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-24)
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
		
		if (strAct.equals("FILTER_RELS"))
		{
			String strLOV_NO = CITCommon.toKOR(request.getParameter("LOV_NO"));
			
			strSql  = " Select LOV_NO, \n";
			strSql += "        FILTER_REL_SEQ, \n";
			strSql += "        DIS_SEQ, \n";
			strSql += "        to_char(M_FILTER_SEQ) as M_FILTER_SEQ, \n";
			strSql += "        to_char(D_FILTER_SEQ) as D_FILTER_SEQ \n";
			strSql += " From   T_LOV_FILTER_RELS \n";
			strSql += " Where  LOV_NO =  ? \n";
			strSql += " Order by DIS_SEQ \n";
			
			lrArgData.addColumn("LOV_NO", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("LOV_NO", strLOV_NO);
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("LOV_NO", true);
				lrReturnData.setKey("FILTER_REL_SEQ", true);
				
				lrReturnData.setNotNull("DIS_SEQ", true);
				lrReturnData.setNotNull("M_FILTER_SEQ", true);
				lrReturnData.setNotNull("D_FILTER_SEQ", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","T_LOV_FILTER_RELS Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("FILTER_REL_SEQ"))
		{
			strSql  = " Select SQ_T_LOV_FILTER_RELS.nextval as FILTER_REL_SEQ \n";
			strSql += " From   DUAL ";
			
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
				GauceInfo.response.writeException("USER", "900001", "SQ_T_LOV_FILTER_RELS Sequence Select ���� -> " + ex.getMessage());
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
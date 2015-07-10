<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WETaxDeptR_q(�μ� ���)
/* 2. ����(�ó�����) : Select Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-05-11)
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
			String strCOMPANY_CODE = CITCommon.toKOR(request.getParameter("COMPANY_CODE"));
			String strITEM_CODE = CITCommon.toKOR(request.getParameter("ITEM_CODE"));
			String strITEM_NAME = CITCommon.toKOR(request.getParameter("ITEM_NAME"));

			strSql  = " Select	A.COM_ID		, \n";
			strSql += "       	A.ITEM_CODE , \n";
			strSql += "       	A.ITEM_NAME , \n";
			strSql += "       	A.ITEM_SIZE , \n";
			strSql += "       	A.INSERT_DATE  , \n";
			strSql += "       	A.UPDATE_DATE  , \n";
			strSql += "       	A.INSERT_EMP   , \n";			
			strSql += "       	A.UPDATE_EMP   , \n";
			strSql += "       	( select b.com_name from tb_wt_company b 	\n";
			strSql += "       		where  b.com_id = A.com_id ) COM_NAME		\n";			
			strSql += " From	TB_WT_ITEM A  \n";
			strSql += " Where	A.COM_ID   = ?   \n";
			if(!"".equals(strITEM_CODE)) strSql += " And		A.ITEM_CODE like ? ||'%' \n";
			if(!"".equals(strITEM_NAME)) strSql += " And		A.ITEM_NAME like '%' || ? || '%' \n";
			
			lrArgData.addColumn("COMPANY_CODE", CITData.VARCHAR2);
			if(!"".equals(strITEM_CODE)) lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
			if(!"".equals(strITEM_NAME)) lrArgData.addColumn("DEPT_NAME", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMPANY_CODE", strCOMPANY_CODE);
			if(!"".equals(strITEM_CODE)) lrArgData.setValue("DEPT_CODE", strITEM_CODE);
			if(!"".equals(strITEM_NAME)) lrArgData.setValue("DEPT_NAME", strITEM_NAME);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COM_ID", true);
				lrReturnData.setKey("ITEM_CODE", true);
				lrReturnData.setNotNull("ITEM_CODE", true);
				lrReturnData.setNotNull("COM_ID", true);
			
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
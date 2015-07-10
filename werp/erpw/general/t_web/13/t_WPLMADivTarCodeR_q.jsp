<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Select Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-11-18)
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
		
			strSql  = " SELECT \n";
			strSql += " 	DVD_TAR_CODE, \n";
			strSql += " 	DVD_TAR_NAME \n";
			strSql += " FROM \n";
			strSql += " 	T_PL_MA_DVD_TAR_CODE \n";
			strSql += " ORDER BY \n";
			strSql += " 	DVD_TAR_CODE ";
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("DVD_TAR_CODE", true);
				lrReturnData.setNotNull("DVD_TAR_NAME", true);
				
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
		else if (strAct.equals("SUB01"))
		{
			String strDVD_TAR_CODE = CITCommon.toKOR(request.getParameter("DVD_TAR_CODE"));
			
			strSql  = " SELECT \n";
			strSql += " 	A.DVD_TAR_CODE, \n";
			strSql += " 	A.DEPT_CODE, \n";
			strSql += " 	B.DEPT_NAME \n";
			strSql += " FROM \n";
			strSql += " 	T_PL_MA_DVD_TAR_DEPT A, \n";
			strSql += " 	T_DEPT_CODE_ORG B \n";
			strSql += " WHERE \n";
			strSql += " 	 A.DEPT_CODE = B.DEPT_CODE \n";
			strSql += " 	 AND A.DVD_TAR_CODE =  ?  \n";
			strSql += " ORDER BY \n";
			strSql += " 	DVD_TAR_CODE, \n";
			strSql += " 	DEPT_CODE ";
			
			lrArgData.addColumn("1DVD_TAR_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1DVD_TAR_CODE", strDVD_TAR_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("DVD_TAR_CODE", true);
				lrReturnData.setKey("DEPT_CODE", true);
				lrReturnData.setNotNull("DEPT_NAME", true);
				
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
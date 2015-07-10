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
			String strDIV_COMP_CODE = CITCommon.toKOR(request.getParameter("DIV_COMP_CODE"));
			
			strSql  = " SELECT \n";
			strSql += " 	DIV_COMP_CODE, \n";
			strSql += " 	DIV_CODE, \n";
			strSql += " 	DIV_NAME, \n";
			strSql += " 	DIV_RATIO, \n";
			strSql += " 	REMARKS, \n";
			strSql += " 	MAIN_TAG, \n";
			strSql += " 	USE_TAG \n";
			strSql += " FROM \n";
			strSql += " 	T_ACC_VAT_DIV_CODE \n";
			strSql += " WHERE \n";
			strSql += " 	 DIV_COMP_CODE =  ?  \n";
			strSql += " ORDER BY \n";
			strSql += " 	DIV_COMP_CODE, \n";
			strSql += " 	DIV_CODE ";
			
			lrArgData.addColumn("1DIV_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1DIV_COMP_CODE", strDIV_COMP_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("DIV_COMP_CODE", true);
				lrReturnData.setKey("DIV_CODE", true);
				lrReturnData.setNotNull("DIV_NAME", true);
				
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
			String strDIV_COMP_CODE = CITCommon.toKOR(request.getParameter("DIV_COMP_CODE"));
			String strDIV_CODE = CITCommon.toKOR(request.getParameter("DIV_CODE"));
			
			strSql  = " SELECT \n";
			strSql += " 	A.DIV_COMP_CODE, \n";
			strSql += " 	A.DIV_CODE, \n";
			strSql += " 	A.DIV_DEPT_CODE, \n";
			strSql += " 	B.DEPT_NAME DIV_DEPT_NAME \n";
			strSql += " FROM \n";
			strSql += " 	T_ACC_VAT_DIV_C_DEPT A, \n";
			strSql += " 	T_DEPT_CODE_ORG B \n";
			strSql += " WHERE \n";
			strSql += " 	 A.DIV_DEPT_CODE = B.DEPT_CODE \n";
			strSql += " 	 AND A.DIV_COMP_CODE =  ?  \n";
			strSql += " 	 AND A.DIV_CODE =  ?  \n";
			strSql += " ORDER BY \n";
			strSql += " 	DIV_COMP_CODE, \n";
			strSql += " 	DIV_CODE, \n";
			strSql += " 	DIV_DEPT_CODE ";
			
			lrArgData.addColumn("1DIV_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2DIV_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1DIV_COMP_CODE", strDIV_COMP_CODE);
			lrArgData.setValue("2DIV_CODE", strDIV_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("DIV_COMP_CODE", true);
				lrReturnData.setKey("DIV_CODE", true);
				lrReturnData.setKey("DIV_DEPT_CODE", true);
				lrReturnData.setNotNull("DIV_DEPT_NAME", true);
				
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
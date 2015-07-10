<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Select Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-06)
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

			
			strSql  = " Select \n";
			strSql += " 	a.MAIN_ACC_CODE , \n";
			strSql += " 	b.ACC_NAME, \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE \n";
			strSql += " From	T_MAIN_ACC_CODE a, \n";
			strSql += " 		T_ACC_CODE b \n";
			strSql += " Where	a.MAIN_ACC_CODE = b.ACC_CODE \n";
			strSql += " Order By \n";
			strSql += " 	a.MAIN_ACC_CODE \n";
			strSql += "  ";
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("MAIN_ACC_CODE", true);

				
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
			String strMAIN_ACC_CODE = CITCommon.toKOR(request.getParameter("MAIN_ACC_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	a.MAIN_ACC_CODE , \n";
			strSql += " 	b.ACC_NAME, \n";
			strSql += " 	a.COST_DEPT_KND_TAG , \n";
			strSql += " 	a.ACC_CODE , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE \n";
			strSql += " From	T_CODE_KIND_ACC_CODE a, \n";
			strSql += " 		T_ACC_CODE b \n";
			strSql += " Where	a.ACC_CODE = b.ACC_CODE \n";
			strSql += " And		a.MAIN_ACC_CODE =  ?  \n";
			strSql += " Order By \n";
			strSql += " 	a.COST_DEPT_KND_TAG \n";
			strSql += "  ";
			
			lrArgData.addColumn("1MAIN_ACC_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1MAIN_ACC_CODE", strMAIN_ACC_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("MAIN_ACC_CODE", true);
				lrReturnData.setKey("COST_DEPT_KND_TAG", true);
				//lrReturnData.setKey("ACC_CODE", true);
				lrReturnData.setNotNull("ACC_CODE", true);

				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","SUB01 Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("COST_DEPT_KIND"))
		{

			
			strSql  = " Select \n";
			strSql += " 	a.COST_DEPT_KND_TAG, \n";
			strSql += " 	a.COST_DEPT_KND_NAME \n";
			strSql += " From	T_COST_DEPT_KIND a \n";
			strSql += " Order By \n";
			strSql += " 	a.COST_DEPT_KND_TAG \n";
			strSql += "  ";
			

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
				GauceInfo.response.writeException("USER", "900001","COST_DEPT_KIND Select ����-> "+ ex.getMessage());
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
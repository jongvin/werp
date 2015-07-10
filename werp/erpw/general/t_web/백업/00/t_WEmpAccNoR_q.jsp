<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Select Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-30)
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
			String strNAME = CITCommon.toKOR(request.getParameter("NAME"));
			
			strSql  = " Select \n";
			strSql += " 	a.EMPNO ERMP_NO, \n";
			strSql += " 	a.NAME, \n";
			strSql += " 	b.IN_BANK_MAIN_CODE_1 , \n";
			strSql += " 	b.IN_ACC_NO_1 , \n";
			strSql += " 	b.IN_BANK_MAIN_CODE_2 , \n";
			strSql += " 	b.IN_ACC_NO_2 , \n";
			strSql += " 	b.IN_BANK_MAIN_CODE_3 , \n";
			strSql += " 	b.IN_ACC_NO_3 \n";
			strSql += " From	Z_AUTHORITY_USER a, \n";
			strSql += " 		T_FIN_EMP_IN_ACC_NO b \n";
			strSql += " Where	a.EMPNO = b.ERMP_NO (+) \n";
			strSql += " And		a.EMPNO || a.NAME Like '%'||Replace(?,' ','%') ||'%' \n";
			strSql += " Order By \n";
			strSql += " 	a.NAME ";
			
			lrArgData.addColumn("1NAME", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1NAME", strNAME);
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
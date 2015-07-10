<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Select Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-19)
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
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	a.ACCNO, \n";
			strSql += " 	a.BANK_CODE, \n";
			strSql += " 	b.ACCOUNT_NO , \n";
			strSql += " 	F_T_StringToYMDFormat(b.CHANGE_YMD) CHANGE_YMD, \n";
			strSql += " 	b.OLD_PASSWORD , \n";
			strSql += " 	b.NEW_PASSWORD , \n";
			strSql += " 	b.CREATION_DATE , \n";
			strSql += " 	b.CREATION_EMP_NO , \n";
			strSql += " 	b.LAST_MODIFY_DATE , \n";
			strSql += " 	b.LAST_MODIFY_EMP_NO, \n";
			strSql += " 	c.BANK_NAME \n";
			strSql += " From	T_ACCNO_CODE a, \n";
			strSql += " 		T_FB_ACCOUNTS_PWD b, \n";
			strSql += " 		T_BANK_CODE c \n";
			strSql += " Where	Replace(a.ACCNO,'-','') = b.ACCOUNT_NO (+) \n";
			strSql += " And		a.COMP_CODE =  ?  \n";
			strSql += " And		a.BANK_CODE = c.BANK_CODE \n";
			strSql += " Order By \n";
			strSql += " 	a.BANK_CODE, \n";
			strSql += " 	a.ACCNO ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
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
<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Select Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-19)
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
			strSql += " 	a.LOAN_KIND_CODE , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.LOAN_TAG , \n";
			strSql += " 	a.LOAN_KIND_NAME , \n";
			strSql += " 	a.LOAN_ACC_CODE , \n";
			strSql += " 	a.ITR_ACC_CODE, \n";
			strSql += " 	a.PE_ITR_ACC_CODE, \n";
			strSql += " 	a.AE_ITR_ACC_CODE, \n";
			strSql += " 	b.ACC_NAME LOAN_ACC_CODE_NAME, \n";
			strSql += " 	c.ACC_NAME ITR_ACC_CODE_NAME, \n";
			strSql += " 	d.ACC_NAME PE_ITR_ACC_CODE_NAME, \n";
			strSql += " 	e.ACC_NAME AE_ITR_ACC_CODE_NAME \n";
			strSql += " From	T_FIN_LOAN_KIND a, \n";
			strSql += " 		T_ACC_CODE b, \n";
			strSql += " 		T_ACC_CODE c, \n";
			strSql += " 		T_ACC_CODE d, \n";
			strSql += " 		T_ACC_CODE e \n";
			strSql += " Where	a.LOAN_ACC_CODE = b.ACC_CODE (+) \n";
			strSql += " And		a.ITR_ACC_CODE = c.ACC_CODE (+) \n";
			strSql += " And		a.PE_ITR_ACC_CODE = d.ACC_CODE (+) \n";
			strSql += " And		a.AE_ITR_ACC_CODE = e.ACC_CODE (+) \n";
			strSql += " Order By  a.LOAN_KIND_CODE";
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("LOAN_KIND_CODE", true);
				lrReturnData.setNotNull("LOAN_KIND_NAME", true);
				lrReturnData.setNotNull("LOAN_TAG", true);


				
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

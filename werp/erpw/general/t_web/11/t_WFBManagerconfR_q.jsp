<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Select Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-20)
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
			String	strCOMP_CODE= CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String	strPAY_GUBUN= CITCommon.toKOR(request.getParameter("PAY_GUBUN"));
			String	strPAY_STATUS= CITCommon.toKOR(request.getParameter("PAY_STATUS"));
			String	strBANK_CODE= CITCommon.toKOR(request.getParameter("BANK_CODE"));
			String	strACCNO_CODE= CITCommon.toKOR(request.getParameter("ACCNO_CODE"));
			String	strDT_F= CITCommon.toKOR(request.getParameter("DT_F"));
			String	strDT_T= CITCommon.toKOR(request.getParameter("DT_T"));
			String	strCUST_SEQ= CITCommon.toKOR(request.getParameter("CUST_CODE"));

			{
				strSql =
					"Select							"+"\r\n"+
					"	a.PAY_SEQ ,				"+"\r\n"+
					"	'F' SELECT_YN ,		"+"\r\n"+
					"	a.PAY_AMT,				"+"\r\n"+
					"	a.PAY_KIND_GUBUN_NAME ,		"+"\r\n"+
					"	a.PAY_STATUS_NAME ,				"+"\r\n"+
					"	a.PAY_STATUS ,						"+"\r\n"+
					"	F_T_DATETOSTRING(a.PAY_DUE_YMD) PAY_DUE_YMD ,												"+"\r\n"+
					"	F_T_DATETOSTRING(a.MANAGER_CONFIRM_DATE) MANAGER_CONFIRM_DATE ,			"+"\r\n"+
					"	a.COMPANY_NAME ,					"+"\r\n"+
					"	a.IN_BANK_CODE_NAME ,			"+"\r\n"+
					"	a.IN_ACCOUNT_NO ,					"+"\r\n"+
					"	a.OUT_BANK_CODE_NAME,			"+"\r\n"+
					"	a.OUT_ACCOUNT_NO ,				"+"\r\n"+
					"	a.DESCRIPTION , 					"+"\r\n"+
					"	a.CUST_NAME  							"+"\r\n"+
					"From	VIEW_CASH_PAY_DATA a 	"+"\r\n"+
					"Where	a.COMP_CODE = ? 		"+"\r\n"+
					"And 	a.PAY_KIND_GUBUN like ?||'%' 	"+"\r\n"+
					"And 	a.PAY_STATUS = ? 							"+"\r\n"+
					"And 	a.OUT_BANK_CODE = ? 					"+"\r\n"+
					"And 	a.PAY_DUE_YMD BETWEEN F_T_STRINGTODATE(?) AND F_T_STRINGTODATE(?) "+"\r\n";
					if(!"%".equals(strACCNO_CODE)) strSql += "And 	a.OUT_ACCOUNT_NO = ? "+"\r\n" ;					
					if(!"".equals(strCUST_SEQ)) strSql += "And 	a.CUST_SEQ like ?||'%' 			"+"\r\n";
					strSql += "Order By	a.PAY_KIND_GUBUN ";
			}

			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("PAY_GUBUN", CITData.VARCHAR2);
			lrArgData.addColumn("PAY_STATUS", CITData.VARCHAR2);
			lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("DT_T", CITData.VARCHAR2);
			if(!"%".equals(strACCNO_CODE)) lrArgData.addColumn("ACCNO_CODE", CITData.VARCHAR2);						
			if(!"".equals(strCUST_SEQ)) lrArgData.addColumn("CUST_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("PAY_GUBUN", strPAY_GUBUN);
			lrArgData.setValue("PAY_STATUS", strPAY_STATUS);
			lrArgData.setValue("BANK_CODE", strBANK_CODE);
			lrArgData.setValue("DT_F", strDT_F);
			lrArgData.setValue("DT_T", strDT_T);
			if(!"%".equals(strACCNO_CODE)) lrArgData.setValue("ACCNO_CODE", strACCNO_CODE);
			if(!"".equals(strCUST_SEQ)) lrArgData.setValue("CUST_CODE", strCUST_SEQ);

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
		}
		else if (strAct.equals("COPY"))
		{
			
			strSql  = " Select 0 PAY_SEQ from dual \n";
			
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
		
			try
			{
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","COPY Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("BANK"))
		{
			String	strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
					
			strSql  = 
				"select "+"\n"+
				"	a.BANK_MAIN_CODE  CODE, "+"\n"+
				"	a.BANK_MAIN_NAME NAME  "+"\n"+
				"from	VIEW_FBS_ACCOUNTS a "+"\n"+
				"where a.COMP_CODE = ? "+"\n"+
				"and   a.FBS_TRANSFER_CLS = 'T' "+"\n"+
				"group by"+"\n"+
				"	a.BANK_MAIN_CODE , "+"\n"+ 
				"	a.BANK_MAIN_NAME "+"\n";
			
			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE",strCOMP_CODE);

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
		}
		else if (strAct.equals("ACCOUNT"))
		{ 
			String	strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String	strBANK_CODE = CITCommon.toKOR(request.getParameter("BANK_CODE"));
					
			strSql  = 
				"select '%' 		CODE ,	"+"\n"+
				"				'��ü'	NAME		"+"\n"+
				"from   dual						"+"\n"+
				"union all							"+"\n"+
				"select 								"+"\n"+
				"	a.NAIVE_ACCOUNT_NUMBER  CODE, "+"\n"+
				"	a.ACCOUNT_NUMBER NAME  				"+"\n"+
				"from	VIEW_FBS_ACCOUNTS a 			"+"\n"+
				"where a.COMP_CODE = ? 					"+"\n"+
				"and  a.BANK_MAIN_CODE = ? 			"+"\n"+
//				"and  a.FBS_TRANSFER_CLS = 'T' "+"\n"+
				"group by												"+"\n"+
				"	a.NAIVE_ACCOUNT_NUMBER , 			"+"\n"+ 
				"	a.ACCOUNT_NUMBER 							"+"\n";
			
			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("BANK_CODE",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE",strCOMP_CODE);
			lrArgData.setValue("BANK_CODE",strBANK_CODE);
		
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);		
		}		
		else if (strAct.equals("PASS"))
		{
			String	strEMP_NO= CITCommon.toKOR(request.getParameter("EMP_NO"));
			String	strMANAGER_PASS1= CITCommon.toKOR(request.getParameter("MANAGER_PASS1"));
			String	strMANAGER_PASS2= CITCommon.toKOR(request.getParameter("MANAGER_PASS2")); 
			
			strSql  = " Select FBS_UTIL_PKG.format_msg(FBS_UTIL_PKG.do_pwd_job('CHK_CASH_PW',?,?,?)) RET_MSG from dual \n";
			
			lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
			lrArgData.addColumn("MANAGER_PASS1", CITData.VARCHAR2);
			lrArgData.addColumn("MANAGER_PASS2", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("EMP_NO", strEMP_NO);
			lrArgData.setValue("MANAGER_PASS1", strMANAGER_PASS1);
			lrArgData.setValue("MANAGER_PASS2", strMANAGER_PASS2);
			
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
		
			try
			{
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","PASS Select ����-> "+ ex.getMessage());
			}
		}		
		try
		{
			lrDataset = CITCommon.toGauceDataSet(lrReturnData);
			GauceInfo.response.enableFirstRow(lrDataset);
			lrDataset.flush();
		}
		catch (Exception ex)
		{
			GauceInfo.response.writeException("USER", "900001", ex.getMessage());
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
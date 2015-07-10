<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Select Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-11-17)
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
			String strTRADE_CLS = CITCommon.toKOR(request.getParameter("TRADE_CLS"));
			String strSEARCH_CONDITION = CITCommon.toKOR(request.getParameter("SEARCH_CONDITION"));
			String strACCNO = CITCommon.toKOR(request.getParameter("ACCNO"));
			
			if(CITCommon.isNull(strACCNO))
			{
				strSql  = " Select	/*+ parallel(t_cust_code 4) */   A.CUST_SEQ , \n";  ///*+ all_rows */
				strSql += "       	A.CRTUSERNO , \n";
				strSql += "       	A.CRTDATE , \n";
				strSql += "       	A.MODUSERNO , \n";
				strSql += "       	A.MODDATE , \n";
				strSql += "       	F_T_CUST_MASK(A.CUST_CODE) CUST_CODE , \n";
				strSql += "       	A.CUST_NAME , \n";
				strSql += "       	A.BOSS_NAME , \n";
				strSql += "       	A.TRADE_CLS , \n";
				strSql += "       	A.BIZCOND , \n";
				strSql += "       	A.BIZKND , \n";
				strSql += "       	F_T_ZIP_MASK(A.ZIPCODE) ZIPCODE , \n";
				strSql += "       	A.ADDR1 , \n";
				strSql += "       	A.ADDR2 , \n";
				strSql += "       	A.TELNO , \n";
				strSql += "       	A.GROUP_COMP_CLS , \n";
				strSql += "       	A.REPRESENT_CUST_SEQ , \n";
				strSql += "       	F_T_CUST_MASK(B.CUST_CODE) REPRESENT_CUST_CODE , \n";
				strSql += "       	B.CUST_NAME REPRESENT_CUST_NAME , \n";
				strSql += "       	A.USE_CLS \n";
				strSql += " From	T_CUST_CODE A, \n";
				strSql += " 		T_CUST_CODE B \n";
				strSql += " Where	A.CUST_SEQ = B.REPRESENT_CUST_SEQ(+) \n";
				strSql += " And	A.TRADE_CLS Like  '%'||  ?  ||'%' \n";
				strSql += " And	A.CUST_CODE || A.CUST_NAME Like '%'|| Replace(?,' ','%') || '%' \n";
	
				lrArgData.addColumn("TRADE_CLS", CITData.VARCHAR2);
				lrArgData.addColumn("SEARCH_CONDITION", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("TRADE_CLS", strTRADE_CLS);
				lrArgData.setValue("SEARCH_CONDITION", strSEARCH_CONDITION);
			}
			else
			{
				strSql  = " Select	/*+ parallel(t_cust_code 4) */   A.CUST_SEQ , \n";  ///*+ all_rows */
				strSql += "       	A.CRTUSERNO , \n";
				strSql += "       	A.CRTDATE , \n";
				strSql += "       	A.MODUSERNO , \n";
				strSql += "       	A.MODDATE , \n";
				strSql += "       	F_T_CUST_MASK(A.CUST_CODE) CUST_CODE , \n";
				strSql += "       	A.CUST_NAME , \n";
				strSql += "       	A.BOSS_NAME , \n";
				strSql += "       	A.TRADE_CLS , \n";
				strSql += "       	A.BIZCOND , \n";
				strSql += "       	A.BIZKND , \n";
				strSql += "       	F_T_ZIP_MASK(A.ZIPCODE) ZIPCODE , \n";
				strSql += "       	A.ADDR1 , \n";
				strSql += "       	A.ADDR2 , \n";
				strSql += "       	A.TELNO , \n";
				strSql += "       	A.GROUP_COMP_CLS , \n";
				strSql += "       	A.REPRESENT_CUST_SEQ , \n";
				strSql += "       	F_T_CUST_MASK(B.CUST_CODE) REPRESENT_CUST_CODE , \n";
				strSql += "       	B.CUST_NAME REPRESENT_CUST_NAME , \n";
				strSql += "       	A.USE_CLS \n";
				strSql += " From	T_CUST_CODE A, \n";
				strSql += " 		T_CUST_CODE B \n";
				strSql += " Where	A.CUST_SEQ = B.REPRESENT_CUST_SEQ(+) \n";
				strSql += " And	A.TRADE_CLS Like  '%'||  ?  ||'%' \n";
				strSql += " And	A.CUST_CODE || A.CUST_NAME Like '%'|| Replace(?,' ','%') || '%' \n";
				strSql += " And	a.cust_seq in  (Select x.cust_seq From T_CUST_ACCNO_CODE x where  replace(x.accno,'-','') Like '%' || replace(?,'-','') || '%' and rownum < 100 ) \n";
	
				lrArgData.addColumn("TRADE_CLS", CITData.VARCHAR2);
				lrArgData.addColumn("SEARCH_CONDITION", CITData.VARCHAR2);
				lrArgData.addColumn("ACCNO", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("TRADE_CLS", strTRADE_CLS);
				lrArgData.setValue("SEARCH_CONDITION", strSEARCH_CONDITION);
				lrArgData.setValue("ACCNO", strACCNO);
			}
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("CUST_SEQ", true);
				lrReturnData.setNotNull("CUST_CODE", true);
				lrReturnData.setNotNull("CUST_NAME", true);
				lrReturnData.setNotNull("TRADE_CLS", true);
				lrReturnData.setNotNull("GROUP_COMP_CLS", true);
				lrReturnData.setNotNull("USE_CLS", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","T_CUST_CODE Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("CUST_SEQ"))
		{
			
			strSql  = " Select SQ_T_CUST_SEQ.nextval as CUST_SEQ from dual ";
			
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
				GauceInfo.response.writeException("USER", "900001","T_CUST_ACCNO_CODE Select ����-> "+ ex.getMessage());
			}
		}
		if (strAct.equals("CUST_CODE"))
		{
			String strCUST_CODE = CITCommon.toKOR(request.getParameter("CUST_CODE"));
			
			strSql  = " Select	A.CUST_CODE \n";
			strSql += " From	T_CUST_CODE A \n";
			strSql += " Where	A.CUST_CODE =  ?  ";
			
			lrArgData.addColumn("CUST_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("CUST_CODE", strCUST_CODE);
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
		else if (strAct.equals("CUST_ACCNO"))
		{
			String strCUST_SEQ = CITCommon.toKOR(request.getParameter("CUST_SEQ"));
			
			strSql  = " Select	A.CUST_SEQ , \n";
			strSql += "       	A.ACCNO , \n";
			strSql += "       	A.SEQ , \n";
			strSql += "       	A.CRTUSERNO , \n";
			strSql += "       	A.CRTDATE , \n";
			strSql += "       	A.MODUSERNO , \n";
			strSql += "       	A.MODDATE , \n";
			strSql += "       	A.BANK_MAIN_CODE , \n";
			strSql += "       	B.BANK_MAIN_NAME , \n";
			strSql += "       	A.ACCNO_OWNER , \n";
			strSql += "       	A.ACCNO_CLS , \n";
			strSql += "       	A.OUT_ACCNO , \n";
			strSql += "       	F_T_DATETOSTRING(A.CLOSE_DT) CLOSE_DT , \n";
			strSql += "       	A.USE_TG \n";
			strSql += " From	T_CUST_ACCNO_CODE A , \n";
			strSql += " 		T_BANK_MAIN B \n";
			strSql += " Where		A.BANK_MAIN_CODE = B.BANK_MAIN_CODE(+) \n";
			strSql += " And		A.CUST_SEQ =  ?  ";
			
			lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("CUST_SEQ", strCUST_SEQ);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("CUST_SEQ", true);
				lrReturnData.setKey("ACCNO", true);
				lrReturnData.setNotNull("BANK_MAIN_CODE", true);
				lrReturnData.setNotNull("BANK_MAIN_NAME", true);
				lrReturnData.setNotNull("ACCNO_OWNER", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","T_CUST_ACCNO_CODE Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("PAY_STOP"))
		{
			
			String strCUST_SEQ = CITCommon.toKOR(request.getParameter("CUST_SEQ"));
			
			strSql  = " SELECT  A.CUST_SEQ, \n";
			strSql += "         A.PAY_STOP_SEQ, \n";
			strSql += "         A.CRTUSERNO, \n";
			strSql += "         A.CRTDATE, \n";
			strSql += "         A.MODUSERNO, \n";
			strSql += "         A.MODDATE, \n";
			strSql += "         A.PAY_STOP_CLS, \n";
			strSql += "         F_T_DATETOSTRING(A.PAY_STOPSTR_DT) PAY_STOPSTR_DT, \n";
			strSql += "         F_T_DATETOSTRING(A.PAY_STOPEND_DT) PAY_STOPEND_DT, \n";
			strSql += "         A.PAY_STOPSTR_MEMO, \n";
			strSql += "         A.PAY_STOPEND_MEMO, \n";
			strSql += "         A.DEPT_CODE, \n";
			strSql += "         B.DEPT_NAME \n";
			strSql += "  FROM   T_PAY_STOP_HISTORY A, \n";
			strSql += "         T_DEPT_CODE B \n";
			strSql += " WHERE   A.DEPT_CODE = B.DEPT_CODE(+) \n";
			strSql += " AND		A.CUST_SEQ =  ?  \n";
			strSql += " ORDER BY PAY_STOP_SEQ desc ";
			
			lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("CUST_SEQ", strCUST_SEQ);
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("CUST_SEQ", true);
				lrReturnData.setKey("PAY_STOP_SEQ", true);
				lrReturnData.setNotNull("PAY_STOP_CLS", true);
				lrReturnData.setNotNull("PAY_STOPSTR_DT", true);
				lrReturnData.setNotNull("PAY_STOPSTR_MEMO", true);
				lrReturnData.setNotNull("DEPT_CODE", true);
				lrReturnData.setNotNull("DEPT_NAME", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","dsPAY_STOP Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("CUST_PAYSTOP_SEQ"))
		{
			strSql  = " SELECT SQ_T_PAY_STOP_HISTORY_SEQ.NextVal PAY_STOP_SEQ FROM dual ";
		 	
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
				GauceInfo.response.writeException("USER", "900001","CUST_PAYSTOP_SEQ Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("ACCT"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strBANK_MAIN_CODE = CITCommon.toKOR(request.getParameter("BANK_MAIN_CODE"));
			String strACCNO = CITCommon.toKOR(request.getParameter("ACCNO"));
			
			strSql  = " Select	f_retrive_acct_holder_name(?,?,Replace(?,'-',''),Null) ACCNO_OWNER From Dual \n";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("BANK_MAIN_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("ACCNO", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("BANK_MAIN_CODE", strBANK_MAIN_CODE);
			lrArgData.setValue("ACCNO", strACCNO);
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
				GauceInfo.response.writeException("USER", "900001","f_retrive_acct_holder_name Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("BILL_VENDOR"))
		{
			String strVAT_REGISTRATION_NUM = CITCommon.toKOR(request.getParameter("VAT_REGISTRATION_NUM"));
			
			strSql  = " Select \n";
			strSql += " 	a.SEQ , \n";
			strSql += " 	a.TRANSFER_YMD , \n";
			strSql += " 	a.VAT_REGISTRATION_NUM , \n";
			strSql += " 	a.VENDOR_NAME , \n";
			strSql += " 	a.SSN , \n";
			strSql += " 	a.CONTRACT_GUBUN , \n";
			strSql += " 	a.CHANGE_YMD , \n";
			strSql += " 	a.ACCOUNT_NO , \n";
			strSql += " 	a.BANK_CODE , \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.CREATION_DATE , \n";
			strSql += " 	a.CREATION_EMP_NO , \n";
			strSql += " 	a.LAST_MODIFY_DATE , \n";
			strSql += " 	a.LAST_MODIFY_EMP_NO , \n";
			strSql += " 	a.ATTRIBUTE1 , \n";
			strSql += " 	a.ATTRIBUTE2 , \n";
			strSql += " 	a.ATTRIBUTE3 , \n";
			strSql += " 	a.FRANCHISE_NO , \n";
			strSql += " 	a.CHECK_NO , \n";
			strSql += " 	a.CUST_NO, \n";
			strSql += " 	b.BANK_MAIN_NAME \n";
			strSql += " From	t_fb_bill_vendors a, \n";
			strSql += " 		T_BANK_MAIN b \n";
			strSql += " Where	a.BANK_CODE = b.BANK_MAIN_CODE (+) \n";
			strSql += " And		a.VAT_REGISTRATION_NUM =  replace(?,'-','')  \n";
			strSql += "  ";
			
			lrArgData.addColumn("1VAT_REGISTRATION_NUM", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1VAT_REGISTRATION_NUM", strVAT_REGISTRATION_NUM);
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
				GauceInfo.response.writeException("USER", "900001","BILL_VENDOR Select ����-> "+ ex.getMessage());
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
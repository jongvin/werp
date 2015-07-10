<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-05)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
 
	CITGauceInfo GauceInfo = null;
	
	CITData      lrReturnData = null;
	GauceDataSet lrDataset = null;
	              	
	String	strSql = "";
	String	strAct = "";

	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		CITData lrArgData = new CITData();

		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MAIN01"))
		{
			String	strCOMP_CODE 	= CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String	strBANK_CODE 	= CITCommon.toKOR(request.getParameter("BANK_CODE"));
			String	strCHK_BILL_CLS = CITCommon.toKOR(request.getParameter("CHK_BILL_CLS"));
			
			strSql  = " Select \n";
			strSql += " 	a.CHK_BILL_NO , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.CHK_BILL_CLS , \n";
			strSql += " 	a.BILL_KIND , \n";
			strSql += " 	a.STAT_CLS , \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.BANK_CODE , \n";
			strSql += " 	To_char(a.CUST_SEQ) CUST_SEQ, \n";
			strSql += " 	F_T_Cust_Mask(c.CUST_CODE) CUST_CODE, \n";
			strSql += " 	F_T_DATETOSTRING(a.ACPT_DT) ACPT_DT, \n";
			strSql += " 	F_T_DATETOSTRING(a.PUBL_DT) PUBL_DT, \n";
			strSql += " 	a.PUBL_AMT , \n";
			strSql += " 	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT, \n";
			strSql += " 	F_T_DATETOSTRING(a.CHG_EXPR_DT) CHG_EXPR_DT, \n";
			strSql += " 	F_T_DATETOSTRING(a.DUSE_DT) DUSE_DT, \n";
			strSql += " 	F_T_DATETOSTRING(a.CUST_DOUT_DT) CUST_DOUT_DT, \n";
			strSql += " 	F_T_DATETOSTRING(a.COLL_DT) COLL_DT, \n";
			strSql += " 	F_T_DATETOSTRING(a.RETURN_DT) RETURN_DT, \n";
			strSql += " 	a.DISC_RAT , \n";
			strSql += " 	a.DISC_AMT , \n";
			strSql += " 	To_Char(a.SLIP_ID) SLIP_ID , \n";
			strSql += " 	To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ , \n";
			strSql += " 	To_Char(a.RESET_SLIP_ID) RESET_SLIP_ID , \n";
			strSql += " 	To_Char(a.RESET_SLIP_IDSEQ) RESET_SLIP_IDSEQ , \n";
			strSql += " 	a.REMARKS, \n";
			strSql += " 	b.BANK_NAME, \n";
			strSql += " 	c.CUST_NAME \n";
			strSql += " From	T_FIN_PAY_CHK_BILL a, \n";
			strSql += " 		T_BANK_CODE b, \n";
			strSql += " 		T_CUST_CODE c \n";
			strSql += " Where	a.CHK_BILL_CLS =  ?  \n";
			strSql += " And		a.COMP_CODE Like '%'|| ? ||'%' \n";
			strSql += " And		a.BANK_CODE Like '%'|| ? ||'%' \n";
			strSql += " And		a.BANK_CODE = b.BANK_CODE (+) \n";
			strSql += " And		a.CUST_SEQ = c.CUST_SEQ (+) \n";
			strSql += " And		a.STAT_CLS In ('1','3','4','9') \n";	//1:미발행,3:폐기,4:분실,9:은행반환
			strSql += " Order By \n";
			strSql += " 	a.CHK_BILL_NO \n";
			strSql += "  ";
			
			lrArgData.addColumn("CHK_BILL_CLS",CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("BANK_CODE",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("CHK_BILL_CLS",strCHK_BILL_CLS);
			lrArgData.setValue("COMP_CODE",strCOMP_CODE);
			lrArgData.setValue("BANK_CODE",strBANK_CODE);
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("CHK_BILL_NO", true);
				lrReturnData.setNotNull("CHK_BILL_CLS", true);
				lrReturnData.setNotNull("COMP_CODE", true);
				lrReturnData.setNotNull("BANK_CODE", true);
				//lrReturnData.setNotNull("CUST_CODE", true);
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN01 Select 오류-> "+ ex.getMessage());
			}
		}	
		else if (strAct.equals("MAIN02"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strBANK_CODE = CITCommon.toKOR(request.getParameter("BANK_CODE"));
			String strPUBL_DT_F = CITCommon.toKOR(request.getParameter("PUBL_DT_F"));
			String strPUBL_DT_T = CITCommon.toKOR(request.getParameter("PUBL_DT_T"));
			String strCHK_BILL_CLS = CITCommon.toKOR(request.getParameter("CHK_BILL_CLS"));
			
			strSql  = " Select \n";
			strSql += " 	a.CHK_BILL_CLS , \n";
			strSql += " 	a.CHK_BILL_NO , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.BANK_CODE , \n";
			strSql += " 	To_Char(a.CUST_SEQ) CUST_SEQ, \n";
			strSql += " 	F_T_Cust_Mask(c.CUST_CODE)  CUST_CODE , \n";
			strSql += " 	F_T_DATETOSTRING(a.ACPT_DT) ACPT_DT , \n";
			strSql += " 	F_T_DATETOSTRING(a.PUBL_DT) PUBL_DT , \n";
			strSql += " 	nvl(a.PUBL_AMT,0) PUBL_AMT , \n";
			strSql += " 	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT , \n";
			strSql += " 	F_T_DATETOSTRING(a.CHG_EXPR_DT) CHG_EXPR_DT , \n";
			strSql += " 	F_T_DATETOSTRING(a.DUSE_DT) DUSE_DT , \n";
			strSql += " 	F_T_DATETOSTRING(a.CUST_DOUT_DT) CUST_DOUT_DT , \n";
			strSql += " 	F_T_DATETOSTRING(a.COLL_DT) COLL_DT , \n";
			strSql += " 	a.DISC_RAT , \n";
			strSql += " 	a.DISC_AMT , \n";
			strSql += " 	To_Char(a.SLIP_ID) SLIP_ID, \n";
			strSql += " 	To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ , \n";
			strSql += " 	a.REMARKS , \n";
			strSql += " 	b.BANK_NAME , \n";
			strSql += " 	c.CUST_NAME, \n";
			strSql += " 	d.MAKE_SLIPNO \n";
			strSql += " From	T_FIN_PAY_CHK_BILL a, \n";
			strSql += " 		T_BANK_CODE b , \n";
			strSql += " 		T_CUST_CODE c, \n";
			strSql += " 		T_ACC_SLIP_HEAD d \n";
			strSql += " Where	a.PUBL_AMT <> '0' \n";
			strSql += " And		a.BANK_CODE = b.BANK_CODE(+) \n";
			strSql += " And		a.CUST_SEQ  = c.CUST_SEQ(+) \n";
			strSql += " And		a.COMP_CODE like '%' ||    ?    || '%' \n";
			strSql += " And		a.BANK_CODE like '%' ||    ?    || '%' \n";
			strSql += " And		a.PUBL_DT Between  ?  And  ?  \n";
			strSql += " And		a.CHK_BILL_CLS =    ?  \n";
			strSql += " And		a.STAT_CLS in ( '2' )  \n";
			strSql += " And		a.SLIP_ID = d.SLIP_ID (+) \n";
			strSql += " Order By \n";
			strSql += " 	a.CHK_BILL_NO \n";
			strSql += "  ";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("PUBL_DT_F", CITData.DATE);
			lrArgData.addColumn("PUBL_DT_T", CITData.DATE);
			lrArgData.addColumn("CHK_BILL_CLS", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("BANK_CODE", strBANK_CODE);
			lrArgData.setValue("PUBL_DT_F", strPUBL_DT_F);
			lrArgData.setValue("PUBL_DT_T", strPUBL_DT_T);
			lrArgData.setValue("CHK_BILL_CLS", strCHK_BILL_CLS);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("CHK_BILL_NO", true);

				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN02 Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("MAIN03"))
		{
			String strPUBL_DT_F = CITCommon.toKOR(request.getParameter("PUBL_DT_F"));
			String strPUBL_DT_T = CITCommon.toKOR(request.getParameter("PUBL_DT_T"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strBANK_CODE = CITCommon.toKOR(request.getParameter("BANK_CODE"));
			String strCHK_BILL_CLS = CITCommon.toKOR(request.getParameter("CHK_BILL_CLS"));
			
			strSql  = " Select \n";
			strSql += " 	a.CHK_BILL_NO , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.CHK_BILL_CLS , \n";
			strSql += " 	a.BILL_KIND , \n";
			strSql += " 	a.STAT_CLS , \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.BANK_CODE , \n";
			strSql += " 	To_char(a.CUST_SEQ) CUST_SEQ, \n";
			strSql += " 	F_T_Cust_Mask(c.CUST_CODE) CUST_CODE, \n";
			strSql += " 	F_T_DATETOSTRING(a.ACPT_DT) ACPT_DT, \n";
			strSql += " 	F_T_DATETOSTRING(a.PUBL_DT) PUBL_DT, \n";
			strSql += " 	a.PUBL_AMT , \n";
			strSql += " 	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT, \n";
			strSql += " 	F_T_DATETOSTRING(a.CHG_EXPR_DT) CHG_EXPR_DT, \n";
			strSql += " 	F_T_DATETOSTRING(a.DUSE_DT) DUSE_DT, \n";
			strSql += " 	F_T_DATETOSTRING(a.CUST_DOUT_DT) CUST_DOUT_DT, \n";
			strSql += " 	F_T_DATETOSTRING(a.COLL_DT) COLL_DT, \n";
			strSql += " 	F_T_DATETOSTRING(a.RETURN_DT) RETURN_DT, \n";
			strSql += " 	a.DISC_RAT , \n";
			strSql += " 	a.DISC_AMT , \n";
			strSql += " 	To_Char(a.SLIP_ID) SLIP_ID , \n";
			strSql += " 	To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ , \n";
			strSql += " 	To_Char(a.RESET_SLIP_ID) RESET_SLIP_ID , \n";
			strSql += " 	To_Char(a.RESET_SLIP_IDSEQ) RESET_SLIP_IDSEQ , \n";
			strSql += " 	a.REMARKS, \n";
			strSql += " 	b.BANK_NAME, \n";
			strSql += " 	c.CUST_NAME \n";
			strSql += " From	T_FIN_PAY_CHK_BILL a, \n";
			strSql += " 		T_BANK_CODE b, \n";
			strSql += " 		T_CUST_CODE c \n";
			strSql += " where	a.BANK_CODE = b.BANK_CODE(+) \n";
			strSql += " And		a.CUST_SEQ  = c.CUST_SEQ(+) \n";
			strSql += " And		a.PUBL_DT Between  ?  And  ?  \n";
			strSql += " And		a.COMP_CODE like '%' ||    ?    || '%' \n";
			strSql += " And		a.BANK_CODE like '%' ||    ?    || '%' \n";
			strSql += " And 	a.CHK_BILL_CLS =    ?  \n";
			strSql += " And		a.STAT_CLS = '0' ";
			
			lrArgData.addColumn("PUBL_DT_F", CITData.DATE);
			lrArgData.addColumn("PUBL_DT_T", CITData.DATE);
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CHK_BILL_CLS", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("PUBL_DT_F", strPUBL_DT_F);
			lrArgData.setValue("PUBL_DT_T", strPUBL_DT_T);
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("BANK_CODE", strBANK_CODE);
			lrArgData.setValue("CHK_BILL_CLS", strCHK_BILL_CLS);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("CHK_BILL_NO", true);


				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN03 Select 오류-> "+ ex.getMessage());
			}
		}	
	}
	catch (Exception ex)
	{
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
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
			GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
		}
	}
%>
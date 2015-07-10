<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2005-11-30)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
CITDebug.PrintMessages("aaaa"); 
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
			String strCHK_BILL_CLS = CITCommon.toKOR(request.getParameter("CHK_BILL_CLS"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strBANK_CODE = CITCommon.toKOR(request.getParameter("BANK_CODE"));
			
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
			
			lrArgData.addColumn("CHK_BILL_CLS", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("CHK_BILL_CLS", strCHK_BILL_CLS);
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("BANK_CODE", strBANK_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("CHK_BILL_NO", true);
				lrReturnData.setNotNull("CHK_BILL_CLS", true);
				lrReturnData.setNotNull("BILL_KIND", true);
				lrReturnData.setNotNull("STAT_CLS", true);
				lrReturnData.setNotNull("COMP_CODE", true);
				lrReturnData.setNotNull("BANK_CODE", true);
				
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
			strSql += " 	a.BILL_KIND , \n";
			strSql += " 	a.STAT_CLS , \n";
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
		else if (strAct.equals("SETSLIP"))
		{
			String strCHK_BILL_NO = CITCommon.toKOR(request.getParameter("CHK_BILL_NO"));
			
			strSql  = " Select \n";
			strSql += " 	GB_TAG, \n";
			strSql += " 	MAKE_DT, \n";
			strSql += " 	SLIP_ID , \n";
			strSql += " 	SLIP_IDSEQ, \n";
			strSql += " 	CHK_BILL_NO, \n";
			strSql += " 	GB, \n";
			strSql += " 	MAKE_SLIPNO, \n";
			strSql += " 	MAKE_SLIPLINE, \n";
			strSql += " 	SUMMARY, \n";
			strSql += " 	DB_AMT , \n";
			strSql += " 	CR_AMT, \n";
			strSql += " 	DEPT_CODE, \n";
			strSql += " 	DEPT_NAME, \n";
			strSql += " 	Sum(Nvl(CR_AMT,0) - Nvl(DB_AMT,0)) Over (Order By GB_TAG,MAKE_DT,SLIP_ID,SLIP_IDSEQ) REMAIN_AMT \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			1 GB_TAG, \n";
			strSql += " 			c.MAKE_DT, \n";
			strSql += " 			b.SLIP_ID , \n";
			strSql += " 			b.SLIP_IDSEQ, \n";
			strSql += " 			a.CHK_BILL_NO, \n";
			strSql += " 			SubStrb('설정',1,20) GB, \n";
			strSql += " 			c.MAKE_SLIPNO, \n";
			strSql += " 			b.MAKE_SLIPLINE, \n";
			strSql += " 			b.SUMMARY1||' '|| b.SUMMARY2 SUMMARY, \n";
			strSql += " 			b.DB_AMT , \n";
			strSql += " 			b.CR_AMT, \n";
			strSql += " 			b.DEPT_CODE, \n";
			strSql += " 			d.DEPT_NAME \n";
			strSql += " 		From	T_FIN_PAY_CHK_BILL a, \n";
			strSql += " 				T_ACC_SLIP_BODY b, \n";
			strSql += " 				T_ACC_SLIP_HEAD c, \n";
			strSql += " 				T_DEPT_CODE d \n";
			strSql += " 		Where	a.SLIP_ID = b.SLIP_ID \n";
			strSql += " 		And		a.SLIP_IDSEQ = b.SLIP_IDSEQ \n";
			strSql += " 		And		b.SLIP_ID = c.SLIP_ID \n";
			strSql += " 		And		b.DEPT_CODE = d.DEPT_CODE (+) \n";
			strSql += " 		And		a.CHK_BILL_NO =  ?  \n";
			strSql += " 		Union All \n";
			strSql += " 		Select \n";
			strSql += " 			2 GB_TAG, \n";
			strSql += " 			c.MAKE_DT, \n";
			strSql += " 			b.SLIP_ID , \n";
			strSql += " 			b.SLIP_IDSEQ, \n";
			strSql += " 			a.CHK_BILL_NO, \n";
			strSql += " 			SubStrb('반제',1,20) GB, \n";
			strSql += " 			c.MAKE_SLIPNO, \n";
			strSql += " 			b.MAKE_SLIPLINE, \n";
			strSql += " 			b.SUMMARY1||' '|| b.SUMMARY2 SUMMARY, \n";
			strSql += " 			b.DB_AMT , \n";
			strSql += " 			b.CR_AMT, \n";
			strSql += " 			b.DEPT_CODE, \n";
			strSql += " 			d.DEPT_NAME \n";
			strSql += " 		From	T_FIN_PAY_CHK_BILL a, \n";
			strSql += " 				T_ACC_SLIP_BODY b, \n";
			strSql += " 				T_ACC_SLIP_HEAD c, \n";
			strSql += " 				T_DEPT_CODE d \n";
			strSql += " 		Where	a.SLIP_ID = b.RESET_SLIP_ID \n";
			strSql += " 		And		a.SLIP_IDSEQ = b.RESET_SLIP_IDSEQ \n";
			strSql += " 		And		b.SLIP_ID <> b.RESET_SLIP_ID \n";
			strSql += " 		And		b.SLIP_ID = c.SLIP_ID \n";
			strSql += " 		And		b.DEPT_CODE = d.DEPT_CODE (+) \n";
			strSql += " 		And		a.CHK_BILL_NO =  ?  \n";
			strSql += " 	) \n";
			strSql += " Order By \n";
			strSql += " 	GB_TAG, \n";
			strSql += " 	MAKE_DT, \n";
			strSql += " 	SLIP_ID , \n";
			strSql += " 	SLIP_IDSEQ \n";
			strSql += "  ";
			
			lrArgData.addColumn("CHK_BILL_NO_1", CITData.VARCHAR2);
			lrArgData.addColumn("CHK_BILL_NO_2", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("CHK_BILL_NO_1", strCHK_BILL_NO);
			lrArgData.setValue("CHK_BILL_NO_2", strCHK_BILL_NO);
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
				GauceInfo.response.writeException("USER", "900001","SETSLIP Select 오류-> "+ ex.getMessage());
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
		else if (strAct.equals("MAIN04"))
		{
			String	strF_EXPR_DT = CITCommon.toKOR(request.getParameter("F_EXPR_DT"));
			String	strE_EXPR_DT = CITCommon.toKOR(request.getParameter("E_EXPR_DT"));
			String	strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String	strBANK_CODE = CITCommon.toKOR(request.getParameter("BANK_CODE"));
			String	strCHK_BILL_CLS = CITCommon.toKOR(request.getParameter("CHK_BILL_CLS"));

			strSql  = "select   \n";
			strSql  += "	a.CHK_BILL_CLS ,   \n";
			strSql  += "	a.CHK_BILL_NO ,   \n";
			strSql  += "	a.CRTUSERNO ,   \n";
			strSql  += "	a.CRTDATE ,   \n";
			strSql  += "	a.MODUSERNO ,   \n";
			strSql  += "	a.MODDATE ,   \n";
			strSql += " 	a.BILL_KIND , \n";
			strSql += " 	a.STAT_CLS , \n";
			strSql  += "	a.COMP_CODE ,   \n";
			strSql  += "	a.BANK_CODE ,   \n";
			strSql  += "    To_Char(a.CUST_SEQ) CUST_SEQ, \n";
			strSql  += "	F_T_Cust_Mask(d.CUST_CODE) CUST_CODE ,   \n";
			strSql  += "	F_T_DATETOSTRING(a.ACPT_DT) ACPT_DT ,   \n";
			strSql  += "	F_T_DATETOSTRING(a.PUBL_DT) PUBL_DT ,   \n";
			strSql  += "	a.PUBL_AMT ,   \n";
			strSql  += "	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT ,   \n";
			strSql  += "	F_T_DATETOSTRING(a.CHG_EXPR_DT) CHG_EXPR_DT ,   \n";
			strSql  += "	F_T_DATETOSTRING(a.DUSE_DT) DUSE_DT ,   \n";
			strSql  += "	F_T_DATETOSTRING(a.CUST_DOUT_DT) CUST_DOUT_DT ,   \n";
			strSql  += "	F_T_DATETOSTRING(a.COLL_DT) COLL_DT ,   \n";
			strSql  += "	a.DISC_RAT ,   \n";
			strSql  += "	a.DISC_AMT ,   \n";
			strSql  += "	To_Char(a.SLIP_ID) SLIP_ID ,   \n";
			strSql  += "	To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ ,   \n";
			strSql  += "	a.REMARKS ,   \n";
			strSql  += "	b.BANK_NAME ,   \n";
			strSql  += "	c.COMPANY_NAME ,   \n";
			strSql  += "	d.CUST_NAME   \n";
			strSql  += "from	T_FIN_PAY_CHK_BILL a ,   \n";
			strSql  += "		T_BANK_CODE b ,   \n";
			strSql  += "		T_COMPANY c ,   \n";
			strSql  += "		T_CUST_CODE d   \n";
			strSql  += "where	a.PUBL_AMT <> '0'   \n";
			strSql  += "and		a.EXPR_DT >=  ?  \n";
			strSql  += "and		a.EXPR_DT <=  ?  \n";
			strSql  += "and		a.BANK_CODE = b.BANK_CODE(+)   \n";
			strSql  += "and		a.COMP_CODE = c.COMP_CODE(+)   \n";
			strSql  += "and		a.CUST_SEQ = d.CUST_SEQ(+)   \n";
			strSql  += "and		a.COMP_CODE like '%' ||    ?    || '%'   \n";
			strSql  += "and		a.BANK_CODE like '%' ||    ?    || '%'   \n";
			strSql  += "and 	a.CHK_BILL_CLS =    ?  ";

			lrArgData.addColumn("F_EXPR_DT",CITData.DATE);
			lrArgData.addColumn("E_EXPR_DT",CITData.DATE);
			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("BANK_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("CHK_BILL_CLS",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("F_EXPR_DT",strF_EXPR_DT);
			lrArgData.setValue("E_EXPR_DT",strE_EXPR_DT);
			lrArgData.setValue("COMP_CODE",strCOMP_CODE);
			lrArgData.setValue("BANK_CODE",strBANK_CODE);
			lrArgData.setValue("CHK_BILL_CLS",strCHK_BILL_CLS);
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("CHK_BILL_CLS",true);
				lrReturnData.setKey("CHK_BILL_NO",true);
				lrReturnData.setNotNull("CHK_BILL_CLS",true);
				lrReturnData.setNotNull("CHK_BILL_NO",true);

				
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
		else if (strAct.equals("MAIN05"))
		{
			String	strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String	strBANK_CODE = CITCommon.toKOR(request.getParameter("BANK_CODE"));
			String	strCHK_BILL_CLS = CITCommon.toKOR(request.getParameter("CHK_BILL_CLS"));
			String	strACPT_DT_FROM = CITCommon.toKOR(request.getParameter("ACPT_DT_FROM"));
			String	strACPT_DT_TO = CITCommon.toKOR(request.getParameter("ACPT_DT_TO"));

			strSql  = "Select  \n";
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
			strSql  += "From	T_FIN_PAY_CHK_BILL a ,  \n";
			strSql  += "		T_BANK_CODE b ,  \n";
			strSql  += "		T_CUST_CODE c  \n";
			strSql  += "Where	a.BANK_CODE = b.BANK_CODE(+)  \n";
			strSql  += "And		a.CUST_SEQ = c.CUST_SEQ(+)  \n";
			strSql  += "And		a.COMP_CODE =  ?   \n";
			strSql  += "And		a.BANK_CODE like    ?   || '%'  \n";
			strSql  += "And		a.CHK_BILL_CLS =   ?     \n";
			strSql  += "And		a.ACPT_DT Between	?	And		? \n";
			strSql  += "And		a.STAT_CLS In ('2','0') \n";
			strSql  += "Order By  a.CHK_BILL_CLS , a.CHK_BILL_NO \n";

			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("BANK_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("CHK_BILL_CLS",CITData.VARCHAR2);
			lrArgData.addColumn("ACPT_DT_FROM",CITData.DATE);
			lrArgData.addColumn("ACPT_DT_TO",CITData.DATE);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE",strCOMP_CODE);
			lrArgData.setValue("BANK_CODE",strBANK_CODE);
			lrArgData.setValue("CHK_BILL_CLS",strCHK_BILL_CLS);
			lrArgData.setValue("ACPT_DT_FROM",strACPT_DT_FROM);
			lrArgData.setValue("ACPT_DT_TO",strACPT_DT_TO);
			
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
				GauceInfo.response.writeException("USER", "900001","MAIN01 Select 오류-> "+ ex.getMessage());
			}
		}	
		else if (strAct.equals("LIST05"))
		{
			String strCHK_BILL_NO = CITCommon.toKOR(request.getParameter("CHK_BILL_NO"));
			
			strSql  = " Select \n";
			strSql += " 	a.CHK_BILL_NO , \n";
			strSql += " 	a.CHG_SEQ , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	F_T_DATETOSTRING(a.CHG_DT) CHG_DT , \n";
			strSql += " 	F_T_DATETOSTRING(a.CHG_EXPR_DT) CHG_EXPR_DT , \n";
			strSql += " 	a.REMARKS, \n";
			strSql += " 	F_T_DATETOSTRING(Lag(a.CHG_EXPR_DT,1,b.EXPR_DT) Over ( Order By a.CHG_DT,a.CHG_SEQ)) PRE_EXPR_DT \n";
			strSql += " From	T_FIN_BILL_CHG_LIST a, \n";
			strSql += " 		T_FIN_PAY_CHK_BILL b \n";
			strSql += " Where	a.CHK_BILL_NO = b.CHK_BILL_NO \n";
			strSql += " And		a.CHK_BILL_NO =  ?  \n";
			strSql += " Order By \n";
			strSql += " 	a.CHG_DT, \n";
			strSql += " 	a.CHG_SEQ ";
			
			lrArgData.addColumn("CHK_BILL_NO", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("CHK_BILL_NO", strCHK_BILL_NO);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("CHK_BILL_NO", true);
				lrReturnData.setKey("CHG_SEQ", true);
				lrReturnData.setNotNull("CHG_DT", true);
				lrReturnData.setNotNull("CHG_EXPR_DT", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","LIST05 Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SEQ"))
		{

			strSql  = "Select	SQ_T_BILL_CHG_SEQ.NextVal CHG_SEQ from Dual \n";

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);


				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","SEQ Select 오류-> "+ ex.getMessage());
				throw new Exception("USER-900001:SEQ Select 오류 -> " + ex.getMessage());
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

<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id :
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 :
/* 4. 변  경  이  력 : 한재원 작성(2005-12-07)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
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

			String	strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));                                                                  
			String	strSEC_KIND_CODE = CITCommon.toKOR(request.getParameter("SEC_KIND_CODE"));                                                                          
			String	strDATE_FROM = CITCommon.toKOR(request.getParameter("DATE_FROM"));                                                                        
			String	strDATE_TO = CITCommon.toKOR(request.getParameter("DATE_TO"));                                                                            
			String	strDATE_CLS = CITCommon.toKOR(request.getParameter("DATE_CLS"));

			strSql =
				"Select"+"\n"+
				"	a.SECU_NO ,"+"\n"+
				"	a.CRTUSERNO ,"+"\n"+
				"	a.CRTDATE ,"+"\n"+
				"	a.MODUSERNO ,"+"\n"+
				"	a.MODDATE ,"+"\n"+
				"	a.REAL_SECU_NO ,"+"\n"+
				"	a.SEC_KIND_CODE ,"+"\n"+
				"	To_Char(a.SLIP_ID) SLIP_ID ,"+"\n"+
				"	To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ ,"+"\n"+
				"	To_Char(a.RESET_SLIP_ID) RESET_SLIP_ID ,"+"\n"+
				"	To_Char(a.RESET_SLIP_IDSEQ) RESET_SLIP_IDSEQ ,"+"\n"+
				"	To_Char(a.PRE_ITR_SLIP_ID) PRE_ITR_SLIP_ID ,"+"\n"+
				"	To_Char(a.PRE_ITR_SLIP_IDSEQ) PRE_ITR_SLIP_IDSEQ ,"+"\n"+
				"	a.COMP_CODE ,"+"\n"+
				"	F_T_DATETOSTRING(a.GET_DT) GET_DT ,"+"\n"+
				"	a.GET_PLACE ,"+"\n"+
				"	a.PERSTOCK_AMT ,"+"\n"+
				"	a.INCOME_AMT ,"+"\n"+
				"	a.BF_GET_ITR_AMT ,"+"\n"+
				"	a.BF_GET_ITR_TAX ,"+"\n"+
				"	a.GET_ITR_AMT ,"+"\n"+
				"	a.SALE_AMT ,"+"\n"+
				"	F_T_DATETOSTRING(a.PUBL_DT) PUBL_DT,"+"\n"+
				"	a.ITR_TAG ,"+"\n"+
				"	a.INTR_RATE ,"+"\n"+
				"	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT ,"+"\n"+
				"	F_T_DATETOSTRING(a.SALE_DT) SALE_DT ,"+"\n"+
				"	F_T_DATETOSTRING(a.RETURN_DT) RETURN_DT,"+"\n"+
				"	a.CONSIGN_BANK,"+"\n"+
				"	g.BANK_NAME,"+"\n"+
				"	a.SALE_ITR_AMT,"+"\n"+
				"	a.SALE_TAX,"+"\n"+
				"	a.SALE_LOSS,"+"\n"+
				"	a.SALE_NP_ITR_AMT,"+"\n"+
				"	b.MAKE_SLIPNO,"+"\n"+
				"	b.make_slipno  as SLIPNO ,"+"\n"+
				"	b.MAKE_COMP_CODE ,"+"\n"+
				"	b.MAKE_DEPT_CODE ,"+"\n"+
				"	b.MAKE_DT_TRANS ,"+"\n"+
				"	To_Char(b.MAKE_SEQ) MAKE_SEQ,"+"\n"+
				"	b.SLIP_KIND_TAG ,"+"\n"+
				"	b2.MAKE_COMP_CODE PRE_ITR_MAKE_COMP_CODE,"+"\n"+
				"	b2.MAKE_DEPT_CODE PRE_ITR_MAKE_DEPT_CODE,"+"\n"+
				"	b2.MAKE_DT_TRANS PRE_ITR_MAKE_DT_TRANS,"+"\n"+
				"	To_Char(b2.MAKE_SEQ) PRE_ITR_MAKE_SEQ,"+"\n"+
				"	b2.SLIP_KIND_TAG PRE_ITR_SLIP_KIND_TAG,"+"\n"+
				"	b1.MAKE_SLIPNO RE_MAKE_SLIPNO,"+"\n"+
				"	b1.MAKE_COMP_CODE RE_MAKE_COMP_CODE,"+"\n"+
				"	b1.MAKE_DEPT_CODE RE_MAKE_DEPT_CODE,"+"\n"+
				"	b1.MAKE_DT_TRANS RE_MAKE_DT_TRANS,"+"\n"+
				"	To_Char(b1.MAKE_SEQ) RE_MAKE_SEQ,"+"\n"+
				"	b1.SLIP_KIND_TAG RE_SLIP_KIND_TAG,"+"\n"+
				"	b2.make_slipno  PRE_ITR_SLIPNO ,"+"\n"+
				"	F_T_DATETOSTRING(b.MAKE_DT) MAKE_DT ,"+"\n"+
				"	F_T_Cust_Mask(f.CUST_CODE) CUST_CODE ,"+"\n"+
				"	c.CUST_NAME ,"+"\n"+
				"	c.DEPT_CODE "+"\n"+
				"from	T_FIN_SECURTY a ,"+"\n"+
				"		T_ACC_SLIP_HEAD b ,"+"\n"+
				"		T_ACC_SLIP_BODY1 c ,"+"\n"+
				"		T_ACC_SLIP_HEAD b1 ,"+"\n"+
				"		T_ACC_SLIP_HEAD b2 ,"+"\n"+
				"		T_ACC_SLIP_BODY1 c1 ,"+"\n"+
				"		T_CUST_CODE f,"+"\n"+
				"		T_BANK_CODE g"+"\n"+
				"Where	a.SLIP_ID = c.SLIP_ID (+)"+"\n"+
				"And		a.SLIP_IDSEQ = c.SLIP_IDSEQ (+)"+"\n"+
				"And		c.SLIP_ID = b.SLIP_ID (+)"+"\n"+
				"And	    a.RESET_SLIP_ID = c1.SLIP_ID (+)"+"\n"+
				"And	    a.PRE_ITR_SLIP_ID = b2.SLIP_ID (+)"+"\n"+
				"And		a.RESET_SLIP_IDSEQ = c1.SLIP_IDSEQ (+)"+"\n"+
				"And		c1.SLIP_ID = b1.SLIP_ID (+)"+"\n"+
				"And		c.CUST_SEQ = f.CUST_SEQ(+)"+"\n"+
				"And		a.CONSIGN_BANK = g.BANK_CODE (+)"+"\n"+
				"And		a.COMP_CODE =  ?"+"\n"+
				"And		a.SEC_KIND_CODE Like '%'||?||'%'"+"\n";
			if (strDATE_CLS.equals("A"))                                                                                                                      
			{
				strSql  += "And		a.PUBL_DT between  ?   And	 ? ";
			}
			else if (strDATE_CLS.equals("B"))
			{
				strSql  += "And		a.EXPR_DT between  ?   And	 ? "; 	
			}
			lrArgData.addColumn("MAKE_COMP_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("SEC_KIND_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("DATE_FROM",CITData.DATE);
			lrArgData.addColumn("DATE_TO",CITData.DATE);
			lrArgData.addRow();
			lrArgData.setValue("MAKE_COMP_CODE",strCOMP_CODE);
			lrArgData.setValue("SEC_KIND_CODE",strSEC_KIND_CODE);
			lrArgData.setValue("DATE_FROM",strDATE_FROM);
			lrArgData.setValue("DATE_TO",strDATE_TO);


			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				lrReturnData.setKey("SECU_NO", true);
				lrReturnData.setNotNull("COMP_CODE", true);
				lrReturnData.setNotNull("REAL_SECU_NO", true);
				lrReturnData.setNotNull("SEC_KIND_CODE", true);

				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SUB01"))
		{
			String strSECU_NO = CITCommon.toKOR(request.getParameter("SECU_NO"));
			
			strSql  = " Select \n";
			strSql += " 	a.SECU_NO , \n";
			strSql += " 	a.ITR_CALC_NO, \n";
			strSql += " 	F_T_DATETOSTRING(a.CALC_DT_TO) CALC_DT_TO , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.KIND_TAG , \n";
			strSql += " 	F_T_DATETOSTRING(a.CALC_DT_FROM) CALC_DT_FROM , \n";
			strSql += " 	a.CALC_DAYS , \n";
			strSql += " 	a.NP_ITR_AMT , \n";
			strSql += " 	a.ITR_AMT , \n";
			strSql += " 	To_Char(a.SLIP_ID) SLIP_ID , \n";
			strSql += " 	To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ , \n";
			strSql += " 	a.REMARKS , \n";
			strSql += " 	c.MAKE_SLIPNO \n";
			strSql += " From	T_FIN_SEC_ITR_AMT a, \n";
			strSql += " 		T_ACC_SLIP_BODY1 b, \n";
			strSql += " 		T_ACC_SLIP_HEAD c \n";
			strSql += " Where	a.SECU_NO =  ?  \n";
			strSql += " And		a.SLIP_ID = b.SLIP_ID (+) \n";
			strSql += " And		a.SLIP_IDSEQ = b.SLIP_IDSEQ (+) \n";
			strSql += " And		b.SLIP_ID = c.SLIP_ID (+) \n";
			strSql += " Order By \n";
			strSql += " 	a.CALC_DT_TO ";
			
			lrArgData.addColumn("SECU_NO", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("SECU_NO", strSECU_NO);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("SECU_NO", true);
				lrReturnData.setKey("ITR_CALC_NO", true);
				lrReturnData.setNotNull("CALC_DT_TO", true);
				lrReturnData.setNotNull("KIND_TAG", true);
				lrReturnData.setNotNull("CALC_DT_FROM", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","SUB01 Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SECU_NO"))
		{


			strSql =
				"Select SQ_T_SECU_NO.NextVal SECU_NO From Dual";


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
				GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("ITR_CALC_NO"))
		{


			strSql =
				"Select SQ_T_ITR_CALC_NO.NextVal ITR_CALC_NO From Dual";


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
				GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("ITR_AMT"))
		{
			String strDT_F = CITCommon.toKOR(request.getParameter("DT_F"));
			String strDT_T = CITCommon.toKOR(request.getParameter("DT_T"));
			String strNUM = CITCommon.toKOR(request.getParameter("NUM"));
			String strITR = CITCommon.toKOR(request.getParameter("ITR"));
			
			strSql  = " select F_T_Calc_Itr_Amt( ? , ? , ? , ? ) ITR_AMT from dual ";
			
			lrArgData.addColumn("DT_F", CITData.DATE);
			lrArgData.addColumn("DT_T", CITData.DATE);
			lrArgData.addColumn("NUM", CITData.NUMBER);
			lrArgData.addColumn("ITR", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("DT_F", strDT_F);
			lrArgData.setValue("DT_T", strDT_T);
			lrArgData.setValue("NUM", strNUM);
			lrArgData.setValue("ITR", strITR);
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
				GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("REMOVE_SLIP"))
		{
			
			strSql  = " Select 'XXXXXXXXXXXXXXXXXXXXXXXXX' SECU_NO From Dual \n";
			
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
				GauceInfo.response.writeException("USER", "900001","DVD Select 오류-> "+ ex.getMessage());
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
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
	
	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;

	String	strSql = "";
	String	strAct = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MASTER"))
		{
			String strBANK_CODE = CITCommon.toKOR(request.getParameter("BANK_CODE"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	a.LOAN_CONT_NO , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.LIMIT_AMT , \n";
			strSql += " 	a.REMARK , \n";
			strSql += " 	a.BANK_CODE , \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.LOAN_CONT_NAME , \n";
			strSql += " 	a.FL_LOAN_KIND_CODE , \n";
			strSql += " 	F_T_DATETOSTRING(a.LOAN_CONT_EXPR_DT) LOAN_CONT_EXPR_DT, \n";
			strSql += " 	b.BANK_NAME \n";
			strSql += " From	T_FIN_LOAN_CONT a, \n";
			strSql += " 		T_BANK_CODE b \n";
			strSql += " where	a.COMP_CODE Like  ?  \n";
			strSql += " And		a.BANK_CODE Like  '%'|| ? ||'%' \n";
			strSql += " And		a.BANK_CODE = b.BANK_CODE (+) \n";
			strSql += " Order By \n";
			strSql += " 	a.BANK_CODE, \n";
			strSql += " 	a.LOAN_CONT_EXPR_DT ";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("BANK_CODE", strBANK_CODE);
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
				GauceInfo.response.writeException("USER", "900001","MASTER Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("MAIN"))
		{
			String strLOAN_CONT_NO = CITCommon.toKOR(request.getParameter("LOAN_CONT_NO"));
			
			strSql  = " Select  \n";
			strSql += "  	a.LOAN_CONT_NO ,  \n";
			strSql += "  	a.LOAN_NO ,  \n";
			strSql += "  	a.REAL_LOAN_NO ,  \n";
			strSql += "  	a.CRTUSERNO ,  \n";
			strSql += "  	a.CRTDATE ,  \n";
			strSql += "  	a.MODUSERNO ,  \n";
			strSql += "  	a.MODDATE ,  \n";
			strSql += "  	a.LOAN_KIND_CODE, \n";
			strSql += "  	a.COMP_CODE ,  \n";
			strSql += "  	a.LOAN_NAME ,  \n";
			strSql += "  	a.BANK_CODE ,  \n";
			strSql += "  	a.LOAN_AMT ,  \n";
			strSql += "  	a.LIMIT_AMT ,  \n";
			strSql += "  	F_T_DATETOSTRING(a.LOAN_FDT) LOAN_FDT ,  \n";
			strSql += "  	F_T_DATETOSTRING(a.LOAN_EXPR_DT) LOAN_EXPR_DT ,  \n";
			strSql += "  	F_T_DATETOSTRING(a.CHG_EXPR_DT) CHG_EXPR_DT ,  \n";
			strSql += "  	a.REAL_INTR_RATE ,  \n";
			strSql += "  	a.TITLE_INTR_RATE ,  \n";
			strSql += "  	a.ORG_REFUND_YEAR ,  \n";
			strSql += "  	a.ORG_REFUND_DIV_YEAR ,  \n";
			strSql += "  	a.ORG_REFUND_MONTH ,  \n";
			strSql += "  	F_T_DATETOSTRING(a.ORG_REFUND_FIRST_MONTH) ORG_REFUND_FIRST_MONTH ,  \n";
			strSql += "  	a.INTR_MTHD ,  \n";
			strSql += "  	a.INTR_REFUND_DAY ,  \n";
			strSql += "  	a.INTR_REFUND_DIV_MONTH ,  \n";
			strSql += "  	F_T_DATETOSTRING(a.INTR_REFUND_FIRST_DT) INTR_REFUND_FIRST_DT ,  \n";
			strSql += "  	a.REMARK,  \n";
			strSql += "  	b.BANK_NAME  \n";
			strSql += "  From	T_FIN_LOAN_SHEET a,  \n";
			strSql += "  		T_BANK_CODE b  \n";
			strSql += "  Where	a.LOAN_CONT_NO =   ?   \n";
			strSql += "  And		a.BANK_CODE = b.BANK_CODE (+)  \n";
			strSql += "  Order By  \n";
			strSql += "  	a.LOAN_NO ";
			strSql += "  ";
			
			lrArgData.addColumn("LOAN_CONT_NO", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("LOAN_CONT_NO", strLOAN_CONT_NO);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("LOAN_NO", true);
				lrReturnData.setNotNull("REAL_LOAN_NO", true);
				lrReturnData.setNotNull("LOAN_FDT", true);
				lrReturnData.setNotNull("BANK_CODE", true);
				lrReturnData.setNotNull("LOAN_KIND_CODE", true);
				lrReturnData.setScale("REAL_INTR_RATE",3);
				lrReturnData.setScale("TITLE_INTR_RATE",3);

				
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
		else if (strAct.equals("LOAN_REFUND_SEQ"))
		{
			
			strSql  = " Select SQ_T_LOAN_REFUND_SEQ.NextVal LOAN_REFUND_SEQ From Dual \n";
			
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
				GauceInfo.response.writeException("USER", "900001","LOAN_REFUND_SEQ Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("LOAN_NO"))
		{
			
			strSql  = " Select To_Char(SQ_T_LOAN_NO.NextVal,'000000000000000000000000000000') LOAN_NO From Dual \n";
			
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
				GauceInfo.response.writeException("USER", "900001","LOAN_REFUND_SEQ Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("LOAN_CONT_NO"))
		{
			
			strSql  = " Select SQ_T_LOAN_CONT_NO.NextVal LOAN_CONT_NO From Dual \n";
			
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
				GauceInfo.response.writeException("USER", "900001","LOAN_REFUND_SEQ Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SUB01"))
		{
			String strLOAN_NO = CITCommon.toKOR(request.getParameter("LOAN_NO"));
			
			strSql  = " Select \n";
			strSql += " 	a.LOAN_NO , \n";
			strSql += " 	a.LOAN_REFUND_SEQ , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.ITR_TAR_TAG , \n";
			strSql += " 	F_T_DATETOSTRING(a.TRANS_DT) TRANS_DT , \n";
			strSql += " 	a.LOAN_AMT , \n";
			strSql += " 	Sum(Nvl(a.LOAN_AMT,0)) Over (Order By a.TRANS_DT,a.LOAN_NO,a.LOAN_REFUND_SEQ) -  \n";
			strSql += " 		Sum(Nvl(a.REFUND_AMT,0)) Over (Order By a.TRANS_DT,a.LOAN_NO,a.LOAN_REFUND_SEQ) LOAN_REMAIN_AMT, \n";
			strSql += " 	F_T_DATETOSTRING(a.REFUND_SCH_DT) REFUND_SCH_DT , \n";
			strSql += " 	a.REFUND_SCH_ORG_AMT , \n";
			strSql += " 	a.REFUND_SCH_INTR_AMT , \n";
			strSql += " 	Sum(Nvl(a.LOAN_AMT,0)) Over (Order By a.TRANS_DT,a.LOAN_NO,a.LOAN_REFUND_SEQ) -  \n";
			strSql += " 		Sum(Nvl(a.REFUND_SCH_ORG_AMT,0)) Over (Order By a.TRANS_DT,a.LOAN_NO,a.LOAN_REFUND_SEQ) SCH_LOAN_REMAIN_AMT, \n";
			strSql += " 	F_T_DATETOSTRING(a.REFUND_INTR_DT) REFUND_INTR_DT , \n";
			strSql += " 	a.REFUND_AMT , \n";
			strSql += " 	a.INTR_AMT , \n";
			strSql += " 	F_T_DATETOSTRING(a.INTR_START_DT) INTR_START_DT , \n";
			strSql += " 	F_T_DATETOSTRING(a.INTR_END_DT) INTR_END_DT , \n";
			strSql += " 	F_T_DATETOSTRING(a.PE_START_DT) PE_START_DT , \n";
			strSql += " 	F_T_DATETOSTRING(a.PE_END_DT) PE_END_DT , \n";
			strSql += " 	F_T_DATETOSTRING(a.AE_START_DT) AE_START_DT , \n";
			strSql += " 	F_T_DATETOSTRING(a.AE_END_DT) AE_END_DT , \n";
			strSql += " 	a.INTR_DAY_CNT , \n";
			strSql += " 	a.ACC_CODE , \n";
			strSql += "  	a.ITR_TAG,  \n";
			strSql += "  	a.PE_ITR_AMT,  \n";
			strSql += "  	a.PE_RESET_ITR_AMT,  \n";
			strSql += "  	a.NOE_ITR_AMT,  \n";
			strSql += "  	a.AE_ITR_AMT,  \n";
			strSql += "  	a.AE_RESET_ITR_AMT,  \n";
			strSql += "  	To_Char(a.PE_RESET_ITR_ID) PE_RESET_ITR_ID,  \n";
			strSql += "  	To_Char(a.PE_RESET_ITR_IDSEQ) PE_RESET_ITR_IDSEQ,  \n";
			strSql += "  	To_Char(a.AE_RESET_ITR_ID) AE_RESET_ITR_ID,  \n";
			strSql += "  	To_Char(a.AE_RESET_ITR_IDSEQ) AE_RESET_ITR_IDSEQ,  \n";
			strSql += "  	a.AE_ITR_NUM_DAYS,  \n";
			strSql += "  	c.MAKE_SLIPNO PE_RESET_SLIP_NO,  \n";
			strSql += "  	d.MAKE_SLIPNO AE_RESET_SLIP_NO,  \n";
			strSql += " 	To_Char(a.LOAN_SLIP_ID) LOAN_SLIP_ID , \n";
			strSql += " 	To_Char(a.LOAN_SLIP_IDSEQ) LOAN_SLIP_IDSEQ , \n";
			strSql += " 	(select x.MAKE_SLIPNO||'-'||to_char(y.MAKE_SLIPLINE) from t_acc_slip_head x,t_acc_slip_body y where x.slip_id = y.slip_id and y.slip_id = a.LOAN_SLIP_ID and y.slip_idseq = a.LOAN_SLIP_IDSEQ ) LOAN_SLIP_NO, \n";
			strSql += " 	To_Char(a.REFUND_SLIP_ID) REFUND_SLIP_ID , \n";
			strSql += " 	To_Char(a.REFUND_SLIP_IDSEQ) REFUND_SLIP_IDSEQ , \n";
			strSql += " 	(select x.MAKE_SLIPNO||'-'||to_char(y.MAKE_SLIPLINE) from t_acc_slip_head x,t_acc_slip_body y where x.slip_id = y.slip_id and y.slip_id = a.REFUND_SLIP_ID and y.slip_idseq = a.REFUND_SLIP_IDSEQ ) REFUND_SLIP_NO, \n";
			strSql += " 	To_Char(a.INTR_SLIP_ID) INTR_SLIP_ID , \n";
			strSql += " 	To_Char(a.INTR_SLIP_IDSEQ) INTR_SLIP_IDSEQ, \n";
			strSql += " 	(select x.MAKE_SLIPNO||'-'||to_char(y.MAKE_SLIPLINE) from t_acc_slip_head x,t_acc_slip_body y where x.slip_id = y.slip_id and y.slip_id = a.INTR_SLIP_ID and y.slip_idseq = a.INTR_SLIP_IDSEQ ) INTR_SLIP_NO \n";
			strSql += " From	T_FIN_LOAN_REFUND_LIST a, \n";
			strSql += "  		T_ACC_SLIP_HEAD c,  \n";
			strSql += "  		T_ACC_SLIP_HEAD d  \n";
			strSql += " Where	a.LOAN_NO =  ?  \n";
			strSql += "  And		a.PE_RESET_ITR_ID = c.SLIP_ID (+)  \n";
			strSql += "  And		a.AE_RESET_ITR_ID = d.SLIP_ID (+)  \n";
			strSql += " Order By \n";
			strSql += " 	a.TRANS_DT, \n";
			strSql += " 	a.LOAN_NO, \n";
			strSql += " 	a.LOAN_REFUND_SEQ ";

			
			lrArgData.addColumn("LOAN_NO", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("LOAN_NO", strLOAN_NO);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("LOAN_NO", true);
				lrReturnData.setKey("LOAN_REFUND_SEQ", true);

				
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
		else if (strAct.equals("SUB02"))
		{
			String strLOAN_NO = CITCommon.toKOR(request.getParameter("LOAN_NO"));
			
			strSql  = " Select \n";
			strSql += " 	a.LOAN_NO , \n";
			strSql += " 	a.GUAR_SEQ , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.GUARANTOR , \n";
			strSql += " 	a.GUAR_NO , \n";
			strSql += " 	a.GUAR_NOTE , \n";
			strSql += " 	F_T_DATETOSTRING(a.GUAR_START_DT) GUAR_START_DT , \n";
			strSql += " 	F_T_DATETOSTRING(a.GUAR_END_DT) GUAR_END_DT , \n";
			strSql += " 	a.GUAR_ORG_AMT , \n";
			strSql += " 	a.GUAR_AMT , \n";
			strSql += " 	a.GUAR_RATE , \n";
			strSql += " 	F_T_DATETOSTRING(a.GUAR_PAYMENT_DT) GUAR_PAYMENT_DT , \n";
			strSql += " 	F_T_DATETOSTRING(a.GUAR_ESTAB_DT) GUAR_ESTAB_DT , \n";
			strSql += " 	F_T_DATETOSTRING(a.GUAR_CANCEL_DT) GUAR_CANCEL_DT \n";
			strSql += " From	T_FIN_LOAN_GUAR a \n";
			strSql += " Where	a.LOAN_NO =  ?  \n";
			strSql += " Order By \n";
			strSql += " 	a.GUAR_ESTAB_DT, \n";
			strSql += " 	a.GUAR_SEQ \n";
			strSql += "  ";
			
			lrArgData.addColumn("LOAN_NO", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("LOAN_NO", strLOAN_NO);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("LOAN_NO", true);
				lrReturnData.setKey("GUAR_SEQ", true);

				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","SUB02 Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("GUAR_SEQ"))
		{
			
			strSql  = " Select SQ_T_GUAR_SEQ.NextVal GUAR_SEQ From Dual \n";
			
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
				GauceInfo.response.writeException("USER", "900001","GUAR_SEQ Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("DVD"))
		{
			
			strSql  = " Select 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' LOAN_NO From Dual \n";
			
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
		else if (strAct.equals("SLIP_INFO"))
		{
			
			String strSLIP_ID = CITCommon.toKOR(request.getParameter("SLIP_ID"));
			strSql  = " Select MAKE_COMP_CODE,MAKE_DT_TRANS,MAKE_SEQ,SLIP_KIND_TAG from T_ACC_SLIP_HEAD Where SLIP_ID = ?  \n";
			
			lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("SLIP_ID", strSLIP_ID);
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
				GauceInfo.response.writeException("USER", "900001","SLIP_INFO Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("CALC_ITR_AMT"))
		{
			
			String strSTART_DT = CITCommon.toKOR(request.getParameter("START_DT"));
			String strEND_DT = CITCommon.toKOR(request.getParameter("END_DT"));
			String strAMT = CITCommon.toKOR(request.getParameter("AMT"));
			String strRATIO = CITCommon.toKOR(request.getParameter("RATIO"));
			strSql  = " Select F_T_Calc_Itr_Amt(F_T_STRINGTODATE(?),F_T_STRINGTODATE(?),?,?) ITR_AMT from dual  \n";
			
			lrArgData.addColumn("START_DT", CITData.VARCHAR2);
			lrArgData.addColumn("END_DT", CITData.VARCHAR2);
			lrArgData.addColumn("AMT", CITData.NUMBER);
			lrArgData.addColumn("RATIO", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("START_DT", strSTART_DT);
			lrArgData.setValue("END_DT", strEND_DT);
			lrArgData.setValue("AMT", strRATIO);
			lrArgData.setValue("RATIO", strAMT);
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
				GauceInfo.response.writeException("USER", "900001","SLIP_INFO Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("CALC_PE_ITR_AMT"))
		{
			
			String strSTART_DT = CITCommon.toKOR(request.getParameter("START_DT"));
			String strEND_DT = CITCommon.toKOR(request.getParameter("END_DT"));
			String strAMT = CITCommon.toKOR(request.getParameter("AMT"));
			String strRATIO = CITCommon.toKOR(request.getParameter("RATIO"));
			strSql  = " Select F_T_Calc_Itr_Amt(F_T_STRINGTODATE(?),F_T_STRINGTODATE(?),?,?) ITR_AMT from dual  \n";
			
			lrArgData.addColumn("START_DT", CITData.VARCHAR2);
			lrArgData.addColumn("END_DT", CITData.VARCHAR2);
			lrArgData.addColumn("AMT", CITData.NUMBER);
			lrArgData.addColumn("RATIO", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("START_DT", strSTART_DT);
			lrArgData.setValue("END_DT", strEND_DT);
			lrArgData.setValue("AMT", strRATIO);
			lrArgData.setValue("RATIO", strAMT);
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
				GauceInfo.response.writeException("USER", "900001","SLIP_INFO Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("CALC_DATE1"))
		{
			
			String strBASE_DT = CITCommon.toKOR(request.getParameter("BASE_DT"));
			strSql  = " Select F_T_DATETOSTRING(Last_Day(F_T_STRINGTODATE(?))+1) INTR_START_DT from dual  \n";
			
			lrArgData.addColumn("BASE_DT1", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("BASE_DT1", strBASE_DT);
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
				GauceInfo.response.writeException("USER", "900001","SLIP_INFO Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("CALC_DATE2"))
		{
			
			String strBASE_DT = CITCommon.toKOR(request.getParameter("BASE_DT"));
			String strEXPR_DT = CITCommon.toKOR(request.getParameter("EXPR_DT"));
			strSql  = " Select F_T_DATETOSTRING(Trunc(F_T_STRINGTODATE(?),'MM')) INTR_START_DT,F_T_Cals_Itr_End_PE(?,?) INTR_END_DT from dual  \n";
			
			lrArgData.addColumn("BASE_DT1", CITData.VARCHAR2);
			lrArgData.addColumn("BASE_DT2", CITData.VARCHAR2);
			lrArgData.addColumn("EXPR_DT", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("BASE_DT1", strBASE_DT);
			lrArgData.setValue("BASE_DT2", strBASE_DT);
			lrArgData.setValue("EXPR_DT", strEXPR_DT);
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
				GauceInfo.response.writeException("USER", "900001","SLIP_INFO Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("CALC_DATE3"))
		{
			
			String strPREV_DT = CITCommon.toKOR(request.getParameter("PREV_DT"));
			String strBASE_DT = CITCommon.toKOR(request.getParameter("BASE_DT"));
			String strDAYS = CITCommon.toKOR(request.getParameter("DAYS"));
			String strEXPR_DT = CITCommon.toKOR(request.getParameter("EXPR_DT"));
			strSql  = " Select F_T_Cals_Itr_Start(?,?,?) INTR_START_DT,F_T_Cals_Itr_End(?,?) INTR_END_DT , F_T_Cals_Itr_Start_AE(?,?) AE_INTR_START_DT, F_T_Cals_Itr_End_AE(?,?,?) AE_INTR_END_DT from dual  \n";
			
			lrArgData.addColumn("BASE_DT1", CITData.VARCHAR2);
			lrArgData.addColumn("DAYS1", CITData.NUMBER);
			lrArgData.addColumn("PREV_DT1", CITData.VARCHAR2);
			lrArgData.addColumn("BASE_DT2", CITData.VARCHAR2);
			lrArgData.addColumn("DAYS2", CITData.NUMBER);
			lrArgData.addColumn("BASE_DT3", CITData.VARCHAR2);
			lrArgData.addColumn("DAYS3", CITData.NUMBER);
			lrArgData.addColumn("BASE_DT4", CITData.VARCHAR2);
			lrArgData.addColumn("EXPR_DT4", CITData.VARCHAR2);
			lrArgData.addColumn("DAYS4", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("BASE_DT1", strBASE_DT);
			lrArgData.setValue("DAYS1", strDAYS);
			lrArgData.setValue("PREV_DT1", strPREV_DT);
			lrArgData.setValue("BASE_DT2", strBASE_DT);
			lrArgData.setValue("DAYS2", strDAYS);
			lrArgData.setValue("BASE_DT3", strBASE_DT);
			lrArgData.setValue("DAYS3", strDAYS);
			lrArgData.setValue("BASE_DT4", strBASE_DT);
			lrArgData.setValue("EXPR_DT4", strEXPR_DT);
			lrArgData.setValue("DAYS4", strDAYS);
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
				GauceInfo.response.writeException("USER", "900001","SLIP_INFO Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("AE_SLIP_ID"))
		{
			String strLOAN_NO = CITCommon.toKOR(request.getParameter("LOAN_NO"));
			
			strSql  = " Select \n";
			strSql += " 	a.SLIP_ID, \n";
			strSql += " 	a.SLIP_IDSEQ, \n";
			strSql += " 	b.MAKE_SLIPNO , \n";
			strSql += " 	a.REMAIN_AMT \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			a.SLIP_ID, \n";
			strSql += " 			a.SLIP_IDSEQ, \n";
			strSql += " 			Nvl(a.CR_AMT,0) -  \n";
			strSql += " 			( \n";
			strSql += " 				Select \n";
			strSql += " 					Nvl(Nvl(Sum(cc.DB_AMT),0) + Nvl(Sum(- cc.CR_AMT),0),0) \n";
			strSql += " 				From	T_ACC_SLIP_BODY1 cc \n";
			strSql += " 				Where	cc.RESET_SLIP_ID = a.RESET_SLIP_ID \n";
			strSql += " 				And		cc.RESET_SLIP_IDSEQ = a.RESET_SLIP_IDSEQ \n";
			strSql += " 				And		cc.KEEP_DT Is Not Null \n";
			strSql += " 				And \n";
			strSql += " 				( \n";
			strSql += " 						cc.SLIP_ID <> cc.RESET_SLIP_ID \n";
			strSql += " 					Or	cc.SLIP_IDSEQ <> cc.RESET_SLIP_IDSEQ \n";
			strSql += " 				) \n";
			strSql += " 			) REMAIN_AMT \n";
			strSql += " 		From	T_ACC_SLIP_BODY a, \n";
			strSql += " 				T_FIN_LOAN_SHEET b, \n";
			strSql += " 				T_FIN_LOAN_KIND c \n";
			strSql += " 		Where	a.LOAN_REFUND_NO = b.LOAN_NO \n";
			strSql += " 		And		b.LOAN_KIND_CODE = c.LOAN_KIND_CODE \n";
			strSql += " 		And		c.AE_ITR_ACC_CODE = a.ACC_CODE \n";
			strSql += " 		And		a.KEEP_DT Is Not Null \n";
			strSql += " 		And		a.SLIP_ID = a.RESET_SLIP_ID \n";
			strSql += " 		And		a.SLIP_IDSEQ = a.RESET_SLIP_IDSEQ \n";
			strSql += " 		And		a.LOAN_REFUND_NO =  ?  \n";
			strSql += " 	) a ,T_ACC_SLIP_HEAD b \n";
			strSql += " Where	Nvl(a.REMAIN_AMT,0) <> 0 ";
			strSql += " And		a.SLIP_ID = b.SLIP_ID ";
			
			lrArgData.addColumn("1LOAN_NO", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1LOAN_NO", strLOAN_NO);
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
				GauceInfo.response.writeException("USER", "900001","AE_SLIP_ID Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("PE_SLIP_ID"))
		{
			String strLOAN_NO = CITCommon.toKOR(request.getParameter("LOAN_NO"));
			
			strSql  = " Select \n";
			strSql += " 	To_Char(a.SLIP_ID) SLIP_ID, \n";
			strSql += " 	To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ, \n";
			strSql += " 	b.MAKE_SLIPNO , \n";
			strSql += " 	a.REMAIN_AMT \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			a.SLIP_ID, \n";
			strSql += " 			a.SLIP_IDSEQ, \n";
			strSql += " 			Nvl(a.DB_AMT,0) -  \n";
			strSql += " 			( \n";
			strSql += " 				Select \n";
			strSql += " 					Nvl(Nvl(Sum(cc.CR_AMT),0) + Nvl(Sum(- cc.DB_AMT),0),0) \n";
			strSql += " 				From	T_ACC_SLIP_BODY1 cc \n";
			strSql += " 				Where	cc.RESET_SLIP_ID = a.RESET_SLIP_ID \n";
			strSql += " 				And		cc.RESET_SLIP_IDSEQ = a.RESET_SLIP_IDSEQ \n";
			strSql += " 				And		cc.KEEP_DT Is Not Null \n";
			strSql += " 				And \n";
			strSql += " 				( \n";
			strSql += " 						cc.SLIP_ID <> cc.RESET_SLIP_ID \n";
			strSql += " 					Or	cc.SLIP_IDSEQ <> cc.RESET_SLIP_IDSEQ \n";
			strSql += " 				) \n";
			strSql += " 			) REMAIN_AMT \n";
			strSql += " 		From	T_ACC_SLIP_BODY a, \n";
			strSql += " 				T_FIN_LOAN_SHEET b, \n";
			strSql += " 				T_FIN_LOAN_KIND c \n";
			strSql += " 		Where	a.LOAN_REFUND_NO = b.LOAN_NO \n";
			strSql += " 		And		b.LOAN_KIND_CODE = c.LOAN_KIND_CODE \n";
			strSql += " 		And		c.PE_ITR_ACC_CODE = a.ACC_CODE \n";
			strSql += " 		And		a.KEEP_DT Is Not Null \n";
			strSql += " 		And		a.SLIP_ID = a.RESET_SLIP_ID \n";
			strSql += " 		And		a.SLIP_IDSEQ = a.RESET_SLIP_IDSEQ \n";
			strSql += " 		And		a.LOAN_REFUND_NO =  ?  \n";
			strSql += " 	) a ,T_ACC_SLIP_HEAD b \n";
			strSql += " Where	Nvl(a.REMAIN_AMT,0) <> 0 ";
			strSql += " And		a.SLIP_ID = b.SLIP_ID ";
			
			lrArgData.addColumn("1LOAN_NO", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1LOAN_NO", strLOAN_NO);
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
				GauceInfo.response.writeException("USER", "900001","AE_SLIP_ID Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SLIP_REMAIN_AMT"))
		{
			String strSLIP_ID = CITCommon.toKOR(request.getParameter("SLIP_ID"));
			String strSLIP_IDSEQ = CITCommon.toKOR(request.getParameter("SLIP_IDSEQ"));
			
			strSql  = " Select \n";
			strSql += " 	To_Char(a.SLIP_ID) SLIP_ID, \n";
			strSql += " 	To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ, \n";
			strSql += " 	b.MAKE_SLIPNO , \n";
			strSql += " 	a.REMAIN_AMT \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			a.SLIP_ID, \n";
			strSql += " 			a.SLIP_IDSEQ, \n";
			strSql += " 			Nvl(a.DB_AMT,0) -  \n";
			strSql += " 			( \n";
			strSql += " 				Select \n";
			strSql += " 					Nvl(Nvl(Sum(cc.CR_AMT),0) + Nvl(Sum(- cc.DB_AMT),0),0) \n";
			strSql += " 				From	T_ACC_SLIP_BODY1 cc \n";
			strSql += " 				Where	cc.RESET_SLIP_ID = a.RESET_SLIP_ID \n";
			strSql += " 				And		cc.RESET_SLIP_IDSEQ = a.RESET_SLIP_IDSEQ \n";
			strSql += " 				And		cc.KEEP_DT Is Not Null \n";
			strSql += " 				And \n";
			strSql += " 				( \n";
			strSql += " 						cc.SLIP_ID <> cc.RESET_SLIP_ID \n";
			strSql += " 					Or	cc.SLIP_IDSEQ <> cc.RESET_SLIP_IDSEQ \n";
			strSql += " 				) \n";
			strSql += " 			) REMAIN_AMT \n";
			strSql += " 		From	T_ACC_SLIP_BODY a \n";
			strSql += " 		Where	a.KEEP_DT Is Not Null \n";
			strSql += " 		And		a.SLIP_ID = a.RESET_SLIP_ID \n";
			strSql += " 		And		a.SLIP_IDSEQ = a.RESET_SLIP_IDSEQ \n";
			strSql += " 		And		a.SLIP_ID =  ?  \n";
			strSql += " 		And		a.SLIP_IDSEQ =  ?  \n";
			strSql += " 	) a ,T_ACC_SLIP_HEAD b \n";
			strSql += " Where	Nvl(a.REMAIN_AMT,0) <> 0 ";
			strSql += " And		a.SLIP_ID = b.SLIP_ID ";
			
			lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
			lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("SLIP_ID", strSLIP_ID);
			lrArgData.setValue("SLIP_IDSEQ", strSLIP_IDSEQ);
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
				GauceInfo.response.writeException("USER", "900001","AE_SLIP_ID Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("MAKE_ITR_SLIP"))
		{
			
			strSql  = " Select 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' LOAN_NO,0 LOAN_REFUND_SEQ,'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' DEPT_CODE,'XXXXXXXXXXXXXXXXXXXX' COMP_CODE From Dual \n";
			
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
		else if (strAct.equals("REMOVE_SLIP"))
		{
			
			strSql  = " Select 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' LOAN_NO,0 LOAN_REFUND_SEQ From Dual \n";
			
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

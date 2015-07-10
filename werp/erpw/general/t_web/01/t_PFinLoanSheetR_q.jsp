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
		
		if (strAct.equals("MAIN"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strBANK_CODE = CITCommon.toKOR(request.getParameter("BANK_CODE"));
			String strACC_CODE = CITCommon.toKOR(request.getParameter("ACC_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	a.LOAN_NO , \n";
			strSql += " 	a.REAL_LOAN_NO , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.LOAN_KIND_CODE, \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.LOAN_NAME , \n";
			strSql += " 	a.BANK_CODE , \n";
			strSql += " 	a.LOAN_AMT , \n";
			strSql += " 	a.LIMIT_AMT , \n";
			strSql += " 	F_T_DATETOSTRING(a.LOAN_FDT) LOAN_FDT , \n";
			strSql += " 	F_T_DATETOSTRING(a.LOAN_EXPR_DT) LOAN_EXPR_DT , \n";
			strSql += " 	F_T_DATETOSTRING(a.CHG_EXPR_DT) CHG_EXPR_DT , \n";
			strSql += " 	a.REAL_INTR_RATE , \n";
			strSql += " 	a.TITLE_INTR_RATE , \n";
			strSql += " 	a.ORG_REFUND_YEAR , \n";
			strSql += " 	a.ORG_REFUND_DIV_YEAR , \n";
			strSql += " 	a.ORG_REFUND_MONTH , \n";
			strSql += " 	F_T_DATETOSTRING(a.ORG_REFUND_FIRST_MONTH) ORG_REFUND_FIRST_MONTH , \n";
			strSql += " 	a.INTR_MTHD , \n";
			strSql += " 	a.INTR_REFUND_DAY , \n";
			strSql += " 	a.INTR_REFUND_DIV_MONTH , \n";
			strSql += " 	F_T_DATETOSTRING(a.INTR_REFUND_FIRST_DT) INTR_REFUND_FIRST_DT , \n";
			strSql += " 	a.REMARK, \n";
			strSql += " 	b.BANK_NAME, \n";
			strSql += " 	c.LOAN_ACC_CODE , \n";
			strSql += " 	c.ITR_ACC_CODE \n";
			strSql += " From	T_FIN_LOAN_SHEET a, \n";
			strSql += " 		T_BANK_CODE b, \n";
			strSql += " 		T_FIN_LOAN_KIND c \n";
			strSql += " Where	a.COMP_CODE =    ?  \n";
			strSql += " And		a.BANK_CODE Like  '%'||  ?    || '%' \n";
			strSql += " And		a.BANK_CODE = b.BANK_CODE (+) \n";
			strSql += " And		a.LOAN_KIND_CODE = c.LOAN_KIND_CODE \n";
			strSql += " And		a.LOAN_KIND_CODE In \n";
			strSql += " 		( \n";
			strSql += " 			Select \n";
			strSql += " 				x.LOAN_KIND_CODE \n";
			strSql += " 			From	T_FIN_LOAN_KIND x \n";
			strSql += " 			Where	 ?  In (x.LOAN_ACC_CODE,x.ITR_ACC_CODE) \n";
			strSql += " 		) \n";
			strSql += " Order By \n";
			strSql += " 	a.LOAN_NO \n";
			strSql += "  ";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("BANK_CODE", strBANK_CODE);
			lrArgData.setValue("ACC_CODE", strACC_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("LOAN_NO", true);
				lrReturnData.setScale("REAL_INTR_RATE",3);
				lrReturnData.setScale("TITLE_INTR_RATE",3);
				lrReturnData.setNotNull("LOAN_FDT", true);
				lrReturnData.setNotNull("LOAN_KIND_CODE", true);
				lrReturnData.setNotNull("BANK_CODE", true);

				
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
			strSql += " 	a.INTR_DAY_CNT , \n";
			strSql += " 	a.ACC_CODE , \n";
			strSql += " 	To_Char(a.LOAN_SLIP_ID) LOAN_SLIP_ID , \n";
			strSql += " 	To_Char(a.LOAN_SLIP_IDSEQ) LOAN_SLIP_IDSEQ , \n";
			strSql += " 	(select x.MAKE_SLIPNO||'-'||to_char(y.MAKE_SLIPLINE) from t_acc_slip_head x,t_acc_slip_body y where x.slip_id = y.slip_id and y.slip_id = a.LOAN_SLIP_ID and y.slip_idseq = a.LOAN_SLIP_IDSEQ ) LOAN_SLIP_NO, \n";
			strSql += " 	To_Char(a.REFUND_SLIP_ID) REFUND_SLIP_ID , \n";
			strSql += " 	To_Char(a.REFUND_SLIP_IDSEQ) REFUND_SLIP_IDSEQ , \n";
			strSql += " 	(select x.MAKE_SLIPNO||'-'||to_char(y.MAKE_SLIPLINE) from t_acc_slip_head x,t_acc_slip_body y where x.slip_id = y.slip_id and y.slip_id = a.REFUND_SLIP_ID and y.slip_idseq = a.REFUND_SLIP_IDSEQ ) REFUND_SLIP_NO, \n";
			strSql += " 	To_Char(a.INTR_SLIP_ID) INTR_SLIP_ID , \n";
			strSql += " 	To_Char(a.INTR_SLIP_IDSEQ) INTR_SLIP_IDSEQ, \n";
			strSql += " 	(select x.MAKE_SLIPNO||'-'||to_char(y.MAKE_SLIPLINE) from t_acc_slip_head x,t_acc_slip_body y where x.slip_id = y.slip_id and y.slip_id = a.INTR_SLIP_ID and y.slip_idseq = a.INTR_SLIP_IDSEQ ) INTR_SLIP_NO \n";
			strSql += " From	T_FIN_LOAN_REFUND_LIST a \n";
			strSql += " Where	a.LOAN_NO =  ?  \n";
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
			
			strSql  = " Select 'XXXXXXXXXXXXXXXXXXXXXXXXX' LOAN_NO From Dual \n";
			
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

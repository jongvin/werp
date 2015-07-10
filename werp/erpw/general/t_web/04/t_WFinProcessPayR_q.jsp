<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-13)
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
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strWORK_DT_F = CITCommon.toKOR(request.getParameter("WORK_DT_F"));
			String strWORK_DT_T = CITCommon.toKOR(request.getParameter("WORK_DT_T"));
			
			strSql  = " Select \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	F_T_DATETOSTRING(a.WORK_DT) WORK_DT , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.CONTENTS \n";
			strSql += " From	T_FIN_PAY_SUM_LIST a \n";
			strSql += " Where	a.COMP_CODE =  ?  \n";
			strSql += " And		a.WORK_DT Between  ?  And  ?  \n";
			strSql += " Order By \n";
			strSql += " 	a.WORK_DT desc \n";
			strSql += "  ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2WORK_DT_F", CITData.DATE);
			lrArgData.addColumn("3WORK_DT_T", CITData.DATE);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2WORK_DT_F", strWORK_DT_F);
			lrArgData.setValue("3WORK_DT_T", strWORK_DT_T);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("WORK_DT", true);

				
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
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strWORK_DT = CITCommon.toKOR(request.getParameter("WORK_DT"));
			String strACC_KIND_CODE = CITCommon.toKOR(request.getParameter("ACC_KIND_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	'F' CHK_TAG, \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	F_T_DATETOSTRING(a.WORK_DT) WORK_DT , \n";
			strSql += " 	a.SEQ , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.ACC_CODE , \n";
			strSql += " 	To_Char(a.TARGET_SLIP_ID) TARGET_SLIP_ID , \n";
			strSql += " 	To_Char(a.TARGET_SLIP_IDSEQ) TARGET_SLIP_IDSEQ , \n";
			strSql += " 	To_Char(a.CUST_SEQ) CUST_SEQ , \n";
			strSql += " 	F_T_Get_Dflt_Out_AccNo(a.CUST_SEQ,'3') OUT_ACCNO3 , \n";		//구매자금용 당사 인출계좌
			strSql += " 	F_T_CUST_MASK(cc.CUST_CODE) CUST_CODE , \n";
			strSql += " 	a.CUST_NAME , \n";
			strSql += " 	a.SET_AMT , \n";
			strSql += " 	a.PRE_RESET_AMT , \n";
			strSql += " 	a.EXCEPT_AMT , \n";
			strSql += " 	To_Char(a.C_RATIO,'FM999,999,999,999,999,999,999,990.00') C_RATIO , \n";
			strSql += " 	To_Char(a.B_RATIO,'FM999,999,999,999,999,999,999,990.00') B_RATIO , \n";
			strSql += " 	b.MAKE_SLIPNO, \n";
			strSql += " 	b.MAKE_COMP_CODE, \n";
			strSql += " 	b.MAKE_DT_TRANS, \n";
			strSql += " 	b.MAKE_SEQ, \n";
			strSql += " 	b.SLIP_KIND_TAG, \n";
			strSql += " 	c.ACC_NAME, \n";
			strSql += " 	bb.SUMMARY1 || bb.SUMMARY2 SUMMARY, \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			SubStr(F_T_ConcatString(','||e.ACC_KIND_NAME ),2) \n";
			strSql += " 		From	T_FIN_PAY_SUM_ACC_LIST d, \n";
			strSql += " 				T_FIN_PAY_SUM_ACC_GROUP e \n";
			strSql += " 		Where	a.ACC_CODE = d.ACC_CODE \n";
			strSql += " 		And		d.ACC_KIND_CODE = e.ACC_KIND_CODE \n";
			strSql += " 	) ACC_KIND_NAME, \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			Sum(f.EXEC_AMT) \n";
			strSql += " 		From	T_FIN_PAY_EXEC_LIST f \n";
			strSql += " 		Where	a.COMP_CODE = f.COMP_CODE \n";
			strSql += " 		And		a.WORK_DT = f.WORK_DT \n";
			strSql += " 		And		a.TARGET_SLIP_ID = f.TARGET_SLIP_ID \n";
			strSql += " 		And		a.TARGET_SLIP_IDSEQ = f.TARGET_SLIP_IDSEQ \n";
			strSql += " 	) EXEC_AMT, \n";
			strSql += " 		( \n";
			strSql += " 		Select \n";
			strSql += " 			Sum(f.EXEC_AMT) \n";
			strSql += " 		From	T_FIN_PAY_EXEC_LIST f \n";
			strSql += " 		Where	a.COMP_CODE = f.COMP_CODE \n";
			strSql += " 		And		a.WORK_DT = f.WORK_DT \n";
			strSql += " 		And		a.TARGET_SLIP_ID = f.TARGET_SLIP_ID \n";
			strSql += " 		And		a.TARGET_SLIP_IDSEQ = f.TARGET_SLIP_IDSEQ \n";
			strSql += " 		And		f.SLIP_ID Is Not Null \n";
			strSql += " 	) SLIP_EXEC_AMT \n";
			strSql += " From	T_FIN_PAY_TARGET_SLIP_LIST a, \n";
			strSql += " 		T_ACC_SLIP_HEAD b, \n";
			strSql += " 		T_ACC_SLIP_BODY bb, \n";
			strSql += " 		T_ACC_CODE c, \n";
			strSql += " 		t_cust_code cc \n";
			strSql += " Where	a.COMP_CODE =  ?  \n";
			strSql += " And		a.WORK_DT =  ?  \n";
			strSql += " And		a.TARGET_SLIP_ID = b.SLIP_ID (+) \n";
			strSql += " And		a.TARGET_SLIP_ID = bb.SLIP_ID (+) \n";
			strSql += " And		a.TARGET_SLIP_IDSEQ = bb.SLIP_IDSEQ (+) \n";
			strSql += " And		a.ACC_CODE = c.ACC_CODE \n";
			strSql += " And		a.CUST_SEQ = cc.CUST_SEQ (+) \n";
			strSql += " And		a.ACC_CODE In \n";
			strSql += " 		( \n";
			strSql += " 			Select	x.ACC_CODE \n";
			strSql += " 			From	T_FIN_PAY_SUM_ACC_LIST x \n";
			strSql += " 			Where	x.ACC_KIND_CODE Like  ?  || '%' \n";
			strSql += " 		) \n";
			strSql += " Order By \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.WORK_DT ,F_T_CUST_MASK(cc.CUST_CODE), \n";
			strSql += " 	a.SEQ \n";
			strSql += "  ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2WORK_DT", CITData.DATE);
			lrArgData.addColumn("3ACC_KIND_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2WORK_DT", strWORK_DT);
			lrArgData.setValue("3ACC_KIND_CODE", strACC_KIND_CODE);
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
		else if (strAct.equals("MAKE"))
		{

			
			strSql  = " Select 'XXXXXXXXXXXXX' COMP_CODE, F_T_DATETOSTRING(Sysdate) WORK_DT From Dual ";
			

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
				GauceInfo.response.writeException("USER", "900001","MAKE Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("REMOVE"))
		{

			
			strSql  = " Select 'XXXXXXXXXXXXX' COMP_CODE, F_T_DATETOSTRING(Sysdate) WORK_DT,0 SLIP_ID,0 SLIP_IDSEQ From Dual ";
			

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
				GauceInfo.response.writeException("USER", "900001","REMOVE Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SEQ"))
		{

			
			strSql  = " Select SQ_T_PAY_EXEC_SEQ.NextVal SEQ From Dual ";
			

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
				GauceInfo.response.writeException("USER", "900001","MAKE Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SUB01"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strWORK_DT = CITCommon.toKOR(request.getParameter("WORK_DT"));
			String strACC_KIND_CODE = CITCommon.toKOR(request.getParameter("ACC_KIND_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	'F' CHK_TAG, \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	F_T_DATETOSTRING(a.WORK_DT) WORK_DT , \n";
			strSql += " 	a.SEQ , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.EXEC_KIND_TAG , \n";
			strSql += " 	To_Char(a.TARGET_SLIP_ID) TARGET_SLIP_ID , \n";
			strSql += " 	To_Char(a.TARGET_SLIP_IDSEQ) TARGET_SLIP_IDSEQ , \n";
			strSql += " 	a.EXEC_AMT , \n";
			strSql += " 	a.OUT_ACC_NO , \n";
			strSql += " 	a.IN_BANK_MAIN_CODE , \n";
			strSql += " 	a.IN_ACC_NO , \n";
			strSql += " 	a.ACCNO_OWNER , \n";
			strSql += " 	To_Char(a.SLIP_PUB_SEQ) SLIP_PUB_SEQ , \n";
			strSql += " 	To_Char(a.SLIP_ID) SLIP_ID , \n";
			strSql += " 	To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ , \n";
			strSql += " 	a.CHK_BILL_NO, \n";
			strSql += " 	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT, \n";
			strSql += " 	To_Char(e.CUST_SEQ) CUST_SEQ, \n";
			strSql += " 	F_T_CUST_MASK(e.CUST_CODE) CUST_CODE, \n";
			strSql += " 	c.CUST_NAME, \n";
			strSql += " 	b.MAKE_SLIPNO, \n";
			strSql += " 	b.MAKE_COMP_CODE, \n";
			strSql += " 	b.MAKE_DT_TRANS, \n";
			strSql += " 	b.MAKE_SEQ, \n";
			strSql += " 	b.SLIP_KIND_TAG, \n";
			strSql += " 	d.ACC_NAME, \n";
			strSql += " 	c.SUMMARY1||c.SUMMARY2 SUMMARY, \n";
			strSql += " 	f.MAKE_SLIPNO PAY_MAKE_SLIPNO, \n";
			strSql += " 	f.MAKE_COMP_CODE PAY_MAKE_COMP_CODE, \n";
			strSql += " 	f.MAKE_DT_TRANS PAY_MAKE_DT_TRANS, \n";
			strSql += " 	f.MAKE_SEQ PAY_MAKE_SEQ, \n";
			strSql += " 	f.SLIP_KIND_TAG PAY_SLIP_KIND_TAG \n";
			strSql += " From	T_FIN_PAY_EXEC_LIST a, \n";
			strSql += " 		T_ACC_SLIP_HEAD b, \n";
			strSql += " 		T_ACC_SLIP_BODY c, \n";
			strSql += " 		T_ACC_CODE d, \n";
			strSql += " 		T_CUST_CODE e, \n";
			strSql += " 		T_ACC_SLIP_HEAD f, \n";
			strSql += " 		T_ACC_SLIP_BODY g \n";
			strSql += " Where	a.TARGET_SLIP_ID = b.SLIP_ID (+) \n";
			strSql += " And		a.TARGET_SLIP_ID = c.SLIP_ID (+) \n";
			strSql += " And		a.TARGET_SLIP_IDSEQ = c.SLIP_IDSEQ (+) \n";
			strSql += " And		c.ACC_CODE = d.ACC_CODE (+)\n";
			strSql += " And		c.CUST_SEQ = e.CUST_SEQ (+) \n";
			strSql += " And		a.SLIP_ID = f.SLIP_ID (+) \n";
			strSql += " And		a.SLIP_ID = g.SLIP_ID (+) \n";
			strSql += " And		a.SLIP_IDSEQ = g.SLIP_IDSEQ (+) \n";
			strSql += " And		a.COMP_CODE =  ?  \n";
			strSql += " And		a.WORK_DT =  ?  \n";
			strSql += " And		a.EXEC_KIND_TAG = '1' \n";
			strSql += " And		c.ACC_CODE In  \n";
			strSql += " 		( \n";
			strSql += " 			Select \n";
			strSql += " 				x.ACC_CODE \n";
			strSql += " 			From	T_FIN_PAY_SUM_ACC_LIST x \n";
			strSql += " 			Where	x.ACC_KIND_CODE Like   ?   || '%' \n";
			strSql += " 		) \n";
			strSql += " Order By \n";
			strSql += " 	e.CUST_CODE, \n";
			strSql += " 	a.TARGET_SLIP_ID , \n";
			strSql += " 	a.TARGET_SLIP_IDSEQ ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2WORK_DT", CITData.DATE);
			lrArgData.addColumn("3ACC_KIND_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2WORK_DT", strWORK_DT);
			lrArgData.setValue("3ACC_KIND_CODE", strACC_KIND_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("WORK_DT", true);
				lrReturnData.setKey("SEQ", true);

				
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
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strWORK_DT = CITCommon.toKOR(request.getParameter("WORK_DT"));
			String strACC_KIND_CODE = CITCommon.toKOR(request.getParameter("ACC_KIND_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	'F' CHK_TAG, \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	F_T_DATETOSTRING(a.WORK_DT) WORK_DT , \n";
			strSql += " 	a.SEQ , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.EXEC_KIND_TAG , \n";
			strSql += " 	To_Char(a.TARGET_SLIP_ID) TARGET_SLIP_ID , \n";
			strSql += " 	To_Char(a.TARGET_SLIP_IDSEQ) TARGET_SLIP_IDSEQ , \n";
			strSql += " 	a.EXEC_AMT , \n";
			strSql += " 	a.OUT_ACC_NO , \n";
			strSql += " 	a.IN_BANK_MAIN_CODE , \n";
			strSql += " 	a.IN_ACC_NO , \n";
			strSql += " 	a.ACCNO_OWNER , \n";
			strSql += " 	To_Char(a.SLIP_PUB_SEQ) SLIP_PUB_SEQ , \n";
			strSql += " 	To_Char(a.SLIP_ID) SLIP_ID , \n";
			strSql += " 	To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ , \n";
			strSql += " 	a.CHK_BILL_NO, \n";
			strSql += " 	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT, \n";
			strSql += " 	To_Char(e.CUST_SEQ) CUST_SEQ, \n";
			strSql += " 	F_T_CUST_MASK(e.CUST_CODE) CUST_CODE, \n";
			strSql += " 	c.CUST_NAME, \n";
			strSql += " 	b.MAKE_SLIPNO, \n";
			strSql += " 	b.MAKE_COMP_CODE, \n";
			strSql += " 	b.MAKE_DT_TRANS, \n";
			strSql += " 	b.MAKE_SEQ, \n";
			strSql += " 	b.SLIP_KIND_TAG, \n";
			strSql += " 	d.ACC_NAME, \n";
			strSql += " 	c.SUMMARY1||c.SUMMARY2 SUMMARY, \n";
			strSql += " 	f.MAKE_SLIPNO PAY_MAKE_SLIPNO, \n";
			strSql += " 	f.MAKE_COMP_CODE PAY_MAKE_COMP_CODE, \n";
			strSql += " 	f.MAKE_DT_TRANS PAY_MAKE_DT_TRANS, \n";
			strSql += " 	f.MAKE_SEQ PAY_MAKE_SEQ, \n";
			strSql += " 	f.SLIP_KIND_TAG PAY_SLIP_KIND_TAG \n";
			strSql += " From	T_FIN_PAY_EXEC_LIST a, \n";
			strSql += " 		T_ACC_SLIP_HEAD b, \n";
			strSql += " 		T_ACC_SLIP_BODY c, \n";
			strSql += " 		T_ACC_CODE d, \n";
			strSql += " 		T_CUST_CODE e, \n";
			strSql += " 		T_ACC_SLIP_HEAD f, \n";
			strSql += " 		T_ACC_SLIP_BODY g \n";
			strSql += " Where	a.TARGET_SLIP_ID = b.SLIP_ID \n";
			strSql += " And		a.TARGET_SLIP_ID = c.SLIP_ID \n";
			strSql += " And		a.TARGET_SLIP_IDSEQ = c.SLIP_IDSEQ \n";
			strSql += " And		c.ACC_CODE = d.ACC_CODE \n";
			strSql += " And		c.CUST_SEQ = e.CUST_SEQ (+) \n";
			strSql += " And		a.SLIP_ID = f.SLIP_ID (+) \n";
			strSql += " And		a.SLIP_ID = g.SLIP_ID (+) \n";
			strSql += " And		a.SLIP_IDSEQ = g.SLIP_IDSEQ (+) \n";
			strSql += " And		a.COMP_CODE =  ?  \n";
			strSql += " And		a.WORK_DT =  ?  \n";
			strSql += " And		a.EXEC_KIND_TAG = '2' \n";
			strSql += " And		c.ACC_CODE In  \n";
			strSql += " 		( \n";
			strSql += " 			Select \n";
			strSql += " 				x.ACC_CODE \n";
			strSql += " 			From	T_FIN_PAY_SUM_ACC_LIST x \n";
			strSql += " 			Where	x.ACC_KIND_CODE Like   ?   || '%' \n";
			strSql += " 		) \n";
			strSql += " Order By \n";
			strSql += " 	e.CUST_CODE, \n";
			strSql += " 	a.TARGET_SLIP_ID , \n";
			strSql += " 	a.TARGET_SLIP_IDSEQ ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2WORK_DT", CITData.DATE);
			lrArgData.addColumn("3ACC_KIND_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2WORK_DT", strWORK_DT);
			lrArgData.setValue("3ACC_KIND_CODE", strACC_KIND_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("WORK_DT", true);
				lrReturnData.setKey("SEQ", true);

				
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
		else if (strAct.equals("SUB03"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strWORK_DT = CITCommon.toKOR(request.getParameter("WORK_DT"));
			String strACC_KIND_CODE = CITCommon.toKOR(request.getParameter("ACC_KIND_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	'F' CHK_TAG, \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	F_T_DATETOSTRING(a.WORK_DT) WORK_DT , \n";
			strSql += " 	a.SEQ , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.EXEC_KIND_TAG , \n";
			strSql += " 	To_Char(a.TARGET_SLIP_ID) TARGET_SLIP_ID , \n";
			strSql += " 	To_Char(a.TARGET_SLIP_IDSEQ) TARGET_SLIP_IDSEQ , \n";
			strSql += " 	a.EXEC_AMT , \n";
			strSql += " 	a.OUT_ACC_NO , \n";
			strSql += " 	a.IN_BANK_MAIN_CODE , \n";
			strSql += " 	a.IN_ACC_NO , \n";
			strSql += " 	a.ACCNO_OWNER , \n";
			strSql += " 	To_Char(a.SLIP_PUB_SEQ) SLIP_PUB_SEQ , \n";
			strSql += " 	To_Char(a.SLIP_ID) SLIP_ID , \n";
			strSql += " 	To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ , \n";
			strSql += " 	a.CHK_BILL_NO, \n";
			strSql += " 	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT, \n";
			strSql += " 	To_Char(e.CUST_SEQ) CUST_SEQ, \n";
			strSql += " 	F_T_CUST_MASK(e.CUST_CODE) CUST_CODE, \n";
			strSql += " 	c.CUST_NAME, \n";
			strSql += " 	b.MAKE_SLIPNO, \n";
			strSql += " 	b.MAKE_COMP_CODE, \n";
			strSql += " 	b.MAKE_DT_TRANS, \n";
			strSql += " 	b.MAKE_SEQ, \n";
			strSql += " 	b.SLIP_KIND_TAG, \n";
			strSql += " 	d.ACC_NAME, \n";
			strSql += " 	c.SUMMARY1||c.SUMMARY2 SUMMARY, \n";
			strSql += " 	f.MAKE_SLIPNO PAY_MAKE_SLIPNO, \n";
			strSql += " 	f.MAKE_COMP_CODE PAY_MAKE_COMP_CODE, \n";
			strSql += " 	f.MAKE_DT_TRANS PAY_MAKE_DT_TRANS, \n";
			strSql += " 	f.MAKE_SEQ PAY_MAKE_SEQ, \n";
			strSql += " 	f.SLIP_KIND_TAG PAY_SLIP_KIND_TAG \n";
			strSql += " From	T_FIN_PAY_EXEC_LIST a, \n";
			strSql += " 		T_ACC_SLIP_HEAD b, \n";
			strSql += " 		T_ACC_SLIP_BODY c, \n";
			strSql += " 		T_ACC_CODE d, \n";
			strSql += " 		T_CUST_CODE e, \n";
			strSql += " 		T_ACC_SLIP_HEAD f, \n";
			strSql += " 		T_ACC_SLIP_BODY g \n";
			strSql += " Where	a.TARGET_SLIP_ID = b.SLIP_ID \n";
			strSql += " And		a.TARGET_SLIP_ID = c.SLIP_ID \n";
			strSql += " And		a.TARGET_SLIP_IDSEQ = c.SLIP_IDSEQ \n";
			strSql += " And		c.ACC_CODE = d.ACC_CODE \n";
			strSql += " And		c.CUST_SEQ = e.CUST_SEQ (+) \n";
			strSql += " And		a.SLIP_ID = f.SLIP_ID (+) \n";
			strSql += " And		a.SLIP_ID = g.SLIP_ID (+) \n";
			strSql += " And		a.SLIP_IDSEQ = g.SLIP_IDSEQ (+) \n";
			strSql += " And		a.COMP_CODE =  ?  \n";
			strSql += " And		a.WORK_DT =  ?  \n";
			strSql += " And		a.EXEC_KIND_TAG = '3' \n";
			strSql += " And		c.ACC_CODE In  \n";
			strSql += " 		( \n";
			strSql += " 			Select \n";
			strSql += " 				x.ACC_CODE \n";
			strSql += " 			From	T_FIN_PAY_SUM_ACC_LIST x \n";
			strSql += " 			Where	x.ACC_KIND_CODE Like   ?   || '%' \n";
			strSql += " 		) \n";
			strSql += " Order By \n";
			strSql += " 	e.CUST_CODE, \n";
			strSql += " 	a.TARGET_SLIP_ID , \n";
			strSql += " 	a.TARGET_SLIP_IDSEQ ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2WORK_DT", CITData.DATE);
			lrArgData.addColumn("3ACC_KIND_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2WORK_DT", strWORK_DT);
			lrArgData.setValue("3ACC_KIND_CODE", strACC_KIND_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("WORK_DT", true);
				lrReturnData.setKey("SEQ", true);

				
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
		else if (strAct.equals("SUB04"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strWORK_DT = CITCommon.toKOR(request.getParameter("WORK_DT"));
			String strACC_KIND_CODE = CITCommon.toKOR(request.getParameter("ACC_KIND_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	'F' CHK_TAG, \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	F_T_DATETOSTRING(a.WORK_DT) WORK_DT , \n";
			strSql += " 	a.SEQ , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.EXEC_KIND_TAG , \n";
			strSql += " 	To_Char(a.TARGET_SLIP_ID) TARGET_SLIP_ID , \n";
			strSql += " 	To_Char(a.TARGET_SLIP_IDSEQ) TARGET_SLIP_IDSEQ , \n";
			strSql += " 	a.EXEC_AMT , \n";
			strSql += " 	a.OUT_ACC_NO , \n";
			strSql += " 	a.IN_BANK_MAIN_CODE , \n";
			strSql += " 	a.IN_ACC_NO , \n";
			strSql += " 	a.ACCNO_OWNER , \n";
			strSql += " 	To_Char(a.SLIP_PUB_SEQ) SLIP_PUB_SEQ , \n";
			strSql += " 	To_Char(a.SLIP_ID) SLIP_ID , \n";
			strSql += " 	To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ , \n";
			strSql += " 	a.CHK_BILL_NO, \n";
			strSql += " 	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT, \n";
			strSql += " 	To_Char(e.CUST_SEQ) CUST_SEQ, \n";
			strSql += " 	F_T_CUST_MASK(e.CUST_CODE) CUST_CODE, \n";
			strSql += " 	c.CUST_NAME, \n";
			strSql += " 	b.MAKE_SLIPNO, \n";
			strSql += " 	b.MAKE_COMP_CODE, \n";
			strSql += " 	b.MAKE_DT_TRANS, \n";
			strSql += " 	b.MAKE_SEQ, \n";
			strSql += " 	b.SLIP_KIND_TAG, \n";
			strSql += " 	d.ACC_NAME, \n";
			strSql += " 	c.SUMMARY1||c.SUMMARY2 SUMMARY, \n";
			strSql += " 	f.MAKE_SLIPNO PAY_MAKE_SLIPNO, \n";
			strSql += " 	f.MAKE_COMP_CODE PAY_MAKE_COMP_CODE, \n";
			strSql += " 	f.MAKE_DT_TRANS PAY_MAKE_DT_TRANS, \n";
			strSql += " 	f.MAKE_SEQ PAY_MAKE_SEQ, \n";
			strSql += " 	f.SLIP_KIND_TAG PAY_SLIP_KIND_TAG \n";
			strSql += " From	T_FIN_PAY_EXEC_LIST a, \n";
			strSql += " 		T_ACC_SLIP_HEAD b, \n";
			strSql += " 		T_ACC_SLIP_BODY c, \n";
			strSql += " 		T_ACC_CODE d, \n";
			strSql += " 		T_CUST_CODE e, \n";
			strSql += " 		T_ACC_SLIP_HEAD f, \n";
			strSql += " 		T_ACC_SLIP_BODY g \n";
			strSql += " Where	a.TARGET_SLIP_ID = b.SLIP_ID \n";
			strSql += " And		a.TARGET_SLIP_ID = c.SLIP_ID \n";
			strSql += " And		a.TARGET_SLIP_IDSEQ = c.SLIP_IDSEQ \n";
			strSql += " And		c.ACC_CODE = d.ACC_CODE \n";
			strSql += " And		c.CUST_SEQ = e.CUST_SEQ (+) \n";
			strSql += " And		a.SLIP_ID = f.SLIP_ID (+) \n";
			strSql += " And		a.SLIP_ID = g.SLIP_ID (+) \n";
			strSql += " And		a.SLIP_IDSEQ = g.SLIP_IDSEQ (+) \n";
			strSql += " And		a.COMP_CODE =  ?  \n";
			strSql += " And		a.WORK_DT =  ?  \n";
			strSql += " And		a.EXEC_KIND_TAG = '4' \n";
			strSql += " And		c.ACC_CODE In  \n";
			strSql += " 		( \n";
			strSql += " 			Select \n";
			strSql += " 				x.ACC_CODE \n";
			strSql += " 			From	T_FIN_PAY_SUM_ACC_LIST x \n";
			strSql += " 			Where	x.ACC_KIND_CODE Like   ?   || '%' \n";
			strSql += " 		) \n";
			strSql += " Order By \n";
			strSql += " 	e.CUST_CODE, \n";
			strSql += " 	a.TARGET_SLIP_ID , \n";
			strSql += " 	a.TARGET_SLIP_IDSEQ ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2WORK_DT", CITData.DATE);
			lrArgData.addColumn("3ACC_KIND_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2WORK_DT", strWORK_DT);
			lrArgData.setValue("3ACC_KIND_CODE", strACC_KIND_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("WORK_DT", true);
				lrReturnData.setKey("SEQ", true);

				
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
		else if (strAct.equals("SUB05"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strWORK_DT = CITCommon.toKOR(request.getParameter("WORK_DT"));
			String strACC_KIND_CODE = CITCommon.toKOR(request.getParameter("ACC_KIND_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	'F' CHK_TAG, \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	F_T_DATETOSTRING(a.WORK_DT) WORK_DT , \n";
			strSql += " 	a.SEQ , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.EXEC_KIND_TAG , \n";
			strSql += " 	SubStrb(Decode(a.EXEC_KIND_TAG,'1','예금','2','구매카드','3','실물어음','4','현금'),1,60)  EXEC_KIND_TAG_NM, \n";
			strSql += " 	To_Char(a.TARGET_SLIP_ID) TARGET_SLIP_ID , \n";
			strSql += " 	To_Char(a.TARGET_SLIP_IDSEQ) TARGET_SLIP_IDSEQ , \n";
			strSql += " 	a.EXEC_AMT , \n";
			strSql += " 	a.OUT_ACC_NO , \n";
			strSql += " 	a.IN_BANK_MAIN_CODE , \n";
			strSql += " 	a.IN_ACC_NO , \n";
			strSql += " 	a.ACCNO_OWNER , \n";
			strSql += " 	To_Char(a.SLIP_PUB_SEQ) SLIP_PUB_SEQ , \n";
			strSql += " 	To_Char(a.SLIP_ID) SLIP_ID , \n";
			strSql += " 	To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ , \n";
			strSql += " 	a.CHK_BILL_NO, \n";
			strSql += " 	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT, \n";
			strSql += " 	To_Char(e.CUST_SEQ) CUST_SEQ, \n";
			strSql += " 	F_T_CUST_MASK(e.CUST_CODE) CUST_CODE, \n";
			strSql += " 	c.CUST_NAME, \n";
			strSql += " 	b.MAKE_SLIPNO, \n";
			strSql += " 	b.MAKE_COMP_CODE, \n";
			strSql += " 	b.MAKE_DT_TRANS, \n";
			strSql += " 	b.MAKE_SEQ, \n";
			strSql += " 	b.SLIP_KIND_TAG, \n";
			strSql += " 	d.ACC_NAME, \n";
			strSql += " 	c.SUMMARY1||c.SUMMARY2 SUMMARY, \n";
			strSql += " 	f.MAKE_SLIPNO PAY_MAKE_SLIPNO, \n";
			strSql += " 	f.MAKE_COMP_CODE PAY_MAKE_COMP_CODE, \n";
			strSql += " 	f.MAKE_DT_TRANS PAY_MAKE_DT_TRANS, \n";
			strSql += " 	f.MAKE_SEQ PAY_MAKE_SEQ, \n";
			strSql += " 	f.SLIP_KIND_TAG PAY_SLIP_KIND_TAG \n";
			strSql += " From	T_FIN_PAY_EXEC_LIST a, \n";
			strSql += " 		T_ACC_SLIP_HEAD b, \n";
			strSql += " 		T_ACC_SLIP_BODY c, \n";
			strSql += " 		T_ACC_CODE d, \n";
			strSql += " 		T_CUST_CODE e, \n";
			strSql += " 		T_ACC_SLIP_HEAD f, \n";
			strSql += " 		T_ACC_SLIP_BODY g \n";
			strSql += " Where	a.TARGET_SLIP_ID = b.SLIP_ID \n";
			strSql += " And		a.TARGET_SLIP_ID = c.SLIP_ID \n";
			strSql += " And		a.TARGET_SLIP_IDSEQ = c.SLIP_IDSEQ \n";
			strSql += " And		c.ACC_CODE = d.ACC_CODE \n";
			strSql += " And		c.CUST_SEQ = e.CUST_SEQ (+) \n";
			strSql += " And		a.SLIP_ID = f.SLIP_ID (+) \n";
			strSql += " And		a.SLIP_ID = g.SLIP_ID (+) \n";
			strSql += " And		a.SLIP_IDSEQ = g.SLIP_IDSEQ (+) \n";
			strSql += " And		a.COMP_CODE =  ?  \n";
			strSql += " And		a.WORK_DT =  ?  \n";
			strSql += " And		c.ACC_CODE In  \n";
			strSql += " 		( \n";
			strSql += " 			Select \n";
			strSql += " 				x.ACC_CODE \n";
			strSql += " 			From	T_FIN_PAY_SUM_ACC_LIST x \n";
			strSql += " 			Where	x.ACC_KIND_CODE Like   ?   || '%' \n";
			strSql += " 		) \n";
			strSql += " Order By \n";
			strSql += " 	e.CUST_CODE, a.EXEC_KIND_TAG, \n";
			strSql += " 	a.TARGET_SLIP_ID , \n";
			strSql += " 	a.TARGET_SLIP_IDSEQ ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2WORK_DT", CITData.DATE);
			lrArgData.addColumn("3ACC_KIND_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2WORK_DT", strWORK_DT);
			lrArgData.setValue("3ACC_KIND_CODE", strACC_KIND_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("WORK_DT", true);
				lrReturnData.setKey("SEQ", true);

				
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
		else if (strAct.equals("CUST_ACC"))
		{
			String strSLIP_ID = CITCommon.toKOR(request.getParameter("SLIP_ID"));
			String strSLIP_IDSEQ = CITCommon.toKOR(request.getParameter("SLIP_IDSEQ"));
			String strACCNO_CLS = CITCommon.toKOR(request.getParameter("ACCNO_CLS"));
			
			strSql  = " Select	BANK_MAIN_CODE,ACCNO,ACCNO_OWNER	From	Table(F_T_ACC_INFO(?,?,?)) \n";
			
			lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
			lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
			lrArgData.addColumn("2ACCNO_CLS", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("SLIP_ID", strSLIP_ID);
			lrArgData.setValue("SLIP_IDSEQ", strSLIP_IDSEQ);
			lrArgData.setValue("2ACCNO_CLS", strACCNO_CLS);
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
				GauceInfo.response.writeException("USER", "900001","CUST_ACC Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("ACC_INFO"))
		{
			String strSLIP_ID = CITCommon.toKOR(request.getParameter("SLIP_ID"));
			String strSLIP_IDSEQ = CITCommon.toKOR(request.getParameter("SLIP_IDSEQ"));
			
			strSql  = " Select \n";
			strSql += " 	c.PAY_TAR_TAG,a.EMP_NO \n";
			strSql += " From	T_ACC_SLIP_BODY a, \n";
			strSql += " 		T_FIN_PAY_SUM_ACC_LIST b, \n";
			strSql += " 		T_FIN_PAY_SUM_ACC_GROUP c \n";
			strSql += " Where	a.SLIP_ID =  ?  \n";
			strSql += " And		a.SLIP_IDSEQ =  ?  \n";
			strSql += " And		b.ACC_CODE = a.ACC_CODE \n";
			strSql += " And		b.ACC_KIND_CODE = c.ACC_KIND_CODE \n";
			strSql += " And		rowNum < 2 \n";
			strSql += "  ";
			
			lrArgData.addColumn("1SLIP_ID", CITData.NUMBER);
			lrArgData.addColumn("2SLIP_IDSEQ", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("1SLIP_ID", strSLIP_ID);
			lrArgData.setValue("2SLIP_IDSEQ", strSLIP_IDSEQ);
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
				GauceInfo.response.writeException("USER", "900001","CUST_ACC Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SLIP_INFO"))
		{
			String strSLIP_ID = CITCommon.toKOR(request.getParameter("SLIP_ID"));
			String strSLIP_IDSEQ = CITCommon.toKOR(request.getParameter("SLIP_IDSEQ"));
			
			strSql  = " Select \n";
			strSql += " 	a.SLIP_ID , \n";
			strSql += " 	a.SLIP_IDSEQ , \n";
			strSql += " 	a.MAKE_SLIPLINE , \n";
			strSql += " 	a.ACC_CODE , \n";
			strSql += " 	a.DB_AMT , \n";
			strSql += " 	a.CR_AMT , \n";
			strSql += " 	a.SUMMARY_CODE , \n";
			strSql += " 	a.TAX_COMP_CODE , \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.DEPT_CODE , \n";
			strSql += " 	a.CLASS_CODE , \n";
			strSql += " 	a.VAT_CODE , \n";
			strSql += " 	F_T_DATETOSTRING(a.VAT_DT) VAT_DT , \n";
			strSql += " 	a.SUPAMT , \n";
			strSql += " 	a.VATAMT , \n";
			strSql += " 	To_Char(a.CUST_SEQ) CUST_SEQ , \n";
			strSql += " 	a.CUST_NAME , \n";
			strSql += " 	a.BANK_CODE , \n";
			strSql += " 	a.ACCNO , \n";
			strSql += " 	To_Char(a.RESET_SLIP_ID) RESET_SLIP_ID , \n";
			strSql += " 	To_Char(a.RESET_SLIP_IDSEQ) RESET_SLIP_IDSEQ , \n";
			strSql += " 	a.MAKE_COMP_CODE , \n";
			strSql += " 	a.MAKE_DEPT_CODE , \n";
			strSql += " 	F_T_DATETOSTRING(a.MAKE_DT) MAKE_DT , \n";
			strSql += " 	F_T_DATETOSTRING(a.KEEP_DT) KEEP_DT , \n";
			strSql += " 	a.SLIP_KIND_TAG , \n";
			strSql += " 	a.TRANSFER_TAG , \n";
			strSql += " 	a.IGNORE_SET_RESET_TAG , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.SUMMARY1 , \n";
			strSql += " 	a.SUMMARY2 , \n";
			strSql += " 	a.CHK_NO , \n";
			strSql += " 	a.BILL_NO , \n";
			strSql += " 	a.REC_BILL_NO , \n";
			strSql += " 	a.CP_NO , \n";
			strSql += " 	To_Char(a.SECU_NO) SECU_NO , \n";
			strSql += " 	a.LOAN_NO , \n";
			strSql += " 	a.LOAN_REFUND_NO , \n";
			strSql += " 	To_Char(a.LOAN_REFUND_SEQ) LOAN_REFUND_SEQ , \n";
			strSql += " 	a.DEPOSIT_ACCNO , \n";
			strSql += " 	a.PAYMENT_SEQ , \n";
			strSql += " 	a.PAY_CON_CASH , \n";
			strSql += " 	a.PAY_CON_BILL , \n";
			strSql += " 	F_T_DATETOSTRING(a.PAY_CON_BILL_DT) PAY_CON_BILL_DT , \n";
			strSql += " 	F_T_DATETOSTRING(a.ANTICIPATION_DT) ANTICIPATION_DT , \n";
			strSql += " 	a.PAY_CON_BILL_DAYS , \n";
			strSql += " 	F_T_DATETOSTRING(a.MNG_ITEM_DT1 + a.PAY_CON_BILL_DAYS) PAY_CON_EXPR_DT, \n";
			strSql += " 	a.EMP_NO , \n";
			strSql += " 	a.MNG_ITEM_CHAR1 , \n";
			strSql += " 	a.MNG_ITEM_CHAR2 , \n";
			strSql += " 	a.MNG_ITEM_CHAR3 , \n";
			strSql += " 	a.MNG_ITEM_CHAR4 , \n";
			strSql += " 	a.MNG_ITEM_NUM1 , \n";
			strSql += " 	a.MNG_ITEM_NUM2 , \n";
			strSql += " 	a.MNG_ITEM_NUM3 , \n";
			strSql += " 	a.MNG_ITEM_NUM4 , \n";
			strSql += " 	a.MNG_ITEM_DT1 , \n";
			strSql += " 	a.MNG_ITEM_DT2 , \n";
			strSql += " 	a.MNG_ITEM_DT3 , \n";
			strSql += " 	a.MNG_ITEM_DT4 , \n";
			strSql += " 	To_Char(a.FIX_ASSET_SEQ) FIX_ASSET_SEQ \n";
			strSql += " From	T_ACC_SLIP_BODY a \n";
			strSql += " Where	a.SLIP_ID =  ?  \n";
			strSql += " And		a.SLIP_IDSEQ =  ?  ";
			
			lrArgData.addColumn("1SLIP_ID", CITData.NUMBER);
			lrArgData.addColumn("2SLIP_IDSEQ", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("1SLIP_ID", strSLIP_ID);
			lrArgData.setValue("2SLIP_IDSEQ", strSLIP_IDSEQ);
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
		else if (strAct.equals("MAKE_SLIP_INFO"))
		{

			
			strSql  = " Select \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	F_T_DATETOSTRING(a.WORK_DT) WORK_DT , \n";
			strSql += " 	a.SEQ , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.EXEC_KIND_TAG , \n";
			strSql += " 	To_Char(a.TARGET_SLIP_ID) TARGET_SLIP_ID , \n";
			strSql += " 	To_Char(a.TARGET_SLIP_IDSEQ) TARGET_SLIP_IDSEQ , \n";
			strSql += " 	a.EXEC_AMT , \n";
			strSql += " 	a.OUT_ACC_NO , \n";
			strSql += " 	a.IN_BANK_MAIN_CODE , \n";
			strSql += " 	a.IN_ACC_NO , \n";
			strSql += " 	a.ACCNO_OWNER , \n";
			strSql += " 	To_Char(a.SLIP_PUB_SEQ) SLIP_PUB_SEQ , \n";
			strSql += " 	To_Char(a.SLIP_ID) SLIP_ID , \n";
			strSql += " 	To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ , \n";
			strSql += " 	a.CHK_BILL_NO , \n";
			strSql += " 	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT \n";
			strSql += " From	T_FIN_PAY_EXEC_LIST_TMP a \n";
			strSql += " Where	1 = 0 ";
			

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
				GauceInfo.response.writeException("USER", "900001","MAKE_SLIP_INFO Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("MAKE_PAY_INFO"))
		{

			
			strSql  = " Select \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	F_T_DATETOSTRING(a.WORK_DT) WORK_DT , \n";
			strSql += " 	a.SEQ , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.EXEC_KIND_TAG , \n";
			strSql += " 	To_Char(a.TARGET_SLIP_ID) TARGET_SLIP_ID , \n";
			strSql += " 	To_Char(a.TARGET_SLIP_IDSEQ) TARGET_SLIP_IDSEQ , \n";
			strSql += " 	a.EXEC_AMT , \n";
			strSql += " 	a.OUT_ACC_NO , \n";
			strSql += " 	a.IN_BANK_MAIN_CODE , \n";
			strSql += " 	a.IN_ACC_NO , \n";
			strSql += " 	a.ACCNO_OWNER , \n";
			strSql += " 	To_Char(a.SLIP_PUB_SEQ) SLIP_PUB_SEQ , \n";
			strSql += " 	To_Char(a.SLIP_ID) SLIP_ID , \n";
			strSql += " 	To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ , \n";
			strSql += " 	a.CHK_BILL_NO , \n";
			strSql += " 	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT \n";
			strSql += " From	T_FIN_PAY_EXEC_LIST_TMP a \n";
			strSql += " Where	1 = 0 ";
			

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
				GauceInfo.response.writeException("USER", "900001","MAKE_SLIP_INFO Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("MAKE_PAY"))
		{

			
			strSql  = " Select 'XXXXXXXXXXXXX' COMP_CODE, F_T_DATETOSTRING(Sysdate) WORK_DT, 'XXXXXXXXXXXXX' CRTUSERNO , 'XXXXXXXXXXXXX' DEPT_CODE From Dual ";
			

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
				GauceInfo.response.writeException("USER", "900001","MAKE Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("MAKE_SLIP"))
		{

			
			strSql  = " Select 'XXXXXXXXXXXXX' COMP_CODE, F_T_DATETOSTRING(Sysdate) WORK_DT, 'XXXXXXXXXXXXX' CRTUSERNO , 'XXXXXXXXXXXXX' DEPT_CODE From Dual ";
			

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
				GauceInfo.response.writeException("USER", "900001","MAKE Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("DETAIL"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strWORK_DT = CITCommon.toKOR(request.getParameter("WORK_DT"));
			
			strSql  = " Select \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	F_T_DATETOSTRING(a.WORK_DT) WORK_DT , \n";
			strSql += " 	a.SLIP_PUB_SEQ , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	To_Char(a.SLIP_ID) SLIP_ID , \n";
			strSql += " 	To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ, \n";
			strSql += " 	b.MAKE_COMP_CODE, \n";
			strSql += " 	b.MAKE_DT_TRANS, \n";
			strSql += " 	b.MAKE_SEQ, \n";
			strSql += " 	b.SLIP_KIND_TAG, \n";
			strSql += " 	b.MAKE_SLIPNO \n";
			strSql += " From	T_FIN_PAY_PUB_SLIP_LIST a, \n";
			strSql += " 		T_ACC_SLIP_HEAD b \n";
			strSql += " Where	a.SLIP_ID = b.SLIP_ID (+) \n";
			strSql += " And		a.COMP_CODE =  ?  \n";
			strSql += " And		a.WORK_DT =  ?  \n";
			strSql += " Order By \n";
			strSql += " 	a.SLIP_ID ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2WORK_DT", CITData.DATE);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2WORK_DT", strWORK_DT);
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
				GauceInfo.response.writeException("USER", "900001","DETAIL Select 오류-> "+ ex.getMessage());
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
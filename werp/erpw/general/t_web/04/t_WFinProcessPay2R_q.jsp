<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-05-16)
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
			String strOUT_ACC_NO = CITCommon.toKOR(request.getParameter("OUT_ACC_NO"));
			String strAR_COMP_CODE = CITCommon.toKOR(request.getParameter("AR_COMP_CODE"));
			String strWORK_DT = CITCommon.toKOR(request.getParameter("WORK_DT"));
			String strAR_CRTUSERNO = CITCommon.toKOR((String)session.getAttribute("emp_no"));
			String strACC_KIND_CODE = CITCommon.toKOR(request.getParameter("ACC_KIND_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	'F' CHK_TAG, \n";
			strSql += " 	a.COMP_CODE, \n";
			strSql += " 	a.WORK_DT, \n";
			strSql += " 	a.CRTUSERNO, \n";
			strSql += " 	a.CRTDATE, \n";
			strSql += " 	a.ACC_CODE, \n";
			strSql += " 	'3' EXEC_KIND_TAG, \n";		//실물어음
			strSql += " 	0 EXEC_AMT, \n";
			strSql += " 	 ?  OUT_ACC_NO, \n";
			strSql += " 	a.ACC_NAME, \n";
			strSql += " 	a.TARGET_SLIP_ID, \n";
			strSql += " 	a.TARGET_SLIP_IDSEQ, \n";
			strSql += " 	a.MNG_ITEM_DT1, \n";
			strSql += " 	To_Char(a.PAY_CON_BILL_DAYS,'fm999,999,999,999') PAY_CON_BILL_DAYS , \n";
			strSql += " 	a.CUST_CODE, \n";
			strSql += " 	a.MAKE_SLIPNO, \n";
			strSql += " 	a.MAKE_COMP_CODE, \n";
			strSql += " 	a.MAKE_DT_TRANS, \n";
			strSql += " 	a.MAKE_SEQ, \n";
			strSql += " 	a.SLIP_KIND_TAG, \n";
			strSql += " 	a.PAY_CON_EXPR_DT EXPR_DT, \n";
			strSql += " 	a.MASKED_CUST_CODE, \n";
			strSql += " 	a.CUST_SEQ, \n";
			strSql += " 	a.CUST_NAME, \n";
			strSql += " 	a.SET_AMT, \n";
			strSql += " 	a.PRE_RESET_AMT, \n";
			strSql += " 	Nvl(a.SET_AMT,0) - Nvl(a.PRE_RESET_AMT,0) REMAIN_AMT, \n";
			strSql += " 	a.ANTICIPATION_DT, \n";
			strSql += " 	to_char(a.C_RATIO,'fm999,999,999,999') C_RATIO, \n";
			strSql += " 	to_char(a.B_RATIO,'fm999,999,999,999') B_RATIO, \n";
			strSql += " 	SubStr(a.IN_ACC_INFO,1,Instr(a.IN_ACC_INFO,'@') - 1) IN_BANK_MAIN_CODE, \n";
			strSql += " 	SubStr(a.IN_ACC_INFO,Instr(a.IN_ACC_INFO,'@') + 1 ,Instr(a.IN_ACC_INFO,'@@') - 1 - (Instr(a.IN_ACC_INFO,'@') ) ) IN_ACC_NO, \n";
			strSql += " 	SubStr(a.IN_ACC_INFO,Instr(a.IN_ACC_INFO,'@@') + 2 ,Length(a.IN_ACC_INFO) - Instr(a.IN_ACC_INFO,'@@')) ACCNO_OWNER, \n";
			strSql += " 	a.IN_ACC_INFO, \n";
			strSql += " 	SubStrb('',1,20) CHK_BILL_NO \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			a.COMP_CODE, \n";
			strSql += " 			a.WORK_DT, \n";
			strSql += " 			a.CRTUSERNO, \n";
			strSql += " 			a.CRTDATE, \n";
			strSql += " 			a.ACC_CODE, \n";
			strSql += " 			e.ACC_NAME, \n";
			strSql += " 			c.CUST_CODE, \n";
			strSql += " 			F_T_CUST_MASK(c.CUST_CODE) MASKED_CUST_CODE, \n";
			strSql += " 			d.MAKE_SLIPNO, \n";
			strSql += " 			d.MAKE_COMP_CODE, \n";
			strSql += " 			d.MAKE_DT_TRANS, \n";
			strSql += " 			d.MAKE_SEQ, \n";
			strSql += " 			d.SLIP_KIND_TAG, \n";
			strSql += " 			a.TARGET_SLIP_ID, \n";
			strSql += " 			a.TARGET_SLIP_IDSEQ, \n";
			strSql += " 			a.MNG_ITEM_DT1, \n";
			strSql += " 			a.PAY_CON_BILL_DAYS, \n";
			strSql += " 			a.PAY_CON_EXPR_DT, \n";
			strSql += " 			a.CUST_SEQ, \n";
			strSql += " 			a.CUST_NAME, \n";
			strSql += " 			a.SET_AMT, \n";
			strSql += " 			a.PRE_RESET_AMT, \n";
			strSql += " 			a.ANTICIPATION_DT, \n";
			strSql += " 			a.C_RATIO, \n";
			strSql += " 			a.B_RATIO, \n";
			strSql += " 			( \n";
			strSql += " 				Select \n";
			strSql += " 					x.BANK_MAIN_CODE || '@' || x.ACCNO || '@@' ||x.ACCNO_OWNER \n";
			strSql += " 				From	T_CUST_ACCNO_CODE x \n";
			strSql += " 				Where	x.CUST_SEQ = a.CUST_SEQ \n";
			strSql += " 				And		x.ACCNO_CLS = '2' \n";			//실물어음 계좌
			strSql += " 				And		x.USE_TG = 'T' \n";
			strSql += " 				And		RowNum < 2 \n";
			strSql += " 			) IN_ACC_INFO, \n";
			strSql += " 			RowNum Rn \n";
			strSql += " 		From \n";
			strSql += " 			( \n";
			strSql += " 				Select \n";
			strSql += " 					 ?  COMP_CODE, \n";
			strSql += " 					 ?  WORK_DT, \n";
			strSql += " 					 ?  CRTUSERNO, \n";
			strSql += " 					SysDate CRTDATE, \n";
			strSql += " 					a.ACC_CODE ACC_CODE, \n";
			strSql += " 					a.SLIP_ID TARGET_SLIP_ID, \n";
			strSql += " 					a.SLIP_IDSEQ TARGET_SLIP_IDSEQ, \n";
			strSql += " 					F_T_DATETOSTRING(a.MNG_ITEM_DT1) MNG_ITEM_DT1, \n";
			strSql += " 					a.PAY_CON_BILL_DAYS, \n";
			strSql += " 					F_T_DATETOSTRING(a.MNG_ITEM_DT1 + a.PAY_CON_BILL_DAYS) PAY_CON_EXPR_DT, \n";
			strSql += " 					a.CUST_SEQ CUST_SEQ, \n";
			strSql += " 					a.CUST_NAME CUST_NAME, \n";
			strSql += " 					Nvl(a.CR_AMT,0) - Nvl(a.DB_AMT,0) SET_AMT, \n";
			strSql += " 					Nvl(Sum(b.DB_AMT),0) - Nvl(Sum(b.CR_AMT),0) PRE_RESET_AMT, \n";
			strSql += " 					F_T_DATETOSTRING(a.ANTICIPATION_DT) ANTICIPATION_DT, \n";
			strSql += " 					a.PAY_CON_CASH C_RATIO, \n";
			strSql += " 					a.PAY_CON_BILL B_RATIO \n";
			strSql += " 				From	T_ACC_SLIP_BODY a, \n";
			strSql += " 						T_ACC_SLIP_BODY1 b \n";
			strSql += " 				Where	a.SLIP_ID = b.RESET_SLIP_ID (+) \n";
			strSql += " 				And		a.SLIP_IDSEQ = b.RESET_SLIP_IDSEQ (+) \n";
			strSql += " 				And		a.COMP_CODE =  ?  \n";
			strSql += " 				And		a.MAKE_DT <=  ?  \n";
			strSql += " 				And		b.MAKE_DT(+) <  ?  \n";
			strSql += " 				And		a.SLIP_ID = a.RESET_SLIP_ID \n";
			strSql += " 				And		a.SLIP_IDSEQ = a.RESET_SLIP_IDSEQ \n";
			strSql += " 				And		b.SLIP_IDSEQ (+) <> b.RESET_SLIP_IDSEQ (+) \n";
			strSql += " 				And		a.IGNORE_SET_RESET_TAG = 'F' \n";
			strSql += " 				And		a.TRANSFER_TAG = 'F' \n";
			strSql += " 				And		b.TRANSFER_TAG (+) = 'F' \n";
			strSql += " 				And		a.KEEP_DT Is Not Null \n";
			strSql += " 				And		b.KEEP_DT (+) Is Not Null \n";
			strSql += " 				And		a.ACC_CODE In \n";
			strSql += " 						( \n";
			strSql += " 							Select \n";
			strSql += " 								x.ACC_CODE \n";
			strSql += " 							From	T_FIN_PAY_SUM_ACC_LIST x \n";
			strSql += " 							Where	x.ACC_KIND_CODE =  ?  \n";
			strSql += " 						) \n";
			strSql += " 				having	Nvl(a.CR_AMT,0) - Nvl(a.DB_AMT,0) - (Nvl(Sum(b.DB_AMT),0) - Nvl(Sum(b.CR_AMT),0)) <> 0 \n";
			strSql += " 				Group By \n";
			strSql += " 					a.CUST_NAME, \n";
			strSql += " 					a.CUST_SEQ , \n";
			strSql += " 					a.ACC_CODE, \n";
			strSql += " 					a.SLIP_ID , \n";
			strSql += " 					a.SLIP_IDSEQ, \n";
			strSql += " 					a.ANTICIPATION_DT, \n";
			strSql += " 					a.PAY_CON_CASH , \n";
			strSql += " 					a.MNG_ITEM_DT1, \n";
			strSql += " 					a.PAY_CON_BILL_DAYS, \n";
			strSql += " 					a.PAY_CON_BILL , \n";
			strSql += " 					a.DB_AMT, \n";
			strSql += " 					a.ANTICIPATION_DT, \n";
			strSql += " 					a.CR_AMT \n";
			strSql += " 			)a, \n";
			strSql += " 			T_CUST_CODE c, \n";
			strSql += " 			T_ACC_SLIP_HEAD d, \n";
			strSql += " 			T_ACC_CODE e \n";
			strSql += " 		Where	a.CUST_SEQ = c.CUST_SEQ \n";
			strSql += " 		And		a.TARGET_SLIP_ID = d.SLIP_ID \n";
			strSql += " 		And		a.ACC_CODE = e.ACC_CODE \n";
			strSql += " 		And		a.B_RATIO > 0 \n";
			strSql += " 	) a \n";
			strSql += "  ";
			
			lrArgData.addColumn("1OUT_ACC_NO", CITData.VARCHAR2);
			lrArgData.addColumn("2AR_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("3WORK_DT", CITData.DATE);
			lrArgData.addColumn("4AR_CRTUSERNO", CITData.VARCHAR2);
			lrArgData.addColumn("5AR_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("6WORK_DT", CITData.DATE);
			lrArgData.addColumn("7WORK_DT", CITData.DATE);
			lrArgData.addColumn("8ACC_KIND_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1OUT_ACC_NO", strOUT_ACC_NO);
			lrArgData.setValue("2AR_COMP_CODE", strAR_COMP_CODE);
			lrArgData.setValue("3WORK_DT", strWORK_DT);
			lrArgData.setValue("4AR_CRTUSERNO", strAR_CRTUSERNO);
			lrArgData.setValue("5AR_COMP_CODE", strAR_COMP_CODE);
			lrArgData.setValue("6WORK_DT", strWORK_DT);
			lrArgData.setValue("7WORK_DT", strWORK_DT);
			lrArgData.setValue("8ACC_KIND_CODE", strACC_KIND_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				lrReturnData.setColumnDisplaySize("CHK_BILL_NO",40);
				


				
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
		else if (strAct.equals("MAKE_SLIP"))
		{

			
			strSql  = " Select 'XXXXXXXXXXXXX' COMP_CODE, F_T_DATETOSTRING(Sysdate) WORK_DT, 'XXXXXXXXXXXXX' CRTUSERNO , 'XXXXXXXXXXXXX' DEPT_CODE ,0 SLIP_ID,0 SLIP_IDSEQ, 'XXXXXXXXXXXXXXXXXXXXXXXXXX' MAKE_SLIPNO ,'XXXXXXXXXXXXXXXXX' MAKE_COMP_CODE, 'XXXXXXXXXXXXXXXXXX' MAKE_DT_TRANS, 0 MAKE_SEQ, 'XXXXXXXXXXXXXXXXXXXXXX' SLIP_KIND_TAG From Dual ";
			

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

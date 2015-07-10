<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-18)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
 
	CITGauceInfo GauceInfo = null;
	
	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;

	String	strSql = "";
	String	strAct = "";
	String strUserNo = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* 세션정보 */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MAIN"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strTAX_YEAR = CITCommon.toKOR(request.getParameter("TAX_YEAR"));
			
			strSql  = " SELECT  \n";
			strSql += "  	COMP_CODE,  \n";
			strSql += "  	WORK_NO, \n";
			strSql += " 	B.CODE_LIST_NAME||' '||C.CODE_LIST_NAME||' '||REMARKS WORK_NAME, \n";
			strSql += "  	F_T_Datetostring(WORK_DATE) WORK_DATE,  \n";
			strSql += "  	TAX_YEAR,  \n";
			strSql += "  	TAX_GI,  \n";
			strSql += "  	TAX_CONF,  \n";
			strSql += "  	F_T_Datetostring(BASE_DT_F) BASE_DT_F,  \n";
			strSql += "  	F_T_Datetostring(BASE_DT_T) BASE_DT_T,  \n";
			strSql += "  	F_T_Datetostring(MISSING_PROCESS_DT_F) MISSING_PROCESS_DT_F,  \n";
			strSql += "  	APPLY_TAG,  \n";
			strSql += "  	REMARKS  \n";
			strSql += "   FROM   \n";
			strSql += "   	T_ACC_SLIP_BILL_HEAD A, \n";
			strSql += " 	( \n";
			strSql += " 		SELECT \n";
			strSql += " 			CODE_LIST_ID, CODE_LIST_NAME  \n";
			strSql += " 		FROM \n";
			strSql += " 			V_T_CODE_LIST \n";
			strSql += " 		WHERE \n";
			strSql += " 			CODE_GROUP_ID = 'TAX_GI' \n";
			strSql += " 	) B, \n";
			strSql += " 	( \n";
			strSql += " 		SELECT \n";
			strSql += " 			CODE_LIST_ID, CODE_LIST_NAME  \n";
			strSql += " 		FROM \n";
			strSql += " 			V_T_CODE_LIST \n";
			strSql += " 		WHERE \n";
			strSql += " 			CODE_GROUP_ID = 'TAX_CONF' \n";
			strSql += " 	) C \n";
			strSql += "   WHERE  \n";
			strSql += "   		A.TAX_GI = B.CODE_LIST_ID \n";
			strSql += "   		AND A.TAX_CONF = C.CODE_LIST_ID \n";
			strSql += " 		AND A.COMP_CODE =   ?  \n";
			strSql += " 		AND A.TAX_YEAR =   ?  \n";
			strSql += "   ORDER BY   \n";
			strSql += "   	COMP_CODE,   \n";
			strSql += "  	TAX_YEAR,  \n";
			strSql += "  	TAX_GI,  \n";
			strSql += "  	TAX_CONF,  \n";
			strSql += "  	WORK_DATE  ";

			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2TAX_YEAR", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2TAX_YEAR", strTAX_YEAR);

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("WORK_NO", true);
				lrReturnData.setNotNull("WORK_DATE", true);
				lrReturnData.setNotNull("TAX_YEAR", true);
				lrReturnData.setNotNull("TAX_GI", true);
				lrReturnData.setNotNull("TAX_CONF", true);
				lrReturnData.setNotNull("BASE_DT_F", true);
				lrReturnData.setNotNull("BASE_DT_T", true);
				lrReturnData.setNotNull("MISSING_PROCESS_DT_F", true);
				
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
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strWORK_NO = CITCommon.toKOR(request.getParameter("WORK_NO"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strCUST_CODE = CITCommon.toKOR(request.getParameter("CUST_CODE"));
			String strVAT_CODE = CITCommon.toKOR(request.getParameter("VAT_CODE"));
			String strTAX_YEAR = CITCommon.toKOR(request.getParameter("TAX_YEAR"));
			String strSALEBUY_CLS = CITCommon.toKOR(request.getParameter("SALEBUY_CLS"));
			String strRCPTBILL_CLS = CITCommon.toKOR(request.getParameter("RCPTBILL_CLS"));
			String strSUBTR_CLS = CITCommon.toKOR(request.getParameter("SUBTR_CLS"));
			String strACC_CODE = CITCommon.toKOR(request.getParameter("ACC_CODE"));
			String strDT_F = CITCommon.toKOR(request.getParameter("DT_F"));
			String strDT_T = CITCommon.toKOR(request.getParameter("DT_T"));
			String strDATE_CLS = CITCommon.toKOR(request.getParameter("DATE_CLS"));
			
			strSql  = " SELECT    \n";
			strSql += " 	A0.COMP_CODE,   \n";
			strSql += " 	A0.WORK_NO,  \n";
			strSql += " 	A0.TAX_YEAR, \n";
			strSql += " 	A0.TAX_GI, \n";
			strSql += " 	A0.TAX_CONF, \n";
			strSql += " 	A.SEQ,   \n";
			strSql += " 	A.TAX_COMP_CODE,   \n";
			strSql += " 	C.COMPANY_NAME TAX_COMP_NAME,   \n";
			strSql += " 	F.RCPTBILL_CLS,   \n";
			strSql += " 	F.SALEBUY_CLS,   \n";
			strSql += " 	F.SUBTR_CLS,   \n";
			strSql += " 	NVL(A.COMMBUY_CLS,'F') COMMBUY_CLS,   \n";
			strSql += " 	F_T_Datetostring(A.PUBL_DT) PUBL_DT,   \n";
			strSql += " 	A.VAT_CODE,   \n";
			strSql += " 	A.BOOK_NO,   \n";
			strSql += " 	A.BOOK_SEQ,   \n";
			strSql += " 	A.DEPT_CODE,   \n";
			strSql += " 	D.DEPT_NAME,   \n";
			strSql += " 	A.CUST_SEQ,   \n";
			strSql += " 	E.CUST_CODE,   \n";
			strSql += " 	E.CUST_NAME,   \n";
			strSql += " 	A.SUPAMT,   \n";
			strSql += " 	A.VATAMT,   \n";
			strSql += " 	A.ANNULMENT_CLS,   \n";
			strSql += " 	A.ANNULMENT_DT,   \n";
			strSql += " 	A.OUT_CNT,   \n";
			strSql += " 	A.MISSING_TAG,   \n";
			strSql += " 	A.REMARK,   \n";
			strSql += " 	A.UDT_TAG,   \n";
			strSql += "  	A.CARD_CASH_NO,  \n";
			strSql += " 	A.SLIP_ID,   \n";
			strSql += " 	A.SLIP_IDSEQ,   \n";
			strSql += " 	B1.MAKE_SLIPNO||'-'||B2.MAKE_SLIPLINE MAKE_SLIPNOLINE,   \n";
			strSql += "  	A.ACC_CODE,  \n";
			strSql += "  	F.ACC_NAME,  \n";
			strSql += "     -- 전표조회 인자     \n";
			strSql += "     b1.MAKE_COMP_CODE ,      \n";
			strSql += "     F_T_Datetostring(b1.MAKE_DT) MAKE_DT,      \n";
			strSql += "     b1.MAKE_SEQ ,      \n";
			strSql += "     b1.SLIP_KIND_TAG    \n";
			strSql += " FROM \n";
			strSql += " 	T_ACC_SLIP_BILL_HEAD A0, \n";
			strSql += " 	T_ACC_TAX_BILL_MEDIA A,   \n";
			strSql += " 	T_ACC_SLIP_HEAD B1,  \n";
			strSql += " 	T_ACC_SLIP_BODY1 B2,  \n";
			strSql += " 	T_COMPANY C,  \n";
			strSql += " 	T_DEPT_CODE_ORG D,  \n";
			strSql += " 	T_CUST_CODE E, \n";
			strSql += " 	T_ACC_CODE_VIEW F \n";
			strSql += " WHERE \n";
			strSql += " 	A0.COMP_CODE = A.COMP_CODE \n";
			strSql += " 	AND A0.WORK_NO = A.WORK_NO \n";
			strSql += " 	AND A.SLIP_ID = B1.SLIP_ID(+)   \n";
			strSql += " 	AND A.SLIP_ID = B2.SLIP_ID(+)   \n";
			strSql += " 	AND A.SLIP_IDSEQ = B2.SLIP_IDSEQ(+)   \n";
			strSql += " 	AND A.TAX_COMP_CODE = C.COMP_CODE(+)  \n";
			strSql += " 	AND A.DEPT_CODE = D.DEPT_CODE(+)  \n";
			strSql += " 	AND A.CUST_SEQ = E.CUST_SEQ(+)  \n";
			strSql += " 	AND A.ACC_CODE = F.ACC_CODE(+)  \n";
			strSql += " 	AND A0.WORK_NO = ? \n";
			strSql += " 	AND A0.COMP_CODE =  ?  \n";
			strSql += " 	AND NVL(A.DEPT_CODE, ' ') LIKE  ? ||'%' \n";
			strSql += " 	AND NVL(E.CUST_CODE, ' ') LIKE  ? ||'%' \n";
			strSql += " 	AND NVL(A.VAT_CODE, ' ') LIKE  ? ||'%' \n";
			strSql += " 	AND NVL(A0.TAX_YEAR, ' ') LIKE  ? ||'%' \n";
			strSql += " 	AND NVL(F.SALEBUY_CLS, ' ') LIKE  ? ||'%' \n";
			strSql += " 	AND NVL(F.RCPTBILL_CLS, ' ') LIKE  ? ||'%' \n";
			strSql += " 	AND NVL(F.SUBTR_CLS, ' ') LIKE  ? ||'%' \n";
			strSql += " 	AND NVL(A.ACC_CODE, ' ') LIKE  ? ||'%' \n";
			if("P".equals(strDATE_CLS)){
				strSql += " 	AND A.PUBL_DT BETWEEN F_T_Stringtodate( ? ) AND F_T_Stringtodate( ? ) \n";
			} else if("M".equals(strDATE_CLS)){
				strSql += " 	AND B1.MAKE_DT BETWEEN F_T_Stringtodate( ? ) AND F_T_Stringtodate( ? ) \n";
			}
			strSql += " ORDER BY \n";
			strSql += " 	A0.COMP_CODE,   \n";
			strSql += " 	A0.TAX_YEAR, \n";
			strSql += " 	A0.TAX_GI, \n";
			strSql += " 	A0.TAX_CONF, \n";
			strSql += " 	A0.WORK_NO,  \n";
			if("P".equals(strDATE_CLS)){
				strSql += " 	A.PUBL_DT \n";
			} else if("M".equals(strDATE_CLS)){
				strSql += " 	B1.MAKE_DT \n";
			}
			strSql += "  ";

			lrArgData.addColumn("0WORK_NO", CITData.VARCHAR2);
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("3CUST_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("4VAT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("5TAX_YEAR", CITData.VARCHAR2);
			lrArgData.addColumn("6SALEBUY_CLS", CITData.VARCHAR2);
			lrArgData.addColumn("7RCPTBILL_CLS", CITData.VARCHAR2);
			lrArgData.addColumn("8SUBTR_CLS", CITData.VARCHAR2);
			lrArgData.addColumn("9ACC_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("10DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("11DT_T", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("0WORK_NO", strWORK_NO);
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("3CUST_CODE", strCUST_CODE);
			lrArgData.setValue("4VAT_CODE", strVAT_CODE);
			lrArgData.setValue("5TAX_YEAR", strTAX_YEAR);
			lrArgData.setValue("6SALEBUY_CLS", strSALEBUY_CLS);
			lrArgData.setValue("7RCPTBILL_CLS", strRCPTBILL_CLS);
			lrArgData.setValue("8SUBTR_CLS", strSUBTR_CLS);
			lrArgData.setValue("9ACC_CODE", strACC_CODE);
			lrArgData.setValue("10DT_F", strDT_F);
			lrArgData.setValue("11DT_T", strDT_T);

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("WORK_NO", true);
				lrReturnData.setKey("SEQ", true);
				lrReturnData.setNotNull("ACC_CODE", true);
				lrReturnData.setNotNull("TAX_COMP_CODE", true);
				lrReturnData.setNotNull("TAX_COMP_NAME", true);
				lrReturnData.setNotNull("RCPTBILL_CLS", true);
				lrReturnData.setNotNull("SALEBUY_CLS", true);
				lrReturnData.setNotNull("PUBL_DT", true);
				//lrReturnData.setNotNull("VAT_CODE", true);
				lrReturnData.setNotNull("CUST_CODE", true);
				lrReturnData.setNotNull("SUPAMT", true);
				lrReturnData.setNotNull("VATAMT", true);
				
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
		else if (strAct.equals("SEQ"))
		{
			strSql  = " Select SQ_T_ACC_TAX_BILL_MEDIA_SEQ.NEXTVAL SEQ From DUAL ";

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
				GauceInfo.response.writeException("USER", "900001","SLIP_IDSEQ Select 오류-> "+ ex.getMessage());
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
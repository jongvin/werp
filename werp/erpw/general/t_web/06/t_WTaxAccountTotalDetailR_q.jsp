<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
 
	CITGauceInfo GauceInfo = null;
	
	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;

	String	strSql = "";
	String	strAct = "";
	String	strUserNo = "";
	
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
			String strTAX_GI = CITCommon.toKOR(request.getParameter("TAX_GI"));
			String strTAX_CONF = CITCommon.toKOR(request.getParameter("TAX_CONF"));
			String strSALEBUY_CLS = CITCommon.toKOR(request.getParameter("SALEBUY_CLS"));
			String strRCPTBILL_CLS = CITCommon.toKOR(request.getParameter("RCPTBILL_CLS"));
			String strCUST_CODE = CITCommon.toKOR(request.getParameter("CUST_CODE"));
			
			strSql  = " SELECT    \n";
			strSql += " 	A0.COMP_CODE,   \n";
			strSql += " 	C1.COMPANY_NAME COMP_NAME,   \n";
			strSql += " 	A0.WORK_NO,  \n";
			strSql += " 	A0.TAX_YEAR, \n";
			strSql += " 	A0.TAX_GI, \n";
			strSql += " 	A0.TAX_CONF, \n";
			strSql += " 	A.SEQ,   \n";
			strSql += " 	A.TAX_COMP_CODE,   \n";
			strSql += " 	C.COMPANY_NAME TAX_COMP_NAME,   \n";
			strSql += " 	A.RCPTBILL_CLS,   \n";
			strSql += " 	A.SALEBUY_CLS,   \n";
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
			strSql += " 	A.SLIP_ID,   \n";
			strSql += " 	A.SLIP_IDSEQ,   \n";
			strSql += " 	B1.MAKE_SLIPNO||'-'||B2.MAKE_SLIPLINE MAKE_SLIPNOLINE,   \n";
			strSql += " 	A.ACC_CODE,   \n";
			strSql += " 	F.ACC_NAME,  \n";
			strSql += "     -- 전표조회 인자     \n";
			strSql += "     b1.MAKE_COMP_CODE ,      \n";
			strSql += "     F_T_Datetostring(b1.MAKE_DT) MAKE_DT,      \n";
			strSql += "     b1.MAKE_SEQ ,      \n";
			strSql += "     b1.SLIP_KIND_TAG    \n";
			strSql += " FROM \n";
			strSql += " 	T_ACC_SLIP_BILL_HEAD A0, \n";
			strSql += " 	T_ACC_TAX_BILL_MEDIA_RPT A,   \n";
			strSql += " 	T_ACC_SLIP_HEAD B1,  \n";
			strSql += " 	T_ACC_SLIP_BODY1 B2,  \n";
			strSql += " 	T_COMPANY C,  \n";
			strSql += " 	T_COMPANY C1,  \n";
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
			strSql += " 	AND A.COMP_CODE = C1.COMP_CODE(+)  \n";
			strSql += " 	AND A.DEPT_CODE = D.DEPT_CODE(+)  \n";
			strSql += " 	AND A.CUST_SEQ = E.CUST_SEQ(+)  \n";
			strSql += " 	AND A.ACC_CODE = F.ACC_CODE(+)  \n";
			strSql += " 	AND A0.APPLY_TAG = 'T' \n";
			strSql += " 	AND A.TAX_COMP_CODE =  ?  \n";
			strSql += " 	AND NVL(A0.TAX_YEAR, ' ') LIKE  ? ||'%' \n";
			strSql += " 	AND NVL(A0.TAX_GI, ' ') LIKE  ? ||'%' \n";
			strSql += " 	AND NVL(A0.TAX_CONF, ' ') LIKE  ? ||'%' \n";
			strSql += " 	AND NVL(A.SALEBUY_CLS, ' ') LIKE  ? ||'%' \n";
			strSql += " 	AND NVL(A.RCPTBILL_CLS, ' ') LIKE  ? ||'%' \n";
			strSql += " 	AND NVL(E.CUST_CODE, ' ') LIKE  ? ||'%' \n";
			strSql += " ORDER BY \n";
			strSql += " 	--A0.COMP_CODE,   \n";
			strSql += " 	--A0.WORK_NO,  \n";
			strSql += " 	A0.TAX_YEAR, \n";
			strSql += " 	A0.TAX_GI, \n";
			strSql += " 	A0.TAX_CONF, \n";
			strSql += " 	B1.MAKE_DT \n";
			strSql += "  ";
			
			lrArgData.addColumn("0COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("1TAX_YEAR", CITData.VARCHAR2);
			lrArgData.addColumn("2TAX_GI", CITData.VARCHAR2);
			lrArgData.addColumn("3TAX_CONF", CITData.VARCHAR2);
			lrArgData.addColumn("4SALEBUY_CLS", CITData.VARCHAR2);
			lrArgData.addColumn("5RCPTBILL_CLS", CITData.VARCHAR2);
			lrArgData.addColumn("6CUST_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("0COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("1TAX_YEAR", strTAX_YEAR);
			lrArgData.setValue("2TAX_GI", strTAX_GI);
			lrArgData.setValue("3TAX_CONF", strTAX_CONF);
			lrArgData.setValue("4SALEBUY_CLS", strSALEBUY_CLS);
			lrArgData.setValue("5RCPTBILL_CLS", strRCPTBILL_CLS);
			lrArgData.setValue("6CUST_CODE", strCUST_CODE);
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
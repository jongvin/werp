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
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MAIN"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strTAX_YEAR = CITCommon.toKOR(request.getParameter("TAX_YEAR"));
			
			strSql  = " SELECT \n";
			strSql += " 	COMP_CODE, \n";
			strSql += " 	WORK_NO, \n";
			strSql += " 	F_T_DateToString(WORK_DATE) WORK_DATE, \n";
			strSql += " 	TAX_YEAR, \n";
			strSql += " 	TAX_GI, \n";
			strSql += " 	TAX_CONF, \n";
			strSql += " 	F_T_DateToString(BASE_DT_F) BASE_DT_F, \n";
			strSql += " 	F_T_DateToString(BASE_DT_T) BASE_DT_T, \n";
			strSql += " 	F_T_DateToString(MISSING_PROCESS_DT_F) MISSING_PROCESS_DT_F, \n";
			strSql += " 	APPLY_TAG, \n";
			strSql += " 	REMARKS \n";
			strSql += "  FROM  \n";
			strSql += "  	T_ACC_SLIP_BILL_HEAD \n";
			strSql += "  WHERE  \n";
			strSql += "		COMP_CODE =  ?  \n";
			strSql += " 	AND TAX_YEAR LIKE   ?  \n";
			strSql += "  ORDER BY  \n";
			strSql += "  	COMP_CODE,  \n";
			strSql += " 	TAX_YEAR, \n";
			strSql += " 	TAX_GI, \n";
			strSql += " 	TAX_CONF, \n";
			strSql += " 	WORK_DATE ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2TAX_YEAR", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2TAX_YEAR", strTAX_YEAR);

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setNotNull("COMP_CODE", true);
				lrReturnData.setNotNull("WORK_NO", true);
				lrReturnData.setNotNull("WORK_DATE", true);
				lrReturnData.setKey("TAX_YEAR", true);
				lrReturnData.setKey("TAX_GI", true);
				lrReturnData.setKey("TAX_CONF", true);
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
			String strACC_CODE = CITCommon.toKOR(request.getParameter("ACC_CODE"));
			
			strSql  = " SELECT    \n";
			strSql += "   	A.COMP_CODE,   \n";
			strSql += "   	A.WORK_NO,   \n";
			strSql += "   	A.SEQ,   \n";
			strSql += "   	A.TAX_COMP_CODE,   \n";
			strSql += "   	C.COMPANY_NAME TAX_COMP_NAME,   \n";
			strSql += "   	F.RCPTBILL_CLS,   \n";
			strSql += "   	F.SALEBUY_CLS,   \n";
			strSql += " 	F.SUBTR_CLS,   \n";
			strSql += " 	NVL(A.COMMBUY_CLS,'F') COMMBUY_CLS,   \n";
			strSql += "   	F_T_DATETOSTRING(A.PUBL_DT) PUBL_DT,   \n";
			strSql += "   	A.VAT_CODE,   \n";
			strSql += "   	A.BOOK_NO,   \n";
			strSql += "   	A.BOOK_SEQ,   \n";
			strSql += "   	A.DEPT_CODE,   \n";
			strSql += "   	D.DEPT_NAME,   \n";
			strSql += "   	A.CUST_SEQ,   \n";
			strSql += "   	E.CUST_CODE,   \n";
			strSql += "   	E.CUST_NAME,   \n";
			strSql += "   	A.SUPAMT,   \n";
			strSql += "   	A.VATAMT,   \n";
			strSql += "   	A.ANNULMENT_CLS,   \n";
			strSql += "   	A.ANNULMENT_DT,   \n";
			strSql += "   	A.OUT_CNT,   \n";
			strSql += "   	A.MISSING_TAG,   \n";
			strSql += "   	A.REMARK,   \n";
			strSql += "   	A.UDT_TAG,   \n";
			strSql += "   	A.CARD_CASH_NO,   \n";
			strSql += "   	A.SLIP_ID,   \n";
			strSql += "   	A.SLIP_IDSEQ,   \n";
			strSql += "   	B1.MAKE_SLIPNO||'-'||B2.MAKE_SLIPLINE MAKE_SLIPNOLINE,   \n";
			strSql += "   	A.ACC_CODE,   \n";
			strSql += "   	F.ACC_NAME,  \n";
			strSql += "     -- 전표조회 인자     \n";
			strSql += "     b1.MAKE_COMP_CODE ,      \n";
			strSql += "     F_T_Datetostring(b1.MAKE_DT) MAKE_DT,      \n";
			strSql += "     b1.MAKE_SEQ ,      \n";
			strSql += "     b1.SLIP_KIND_TAG   \n";
			strSql += "   FROM    \n";
			strSql += "   	T_ACC_TAX_BILL_MEDIA A,   \n";
			strSql += "   	T_ACC_SLIP_HEAD B1,  \n";
			strSql += "  	T_ACC_SLIP_BODY1 B2,  \n";
			strSql += "  	T_COMPANY C,  \n";
			strSql += "  	T_DEPT_CODE_ORG D,  \n";
			strSql += "  	T_CUST_CODE E,  \n";
			strSql += "  	T_ACC_CODE_VIEW F  \n";
			strSql += "   WHERE   \n";
			strSql += "   	A.SLIP_ID = B1.SLIP_ID(+)   \n";
			strSql += "  	AND A.SLIP_ID = B2.SLIP_ID(+)   \n";
			strSql += "   	AND A.SLIP_IDSEQ = B2.SLIP_IDSEQ(+)   \n";
			strSql += "  	AND A.TAX_COMP_CODE = C.COMP_CODE(+)  \n";
			strSql += "  	AND A.DEPT_CODE = D.DEPT_CODE(+)  \n";
			strSql += "   	AND A.CUST_SEQ = E.CUST_SEQ(+)  \n";
			strSql += "   	AND A.ACC_CODE = F.ACC_CODE(+)  \n";
			strSql += "   	AND A.COMP_CODE =    ?     \n";
			strSql += "   	AND A.WORK_NO =    ?    \n";
			strSql += "   	AND NVL(F.ACC_CODE, ' ')||NVL(F.ACC_NAME, ' ') LIKE    ?   ||'%'  \n";
			strSql += "   ORDER BY   \n";
			strSql += "   	B1.MAKE_DT   \n";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2WORK_NO", CITData.VARCHAR2);
			lrArgData.addColumn("3ACC_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2WORK_NO", strWORK_NO);
			lrArgData.setValue("3ACC_CODE", strACC_CODE);
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
		else if (strAct.equals("WORK_NO"))
		{
			strSql  = " Select SQ_T_ACC_SLIP_BILL_WORK_NO.NEXTVAL WORK_NO From DUAL ";

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
				GauceInfo.response.writeException("USER", "900001","SLIP_ID Select 오류-> "+ ex.getMessage());
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
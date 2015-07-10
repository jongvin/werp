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
			
			strSql  = " SELECT \n";
			strSql += " 	A.COMP_CODE, \n";
			strSql += " 	A.WORK_NO, \n";
			strSql += " 	A.SEQ, \n";
			strSql += " 	A.DIV_COMP_CODE, \n";
			strSql += " 	A.DIV_CODE, \n";
			strSql += " 	B.DIV_NAME, \n";
			strSql += " 	A.DIV_RATIO, \n";
			strSql += " 	A.CUR_DIV_RATIO, \n";
			strSql += " 	A.GONG_DIV_RATIO, \n";
			strSql += " 	A.PRE_DIV_RATIO, \n";
			strSql += " 	A.CUR_DIV_ACC_AMT, \n";
			strSql += " 	A.CUR_DIV_TAX_AMT \n";
			strSql += " FROM \n";
			strSql += " 	T_ACC_VAT_DIV_HIST A, \n";
			strSql += " 	T_ACC_VAT_DIV_CODE B \n";
			strSql += " WHERE \n";
			strSql += " 	A.DIV_COMP_CODE = B.DIV_COMP_CODE \n";
			strSql += " 	AND A.DIV_CODE = B.DIV_CODE \n";
			strSql += " 	--AND B.USE_TAG = 'T' \n";
			strSql += " 	AND A.COMP_CODE =  ?  \n";
			strSql += " 	AND A.WORK_NO =  ?  \n";
			strSql += " ORDER BY \n";
			strSql += " 	A.COMP_CODE, \n";
			strSql += " 	A.WORK_NO, \n";
			strSql += " 	A.DIV_CODE \n";
			strSql += "  ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2WORK_NO", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2WORK_NO", strWORK_NO);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("WORK_NO", true);
				lrReturnData.setKey("SEQ", true);
				lrReturnData.setKey("DIV_COMP_CODE", true);
				lrReturnData.setKey("DIV_CODE", true);
				lrReturnData.setKey("DIV_NAME", true);
				lrReturnData.setNotNull("DIV_RATIO", true);
				lrReturnData.setNotNull("CUR_DIV_RATIO", true);
				lrReturnData.setNotNull("GONG_DIV_RATIO", true);
				lrReturnData.setNotNull("PRE_DIV_RATIO", true);

				lrReturnData.setScale("DIV_RATIO", 2);
				lrReturnData.setScale("CUR_DIV_RATIO", 2);
				lrReturnData.setScale("GONG_DIV_RATIO", 2);
				lrReturnData.setScale("PRE_DIV_RATIO", 2);




				
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
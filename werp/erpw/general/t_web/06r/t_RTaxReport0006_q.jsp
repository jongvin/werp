<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id :
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 :
/* 4. 변  경  이  력 : 한재원 작성(2005-01-11)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/

	CITGauceInfo GauceInfo = null;

	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;
	String  strSql = "";
	String  strAct = "";
	String  strUserNo = "";
	String  ssCompCode = "";
	String  ssDeptCode = "";
	String  ssDeptName = "";
	String  ssPrivLevel ="";
	String  ssDeptShortName ="";
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		ssCompCode = CITCommon.toKOR((String)session.getAttribute("comp_code"));
		ssDeptCode = CITCommon.toKOR((String)session.getAttribute("dept_code"));
		ssDeptName = CITCommon.toKOR((String)session.getAttribute("long_name"));

		CITData lrArgData = new CITData();

		strAct = CITCommon.toKOR(request.getParameter("ACT"));

		/*
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
			strSql += " 		AND A.APPLY_TAG = 'T' \n";
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
		*/

		if (strAct.equals("MAIN"))
		{
			strSql  = " SELECT  \n";
			strSql += "  	A.CODE_LIST_ID TAX_GI,  \n";
			strSql += "  	B.CODE_LIST_ID TAX_CONF,  \n";
			strSql += " 	A.CODE_LIST_NAME||' '||B.CODE_LIST_NAME WORK_NAME, \n";
			strSql += " 		CASE \n";
			strSql += " 			WHEN A.CODE_LIST_ID='1' AND B.CODE_LIST_ID='1' THEN '01-01' \n";
			strSql += " 			WHEN A.CODE_LIST_ID='1' AND B.CODE_LIST_ID='2' THEN '04-01' \n";
			strSql += " 			WHEN A.CODE_LIST_ID='2' AND B.CODE_LIST_ID='1' THEN '07-01' \n";
			strSql += " 			WHEN A.CODE_LIST_ID='2' AND B.CODE_LIST_ID='2' THEN '10-01' \n";
			strSql += " 		END DT_F, \n";
			strSql += " 		CASE \n";
			strSql += " 			WHEN A.CODE_LIST_ID='1' AND B.CODE_LIST_ID='1' THEN '03-31' \n";
			strSql += " 			WHEN A.CODE_LIST_ID='1' AND B.CODE_LIST_ID='2' THEN '06-30' \n";
			strSql += " 			WHEN A.CODE_LIST_ID='2' AND B.CODE_LIST_ID='1' THEN '09-30' \n";
			strSql += " 			WHEN A.CODE_LIST_ID='2' AND B.CODE_LIST_ID='2' THEN '12-31' \n";
			strSql += " 		END DT_T \n";
			strSql += "   FROM   \n";
			strSql += " 	( \n";
			strSql += " 		SELECT \n";
			strSql += " 			CODE_LIST_ID, CODE_LIST_NAME  \n";
			strSql += " 		FROM \n";
			strSql += " 			V_T_CODE_LIST \n";
			strSql += " 		WHERE \n";
			strSql += " 			CODE_GROUP_ID = 'TAX_GI' \n";
			strSql += " 	) A, \n";
			strSql += " 	( \n";
			strSql += " 		SELECT \n";
			strSql += " 			CODE_LIST_ID, CODE_LIST_NAME  \n";
			strSql += " 		FROM \n";
			strSql += " 			V_T_CODE_LIST \n";
			strSql += " 		WHERE \n";
			strSql += " 			CODE_GROUP_ID = 'TAX_CONF' \n";
			strSql += " 	) B \n";
			strSql += " ORDER BY   \n";
			strSql += "		A.CODE_LIST_ID, \n";
			strSql += " 	B.CODE_LIST_ID \n";
			

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
		if (GauceInfo != null)
		{
			GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
		}
		else
		{
			throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
		}
	}
	finally
	{
		try
		{
			CITCommon.finalServerPage(GauceInfo);
		}
		catch (Exception ex)
		{
			if (GauceInfo != null)
			{
				GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
			}
			else
			{
				throw new Exception("SYS-100002:페이지 종료 오류 -> " + ex.getMessage());
			}
		}
	}
%>

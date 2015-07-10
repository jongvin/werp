<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-25)
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
			String strSEARCH_CONDITION = CITCommon.toKOR(request.getParameter("SEARCH_CONDITION"));
			
			strSql  = " SELECT \n";
			strSql += " 	ACC_GRP_CODE, \n";
			strSql += " 	ACC_GRP_NAME, \n";
			strSql += " 	REMARK, \n";
			strSql += " 	USE_TAG \n";
			strSql += " FROM \n";
			strSql += " 	T_ACC_GRP ";
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("ACC_GRP_CODE", true);
				lrReturnData.setNotNull("ACC_GRP_NAME", true);

				
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
			String strACC_GRP_CODE = CITCommon.toKOR(request.getParameter("ACC_GRP_CODE"));
			
			strSql  = " SELECT \n";
			strSql += "  	'F' CHK_CLS,  \n";
			strSql += " 	B.ACC_GRP_CODE, \n";
			strSql += "  	A.ACC_CODE ,  \n";
			strSql += "  	A.ACC_NAME ,   \n";
			strSql += "  	A.ACC_SHRT_NAME ,  \n";
			strSql += "  	A.COMPUTER_ACC ,   \n";
			strSql += "  	A.ACC_GRP ,   \n";
			strSql += "  	A.ACC_LVL ,   \n";
			strSql += "  	A.ACC_REMAIN_POSITION ,   \n";
			strSql += "  	NVL(A.FUND_INPUT_CLS,'F') FUND_INPUT_CLS  \n";
			strSql += "  FROM   \n";
			strSql += "  	T_ACC_CODE A,  \n";
			strSql += "  	T_GRP_ACC_CODE B  \n";
			strSql += "  WHERE  \n";
			strSql += "  	A.ACC_CODE = B.ACC_CODE(+) \n";
			strSql += "  	AND ? = B.ACC_GRP_CODE(+) \n";
			strSql += " 	AND B.ACC_GRP_CODE IS NOT NULL \n";
			strSql += "  ORDER BY   \n";
			strSql += "  	A.ACC_CODE  ";

			
			lrArgData.addColumn("ACC_GRP_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("ACC_GRP_CODE", strACC_GRP_CODE);
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
		else if (strAct.equals("SUB02"))
		{
			String strACC_GRP_CODE = CITCommon.toKOR(request.getParameter("ACC_GRP_CODE"));
			
			strSql  = " SELECT  \n";
			strSql += "   	'F' CHK_CLS,  \n";
			strSql += "  	? ACC_GRP_CODE,  \n";
			strSql += "   	A.ACC_CODE ,  \n";
			strSql += "   	A.ACC_NAME ,  \n";
			strSql += "   	A.ACC_SHRT_NAME ,  \n";
			strSql += "   	A.COMPUTER_ACC ,  \n";
			strSql += "   	A.ACC_GRP ,  \n";
			strSql += "   	A.ACC_LVL ,  \n";
			strSql += "   	A.ACC_REMAIN_POSITION ,  \n";
			strSql += "   	NVL(A.FUND_INPUT_CLS,'F') FUND_INPUT_CLS  \n";
			strSql += "   FROM  \n";
			strSql += "   	T_ACC_CODE A,  \n";
			strSql += "   	T_GRP_ACC_CODE B  \n";
			strSql += "   WHERE  \n";
			strSql += "   	A.ACC_CODE = B.ACC_CODE(+)  \n";
			strSql += "   	AND ? = B.ACC_GRP_CODE(+)  \n";
			strSql += "  	AND B.ACC_GRP_CODE IS NULL  \n";
			strSql += " 	AND \n";
			strSql += " 	( \n";
			strSql += " 		NVL(A.FUND_INPUT_CLS, 'F') = 'T' \n";
			strSql += " 	 	OR \n";
			strSql += " 	 	(  \n";
			strSql += " 	 		SELECT  \n";
			strSql += " 	 		 	COUNT(*)  \n";
			strSql += " 	 		 FROM  \n";
			strSql += " 	 		 	T_ACC_CODE Ai,  \n";
			strSql += " 	 		 	T_GRP_ACC_CODE Bi,  \n";
			strSql += " 				T_ACC_CODE_CHILD Ci  \n";
			strSql += " 	 		 WHERE  \n";
			strSql += " 	 		 	Ai.ACC_CODE = Bi.ACC_CODE(+)  \n";
			strSql += " 	 		 	AND ? = Bi.ACC_GRP_CODE(+)  \n";
			strSql += " 	 			AND Bi.ACC_GRP_CODE IS NULL  \n";
			strSql += " 	 			AND NVL(Ai.FUND_INPUT_CLS, 'F') = 'T'  \n";
			strSql += " 				AND Ai.ACC_CODE = Ci.CHILD_ACC_CODE \n";
			strSql += " 				AND Ci.PARENT_ACC_CODE = A.ACC_CODE \n";
			strSql += " 	 	) > 0  \n";
			strSql += " 	) \n";
			strSql += "   ORDER BY  \n";
			strSql += "   	A.ACC_CODE ";

			
			
			lrArgData.addColumn("ACC_GRP_CODE1", CITData.VARCHAR2);
			lrArgData.addColumn("ACC_GRP_CODE2", CITData.VARCHAR2);
			lrArgData.addColumn("ACC_GRP_CODE3", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("ACC_GRP_CODE1", strACC_GRP_CODE);
			lrArgData.setValue("ACC_GRP_CODE2", strACC_GRP_CODE);
			lrArgData.setValue("ACC_GRP_CODE3", strACC_GRP_CODE);
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

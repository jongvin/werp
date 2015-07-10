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
			String strACC_CODE = CITCommon.toKOR(request.getParameter("ACC_CODE"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strCUST_SEQ = CITCommon.toKOR(request.getParameter("CUST_SEQ"));
			String strBANK_CODE = CITCommon.toKOR(request.getParameter("BANK_CODE"));
			String strDT_F = CITCommon.toKOR(request.getParameter("DT_F"));
			String strDT_T = CITCommon.toKOR(request.getParameter("DT_T"));
			String strDEPT_MNG     = CITCommon.toKOR(request.getParameter("DEPT_MNG"));
			String strCUST_CODE_MNG     = CITCommon.toKOR(request.getParameter("CUST_CODE_MNG"));
			String strLOAN_MNG     = CITCommon.toKOR(request.getParameter("LOAN_MNG"));
			String strMNG_TG_CHAR1 = CITCommon.toKOR(request.getParameter("MNG_TG_CHAR1"));
			String strMNG_TG_CHAR2 = CITCommon.toKOR(request.getParameter("MNG_TG_CHAR2"));
			String strMNG_TG_CHAR3 = CITCommon.toKOR(request.getParameter("MNG_TG_CHAR3"));
			String strMNG_TG_CHAR4 = CITCommon.toKOR(request.getParameter("MNG_TG_CHAR4"));
			String strMNG_TG_NUM1  = CITCommon.toKOR(request.getParameter("MNG_TG_NUM1"));
			String strMNG_TG_NUM2  = CITCommon.toKOR(request.getParameter("MNG_TG_NUM2"));
			String strMNG_TG_NUM3  = CITCommon.toKOR(request.getParameter("MNG_TG_NUM3"));
			String strMNG_TG_NUM4  = CITCommon.toKOR(request.getParameter("MNG_TG_NUM4"));
			String strMNG_TG_DT1   = CITCommon.toKOR(request.getParameter("MNG_TG_DT1"));
			String strMNG_TG_DT2   = CITCommon.toKOR(request.getParameter("MNG_TG_DT2"));
			String strMNG_TG_DT3   = CITCommon.toKOR(request.getParameter("MNG_TG_DT3"));
			String strMNG_TG_DT4   = CITCommon.toKOR(request.getParameter("MNG_TG_DT4"));
			
			strSql  = " SELECT \n";
			if("T".equals(strCUST_CODE_MNG))		strSql += " 	F_T_CUST_MASK(c.CUST_CODE) CUST_CODE,   \n";
			if("T".equals(strCUST_CODE_MNG))		strSql += " 	c.CUST_NAME,   \n";
			if("T".equals(strLOAN_MNG))		strSql += " 	f.BANK_NAME,   \n";
			if("T".equals(strDEPT_MNG))     strSql += " 	e.DEPT_NAME, \n";
			strSql += " 	A.* \n";
			strSql += " FROM \n";
			strSql += " ( \n";
			strSql += " 	SELECT    \n";
			strSql += " 		 ? ACC_CODE ,  \n";
			if("T".equals(strCUST_CODE_MNG)) strSql += " 	A1.CUST_SEQ ,  \n";
			if("T".equals(strDEPT_MNG))     strSql += " 	A1.DEPT_CODE ,  \n";
			if("T".equals(strLOAN_MNG))     strSql += " 	A1.BANK_CODE ,  \n";
			if("T".equals(strMNG_TG_CHAR1)) strSql += " 	A2.MNG_ITEM_CHAR1 , \n";
			if("T".equals(strMNG_TG_CHAR2)) strSql += " 	A2.MNG_ITEM_CHAR2 , \n";
			if("T".equals(strMNG_TG_CHAR3)) strSql += " 	A2.MNG_ITEM_CHAR3 , \n";
			if("T".equals(strMNG_TG_CHAR4)) strSql += " 	A2.MNG_ITEM_CHAR4 , \n";
			if("T".equals(strMNG_TG_NUM1))  strSql += " 	A2.MNG_ITEM_NUM1, \n";
			if("T".equals(strMNG_TG_NUM2))  strSql += " 	A2.MNG_ITEM_NUM2, \n";
			if("T".equals(strMNG_TG_NUM3))  strSql += " 	A2.MNG_ITEM_NUM3, \n";
			if("T".equals(strMNG_TG_NUM4))  strSql += " 	A2.MNG_ITEM_NUM4, \n";
			if("T".equals(strMNG_TG_DT1))   strSql += " 	A2.MNG_ITEM_DT1 , \n";
			if("T".equals(strMNG_TG_DT2))   strSql += " 	A2.MNG_ITEM_DT2 , \n";
			if("T".equals(strMNG_TG_DT3))   strSql += " 	A2.MNG_ITEM_DT3 , \n";
			if("T".equals(strMNG_TG_DT4))   strSql += " 	A2.MNG_ITEM_DT4 ,  \n";
			strSql += " 		SUM(A1.DB_AMT) DB_AMT,  \n";
			strSql += " 		SUM(A1.CR_AMT) CR_AMT \n";
			strSql += " 	FROM  \n";
			strSql += " 		T_ACC_SLIP_BODY1 A1,   \n";
			strSql += " 		T_ACC_SLIP_BODY2 A2,   \n";
			strSql += " 	 	(  \n";
			strSql += " 	 		SELECT                         \n";
			strSql += " 	 			DISTINCT B.ACC_CODE  \n";
			strSql += " 	 		FROM  \n";
			strSql += " 	 			T_ACC_CODE_CHILD A,  \n";
			strSql += " 	 			T_ACC_CODE B  \n";
			strSql += " 	 		WHERE  \n";
			strSql += " 	 			B.FUND_INPUT_CLS = 'T'  \n";
			strSql += " 	 			AND A.CHILD_ACC_CODE = B.ACC_CODE  \n";
			strSql += " 	 			AND A.PARENT_ACC_CODE LIKE   ?   || '%'  \n";
			strSql += " 	 		UNION  \n";
			strSql += " 	 		SELECT  \n";
			strSql += " 	 			B.ACC_CODE  \n";
			strSql += " 	 		FROM  \n";
			strSql += " 	 			T_ACC_CODE B  \n";
			strSql += " 	 		WHERE  \n";
			strSql += " 	 			B.FUND_INPUT_CLS = 'T'  \n";
			strSql += " 	 			AND B.ACC_CODE LIKE   ?   || '%'  \n";
			strSql += " 	 	) B \n";
			strSql += " 	WHERE   \n";
			strSql += " 	 	A1.SLIP_ID = A2.SLIP_ID  \n";
			strSql += " 	 	AND A1.SLIP_IDSEQ = A2.SLIP_IDSEQ  \n";
			strSql += " 	 	AND A1.ACC_CODE = B.ACC_CODE  \n";
			strSql += " 	 	AND   \n";
			strSql += " 		(  \n";
			strSql += " 			(   \n";
			strSql += " 			  	( A1.MAKE_DT BETWEEN F_T_StringToDate(  ?  ) AND F_T_StringToDate(   ?  ) )  \n";
			strSql += " 			  	AND  \n";
			strSql += " 				( A1.TRANSFER_TAG = 'F' )  \n";
			strSql += " 			)  \n";
			strSql += " 		)  \n";
			strSql += " 		AND A1.COMP_CODE LIKE   ?  ||'%'    \n";
			strSql += " 		AND A1.DEPT_CODE LIKE   ?  ||'%'    \n";
			if(!"".equals(strCUST_SEQ))		strSql += " 		AND A1.CUST_SEQ = ?    \n";
			if(!"".equals(strBANK_CODE))	strSql += " 		AND A1.BANK_CODE = ?  \n";
			strSql += " 		AND A1.KEEP_DT IS NOT NULL  \n";
			strSql += " 		--AND A1.SLIP_KIND_TAG <> 'D'  \n";
			strSql += " 	GROUP BY  \n";
			strSql += " 		 ?  ,   \n";
			if("T".equals(strCUST_CODE_MNG)) strSql += " 	A1.CUST_SEQ ,  \n";
			if("T".equals(strDEPT_MNG))     strSql += " 	A1.DEPT_CODE ,  \n";
			if("T".equals(strLOAN_MNG))     strSql += " 	A1.BANK_CODE ,  \n";
			if("T".equals(strMNG_TG_CHAR1)) strSql += " 	A2.MNG_ITEM_CHAR1 , \n";
			if("T".equals(strMNG_TG_CHAR2)) strSql += " 	A2.MNG_ITEM_CHAR2 , \n";
			if("T".equals(strMNG_TG_CHAR3)) strSql += " 	A2.MNG_ITEM_CHAR3 , \n";
			if("T".equals(strMNG_TG_CHAR4)) strSql += " 	A2.MNG_ITEM_CHAR4 , \n";
			if("T".equals(strMNG_TG_NUM1))  strSql += " 	A2.MNG_ITEM_NUM1 , \n";
			if("T".equals(strMNG_TG_NUM2))  strSql += " 	A2.MNG_ITEM_NUM2 , \n";
			if("T".equals(strMNG_TG_NUM3))  strSql += " 	A2.MNG_ITEM_NUM3 , \n";
			if("T".equals(strMNG_TG_NUM4))  strSql += " 	A2.MNG_ITEM_NUM4 , \n";
			if("T".equals(strMNG_TG_DT1))   strSql += " 	A2.MNG_ITEM_DT1 , \n";
			if("T".equals(strMNG_TG_DT2))   strSql += " 	A2.MNG_ITEM_DT2 , \n";
			if("T".equals(strMNG_TG_DT3))   strSql += " 	A2.MNG_ITEM_DT3 , \n";
			if("T".equals(strMNG_TG_DT4))   strSql += " 	A2.MNG_ITEM_DT4 , \n";
			strSql += " 		'' \n";
			strSql += " 	ORDER BY  \n";
			strSql += " 		 ?   ,   \n";
			if("T".equals(strCUST_CODE_MNG)) strSql += " 	A1.CUST_SEQ ,  \n";
			if("T".equals(strDEPT_MNG))     strSql += " 	A1.DEPT_CODE ,  \n";
			if("T".equals(strLOAN_MNG))     strSql += " 	A1.BANK_CODE ,  \n";
			if("T".equals(strMNG_TG_CHAR1)) strSql += " 	A2.MNG_ITEM_CHAR1 , \n";
			if("T".equals(strMNG_TG_CHAR2)) strSql += " 	A2.MNG_ITEM_CHAR2 , \n";
			if("T".equals(strMNG_TG_CHAR3)) strSql += " 	A2.MNG_ITEM_CHAR3 , \n";
			if("T".equals(strMNG_TG_CHAR4)) strSql += " 	A2.MNG_ITEM_CHAR4 , \n";
			if("T".equals(strMNG_TG_NUM1))  strSql += " 	A2.MNG_ITEM_NUM1 , \n";
			if("T".equals(strMNG_TG_NUM2))  strSql += " 	A2.MNG_ITEM_NUM2 , \n";
			if("T".equals(strMNG_TG_NUM3))  strSql += " 	A2.MNG_ITEM_NUM3 , \n";
			if("T".equals(strMNG_TG_NUM4))  strSql += " 	A2.MNG_ITEM_NUM4 , \n";
			if("T".equals(strMNG_TG_DT1))   strSql += " 	A2.MNG_ITEM_DT1 , \n";
			if("T".equals(strMNG_TG_DT2))   strSql += " 	A2.MNG_ITEM_DT2 , \n";
			if("T".equals(strMNG_TG_DT3))   strSql += " 	A2.MNG_ITEM_DT3 , \n";
			if("T".equals(strMNG_TG_DT4))   strSql += " 	A2.MNG_ITEM_DT4 , \n";
			strSql += " 	 	'' \n";
			strSql += " ) A \n";
			if("T".equals(strDEPT_MNG))     strSql += " ,T_DEPT_CODE E   \n";
			if("T".equals(strCUST_CODE_MNG))		strSql += " ,T_CUST_CODE C  \n";
			if("T".equals(strLOAN_MNG))	strSql += " ,T_BANK_CODE F   \n";
			strSql += " WHERE \n";
			strSql += " 	A.ACC_CODE IS NOT NULL  \n";
			if("T".equals(strDEPT_MNG))     strSql += " 	AND A.DEPT_CODE = E.DEPT_CODE (+)  \n";
			if("T".equals(strCUST_CODE_MNG))		strSql += " 	AND A.CUST_SEQ = C.CUST_SEQ (+)  \n";
			if("T".equals(strLOAN_MNG))	strSql += " 	AND A.BANK_CODE = F.BANK_CODE(+)   ";
			
			lrArgData.addColumn("1ACC_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2ACC_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("3ACC_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("4DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("5DT_T", CITData.VARCHAR2);
			lrArgData.addColumn("6COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("7DEPT_CODE", CITData.VARCHAR2);
			if(!"".equals(strCUST_SEQ))		lrArgData.addColumn("8CUST_SEQ", CITData.VARCHAR2);
			if(!"".equals(strBANK_CODE))	lrArgData.addColumn("9BANK_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("10ACC_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("11ACC_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1ACC_CODE", strACC_CODE);
			lrArgData.setValue("2ACC_CODE", strACC_CODE);
			lrArgData.setValue("3ACC_CODE", strACC_CODE);
			lrArgData.setValue("4DT_F", strDT_F);
			lrArgData.setValue("5DT_T", strDT_T);
			lrArgData.setValue("6COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("7DEPT_CODE", strDEPT_CODE);
			if(!"".equals(strCUST_SEQ))		lrArgData.setValue("8CUST_SEQ", strCUST_SEQ);
			if(!"".equals(strBANK_CODE))	lrArgData.setValue("9BANK_CODE", strBANK_CODE);
			lrArgData.setValue("10ACC_CODE", strACC_CODE);
			lrArgData.setValue("11ACC_CODE", strACC_CODE);
                                     
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
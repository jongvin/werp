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

	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* 세션정보 */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));

		String	strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
		String	strTAX_YEAR = CITCommon.toKOR(request.getParameter("TAX_YEAR"));
		String	strTAX_GI = CITCommon.toKOR(request.getParameter("TAX_GI"));
		String	strTAX_CONF = CITCommon.toKOR(request.getParameter("TAX_CONF"));
		String	strRCPTBILL_CLS = CITCommon.toKOR(request.getParameter("RCPTBILL_CLS"));

		String	strPUBL_DT_FR = "";
		String	strPUBL_DT_TO = "";

		String	strWriteDt = CITCommon.toKOR(request.getParameter("WRITE_DT"));

		if("1".equals(strTAX_GI)){
			if("1".equals(strTAX_CONF)){
				strPUBL_DT_FR = strTAX_YEAR+"0101";
				strPUBL_DT_TO = strTAX_YEAR+"0331";
			} else if("2".equals(strTAX_CONF)){
				strPUBL_DT_FR = strTAX_YEAR+"0401";
				strPUBL_DT_TO = strTAX_YEAR+"0630";
			}
		} else if("2".equals(strTAX_GI)){
			if("1".equals(strTAX_CONF)){
				strPUBL_DT_FR = strTAX_YEAR+"0701";
				strPUBL_DT_TO = strTAX_YEAR+"0930";
			} else if("2".equals(strTAX_CONF)){
				strPUBL_DT_FR = strTAX_YEAR+"1001";
				strPUBL_DT_TO = strTAX_YEAR+"1231";
			}
		}

		String	strSqlSrc = "";
		String	strSqlSrc01 = "";
		String	strSqlSrc02 = "";

		strSqlSrc  += "	( \n";
		strSqlSrc  += "	SELECT \n";
		strSqlSrc  += "		B.* \n";
		strSqlSrc  += "	FROM \n";
		strSqlSrc  += "		T_ACC_SLIP_BILL_HEAD A, \n";
		strSqlSrc  += "		T_ACC_TAX_BILL_MEDIA_RPT B \n";
		strSqlSrc  += "	WHERE \n";
		strSqlSrc  += "		A.COMP_CODE = B.COMP_CODE \n";
		strSqlSrc  += "		AND A.WORK_NO = B.WORK_NO \n";
		strSqlSrc  += "		AND A.APPLY_TAG = 'T' \n";
		strSqlSrc  += "		AND A.TAX_YEAR = '"+strTAX_YEAR+"' \n";
		strSqlSrc  += "		AND A.TAX_GI = '"+strTAX_GI+"' \n";
		strSqlSrc  += "		AND A.TAX_CONF = '"+strTAX_CONF+"' \n";
		strSqlSrc  += "		AND B.TAX_COMP_CODE = '"+strCOMP_CODE+"' \n";
		strSqlSrc  += "		AND B.RCPTBILL_CLS =  '"+strRCPTBILL_CLS+"' \n";
		strSqlSrc  += "	) \n";

		strSqlSrc01   = "	( \n";
		strSqlSrc01  += "	SELECT \n";
		//strSqlSrc01  += "		DISTINCT A.COMP_CODE \n";
		strSqlSrc01  += "		DISTINCT B.TAX_COMP_CODE \n";
		strSqlSrc01  += "	FROM \n";
		strSqlSrc01  += "		T_ACC_SLIP_BILL_HEAD A, \n";
		strSqlSrc01  += "		T_ACC_TAX_BILL_MEDIA_RPT B \n";
		strSqlSrc01  += "	WHERE \n";
		strSqlSrc01  += "		A.COMP_CODE = B.COMP_CODE \n";
		strSqlSrc01  += "		AND A.WORK_NO = B.WORK_NO \n";
		strSqlSrc01  += "		AND A.APPLY_TAG = 'T' \n";
		strSqlSrc01  += "		AND A.TAX_YEAR = '"+strTAX_YEAR+"' \n";
		strSqlSrc01  += "		AND A.TAX_GI = '"+strTAX_GI+"' \n";
		strSqlSrc01  += "		AND A.TAX_CONF = '"+strTAX_CONF+"' \n";
		strSqlSrc01  += "		AND B.TAX_COMP_CODE = '"+strCOMP_CODE+"' \n";
		strSqlSrc01  += "		AND B.RCPTBILL_CLS =  '"+strRCPTBILL_CLS+"' \n";
		strSqlSrc01  += "	) \n";

		strSqlSrc02   = "	( \n";
		strSqlSrc02  += "	SELECT \n";
		strSqlSrc02  += "		''||COUNT(*) \n";
		strSqlSrc02  += "	FROM \n";
		strSqlSrc02  += "		"+strSqlSrc01+" A \n";
		strSqlSrc02  += "	) \n";

		if (strAct.equals("MAIN"))
		{
			strSql  = " SELECT  \n";
			strSql += "  	A.CODE_LIST_ID TAX_GI,  \n";
			strSql += "  	B.CODE_LIST_ID TAX_CONF,  \n";
			strSql += " 	A.CODE_LIST_NAME||' '||B.CODE_LIST_NAME WORK_NAME \n";
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
		else if (strAct.equals("LIST02_1"))
		{
			
			strSql += "\nSELECT                                              ";
			strSql += "\n    '7' e1,                                         ";
			strSql += "\n    F_T_Cust_Mask(a.BIZNO) e2,                                     ";
			strSql += "\n    a.COMPANY_NAME e3,                              ";
			strSql += "\n    a.BOSS e4,                                      ";
			strSql += "\n    a.BIZPLACE_ADDR1||' '||a.BIZPLACE_ADDR2 e5,     ";
			strSql += "\n    ' ' e6,                                         ";
			strSql += "\n    ' ' e7,                                         ";
			strSql += "\n    '"+strPUBL_DT_FR.substring(2)+"'||'"+strPUBL_DT_TO.substring(2)+"' e8,    ";
			strSql += "\n    '"+strWriteDt.substring(2)+"' e9,                                    ";
			strSql += "\n    ' ' e10,                                        ";
			strSql += "\n    ' ' e11,                                        ";
			strSql += "\n    ' ' e12,                                        ";
			strSql += "\n    ' ' e13,                                        ";
			strSql += "\n    ' ' e14,                                        ";
			strSql += "\n    ' ' e15,                                        ";
			strSql += "\n    ' ' e16                                         ";
			strSql += "\nFROM                                                ";
			strSql += "\n    T_COMPANY a                                   ";
			strSql += "\nWHERE                                               ";
			strSql += "\n    a.COMP_CODE IN "+strSqlSrc01+"         ";
			
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

		else if (strAct.equals("LIST02_2"))
		{
			strSql += "\nSELECT                                              ";
			strSql += "\n    e1,                                             ";
			strSql += "\n    e2,                                             ";
			strSql += "\n    ''||rownum e3,                                  ";
			strSql += "\n    e4,                                             ";
			strSql += "\n    e5,                                             ";
			strSql += "\n    e6,                                             ";
			strSql += "\n    e7,                                             ";
			strSql += "\n    e8,                                             ";
			strSql += "\n    e9,                                             ";
			strSql += "\n    e10,                                            ";
			strSql += "\n    e11,                                            ";
			strSql += "\n    e12,                                            ";
			strSql += "\n    e13,                                            ";
			strSql += "\n    e14,                                            ";
			strSql += "\n    e15,                                            ";
			strSql += "\n    e16                                             ";
			strSql += "\nFROM                                                ";
			strSql += "\n(                                                   ";
			strSql += "\nSELECT                                              ";
			strSql += "\n    '1' e1,                                         ";
			strSql += "\n    F_T_Cust_Mask(c.BIZNO) e2,                                     ";
			strSql += "\n    '' e3,                                          ";
			strSql += "\n    F_T_Cust_Mask(b.CUST_CODE) e4,                                 ";
			strSql += "\n    b.CUST_NAME e5,                                 ";
			strSql += "\n    ' ' e6,                                         ";
			strSql += "\n    ' ' e7,                                         ";
			strSql += "\n    ''||COUNT(*) e8,                                ";
			strSql += "\n    '0' e9,                                         ";
			strSql += "\n    SUM(a.SUPAMT) e10,                          ";
			strSql += "\n    SUM(a.VATAMT) e11,                          ";
			strSql += "\n    '0' e12,                                        ";
			strSql += "\n    '0' e13,                                        ";
			strSql += "\n    '7501' e14,                                     ";
			strSql += "\n    SUBSTR(c.BIZNO,1,3) e15,                        ";
			strSql += "\n    '' e16                                          ";
			strSql += "\nFROM                                                ";
			strSql += "\n    "+strSqlSrc+" a,								";
			strSql += "\n    T_CUST_CODE b,                                 ";
			strSql += "\n    T_COMPANY c                                   ";
			strSql += "\nWHERE                                               ";
			strSql += "\n    a.SALEBUY_CLS = '1'                             ";
			strSql += "\n    AND b.CUST_SEQ = a.CUST_SEQ                   ";
			//strSql += "\n    AND c.COMP_CODE = a.COMP_CODE             ";
			strSql += "\n    AND c.COMP_CODE = a.TAX_COMP_CODE             ";
			strSql += "\n    AND a.TAX_COMP_CODE =  '"+strCOMP_CODE+"'     ";
			strSql += "\n    --AND ( a.PUBL_DT BETWEEN F_T_StringToDate('"+strPUBL_DT_FR+"') AND F_T_StringToDate('"+strPUBL_DT_TO+"') ) ";
			strSql += "\n    AND a.RCPTBILL_CLS =  '"+strRCPTBILL_CLS+"'     ";
			strSql += "\nGROUP BY                                            ";
			strSql += "\n    c.BIZNO,                                        ";
			strSql += "\n    b.CUST_CODE,                                    ";
			strSql += "\n    b.CUST_NAME                                     ";
			strSql += "\n)                                                   ";
			
			
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
		else if (strAct.equals("LIST02_3"))
		{
			strSql += "\nSELECT                                              ";
			strSql += "\n    '3' e1,                                         ";
			strSql += "\n    e2,                                             ";
			strSql += "\n    ''||COUNT(e2) e3, -- 총 거래처 수                ";
			strSql += "\n    ''||SUM(e8) e4,  -- 총 세금계산서 매수          ";
			strSql += "\n    SUM(e10) e5, -- 총 공급금액                 ";
			strSql += "\n    SUM(e11) e6, -- 총 세액                     ";
			strSql += "\n    ''||SUM( DECODE( LENGTH(e4), 10, 1, 0 ) ) e7,   ";
			strSql += "\n    ''||SUM( DECODE( LENGTH(e4), 10, e8, 0 ) ) e8,  ";
			strSql += "\n    SUM( DECODE( LENGTH(e4), 10, e10, 0 ) ) e9, ";
			strSql += "\n    SUM( DECODE( LENGTH(e4), 10, e11, 0 ) ) e10,";
			strSql += "\n    ''||SUM( DECODE( LENGTH(e4), 13, 1, 0 ) ) e11,  ";
			strSql += "\n    ''||SUM( DECODE( LENGTH(e4), 13, e8, 0 ) ) e12, ";
			strSql += "\n    SUM( DECODE( LENGTH(e4), 13, e10, 0 ) ) e13,";
			strSql += "\n    SUM( DECODE( LENGTH(e4), 13, e11, 0 ) ) e14,";
			strSql += "\n    ' ' e15,                                        ";
			strSql += "\n    ' ' e16                                         ";
			strSql += "\nFROM                                                ";
			strSql += "\n(                                                   ";
			strSql += "\nSELECT                                              ";
			strSql += "\n    '1' e1,                                         ";
			strSql += "\n    F_T_Cust_Mask(c.BIZNO) e2,                                     ";
			strSql += "\n    '' e3,                                          ";
			strSql += "\n    (b.CUST_CODE) e4,                                 ";
			strSql += "\n    b.CUST_NAME e5,                                 ";
			strSql += "\n    ' ' e6,                                         ";
			strSql += "\n    ' ' e7,                                         ";
			strSql += "\n    ''||COUNT(*) e8,                                ";
			strSql += "\n    '0' e9,                                         ";
			strSql += "\n    ''||SUM(a.SUPAMT) e10,                          ";
			strSql += "\n    ''||SUM(a.VATAMT) e11,                          ";
			strSql += "\n    '0' e12,                                        ";
			strSql += "\n    '0' e13,                                        ";
			strSql += "\n    '7501' e14,                                     ";
			strSql += "\n    SUBSTR(c.BIZNO,1,3) e15,                        ";
			strSql += "\n    '' e16                                          ";
			strSql += "\nFROM                                                ";
			strSql += "\n    "+strSqlSrc+" a,                        ";
			strSql += "\n    T_CUST_CODE b,                                     ";
			strSql += "\n    T_COMPANY c                                   ";
			strSql += "\nWHERE                                               ";
			strSql += "\n    a.SALEBUY_CLS = '1'                             ";
			strSql += "\n    AND b.CUST_SEQ = a.CUST_SEQ                   ";
			//strSql += "\n    AND c.COMP_CODE = a.COMP_CODE             ";
			strSql += "\n    AND c.COMP_CODE = a.TAX_COMP_CODE             ";
			strSql += "\n    AND a.TAX_COMP_CODE =  '"+strCOMP_CODE+"'     ";
			strSql += "\n    --AND ( a.PUBL_DT BETWEEN F_T_StringToDate('"+strPUBL_DT_FR+"') AND F_T_StringToDate('"+strPUBL_DT_TO+"') ) ";
			strSql += "\n    AND a.RCPTBILL_CLS =  '"+strRCPTBILL_CLS+"'     ";
			strSql += "\nGROUP BY                                            ";
			strSql += "\n    c.BIZNO,                                        ";
			strSql += "\n    b.CUST_CODE,                                    ";
			strSql += "\n    b.CUST_NAME                                     ";
			strSql += "\n) e                                                 ";
			strSql += "\nGROUP BY                                            ";
			strSql += "\n    e2                                              ";
			
			
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

		else if (strAct.equals("LIST02_4"))
		{
			strSql += "\nSELECT                                              ";
			strSql += "\n    e1,                                             ";
			strSql += "\n    e2,                                             ";
			strSql += "\n    ''||rownum e3,                                  ";
			strSql += "\n    e4,                                             ";
			strSql += "\n    e5,                                             ";
			strSql += "\n    e6,                                             ";
			strSql += "\n    e7,                                             ";
			strSql += "\n    e8,                                             ";
			strSql += "\n    e9,                                             ";
			strSql += "\n    e10,                                            ";
			strSql += "\n    e11,                                            ";
			strSql += "\n    e12,                                            ";
			strSql += "\n    e13,                                            ";
			strSql += "\n    e14,                                            ";
			strSql += "\n    e15,                                            ";
			strSql += "\n    e16                                             ";
			strSql += "\nFROM                                                ";
			strSql += "\n(                                                   ";
			strSql += "\nSELECT                                              ";
			strSql += "\n    '2' e1,                                         ";
			strSql += "\n    F_T_Cust_Mask(c.BIZNO) e2,                                     ";
			strSql += "\n    '' e3,                                          ";
			strSql += "\n    F_T_Cust_Mask(b.CUST_CODE) e4,                                 ";
			strSql += "\n    b.CUST_NAME e5,                                 ";
			strSql += "\n    ' ' e6,                                         ";
			strSql += "\n    ' ' e7,                                         ";
			strSql += "\n    ''||COUNT(*) e8,                                ";
			strSql += "\n    '0' e9,                                         ";
			strSql += "\n    SUM(a.SUPAMT) e10,                          ";
			strSql += "\n    SUM(a.VATAMT) e11,                          ";
			strSql += "\n    '0' e12,                                        ";
			strSql += "\n    '0' e13,                                        ";
			strSql += "\n    '8501' e14,                                     ";
			strSql += "\n    SUBSTR(c.BIZNO,1,3) e15,                        ";
			strSql += "\n    '' e16                                          ";
			strSql += "\nFROM                                                ";
			strSql += "\n    "+strSqlSrc+" a,                        ";
			strSql += "\n    T_CUST_CODE b,                                     ";
			strSql += "\n    T_COMPANY c                                   ";
			strSql += "\nWHERE                                               ";
			strSql += "\n    a.SALEBUY_CLS = '2'                             ";
			strSql += "\n    AND b.CUST_SEQ = a.CUST_SEQ                   ";
			//strSql += "\n    AND c.COMP_CODE = a.COMP_CODE             ";
			strSql += "\n    AND c.COMP_CODE = a.TAX_COMP_CODE             ";
			strSql += "\n    AND a.TAX_COMP_CODE =  '"+strCOMP_CODE+"'     ";
			strSql += "\n    --AND ( a.PUBL_DT BETWEEN F_T_StringToDate('"+strPUBL_DT_FR+"') AND F_T_StringToDate('"+strPUBL_DT_TO+"') ) ";
			strSql += "\n    AND a.RCPTBILL_CLS =  '"+strRCPTBILL_CLS+"'     ";
			strSql += "\n    AND LENGTH(b.CUST_CODE)=10                      ";
			strSql += "\nGROUP BY                                            ";
			strSql += "\n    c.BIZNO,                                        ";
			strSql += "\n    b.CUST_CODE,                                    ";
			strSql += "\n    b.CUST_NAME                                     ";
			strSql += "\n)                                                   ";
			
			
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

		else if (strAct.equals("LIST02_5"))
		{
			strSql += "\nSELECT                                              ";
			strSql += "\n    '4' e1,                                         ";
			strSql += "\n    e2,                                             ";
			strSql += "\n    ''||COUNT(e2) e3, -- 총 거래처 수                ";
			strSql += "\n    ''||SUM(e8) e4,  -- 총 세금계산서 매수          ";
			strSql += "\n    SUM(e10) e5, -- 총 공급금액                 ";
			strSql += "\n    SUM(e11) e6, -- 총 세액                     ";
			strSql += "\n    '' e7,                                          ";
			strSql += "\n    '' e8,                                          ";
			strSql += "\n    '' e9,                                          ";
			strSql += "\n    '' e10,                                         ";
			strSql += "\n    '' e11,                                         ";
			strSql += "\n    '' e12,                                         ";
			strSql += "\n    '' e13,                                         ";
			strSql += "\n    '' e14,                                         ";
			strSql += "\n    '' e15,                                         ";
			strSql += "\n    '' e16                                          ";
			strSql += "\nFROM                                                ";
			strSql += "\n(                                                   ";
			strSql += "\nSELECT                                              ";
			strSql += "\n    '2' e1,                                         ";
			strSql += "\n    F_T_Cust_Mask(c.BIZNO)e2,                       ";
			strSql += "\n    '' e3,                                          ";
			strSql += "\n    b.CUST_CODE e4,                                 ";
			strSql += "\n    b.CUST_NAME e5,                                 ";
			strSql += "\n    ' ' e6,                                         ";
			strSql += "\n    ' ' e7,                                         ";
			strSql += "\n    ''||COUNT(*) e8,                                ";
			strSql += "\n    '0' e9,                                         ";
			strSql += "\n    ''||SUM(a.SUPAMT) e10,                          ";
			strSql += "\n    ''||SUM(a.VATAMT) e11,                          ";
			strSql += "\n    '0' e12,                                        ";
			strSql += "\n    '0' e13,                                        ";
			strSql += "\n    '8501' e14,                                     ";
			strSql += "\n    SUBSTR(c.BIZNO,1,3) e15,                        ";
			strSql += "\n    '' e16                                          ";
			strSql += "\nFROM                                                ";
			strSql += "\n    "+strSqlSrc+" a,             ";
			strSql += "\n    T_CUST_CODE b,                                     ";
			strSql += "\n    T_COMPANY c                                   ";
			strSql += "\nWHERE                                               ";
			strSql += "\n    a.SALEBUY_CLS = '2'                             ";
			strSql += "\n    AND b.CUST_SEQ = a.CUST_SEQ                   ";
			//strSql += "\n    AND c.COMP_CODE = a.COMP_CODE             ";
			strSql += "\n    AND c.COMP_CODE = a.TAX_COMP_CODE             ";
			strSql += "\n    AND a.TAX_COMP_CODE =  '"+strCOMP_CODE+"'     ";
			strSql += "\n    --AND ( a.PUBL_DT BETWEEN F_T_StringToDate('"+strPUBL_DT_FR+"') AND F_T_StringToDate('"+strPUBL_DT_TO+"') ) ";
			strSql += "\n    AND a.RCPTBILL_CLS =  '"+strRCPTBILL_CLS+"'     ";
			strSql += "\n    AND LENGTH(b.CUST_CODE)=10                      ";
			strSql += "\nGROUP BY                                            ";
			strSql += "\n    c.BIZNO,                                        ";
			strSql += "\n    b.CUST_CODE,                                    ";
			strSql += "\n    b.CUST_NAME                                     ";
			strSql += "\n) e                                                ";
			strSql += "\nGROUP BY                                            ";
			strSql += "\n    e2                                              ";
			
			
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

		else if (strAct.equals("LIST03_1"))
		{
			strSql += "\nSELECT                                                                                                  ";
			strSql += "\n    'A' e1,                                                                                             ";
			strSql += "\n    SUBSTR(a.BIZNO,1,3) e2,                                                                             ";
			strSql += "\n    F_T_DateToString(F_T_StringToDate('"+strWriteDt+"')) e3,                                                                             ";
			strSql += "\n    '2' e4,                                                                                             ";
			strSql += "\n    '' e5,                                                                                              ";
			strSql += "\n    F_T_Cust_Mask(a.BIZNO) e6,                                                                                         ";
			strSql += "\n    a.COMPANY_NAME e7,                                                                                  ";
			strSql += "\n    F_T_Cust_Mask(a.BIZNO2) e8,                                                                                        ";
			strSql += "\n    a.BOSS e9,                                                                                          ";
			strSql += "\n    a.BIZPLACE_ZIPCODE e10,                                                                             ";
			strSql += "\n    a.BIZPLACE_ADDR1||' '||a.BIZPLACE_ADDR2 e11,                                                        ";
			strSql += "\n    a.TELNO e12,                                                                                        ";
			strSql += "\n    "+strSqlSrc02+" e13,                                                                                            ";
			strSql += "\n    '101' e14,                                                                                          ";
			strSql += "\n    '' e15,                                                                                             ";
			strSql += "\n    '' e16,                                                                                             ";
			strSql += "\n    '' e17,                                                                                             ";
			strSql += "\n    '' e18,                                                                                             ";
			strSql += "\n    '' e19,                                                                                             ";
			strSql += "\n    '' e20,                                                                                             ";
			strSql += "\n    '' e21,                                                                                             ";
			strSql += "\n    '' e22,                                                                                             ";
			strSql += "\n    '' e23,                                                                                             ";
			strSql += "\n    '' e24                                                                                              ";
			strSql += "\nFROM                                                                                                    ";
			strSql += "\n    T_COMPANY a                                                                                       ";
			strSql += "\nWHERE                                                                                                   ";
			strSql += "\n    a.COMP_CODE = '"+strCOMP_CODE+"'                                                             ";

			
			
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

		else if (strAct.equals("LIST03_2"))
		{
			strSql += "\nSELECT                                                                                                  ";
			strSql += "\n    'B' e1,                                                                                             ";
			strSql += "\n    SUBSTR(a.BIZNO,1,3) e2,                                                                             ";
			strSql += "\n    ''||1 e3,                                                                                           ";
			strSql += "\n    F_T_Cust_Mask(a.BIZNO) e4,                                                                                         ";
			strSql += "\n    a.COMPANY_NAME e5,                                                                                  ";
			strSql += "\n    a.BOSS e6,                                                                                          ";
			strSql += "\n    a.BIZPLACE_ZIPCODE e7,                                                                              ";
			strSql += "\n    a.BIZPLACE_ADDR1||' '||a.BIZPLACE_ADDR2 e8,                                                         ";
			strSql += "\n    '' e9,                                                                                              ";
			strSql += "\n    '' e10,                                                                                             ";
			strSql += "\n    '' e11,                                                                                             ";
			strSql += "\n    '' e12,                                                                                             ";
			strSql += "\n    '' e13,                                                                                             ";
			strSql += "\n    '' e14,                                                                                             ";
			strSql += "\n    '' e15,                                                                                             ";
			strSql += "\n    '' e16,                                                                                             ";
			strSql += "\n    '' e17,                                                                                             ";
			strSql += "\n    '' e18,                                                                                             ";
			strSql += "\n    '' e19,                                                                                             ";
			strSql += "\n    '' e20,                                                                                             ";
			strSql += "\n    '' e21,                                                                                             ";
			strSql += "\n    '' e22,                                                                                             ";
			strSql += "\n    '' e23,                                                                                             ";
			strSql += "\n    '' e24                                                                                              ";
			strSql += "\nFROM                                                                                                    ";
			strSql += "\n    T_COMPANY a                                                                                       ";
			strSql += "\nWHERE                                                                                                   ";
			strSql += "\n    a.COMP_CODE IN "+strSqlSrc01+"                                                             ";

			
			
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

		else if (strAct.equals("LIST03_3"))
		{
			strSql += "\nSELECT                                                                                                  ";
			strSql += "\n    'C' e1,                                                                                             ";
			strSql += "\n    '17' e2,                                                                                                 ";
			strSql += "\n    (CASE WHEN SUBSTR('"+strPUBL_DT_TO+"',5,2)<'07' THEN '1' ELSE '2' END) e3,                                                                                                 ";
			strSql += "\n    '"+strTAX_CONF+"' e4,                                                                                                 ";
			strSql += "\n    e5,                                             ";
			strSql += "\n    ''||1 e6,                                                                                           ";
			strSql += "\n    e7,                                             ";
			strSql += "\n    '"+strPUBL_DT_FR.substring(0,4)+"' e8,                                                              ";
			strSql += "\n    F_T_DateToString(F_T_StringToDate('"+strPUBL_DT_FR+"')) e9,                                                                             ";
			strSql += "\n    F_T_DateToString(F_T_StringToDate('"+strPUBL_DT_TO+"')) e10,                                                                            ";
			strSql += "\n    F_T_DateToString(F_T_StringToDate('"+strWriteDt+"')) e11,                                                                            ";
			strSql += "\n    ''||COUNT(e7) e12, -- 총 거래처 수                                                                   ";
			strSql += "\n    ''||SUM(e10) e13, -- 총 세금계산서 매수                                                             ";
			strSql += "\n    ''||(CASE WHEN SUM(nvl(e12, 0))>=0 THEN '0' ELSE '1' END) e14, -- 총 공급금액                               ";
			strSql += "\n    ABS(SUM(e12)) e15, -- 총 세액                                                                   ";
			strSql += "\n    ''||SUM( DECODE( LENGTH(e8), 10, 1, 0 ) ) e16,                                                      ";
			strSql += "\n    ''||SUM( DECODE( LENGTH(e8), 10, e10, 0 ) ) e17,                                                    ";
			strSql += "\n    ''||(CASE WHEN SUM( DECODE( LENGTH(e8), 10, e12, 0 ) )>=0 THEN '0' ELSE '1' END) e18, -- 총 공급금액";
			strSql += "\n    ABS(SUM( DECODE( LENGTH(e8), 10, e12, 0 ) )) e19,                                               ";
			strSql += "\n    ''||SUM( DECODE( LENGTH(e8), 13, 1, 0 ) ) e20,                                                      ";
			strSql += "\n    ''||SUM( DECODE( LENGTH(e8), 13, e10, 0 ) ) e21,                                                    ";
			strSql += "\n    ''||(CASE WHEN SUM( DECODE( LENGTH(e8), 13, e12, 0 ) )>=0 THEN '0' ELSE '1' END) e22, -- 총 공급금액";
			strSql += "\n    ABS(SUM( DECODE( LENGTH(e8), 13, e12, 0 ) )) e23,                                               ";
			strSql += "\n    ' ' e24                                                                                             ";
			strSql += "\nFROM                                                                                                    ";
			strSql += "\n(                                                                                                       ";
			strSql += "\nSELECT                                                                                                  ";
			strSql += "\n    'C' e1,                                                                                             ";
			strSql += "\n    '' e2,                                                                                            ";
			strSql += "\n    '' e3,                                                                                             ";
			strSql += "\n    '' e4,                                                                                             ";
			strSql += "\n    SUBSTR(c.BIZNO,1,3) e5,                                                                             ";
			strSql += "\n    '' e6,                                                                                              ";
			strSql += "\n    F_T_Cust_Mask(c.BIZNO) e7,                                                                                         ";
			strSql += "\n    b.CUST_CODE e8,                                                                                     ";
			strSql += "\n    b.CUST_NAME e9,                                                                                     ";
			strSql += "\n    ''||COUNT(*) e10,                                                                                   ";
			strSql += "\n    '' e11,                                                                                             ";
			strSql += "\n    ''||SUM(a.VATAMT+a.SUPAMT) e12,                                                                     ";
			strSql += "\n    '' e13,                                                                                             ";
			strSql += "\n    '' e14,                                                                                             ";
			strSql += "\n    '' e15,                                                                                             ";
			strSql += "\n    '' e16                                                                                              ";
			strSql += "\nFROM                                                                                                    ";
			strSql += "\n    "+strSqlSrc+" a,                                                                            ";
			strSql += "\n    T_CUST_CODE b,                                                                                         ";
			strSql += "\n    T_COMPANY c                                                                                       ";
			strSql += "\nWHERE                                                                                                   ";
			strSql += "\n    a.SALEBUY_CLS = '1'                                                                                 ";
			strSql += "\n    AND b.CUST_SEQ = a.CUST_SEQ                                                                       ";
			//strSql += "\n    AND c.COMP_CODE = a.COMP_CODE             ";
			strSql += "\n    AND c.COMP_CODE = a.TAX_COMP_CODE             ";
			strSql += "\n    AND a.TAX_COMP_CODE =  '"+strCOMP_CODE+"'     ";
			strSql += "\n    --AND ( a.PUBL_DT BETWEEN F_T_StringToDate('"+strPUBL_DT_FR+"') AND F_T_StringToDate('"+strPUBL_DT_TO+"') ) ";
			strSql += "\n    AND a.RCPTBILL_CLS =  '"+strRCPTBILL_CLS+"'     ";
			strSql += "\nGROUP BY                                                                                                ";
			strSql += "\n    c.BIZNO,                                                                                            ";
			strSql += "\n    b.CUST_CODE,                                                                                        ";
			strSql += "\n    b.CUST_NAME                                                                                         ";
			strSql += "\n) e                                                                                                    ";
			strSql += "\nGROUP BY                                                                                                ";
			strSql += "\n    e5,                                                                                                 ";
			strSql += "\n    e7                                                                                                  ";

			
			
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

		else if (strAct.equals("LIST03_4"))
		{
			strSql += "\nSELECT                                                                                                  ";
			strSql += "\n    e1,                                                                                                 ";
			strSql += "\n    e2,                                                                                                 ";
			strSql += "\n    e3,                                                                                                 ";
			strSql += "\n    e4,                                                                                                 ";
			strSql += "\n    e5,                                                                                                 ";
			strSql += "\n    ''||rownum e6,                                                                                      ";
			strSql += "\n    F_T_Cust_Mask(e7) e7,                                                                                                 ";
			strSql += "\n    F_T_Cust_Mask(e8) e8,                                                                                                 ";
			strSql += "\n    e9,                                                                                                 ";
			strSql += "\n    e10,                                                                                                ";
			strSql += "\n    e11,                                                                                                ";
			strSql += "\n    e12,                                                                                                ";
			strSql += "\n    e13,                                                                                                ";
			strSql += "\n    e14,                                                                                                ";
			strSql += "\n    e15,                                                                                                ";
			strSql += "\n    e16,                                                                                                ";
			strSql += "\n    '' e17,                                                                                             ";
			strSql += "\n    '' e18,                                                                                             ";
			strSql += "\n    '' e19,                                                                                             ";
			strSql += "\n    '' e20,                                                                                             ";
			strSql += "\n    '' e21,                                                                                             ";
			strSql += "\n    '' e22,                                                                                             ";
			strSql += "\n    '' e23,                                                                                             ";
			strSql += "\n    '' e24                                                                                              ";
			strSql += "\nFROM                                                                                                    ";
			strSql += "\n(                                                                                                       ";
			strSql += "\nSELECT                                                                                                  ";
			strSql += "\n    'D' e1,                                                                                             ";
			strSql += "\n    '17' e2,                                                                                            ";
			strSql += "\n    (CASE WHEN SUBSTR('"+strPUBL_DT_TO+"',5,2)<'07' THEN '1' ELSE '2' END) e3,                                                                                             ";
			strSql += "\n    '"+strTAX_CONF+"' e4,                                                                                             ";
			strSql += "\n    SUBSTR(c.BIZNO,1,3) e5,                                                                             ";
			strSql += "\n    '' e6,                                                                                              ";
			strSql += "\n    c.BIZNO e7,                                                                                         ";
			strSql += "\n    b.CUST_CODE e8,                                                                                     ";
			strSql += "\n    b.CUST_NAME e9,                                                                                     ";
			strSql += "\n    ''||COUNT(*) e10,                                                                                   ";
			strSql += "\n    ''||(CASE WHEN SUM(a.VATAMT+a.SUPAMT)>=0 THEN '0' ELSE '1' END) e11,                                ";
			strSql += "\n    ABS(SUM(a.VATAMT+a.SUPAMT)) e12,                                                                ";
			strSql += "\n    '' e13,                                                                                             ";
			strSql += "\n    '' e14,                                                                                             ";
			strSql += "\n    '' e15,                                                                                             ";
			strSql += "\n    '' e16                                                                                              ";
			strSql += "\nFROM                                                                                                    ";
			strSql += "\n    "+strSqlSrc+" a,                                                                            ";
			strSql += "\n    T_CUST_CODE b,                                                                                         ";
			strSql += "\n    T_COMPANY c                                                                                       ";
			strSql += "\nWHERE                                                                                                   ";
			strSql += "\n    a.SALEBUY_CLS = '1'                                                                                 ";
			strSql += "\n    AND b.CUST_SEQ = a.CUST_SEQ                                                                       ";
			//strSql += "\n    AND c.COMP_CODE = a.COMP_CODE             ";
			strSql += "\n    AND c.COMP_CODE = a.TAX_COMP_CODE             ";
			strSql += "\n    AND a.TAX_COMP_CODE =  '"+strCOMP_CODE+"'     ";
			strSql += "\n    --AND ( a.PUBL_DT BETWEEN F_T_StringToDate('"+strPUBL_DT_FR+"') AND F_T_StringToDate('"+strPUBL_DT_TO+"') ) ";
			strSql += "\n    AND a.RCPTBILL_CLS =  '"+strRCPTBILL_CLS+"'     ";
			strSql += "\nGROUP BY                                                                                                ";
			strSql += "\n    c.BIZNO,                                                                                            ";
			strSql += "\n    b.CUST_CODE,                                                                                        ";
			strSql += "\n    b.CUST_NAME                                                                                         ";
			strSql += "\n)                                                                                                       ";

			
			
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

		else if (strAct.equals("LIST03_5"))
		{
			strSql += "\nSELECT                                                                                                  ";
			strSql += "\n    'C' e1,                                                                                             ";
			strSql += "\n    '18' e2,                                                                                                 ";
			strSql += "\n    (CASE WHEN SUBSTR('"+strPUBL_DT_TO+"',5,2)<'07' THEN '1' ELSE '2' END) e3,                                                                                                 ";
			strSql += "\n    '"+strTAX_CONF+"' e4,                                                                                                 ";
			strSql += "\n    e5,                                             ";
			strSql += "\n    ''||1 e6,                                                                                           ";
			strSql += "\n    e7,                                             ";
			strSql += "\n    '"+strPUBL_DT_FR.substring(0,4)+"' e8,                                                              ";
			strSql += "\n    F_T_DateToString(F_T_StringToDate('"+strPUBL_DT_FR+"')) e9,                                                                             ";
			strSql += "\n    F_T_DateToString(F_T_StringToDate('"+strPUBL_DT_TO+"')) e10,                                                                            ";
			strSql += "\n    F_T_DateToString(F_T_StringToDate('"+strWriteDt+"')) e11,                                                                            ";
			strSql += "\n    ''||COUNT(e7) e12, -- 총 거래처 수                                                                   ";
			strSql += "\n    ''||SUM(e10) e13, -- 총 세금계산서 매수                                                             ";
			strSql += "\n    ''||(CASE WHEN SUM(nvl(e12, 0))>=0 THEN '0' ELSE '1' END) e14, -- 총 공급금액                               ";
			strSql += "\n    ABS(SUM(e12)) e15, -- 총 세액                                                                   ";
			strSql += "\n    ' ' e16                                                                                             ";
			strSql += "\nFROM                                                                                                    ";
			strSql += "\n(                                                                                                       ";
			strSql += "\nSELECT                                                                                                  ";
			strSql += "\n    'C' e1,                                                                                             ";
			strSql += "\n    '' e2,                                                                                            ";
			strSql += "\n    '' e3,                                                                                             ";
			strSql += "\n    '' e4,                                                                                             ";
			strSql += "\n    SUBSTR(c.BIZNO,1,3) e5,                                                                             ";
			strSql += "\n    '' e6,                                                                                              ";
			strSql += "\n    c.BIZNO e7,                                                                                         ";
			strSql += "\n    b.CUST_CODE e8,                                                                                     ";
			strSql += "\n    b.CUST_NAME e9,                                                                                     ";
			strSql += "\n    ''||COUNT(*) e10,                                                                                   ";
			strSql += "\n    '' e11,                                                                                             ";
			strSql += "\n    ''||SUM(a.VATAMT+a.SUPAMT) e12,                                                                     ";
			strSql += "\n    '' e13,                                                                                             ";
			strSql += "\n    '' e14,                                                                                             ";
			strSql += "\n    '' e15,                                                                                             ";
			strSql += "\n    '' e16                                                                                              ";
			strSql += "\nFROM                                                                                                    ";
			strSql += "\n    "+strSqlSrc+" a,                                                                            ";
			strSql += "\n    T_CUST_CODE b,                                                                                         ";
			strSql += "\n    T_COMPANY c                                                                                       ";
			strSql += "\nWHERE                                                                                                   ";
			strSql += "\n    a.SALEBUY_CLS = '2'                                                                                 ";
			strSql += "\n    AND b.CUST_SEQ = a.CUST_SEQ                                                                       ";
			//strSql += "\n    AND c.COMP_CODE = a.COMP_CODE             ";
			strSql += "\n    AND c.COMP_CODE = a.TAX_COMP_CODE             ";
			strSql += "\n    AND a.TAX_COMP_CODE =  '"+strCOMP_CODE+"'     ";
			strSql += "\n    --AND ( a.PUBL_DT BETWEEN F_T_StringToDate('"+strPUBL_DT_FR+"') AND F_T_StringToDate('"+strPUBL_DT_TO+"') ) ";
			strSql += "\n    AND a.RCPTBILL_CLS =  '"+strRCPTBILL_CLS+"'     ";
			strSql += "\n    AND LENGTH(b.CUST_CODE)=10                                                                          ";
			strSql += "\nGROUP BY                                                                                                ";
			strSql += "\n    c.BIZNO,                                                                                            ";
			strSql += "\n    b.CUST_CODE,                                                                                        ";
			strSql += "\n    b.CUST_NAME                                                                                         ";
			strSql += "\n) e                                                 ";
			strSql += "\nGROUP BY                                                                                                ";
			strSql += "\n    e5,                                                                                                 ";
			strSql += "\n    e7                                                                                                  ";

			
			
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

		else if (strAct.equals("LIST03_6"))
		{
			strSql += "\nSELECT                                                                                                  ";
			strSql += "\n    e1,                                                                                                 ";
			strSql += "\n    e2,                                                                                                 ";
			strSql += "\n    e3,                                                                                                 ";
			strSql += "\n    e4,                                                                                                 ";
			strSql += "\n    e5,                                                                                                 ";
			strSql += "\n    ''||rownum e6,                                                                                      ";
			strSql += "\n    e7,                                                                                                 ";
			strSql += "\n    e8,                                                                                                 ";
			strSql += "\n    e9,                                                                                                 ";
			strSql += "\n    e10,                                                                                                ";
			strSql += "\n    e11,                                                                                                ";
			strSql += "\n    e12,                                                                                                ";
			strSql += "\n    e13,                                                                                                ";
			strSql += "\n    e14,                                                                                                ";
			strSql += "\n    e15,                                                                                                ";
			strSql += "\n    e16,                                                                                                ";
			strSql += "\n    '' e17,                                                                                             ";
			strSql += "\n    '' e18,                                                                                             ";
			strSql += "\n    '' e19,                                                                                             ";
			strSql += "\n    '' e20,                                                                                             ";
			strSql += "\n    '' e21,                                                                                             ";
			strSql += "\n    '' e22,                                                                                             ";
			strSql += "\n    '' e23,                                                                                             ";
			strSql += "\n    '' e24                                                                                              ";
			strSql += "\nFROM                                                                                                    ";
			strSql += "\n(                                                                                                       ";
			strSql += "\nSELECT                                                                                                  ";
			strSql += "\n    'D' e1,                                                                                             ";
			strSql += "\n    '18' e2,                                                                                            ";
			strSql += "\n    (CASE WHEN SUBSTR('"+strPUBL_DT_TO+"',5,2)<'07' THEN '1' ELSE '2' END) e3,                                                                                             ";
			strSql += "\n    '"+strTAX_CONF+"' e4,                                                                                             ";
			strSql += "\n    SUBSTR(c.BIZNO,1,3) e5,                                                                             ";
			strSql += "\n    '' e6,                                                                                              ";
			strSql += "\n    F_T_Cust_Mask(c.BIZNO) e7,                                                                                         ";
			strSql += "\n    F_T_Cust_Mask(b.CUST_CODE) e8,                                                                                     ";
			strSql += "\n    b.CUST_NAME e9,                                                                                     ";
			strSql += "\n    ''||COUNT(*) e10,                                                                                   ";
			strSql += "\n    ''||(CASE WHEN SUM(a.VATAMT+a.SUPAMT)>=0 THEN '0' ELSE '1' END) e11,                                ";
			strSql += "\n    ABS(SUM(a.VATAMT+a.SUPAMT)) e12,                                                                ";
			strSql += "\n    '' e13,                                                                                             ";
			strSql += "\n    '' e14,                                                                                             ";
			strSql += "\n    '' e15,                                                                                             ";
			strSql += "\n    '' e16                                                                                              ";
			strSql += "\nFROM                                                                                                    ";
			strSql += "\n    "+strSqlSrc+" a,                                                                            ";
			strSql += "\n    T_CUST_CODE b,                                                                                         ";
			strSql += "\n    T_COMPANY c                                                                                       ";
			strSql += "\nWHERE                                                                                                   ";
			strSql += "\n    a.SALEBUY_CLS = '2'                                                                                 ";
			strSql += "\n    AND b.CUST_SEQ = a.CUST_SEQ                                                                       ";
			//strSql += "\n    AND c.COMP_CODE = a.COMP_CODE             ";
			strSql += "\n    AND c.COMP_CODE = a.TAX_COMP_CODE             ";
			strSql += "\n    AND a.TAX_COMP_CODE =  '"+strCOMP_CODE+"'     ";
			strSql += "\n    --AND ( a.PUBL_DT BETWEEN F_T_StringToDate('"+strPUBL_DT_FR+"') AND F_T_StringToDate('"+strPUBL_DT_TO+"') ) ";
			strSql += "\n    AND a.RCPTBILL_CLS =  '"+strRCPTBILL_CLS+"'     ";
			strSql += "\n    AND LENGTH(b.CUST_CODE)=10                                                                          ";
			strSql += "\nGROUP BY                                                                                                ";
			strSql += "\n    c.BIZNO,                                                                                            ";
			strSql += "\n    b.CUST_CODE,                                                                                        ";
			strSql += "\n    b.CUST_NAME                                                                                         ";
			strSql += "\n)                                                                                                       ";  

			
			
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
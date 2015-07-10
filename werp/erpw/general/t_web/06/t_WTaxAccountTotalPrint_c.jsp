<%
	/***************************************************/
	/* 이 프로그램은 대보시스템(주) 의 재산입니다.
	/* 최초작성자 : 국종수
	/* 최초작성일 : 2004-12-08
	/* 최종수정자 : 
	/* 최종수정일 : 
	/***************************************************/
	java.io.OutputStream outStream = response.getOutputStream();
	 
	com.cj.util.CITData lrReturnData = null;
	String	strSql = "";

	String	strCOMP_CODE = com.cj.common.CITCommon.toKOR(request.getParameter("COMP_CODE"));
	String	strTAX_YEAR = com.cj.common.CITCommon.toKOR(request.getParameter("TAX_YEAR"));
	String	strTAX_GI = com.cj.common.CITCommon.toKOR(request.getParameter("TAX_GI"));
	String	strTAX_CONF = com.cj.common.CITCommon.toKOR(request.getParameter("TAX_CONF"));
	String	strRCPTBILL_CLS = com.cj.common.CITCommon.toKOR(request.getParameter("RCPTBILL_CLS"));

	String	strSale = "1";//com.cj.common.CITCommon.toKOR(request.getParameter("SALE"));
	String	strSell = "1";//com.cj.common.CITCommon.toKOR(request.getParameter("SELL"));

	String	strPUBL_DT_FR = "";
	String	strPUBL_DT_TO = "";

	String	strWriteDt = com.cj.common.CITCommon.toKOR(request.getParameter("WRITE_DT"));

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

	try
	{
		com.cj.util.CITData lrArgData = new com.cj.util.CITData();

		/*
		_log(strCOMP_CODE);
		_log(strPUBL_DT_FR);
		_log(strPUBL_DT_TO);
		_log(strRCPTBILL_CLS);
		_log(strTAX_CONF);
		_log(strWriteDt);
		_log(strSale);
		_log(strSell);
		*/
		if (strRCPTBILL_CLS.equals("01"))
		{
			strSql += "\nSELECT                                              ";
			strSql += "\n    '7' e1,                                         ";
			strSql += "\n    a.BIZNO e2,                                     ";
			strSql += "\n    RPAD(a.COMPANY_NAME, 30) e3,                              ";
			strSql += "\n    RPAD(a.BOSS, 15) e4,                                      ";
			strSql += "\n    RPAD(a.BIZPLACE_ADDR1||' '||a.BIZPLACE_ADDR2, 45) e5,     ";
			strSql += "\n    RPAD('_', 17) e6,                                         ";
			strSql += "\n    RPAD('_', 25) e7,                                         ";
			strSql += "\n    '"+strPUBL_DT_FR.substring(2)+"'||'"+strPUBL_DT_TO.substring(2)+"' e8,    ";
			strSql += "\n    '"+strWriteDt.substring(2)+"' e9,                                    ";
			strSql += "\n    RPAD('_', 9) e10,                                        ";
			strSql += "\n    '' e11,                                        ";
			strSql += "\n    '' e12,                                        ";
			strSql += "\n    '' e13,                                        ";
			strSql += "\n    '' e14,                                        ";
			strSql += "\n    '' e15,                                        ";
			strSql += "\n    '' e16                                         ";
			strSql += "\nFROM                                                ";
			strSql += "\n    T_COMPANY a                                   ";
			strSql += "\nWHERE                                               ";
			strSql += "\n    a.COMP_CODE IN "+strSqlSrc01+"         ";
if( "1".equals(strSale)	){
			strSql += "\nUNION ALL                                           ";

			strSql += "\nSELECT                                              ";
			strSql += "\n    e1,                                             ";
			strSql += "\n    e2,                                             ";
			strSql += "\n    LPAD(''||rownum, 4, '0') e3,                                ";
			strSql += "\n    e4,                                             ";
			strSql += "\n    RPAD(e5, 30) e5,                                            ";
			strSql += "\n    RPAD(e6, 17) e6,                                            ";
			strSql += "\n    RPAD(e7, 25) e7,                                            ";
			strSql += "\n    LPAD(e8, 7, '0') e8,                                        ";
			strSql += "\n    RPAD(e9, 2) e9,                                             ";
			strSql += "\n    (CASE WHEN e10<0 THEN '-' ELSE '0' END)||LPAD(''||ABS(e10), 13, '0') e10,                                            ";
			strSql += "\n    (CASE WHEN e11<0 THEN '-' ELSE '0' END)||LPAD(''||ABS(e11), 12, '0') e11,                                            ";
			strSql += "\n    e12,                                            ";
			strSql += "\n    e13,                                            ";
			strSql += "\n    e14,                                            ";
			strSql += "\n    e15,                                            ";
			strSql += "\n    RPAD(e16, 28) e16                                             ";
			strSql += "\nFROM                                                ";
			strSql += "\n(                                                   ";
			strSql += "\nSELECT                                              ";
			strSql += "\n    '1' e1,                                         ";
			strSql += "\n    c.BIZNO e2,                                     ";
			strSql += "\n    '' e3,                                          ";
			strSql += "\n    b.CUST_CODE e4,                                 ";
			strSql += "\n    b.CUST_NAME e5,                                 ";
			strSql += "\n    '_' e6,                                         ";
			strSql += "\n    '_' e7,                                         ";
			strSql += "\n    ''||COUNT(*) e8,                                ";
			strSql += "\n    '0' e9,                                         ";
			strSql += "\n    NVL(SUM(a.SUPAMT),0) e10,                          ";
			strSql += "\n    NVL(SUM(a.VATAMT),0) e11,                          ";
			strSql += "\n    '0' e12,                                        ";
			strSql += "\n    '0' e13,                                        ";
			strSql += "\n    '7501' e14,                                     ";
			strSql += "\n    SUBSTR(c.BIZNO,1,3) e15,                        ";
			strSql += "\n    '_' e16                                          ";
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
			strSql += "\n    --AND ( a.PUBL_DT BETWEEN SF_StringToDate('"+strPUBL_DT_FR+"') AND SF_StringToDate('"+strPUBL_DT_TO+"') ) ";
			strSql += "\n    AND a.RCPTBILL_CLS =  '"+strRCPTBILL_CLS+"'     ";
			strSql += "\nGROUP BY                                            ";
			strSql += "\n    c.BIZNO,                                        ";
			strSql += "\n    b.CUST_CODE,                                    ";
			strSql += "\n    b.CUST_NAME                                     ";
			strSql += "\n)                                                   ";

			strSql += "\nUNION ALL                                           ";

			strSql += "\nSELECT                                              ";
			strSql += "\n    '3' e1,                                         ";
			strSql += "\n    e2,                                             ";
			strSql += "\n    LPAD(''||COUNT(*), 7, '0') e3, -- 총 거래처 수                ";
			strSql += "\n    LPAD(''||SUM(e8), 7, '0') e4,  -- 총 세금계산서 매수          ";
			strSql += "\n    LPAD(''||SUM(e10), 15, '0') e5, -- 총 공급금액                 ";
			strSql += "\n    LPAD(''||SUM(e11), 14, '0') e6, -- 총 세액                     ";
			strSql += "\n    LPAD(''||SUM( DECODE( LENGTH(e4), 10, 1, 0 ) ), 7, '0') e7,   ";
			strSql += "\n    LPAD(''||SUM( DECODE( LENGTH(e4), 10, e8, 0 ) ), 7, '0') e8,  ";
			strSql += "\n    LPAD(''||SUM( DECODE( LENGTH(e4), 10, e10, 0 ) ), 15, '0') e9, ";
			strSql += "\n    LPAD(''||SUM( DECODE( LENGTH(e4), 10, e11, 0 ) ), 14, '0') e10,";
			strSql += "\n    LPAD(''||SUM( DECODE( LENGTH(e4), 13, 1, 0 ) ), 7, '0') e11,  ";
			strSql += "\n    LPAD(''||SUM( DECODE( LENGTH(e4), 13, e8, 0 ) ), 7, '0') e12, ";
			strSql += "\n    LPAD(''||SUM( DECODE( LENGTH(e4), 13, e10, 0 ) ), 15, '0') e13,";
			strSql += "\n    LPAD(''||SUM( DECODE( LENGTH(e4), 13, e11, 0 ) ), 14, '0') e14,";
			strSql += "\n    RPAD('_', 30) e15,                                        ";
			strSql += "\n    '' e16                                         ";
			strSql += "\nFROM                                                ";
			strSql += "\n(                                                   ";
			strSql += "\nSELECT                                              ";
			strSql += "\n    '1' e1,                                         ";
			strSql += "\n    c.BIZNO e2,                                     ";
			strSql += "\n    '' e3,                                          ";
			strSql += "\n    b.CUST_CODE e4,                                 ";
			strSql += "\n    b.CUST_NAME e5,                                 ";
			strSql += "\n    ' ' e6,                                         ";
			strSql += "\n    ' ' e7,                                         ";
			strSql += "\n    ''||COUNT(*) e8,                                ";
			strSql += "\n    '0' e9,                                         ";
			strSql += "\n    ''||NVL(SUM(a.SUPAMT),0) e10,                   ";
			strSql += "\n    ''||NVL(SUM(a.VATAMT),0) e11,                   ";
			strSql += "\n    '0' e12,                                        ";
			strSql += "\n    '0' e13,                                        ";
			strSql += "\n    '7501' e14,                                     ";
			strSql += "\n    SUBSTR(c.BIZNO,1,3) e15,                        ";
			strSql += "\n    '' e16                                          ";
			strSql += "\nFROM                                                ";
			strSql += "\n    "+strSqlSrc+" a,             ";
			strSql += "\n    T_CUST_CODE b,                                     ";
			strSql += "\n    T_COMPANY c                                   ";
			strSql += "\nWHERE                                               ";
			strSql += "\n    a.SALEBUY_CLS = '1'                             ";
			strSql += "\n    AND b.CUST_SEQ = a.CUST_SEQ                   ";
			//strSql += "\n    AND c.COMP_CODE = a.COMP_CODE             ";
			strSql += "\n    AND c.COMP_CODE = a.TAX_COMP_CODE             ";
			strSql += "\n    AND a.TAX_COMP_CODE =  '"+strCOMP_CODE+"'     ";
			strSql += "\n    --AND ( a.PUBL_DT BETWEEN SF_StringToDate('"+strPUBL_DT_FR+"') AND SF_StringToDate('"+strPUBL_DT_TO+"') ) ";
			strSql += "\n    AND a.RCPTBILL_CLS =  '"+strRCPTBILL_CLS+"'     ";
			strSql += "\nGROUP BY                                            ";
			strSql += "\n    c.BIZNO,                                        ";
			strSql += "\n    b.CUST_CODE,                                    ";
			strSql += "\n    b.CUST_NAME                                     ";
			strSql += "\n)                                                   ";
			strSql += "\nGROUP BY                                            ";
			strSql += "\n    e2                                              ";
}

if( "1".equals(strSell)	){
			strSql += "\nUNION ALL                                           ";

			strSql += "\nSELECT                                              ";
			strSql += "\n    e1,                                             ";
			strSql += "\n    e2,                                             ";
			strSql += "\n    LPAD(''||rownum, 4, '0') e3,                         ";
			strSql += "\n    e4,                                             ";
			strSql += "\n    RPAD(e5, 30) e5,                                ";
			strSql += "\n    RPAD(e6, 17) e6,                                ";
			strSql += "\n    RPAD(e7, 25) e7,                                ";
			strSql += "\n    LPAD(e8, 7, '0') e8,                                 ";
			strSql += "\n    RPAD(e9, 2) e9,                                 ";
			strSql += "\n    (CASE WHEN e10<0 THEN '-' ELSE '0' END)||LPAD(''||ABS(e10), 13, '0') e10,                                            ";
			strSql += "\n    (CASE WHEN e11<0 THEN '-' ELSE '0' END)||LPAD(''||ABS(e11), 12, '0') e11,                                            ";
			strSql += "\n    e12,                                            ";
			strSql += "\n    e13,                                            ";
			strSql += "\n    e14,                                            ";
			strSql += "\n    e15,                                            ";
			strSql += "\n    RPAD(e16, 28) e16                               ";
			strSql += "\nFROM                                                ";
			strSql += "\n(                                                   ";
			strSql += "\nSELECT                                              ";
			strSql += "\n    '2' e1,                                         ";
			strSql += "\n    c.BIZNO e2,                                     ";
			strSql += "\n    '' e3,                                          ";
			strSql += "\n    b.CUST_CODE e4,                                 ";
			strSql += "\n    b.CUST_NAME e5,                                 ";
			strSql += "\n    '_' e6,                                         ";
			strSql += "\n    '_' e7,                                         ";
			strSql += "\n    ''||COUNT(*) e8,                                ";
			strSql += "\n    '0' e9,                                         ";
			strSql += "\n    NVL(SUM(a.SUPAMT),0) e10,                   ";
			strSql += "\n    NVL(SUM(a.VATAMT),0) e11,                   ";
			strSql += "\n    '0' e12,                                        ";
			strSql += "\n    '0' e13,                                        ";
			strSql += "\n    '8501' e14,                                     ";
			strSql += "\n    SUBSTR(c.BIZNO,1,3) e15,                        ";
			strSql += "\n    '_' e16                                         ";
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
			strSql += "\n    --AND ( a.PUBL_DT BETWEEN SF_StringToDate('"+strPUBL_DT_FR+"') AND SF_StringToDate('"+strPUBL_DT_TO+"') ) ";
			strSql += "\n    AND a.RCPTBILL_CLS =  '"+strRCPTBILL_CLS+"'     ";
			strSql += "\n    AND LENGTH(b.CUST_CODE)=10                      ";
			strSql += "\nGROUP BY                                            ";
			strSql += "\n    c.BIZNO,                                        ";
			strSql += "\n    b.CUST_CODE,                                    ";
			strSql += "\n    b.CUST_NAME                                     ";
			strSql += "\n)                                                   ";

			strSql += "\nUNION ALL                                           ";

			strSql += "\nSELECT                                              ";
			strSql += "\n    '4' e1,                                         ";
			strSql += "\n    e2,                                             ";
			strSql += "\n    LPAD(''||COUNT(*), 7, '0') e3, -- 총 거래처 수        ";
			strSql += "\n    LPAD(''||SUM(e8), 7, '0') e4,  -- 총 세금계산서 매수   ";
			strSql += "\n    LPAD(''||SUM(e10), 15,'0') e5, -- 총 공급금액    ";
			strSql += "\n    LPAD(''||SUM(e11), 14,'0') e6, -- 총 세액        ";
			strSql += "\n    RPAD('_', 116) e7,                               ";
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
			strSql += "\n    c.BIZNO e2,                                     ";
			strSql += "\n    '' e3,                                          ";
			strSql += "\n    b.CUST_CODE e4,                                 ";
			strSql += "\n    b.CUST_NAME e5,                                 ";
			strSql += "\n    ' ' e6,                                         ";
			strSql += "\n    ' ' e7,                                         ";
			strSql += "\n    ''||COUNT(*) e8,                                ";
			strSql += "\n    '0' e9,                                         ";
			strSql += "\n    ''||NVL(SUM(a.SUPAMT),0) e10,                   ";
			strSql += "\n    ''||NVL(SUM(a.VATAMT),0) e11,                   ";
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
			strSql += "\n    --AND ( a.PUBL_DT BETWEEN SF_StringToDate('"+strPUBL_DT_FR+"') AND SF_StringToDate('"+strPUBL_DT_TO+"') ) ";
			strSql += "\n    AND a.RCPTBILL_CLS =  '"+strRCPTBILL_CLS+"'     ";
			strSql += "\n    AND LENGTH(b.CUST_CODE)=10                      ";
			strSql += "\nGROUP BY                                            ";
			strSql += "\n    c.BIZNO,                                        ";
			strSql += "\n    b.CUST_CODE,                                    ";
			strSql += "\n    b.CUST_NAME                                     ";
			strSql += "\n)                                                   ";
			strSql += "\nGROUP BY                                            ";
			strSql += "\n    e2                                              ";
}

			//out.println("<pre>"+strSql+"</pre>");
			lrReturnData = com.cj.database.CITDatabase.selectQuery(strSql, lrArgData);
			for (int i = 0; i < lrReturnData.getRowsCount(); i++)
			{
				if( lrReturnData.toString(i, "E1").replace('_',' ').equals("7") ){
					String strBIZNO = lrReturnData.toString(i, "E2").replace('_',' ');
					String strFileName = "K"+strBIZNO.substring(0,7)+"."+strBIZNO.substring(7);//+".txt";
					strFileName = new String(strFileName.getBytes("euc-kr"),"8859_1");
					response.setContentType("application/x-msdownload");
					response.setHeader("Content-Disposition","attachment; filename="+strFileName);
				}
				for(int j=1;j<=16;j++){
					outStream.write(lrReturnData.toString(i, "E"+j).replace('_',' ').getBytes());
				}
				outStream.write("\r\n".getBytes());

			}

		}
		else if (strRCPTBILL_CLS.equals("02"))
		{
			strSql += "\nSELECT                                                                                                  ";
			strSql += "\n    'A' e1,                                                                                             ";
			strSql += "\n    '312' e2,                                                                             ";
			strSql += "\n    RPAD('"+strWriteDt+"', 8) e3,                                                                             ";
			strSql += "\n    '2' e4,                                                                                             ";
			strSql += "\n    RPAD('_', 6) e5,                                                                                              ";
			strSql += "\n    RPAD(a.BIZNO, 10) e6,                                                                                         ";
			strSql += "\n    RPAD(a.COMPANY_NAME, 40) e7,                                                                                  ";
			strSql += "\n    RPAD(a.BIZNO2, 13) e8,                                                                                        ";
			strSql += "\n    RPAD(a.BOSS, 30) e9,                                                                                          ";
			strSql += "\n    RPAD(a.BIZPLACE_ZIPCODE, 10) e10,                                                                             ";
			strSql += "\n    RPAD(a.BIZPLACE_ADDR1||' '||a.BIZPLACE_ADDR2, 70) e11,                                                        ";
			strSql += "\n    RPAD(a.TELNO, 15) e12,                                                                                        ";
			strSql += "\n    RPAD("+strSqlSrc02+", 5) e13,                                                                                            ";
			strSql += "\n    '101' e14,                                                                                          ";
			strSql += "\n    RPAD('_', 15) e15,                                                                                             ";
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

			strSql += "\nUNION ALL                                           ";

			strSql += "\nSELECT                                                                                                  ";
			strSql += "\n    'B' e1,                                                                                             ";
			strSql += "\n    '312' e2,                                                                             ";
			strSql += "\n    LPAD(''||1,6, '0') e3,                                                                                           ";
			strSql += "\n    a.BIZNO e4,                                                                                         ";
			strSql += "\n    RPAD(a.COMPANY_NAME, 40) e5,                                                                                  ";
			strSql += "\n    RPAD(a.BOSS, 30) e6,                                                                                          ";
			strSql += "\n    RPAD(a.BIZPLACE_ZIPCODE, 10) e7,                                                                              ";
			strSql += "\n    RPAD(a.BIZPLACE_ADDR1||' '||a.BIZPLACE_ADDR2, 70) e8,                                                         ";
			strSql += "\n    RPAD('_', 60) e9,                                                                                              ";
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

if( "1".equals(strSale)	){
			strSql += "\nUNION ALL                                           ";

			strSql += "\nSELECT                                                                                                  ";
			strSql += "\n    'C' e1,                                                                                             ";
			strSql += "\n    e2,                                                                                                 ";
			strSql += "\n    e3,                                                                                                 ";
			strSql += "\n    e4,                                                                                                 ";
			strSql += "\n    e5,                                                                                                 ";
			strSql += "\n    LPAD(''||1, 6, '0') e6,                                                                                           ";
			strSql += "\n    e7,                                                                                                 ";
			strSql += "\n    '"+strPUBL_DT_FR.substring(0,4)+"' e8,                                                              ";
			strSql += "\n    '"+strPUBL_DT_FR+"' e9,                                                                             ";
			strSql += "\n    '"+strPUBL_DT_TO+"' e10,                                                                            ";
			strSql += "\n    '"+strWriteDt+"' e11,                                                                            ";
			strSql += "\n    LPAD(''||COUNT(*), 6, '0') e12, -- 총 거래처 수                                                                   ";
			strSql += "\n    LPAD(''||SUM(e10), 6, '0') e13, -- 총 세금계산서 매수                                                             ";
			strSql += "\n    ''||(CASE WHEN SUM(e12)>=0 THEN '0' ELSE '1' END) e14, -- 총 공급금액                               ";
			strSql += "\n    LPAD(''||ABS(SUM(e12)), 14, '0') e15, -- 총 세액                                                                   ";
			strSql += "\n    LPAD(''||SUM( DECODE( LENGTH(e8), 10, 1, 0 ) ), 6, '0') e16,                                                      ";
			strSql += "\n    LPAD(''||SUM( DECODE( LENGTH(e8), 10, e10, 0 ) ), 6, '0') e17,                                                    ";
			strSql += "\n    ''||(CASE WHEN SUM( DECODE( LENGTH(e8), 10, e12, 0 ) )>=0 THEN '0' ELSE '1' END) e18, -- 총 공급금액";
			strSql += "\n    LPAD(''||ABS(SUM( DECODE( LENGTH(e8), 10, e12, 0 ) )), 14, '0') e19,                                               ";
			strSql += "\n    LPAD(''||SUM( DECODE( LENGTH(e8), 13, 1, 0 ) ), 6, '0') e20,                                                      ";
			strSql += "\n    LPAD(''||SUM( DECODE( LENGTH(e8), 13, e10, 0 ) ), 6, '0') e21,                                                    ";
			strSql += "\n    ''||(CASE WHEN SUM( DECODE( LENGTH(e8), 13, e12, 0 ) )>=0 THEN '0' ELSE '1' END) e22, -- 총 공급금액";
			strSql += "\n    LPAD(''||ABS(SUM( DECODE( LENGTH(e8), 13, e12, 0 ) )), 14, '0') e23,                                               ";
			strSql += "\n    RPAD('_', 97) e24                                                                                             ";
			strSql += "\nFROM                                                                                                    ";
			strSql += "\n(                                                                                                       ";
			strSql += "\nSELECT                                                                                                  ";
			strSql += "\n    'D' e1,                                                                                             ";
			strSql += "\n    '17' e2,                                                                                            ";
			strSql += "\n    (CASE WHEN SUBSTR('"+strPUBL_DT_TO+"',5,2)<'07' THEN '1' ELSE '2' END) e3,                                                                                             ";
			strSql += "\n    '2' e4,                                                                                             ";
			strSql += "\n    '312' e5,                                                                             ";
			strSql += "\n    '' e6,                                                                                              ";
			strSql += "\n    c.BIZNO e7,                                                                                         ";
			strSql += "\n    b.CUST_CODE e8,                                                                                     ";
			strSql += "\n    b.CUST_NAME e9,                                                                                     ";
			strSql += "\n    ''||COUNT(*) e10,                                                                                   ";
			strSql += "\n    '' e11,                                                                                             ";
			strSql += "\n    ''||SUM(NVL(a.VATAMT,0)+NVL(a.SUPAMT,0)) e12,                                                                     ";
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
			strSql += "\n    AND a.TAX_COMP_CODE =  '"+strCOMP_CODE+"'                                                         ";
			strSql += "\n    --AND ( a.PUBL_DT BETWEEN SF_StringToDate('"+strPUBL_DT_FR+"') AND SF_StringToDate('"+strPUBL_DT_TO+"') ) ";
			strSql += "\n    AND a.RCPTBILL_CLS =  '"+strRCPTBILL_CLS+"'     ";
			strSql += "\nGROUP BY                                                                                                ";
			strSql += "\n    c.BIZNO,                                                                                            ";
			strSql += "\n    b.CUST_CODE,                                                                                        ";
			strSql += "\n    b.CUST_NAME                                                                                         ";
			strSql += "\n)                                                                                                       ";
			strSql += "\nGROUP BY                                                                                                ";
			strSql += "\n    e2,                                                                                                 ";
			strSql += "\n    e2,                                                                                                 ";
			strSql += "\n    e3,                                                                                                 ";
			strSql += "\n    e4,                                                                                                 ";
			strSql += "\n    e5,                                                                                                 ";
			strSql += "\n    e7                                                                                                  ";

			strSql += "\nUNION ALL                                           ";

			strSql += "\nSELECT                                                                                                  ";
			strSql += "\n    e1,                                                                                                 ";
			strSql += "\n    e2,                                                                                                 ";
			strSql += "\n    e3,                                                                                                 ";
			strSql += "\n    e4,                                                                                                 ";
			strSql += "\n    e5,                                                                                                 ";
			strSql += "\n    LPAD(''||rownum, 6, '0') e6,                                                                                      ";
			strSql += "\n    e7,                                                                                                 ";
			strSql += "\n    e8,                                                                                                 ";
			strSql += "\n    RPAD(e9, 40) e9,                                                                                                 ";
			strSql += "\n    LPAD(e10, 5, '0') e10,                                                                                                ";
			strSql += "\n    e11,                                                                                                ";
			strSql += "\n    LPAD(e12, 14, '0') e12,                                                                                                ";
			strSql += "\n    RPAD('_', 136) e13,                                                                                                ";
			strSql += "\n    '' e14,                                                                                                ";
			strSql += "\n    '' e15,                                                                                                ";
			strSql += "\n    '' e16,                                                                                                ";
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
			strSql += "\n    '2' e4,                                                                                             ";
			strSql += "\n    '312' e5,                                                                             ";
			strSql += "\n    '' e6,                                                                                              ";
			strSql += "\n    c.BIZNO e7,                                                                                         ";
			strSql += "\n    b.CUST_CODE e8,                                                                                     ";
			strSql += "\n    b.CUST_NAME e9,                                                                                     ";
			strSql += "\n    ''||COUNT(*) e10,                                                                                   ";
			strSql += "\n    ''||(CASE WHEN SUM(NVL(a.VATAMT,0)+NVL(a.SUPAMT,0))>=0 THEN '0' ELSE '1' END) e11,                                ";
			strSql += "\n    ''||ABS(SUM(NVL(a.VATAMT,0)+NVL(a.SUPAMT,0))) e12                                                                ";
			strSql += "\nFROM                                                                                                    ";
			strSql += "\n    "+strSqlSrc+" a,                                                                            ";
			strSql += "\n    T_CUST_CODE b,                                                                                         ";
			strSql += "\n    T_COMPANY c                                                                                       ";
			strSql += "\nWHERE                                                                                                   ";
			strSql += "\n    a.SALEBUY_CLS = '1'                                                                                 ";
			strSql += "\n    AND b.CUST_SEQ = a.CUST_SEQ                                                                       ";
			//strSql += "\n    AND c.COMP_CODE = a.COMP_CODE             ";
			strSql += "\n    AND c.COMP_CODE = a.TAX_COMP_CODE             ";
			strSql += "\n    AND a.TAX_COMP_CODE =  '"+strCOMP_CODE+"'                                                         ";
			strSql += "\n    --AND ( a.PUBL_DT BETWEEN SF_StringToDate('"+strPUBL_DT_FR+"') AND SF_StringToDate('"+strPUBL_DT_TO+"') ) ";
			strSql += "\n    AND a.RCPTBILL_CLS =  '"+strRCPTBILL_CLS+"'     ";
			strSql += "\nGROUP BY                                                                                                ";
			strSql += "\n    c.BIZNO,                                                                                            ";
			strSql += "\n    b.CUST_CODE,                                                                                        ";
			strSql += "\n    b.CUST_NAME                                                                                         ";
			strSql += "\n)                                                                                                       ";
}

if( "1".equals(strSell)	){
			strSql += "\nUNION ALL                                           ";

			strSql += "\nSELECT                                                                                                  ";
			strSql += "\n    'C' e1,                                                                                             ";
			strSql += "\n    e2,                                                                                                 ";
			strSql += "\n    e3,                                                                                                 ";
			strSql += "\n    e4,                                                                                                 ";
			strSql += "\n    e5,                                                                                                 ";
			strSql += "\n    LPAD(''||1, 6, '0') e6,                                                                                           ";
			strSql += "\n    e7,                                                                                                 ";
			strSql += "\n    '"+strPUBL_DT_FR.substring(0,4)+"' e8,                                                              ";
			strSql += "\n    '"+strPUBL_DT_FR+"' e9,                                                                             ";
			strSql += "\n    '"+strPUBL_DT_TO+"' e10,                                                                            ";
			strSql += "\n    '"+strWriteDt+"' e11,                                                                                   ";
			strSql += "\n    LPAD(''||COUNT(*), 6, '0') e12, -- 총 거래처 수                                                                   ";
			strSql += "\n    LPAD(''||SUM(e10), 6, '0') e13, -- 총 세금계산서 매수                                                             ";
			strSql += "\n    ''||(CASE WHEN SUM(e12)>=0 THEN '0' ELSE '1' END) e14, -- 총 공급금액                               ";
			strSql += "\n    LPAD(''||ABS(SUM(e12)), 14, '0') e15, -- 총 세액                                                                   ";
			strSql += "\n    RPAD('_', 151) e16,                                                                                             ";
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
			strSql += "\n    '2' e4,                                                                                             ";
			strSql += "\n    '312' e5,                                                                             ";
			strSql += "\n    '' e6,                                                                                              ";
			strSql += "\n    c.BIZNO e7,                                                                                         ";
			strSql += "\n    b.CUST_CODE e8,                                                                                     ";
			strSql += "\n    b.CUST_NAME e9,                                                                                     ";
			strSql += "\n    ''||COUNT(*) e10,                                                                                   ";
			strSql += "\n    '' e11,                                                                                             ";
			strSql += "\n    ''||SUM(NVL(a.VATAMT,0)+NVL(a.SUPAMT,0)) e12,                                                                     ";
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
			strSql += "\n    AND a.TAX_COMP_CODE =  '"+strCOMP_CODE+"'                                                                         ";
			strSql += "\n    --AND ( a.PUBL_DT BETWEEN SF_StringToDate('"+strPUBL_DT_FR+"') AND SF_StringToDate('"+strPUBL_DT_TO+"') ) ";
			strSql += "\n    AND a.RCPTBILL_CLS =  '"+strRCPTBILL_CLS+"'     ";
			strSql += "\n    AND LENGTH(b.CUST_CODE)=10                                                                          ";
			strSql += "\nGROUP BY                                                                                                ";
			strSql += "\n    c.BIZNO,                                                                                            ";
			strSql += "\n    b.CUST_CODE,                                                                                        ";
			strSql += "\n    b.CUST_NAME                                                                                         ";
			strSql += "\n)                                                                                                       ";
			strSql += "\nGROUP BY                                                                                                ";
			strSql += "\n    e2,                                                                                                 ";
			strSql += "\n    e2,                                                                                                 ";
			strSql += "\n    e3,                                                                                                 ";
			strSql += "\n    e4,                                                                                                 ";
			strSql += "\n    e5,                                                                                                 ";
			strSql += "\n    e7                                                                                                  ";

			strSql += "\nUNION ALL                                           ";

			strSql += "\nSELECT                                                                                                  ";
			strSql += "\n    e1,                                                                                                 ";
			strSql += "\n    e2,                                                                                                 ";
			strSql += "\n    e3,                                                                                                 ";
			strSql += "\n    e4,                                                                                                 ";
			strSql += "\n    e5,                                                                                                 ";
			strSql += "\n    LPAD(''||rownum, 6, '0') e6,                                                                                      ";
			strSql += "\n    e7,                                                                                                 ";
			strSql += "\n    e8,                                                                                                 ";
			strSql += "\n    RPAD(e9, 40) e9,                                                                                                 ";
			strSql += "\n    LPAD(e10, 5, '0') e10,                                                                                                ";
			strSql += "\n    e11,                                                                                                ";
			strSql += "\n    LPAD(e12, 14, '0') e12,                                                                                                ";
			strSql += "\n    RPAD('_',136) e13,                                                                                                ";
			strSql += "\n    '' e14,                                                                                                ";
			strSql += "\n    '' e15,                                                                                                ";
			strSql += "\n    '' e16,                                                                                                ";
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
			strSql += "\n    '2' e4,                                                                                             ";
			strSql += "\n    '312' e5,                                                                             ";
			strSql += "\n    '' e6,                                                                                              ";
			strSql += "\n    c.BIZNO e7,                                                                                         ";
			strSql += "\n    b.CUST_CODE e8,                                                                                     ";
			strSql += "\n    b.CUST_NAME e9,                                                                                     ";
			strSql += "\n    ''||COUNT(*) e10,                                                                                   ";
			strSql += "\n    ''||(CASE WHEN SUM(NVL(a.VATAMT,0)+NVL(a.SUPAMT,0))>=0 THEN '0' ELSE '1' END) e11,                                ";
			strSql += "\n    ''||ABS(SUM(NVL(a.VATAMT,0)+NVL(a.SUPAMT,0))) e12                                                                ";
			strSql += "\nFROM                                                                                                    ";
			strSql += "\n    "+strSqlSrc+" a,                                                                            ";
			strSql += "\n    T_CUST_CODE b,                                                                                         ";
			strSql += "\n    T_COMPANY c                                                                                       ";
			strSql += "\nWHERE                                                                                                   ";
			strSql += "\n    a.SALEBUY_CLS = '2'                                                                                 ";
			strSql += "\n    AND b.CUST_SEQ = a.CUST_SEQ                                                                       ";
			//strSql += "\n    AND c.COMP_CODE = a.COMP_CODE             ";
			strSql += "\n    AND c.COMP_CODE = a.TAX_COMP_CODE             ";
			strSql += "\n    AND a.TAX_COMP_CODE =  '"+strCOMP_CODE+"'                                                         ";
			strSql += "\n    --AND ( a.PUBL_DT BETWEEN SF_StringToDate('"+strPUBL_DT_FR+"') AND SF_StringToDate('"+strPUBL_DT_TO+"') ) ";
			strSql += "\n    AND a.RCPTBILL_CLS =  '"+strRCPTBILL_CLS+"'     ";
			strSql += "\n    AND LENGTH(b.CUST_CODE)=10                                                                          ";
			strSql += "\nGROUP BY                                                                                                ";
			strSql += "\n    c.BIZNO,                                                                                            ";
			strSql += "\n    b.CUST_CODE,                                                                                        ";
			strSql += "\n    b.CUST_NAME                                                                                         ";
			strSql += "\n)                                                                                                       ";  
}

			
			
			lrReturnData = com.cj.database.CITDatabase.selectQuery(strSql, lrArgData);
			for (int i = 0; i < lrReturnData.getRowsCount(); i++)
			{
				if( lrReturnData.toString(i, "E1").replace('_',' ').equals("A") ) {
					String strBIZNO = lrReturnData.toString(i, "E6").replace('_',' ');
					String strFileName = "H"+strBIZNO.substring(0,7)+"."+strBIZNO.substring(7);//+".txt";
					strFileName = new String(strFileName.getBytes("euc-kr"),"8859_1");
					response.setContentType("application/x-msdownload");
					response.setHeader("Content-Disposition","attachment; filename="+strFileName);
				}
				for(int j=1;j<=24;j++){
					outStream.write(lrReturnData.toString(i, "E"+j).replace('_',' ').getBytes());
				}
				outStream.write("\r\n".getBytes());
			}

		} // else if...

	}
	catch (Exception ex)
	{
		throw new Exception("USER-900001: Select 오류 -> " + ex.getMessage());
	} finally {
	}

	outStream.close();
%>
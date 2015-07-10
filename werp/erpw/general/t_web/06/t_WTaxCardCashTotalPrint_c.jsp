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
	strSqlSrc  += "		AND B.RCPTBILL_CLS IN ('21','22') \n";
	strSqlSrc  += "	) \n";

	strSqlSrc01   = "	( \n";
	strSqlSrc01  += "	SELECT \n";
	strSqlSrc01  += "		DISTINCT A.COMP_CODE \n";
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
	strSqlSrc01  += "		AND B.RCPTBILL_CLS IN ('21','22') \n";
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

		strSql  = "Select  \n";
		strSql  += "	'HR' e1, \n";
		strSql  += "	'"+strTAX_YEAR+"' e2, \n";
		strSql  += "	'"+strTAX_GI+"'  e3 ,  \n";
		strSql  += "	'"+strTAX_CONF+"'  e4 ,  \n";
		strSql  += "	RPAD(a.BIZNO,10,' ') e5 , \n";
		strSql  += "	RPAD(a.COMPANY_NAME,60,' ') e6 , \n";
		strSql  += "	RPAD(a.BOSS,30,' ') e7 , \n";
		strSql  += "	RPAD('_'||a.BIZNO2,13,'_') e8 , \n";
		strSql  += "	'"+strWriteDt+"'  e9 , \n";
		strSql  += "	'"+strPUBL_DT_FR.substring(0,6)+"' e10 , \n";
		strSql  += "	'"+strPUBL_DT_TO.substring(0,6)+"' e11 , \n";
		strSql  += "	RPAD('_',9) e12 , \n";
		strSql  += "	'' e13 , \n";
		strSql  += "	'' e14 , \n";
		strSql  += "	'' e15 , \n";
		strSql  += "	'' e16 , \n";
		strSql  += "	'' e17 , \n";
		strSql  += "	'' e18 , \n";
		strSql  += "	'' e19 , \n";
		strSql  += "	'' e20 , \n";
		strSql  += "	'' e21  \n";
		strSql += "FROM                                       \n";
		strSql += "    T_COMPANY a                            \n";
		strSql += "WHERE                                      \n";
		strSql += "    a.COMP_CODE IN "+strSqlSrc01+"         \n";

		strSql += "\nUNION ALL                                           ";

		strSql  += "Select  \n";
		strSql  += "	'DR' e1, \n";
		strSql  += "	'"+strTAX_YEAR+"' e2, \n";
		strSql  += "	'"+strTAX_GI+"'  e3 ,  \n";
		strSql  += "	'"+strTAX_CONF+"'  e4 ,  \n";
		strSql  += "	RPAD(c.BIZNO,10,' ') e5 , \n";
		strSql  += "	LPAD(ROWNUM,6,0) e6 , \n";
		strSql  += "	RPAD(replace(a.CARD_CASH_NO,'-'),20,' ') e7 , \n";
		strSql  += "	RPAD(b.CUST_CODE,10,' ') e8 , \n";
		strSql  += "	replace(F_T_Datetostring(a.PUBL_DT),'-','') e9 , \n";
		strSql  += "	(Case When a.SUPAMT >= 0 Then	'0' Else '1' End)  e10 , \n";
		strSql  += "	LPAD(a.SUPAMT,13,0) e11 , \n";
		strSql  += "	(Case When a.VATAMT >= 0 Then	'0' Else '1' End)  e12 , \n";
		strSql  += "	LPAD(''||a.VATAMT,13,0) e13 , \n";
		strSql  += "	RPAD('_', 60) e14  , \n";
		strSql  += "	'' e15 , \n";
		strSql  += "	'' e16 , \n";
		strSql  += "	'' e17 , \n";
		strSql  += "	'' e18 , \n";
		strSql  += "	'' e19 , \n";
		strSql  += "	'' e20 , \n";
		strSql  += "	'' e21  \n";
		strSql += "\nFROM                                                ";
		strSql += "\n    "+strSqlSrc+" a,								";
		strSql += "\n    T_CUST_CODE b,                                 ";
		strSql += "\n    T_COMPANY c                                   ";
		strSql += "\nWHERE                                               ";
		strSql += "\n    a.SALEBUY_CLS = '2'                             ";
		strSql += "\n    AND b.CUST_SEQ = a.CUST_SEQ                   ";
		strSql += "\n    AND c.COMP_CODE = a.COMP_CODE             ";
		strSql += "\n    AND a.TAX_COMP_CODE =  '"+strCOMP_CODE+"'     ";
		strSql += "\n    --AND ( a.PUBL_DT BETWEEN F_T_StringToDate('"+strPUBL_DT_FR+"') AND F_T_StringToDate('"+strPUBL_DT_TO+"') ) ";
		strSql += "\n    AND a.RCPTBILL_CLS IN ('21','22')     ";

		strSql += "\nUNION ALL                                           ";

		strSql += "Select  \n";
		strSql += "	'TR' e1 , \n";
		strSql += "	'"+strTAX_YEAR+"' e2, \n";
		strSql += "	'"+strTAX_GI+"'  e3 ,  \n";
		strSql += "	'"+strTAX_CONF+"'  e4 ,  \n";
		strSql += "	RPAD(c.BIZNO,10,' ') e5 , \n";
		strSql += "	LPAD(''||Count(*),9,0) e6 , \n";
		strSql += "	''||(Case 		When 	Sum(a.SUPAMT) >= 0 Then	'0' Else '1' End)  e7 , \n";
		strSql += "	LPAD(''||Sum(a.SUPAMT),15,0) e8, \n";
		strSql += "	''||(Case 		When 	Sum(a.VATAMT) >= 0 Then	'0' Else '1' End)  e9 , \n";
		strSql += "	LPAD(''||Sum(a.VATAMT),15,0) e10 , \n";
		strSql += "	LPAD(''||Sum(Case	When	a.RCPTBILL_CLS = '21'	Then  1 	Else 0	End),9,0) e11 ,  \n";
		strSql += "	''||(Case 		When 	Sum(case	When 	a.RCPTBILL_CLS = '21'	Then	a.SUPAMT	Else 0 End) >=0  \n";
		strSql += "				Then	'0' Else '1' End)  e12 , \n";
		strSql += "	LPAD(''||Sum(case	When 	a.RCPTBILL_CLS = '21'	Then	a.SUPAMT	Else 0 End),15,0) e13  ,  \n";
		strSql += "	''||(Case 		When 	Sum(case	When 	a.RCPTBILL_CLS = '21'	Then	a.VATAMT	Else 0 End) >=0  \n";
		strSql += "				Then	'0' Else '1' End)  e14 , \n";
		strSql += "	LPAD(''||Sum(case	When 	a.RCPTBILL_CLS = '21'	Then	a.VATAMT	Else 0 End),15,0) e15 , \n";
		strSql += "	LPAD(''||Sum(Case	When	a.RCPTBILL_CLS = '22'	Then  1 	Else 0	End),9,0) e16 ,  \n";
		strSql += "	''||(Case 		When 	Sum(case	When 	a.RCPTBILL_CLS = '22'	Then	a.SUPAMT	Else 0 End) >=0  \n";
		strSql += "				Then	'0' Else '1' End)  e17 , \n";
		strSql += "	LPAD(''||Sum(case	When 	a.RCPTBILL_CLS = '22'	Then	a.SUPAMT	Else 0 End),15,0) e18  ,  \n";
		strSql += "	''||(Case 		When 	Sum(case	When 	a.RCPTBILL_CLS = '22'	Then	a.VATAMT	Else 0 End) >=0  \n";
		strSql += "				Then	'0' Else '1' End)  e19 , \n";
		strSql += "	LPAD(''||Sum(case	When 	a.RCPTBILL_CLS = '22'	Then	a.VATAMT	Else 0 End),15,0) e20 , \n";
		strSql += "	RPAD('_', 9) e21  \n";
		strSql += "\nFROM                                                ";
		strSql += "\n    "+strSqlSrc+" a,								";
		strSql += "\n    T_CUST_CODE b,                                 ";
		strSql += "\n    T_COMPANY c                                   ";
		strSql += "\nWHERE                                               ";
		strSql += "\n    a.SALEBUY_CLS = '2'                             ";
		strSql += "\n    AND b.CUST_SEQ = a.CUST_SEQ                   ";
		strSql += "\n    AND c.COMP_CODE = a.COMP_CODE             ";
		strSql += "\n    AND a.TAX_COMP_CODE =  '"+strCOMP_CODE+"'     ";
		strSql += "\n    --AND ( a.PUBL_DT BETWEEN F_T_StringToDate('"+strPUBL_DT_FR+"') AND F_T_StringToDate('"+strPUBL_DT_TO+"') ) ";
		strSql += "\n    AND a.RCPTBILL_CLS IN ('21','22')     ";
		strSql  += "Group By \n";
		strSql  += "	c.BIZNO  \n";

		//out.println(strSql);

			
		lrReturnData = com.cj.database.CITDatabase.selectQuery(strSql, lrArgData);
		for (int i = 0; i < lrReturnData.getRowsCount(); i++)
		{
			if( lrReturnData.toString(i, "E1").replace('_',' ').equals("HR") ) {
				String strBIZNO = lrReturnData.toString(i, "E5").replace('_',' ');
				String strFileName = "J"+strBIZNO.substring(0,7)+"."+strBIZNO.substring(7);//+".txt";
				strFileName = new String(strFileName.getBytes("euc-kr"),"8859_1");
				response.setContentType("application/x-msdownload");
				response.setHeader("Content-Disposition","attachment; filename="+strFileName);
			}
			for(int j=1;j<=21;j++){
				outStream.write(lrReturnData.toString(i, "E"+j).replace('_',' ').getBytes());
			}
			outStream.write("\r\n".getBytes());
		}


	}
	catch (Exception ex)
	{
		throw new Exception("USER-900001: Select 오류 -> " + ex.getMessage());
	} finally {
	}

	outStream.close();
%>
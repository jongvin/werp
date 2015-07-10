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
		strSqlSrc  += "		B.*, \n";
		strSqlSrc  += " 	--A.SLIP_ID,   \n";
		strSqlSrc  += " 	--A.SLIP_IDSEQ,   \n";
		strSqlSrc  += " 	c1.MAKE_SLIPNO||'-'||c2.MAKE_SLIPLINE MAKE_SLIPNOLINE,   \n";
		strSqlSrc  += "     -- 전표조회 인자     \n";
		strSqlSrc  += "     c1.MAKE_COMP_CODE ,      \n";
		strSqlSrc  += "     F_T_Datetostring(c1.MAKE_DT) MAKE_DT,      \n";
		strSqlSrc  += "     c1.MAKE_SEQ ,      \n";
		strSqlSrc  += "     c1.SLIP_KIND_TAG    \n";
		strSqlSrc  += "	FROM \n";
		strSqlSrc  += "		T_ACC_SLIP_BILL_HEAD A, \n";
		strSqlSrc  += "		T_ACC_TAX_BILL_MEDIA_RPT B, \n";
		strSqlSrc  += " 	T_ACC_SLIP_HEAD C1,  \n";
		strSqlSrc  += " 	T_ACC_SLIP_BODY1 C2  \n";
		strSqlSrc  += "	WHERE \n";
		strSqlSrc  += "		A.COMP_CODE = B.COMP_CODE \n";
		strSqlSrc  += "		AND A.WORK_NO = B.WORK_NO \n";
		strSqlSrc  += " 	AND B.SLIP_ID = C1.SLIP_ID(+)   \n";
		strSqlSrc  += " 	AND B.SLIP_ID = C2.SLIP_ID(+)   \n";
		strSqlSrc  += " 	AND B.SLIP_IDSEQ = C2.SLIP_IDSEQ(+)   \n";
		strSqlSrc  += "		AND A.APPLY_TAG = 'T' \n";
		strSqlSrc  += "		AND A.TAX_YEAR = '"+strTAX_YEAR+"' \n";
		strSqlSrc  += "		AND A.TAX_GI = '"+strTAX_GI+"' \n";
		strSqlSrc  += "		AND A.TAX_CONF = '"+strTAX_CONF+"' \n";
		strSqlSrc  += "		AND B.TAX_COMP_CODE = '"+strCOMP_CODE+"' \n";
		strSqlSrc  += "		AND B.RCPTBILL_CLS IN ('21','22') \n";
		strSqlSrc  += "		ORDER BY \n";
		strSqlSrc  += "			B.PUBL_DT \n";
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
			strSql  = "Select  \n";
			strSql  += "	'HR' e1, \n";
			strSql  += "	'"+strTAX_YEAR+"' e2, \n";
			strSql  += "	'"+strTAX_GI+"'  e3 ,  \n";
			strSql  += "	'"+strTAX_CONF+"'  e4 ,  \n";
			strSql  += "	RPAD(a.BIZNO,10,' ') e5 , \n";
			strSql  += "	RPAD(a.COMPANY_NAME,60,' ') e6 , \n";
			strSql  += "	RPAD(a.BOSS,30,' ') e7 , \n";
			strSql  += "	RPAD(a.BIZNO2,13,' ') e8 , \n";
			strSql  += "	'"+strWriteDt+"'  e9 , \n";
			strSql  += "	'"+strPUBL_DT_FR.substring(0,6)+"' e10 , \n";
			strSql  += "	'"+strPUBL_DT_TO.substring(0,6)+"' e11 , \n";
			strSql  += "	RPAD('_',9,' ') e12 , \n";
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
			strSql  += "	RPAD('_',60,' ') e14  , \n";
			strSql  += "	'' e15 , \n";
			strSql  += "	'' e16 , \n";
			strSql  += "	'' e17 , \n";
			strSql  += "	'' e18 , \n";
			strSql  += "	'' e19 , \n";
			strSql  += "	'' e20 , \n";
			strSql  += "	'' e21 , \n";
			strSql  += " 	A.SLIP_ID,   \n";
			strSql  += " 	A.SLIP_IDSEQ,   \n";
			strSql  += " 	A.MAKE_SLIPNOLINE,   \n";
			strSql  += "    -- 전표조회 인자     \n";
			strSql  += "    A.MAKE_COMP_CODE ,      \n";
			strSql  += "    A.MAKE_DT,      \n";
			strSql  += "    A.MAKE_SEQ ,      \n";
			strSql  += "    A.SLIP_KIND_TAG    \n";
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
			strSql  = "Select  \n";
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
			strSql += "	RPAD('_',9,' ') e21  \n";
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
			strSql  += "Order By \n";
			strSql  += "	c.BIZNO \n";

			
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
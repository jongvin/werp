<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 배민정 작성(2006-01-20)
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
			String	strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String	strREQUEST_YMD = CITCommon.toKOR(request.getParameter("REQUEST_YMD"));
			String	strTRANSFER_STATUS = CITCommon.toKOR(request.getParameter("TRANSFER_STATUS"));
			String	strOUTACCNO_CODE = CITCommon.toKOR(request.getParameter("OUTACCNO_CODE"));
			String	strOUTBANK_CODE = CITCommon.toKOR(request.getParameter("OUTBANK_CODE"));
			String	strINACCNO_CODE = CITCommon.toKOR(request.getParameter("INACCNO_CODE"));
			String	strINBANK_CODE = CITCommon.toKOR(request.getParameter("INBANK_CODE"));			

			strSql =
				"Select					      "+"\r\n"+
				"	a.TRANSFER_SEQ ,		"+"\r\n"+
				"	'F' SELECT_YN  ,		"+"\r\n"+
				"	a.OUT_BANK_CODE,    "+"\r\n"+
				"	c.BANK_MAIN_NAME OUT_BANK_NAME,  "+"\r\n"+
				"	a.OUT_ACCOUNT_NO ,	"+"\r\n"+
				"	a.IN_BANK_CODE   ,	"+"\r\n"+
				"	d.BANK_MAIN_NAME IN_BANK_NAME,   "+"\r\n"+
				"	a.IN_ACCOUNT_NO  , 	"+"\r\n"+	
				"	TO_NUMBER(SUBSTR(e.MAX_VAL,9,20)) REMAIN_AMT , 	"+"\r\n"+	
				"	SUBSTR(e.MAX_VAL,1,8) STD_YMD , 	"+"\r\n"+	
				"	a.TRANSFER_AMT  , 	"+"\r\n"+	
				"	F_T_DATETOSTRING(a.TRANSFER_YMD) TRANSFER_YMD  , 	"+"\r\n"+	
				"	a.REQUEST_YMD   , 	"+"\r\n"+	
				"	a.FUND_TRANSFER_STATUS TRANSFER_STATUS , "+"\r\n"+	
				"	b.NAME TRANSFER_STATUS_NAME , "+"\r\n"+	
				"	a.DESCRIPTION  , "+"\r\n"+	
				"	''||f.SLIP_ID SLIP_ID,    "+"\r\n"+	
				"	f.MAKE_SLIPNO,    "+"\r\n"+
				"	DECODE(f.SLIP_ID, null, 'F', 'T') MAKE_CLS,    "+"\r\n"+	
				"	DECODE(f.KEEP_DT_TRANS, null, 'F', 'T') KEEP_CLS,    "+"\r\n"+	
				" 	-- 전표조회 인자 "+"\r\n"+
				" 	f.MAKE_COMP_CODE ,  "+"\r\n"+
				" 	F_T_DateToString(f.MAKE_DT) MAKE_DT,  "+"\r\n"+
				" 	f.MAKE_SEQ ,  "+"\r\n"+
				" 	f.SLIP_KIND_TAG "+"\r\n"+
				"From	T_FB_CASH_TRANSFER_DATA a , "+"\r\n"+
				"    	T_BANK_MAIN             c , "+"\r\n"+
				"    	T_BANK_MAIN             d , "+"\r\n"+
				"    	T_ACC_SLIP_HEAD         f , "+"\r\n"+
				"    	( SELECT BANK_CODE, ACCOUNT_NO, MAX(STD_YMD||LPAD(REMAIN_AMT,20,'0')) MAX_VAL "+"\r\n"+
				"       FROM T_FB_ACCT_REMAIN_DATA  "+"\r\n"+
				"       GROUP BY BANK_CODE,ACCOUNT_NO ) e ,  "+"\r\n"+
				"     ( select LOOKUP_CODE  CODE, "+"\n"+
				"	             LOOKUP_VALUE NAME  "+"\n"+
				"       from	T_FB_LOOKUP_VALUES    "+"\n"+
				"       where lookup_type = upper('FUND_TRANSFER_STATUS') "+"\n"+
				"       and   use_yn      = 'Y'       ) b "+"\n"+        
				"Where a.OUT_BANK_CODE   = e.BANK_CODE(+)      "+"\r\n"+
				"And   replace(a.OUT_ACCOUNT_NO,'-','')  = e.ACCOUNT_NO(+)     "+"\r\n"+
				"And   a.OUT_BANK_CODE   = c.BANK_MAIN_CODE(+) "+"\r\n"+
				"And   a.IN_BANK_CODE    = d.BANK_MAIN_CODE(+) "+"\r\n"+				
				"And   a.FUND_TRANSFER_STATUS = b.CODE(+) "+"\r\n"+
				"And   a.SLIP_ID = f.SLIP_ID(+) "+"\r\n"+
				"And   a.COMP_CODE       = ? "+"\r\n"+
				"And 	 a.REQUEST_YMD     = F_T_STRINGTODATE(?) "+"\r\n"+
				"And 	 a.FUND_TRANSFER_STATUS LIKE ?||'%' "+"\r\n" ;
				if(!"".equals(strOUTACCNO_CODE)) strSql
				+= "And 	 a.OUT_ACCOUNT_NO   = ? "+"\r\n" +
				"And 	 a.OUT_BANK_CODE  = ? "+"\r\n" ;
				if(!"".equals(strINACCNO_CODE)) strSql
				+= "And 	 a.IN_ACCOUNT_NO    = ? "+"\r\n" +
				"And 	 a.IN_BANK_CODE   = SUBSTR(?,1,2) "+"\r\n" ;			
				strSql += "Order By	a.COMP_CODE ,a.OUT_BANK_CODE ";

			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("REQUEST_YMD",CITData.VARCHAR2);
			lrArgData.addColumn("TRANSFER_STATUS",CITData.VARCHAR2);
			if(!"".equals(strOUTACCNO_CODE)) lrArgData.addColumn("OUTACCNO_CODE",CITData.VARCHAR2);
			if(!"".equals(strOUTACCNO_CODE)) lrArgData.addColumn("OUTBANK_CODE",CITData.VARCHAR2);
			if(!"".equals(strINACCNO_CODE)) lrArgData.addColumn("INACCNO_CODE",CITData.VARCHAR2);
			if(!"".equals(strINACCNO_CODE)) lrArgData.addColumn("INBANK_CODE",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE",strCOMP_CODE);
			lrArgData.setValue("REQUEST_YMD",strREQUEST_YMD);
			lrArgData.setValue("TRANSFER_STATUS",strTRANSFER_STATUS);
			if(!"".equals(strOUTACCNO_CODE)) lrArgData.setValue("OUTACCNO_CODE",strOUTACCNO_CODE);
			if(!"".equals(strOUTACCNO_CODE)) lrArgData.setValue("OUTBANK_CODE",strOUTBANK_CODE);
			if(!"".equals(strINACCNO_CODE)) lrArgData.setValue("INACCNO_CODE",strINACCNO_CODE);
			if(!"".equals(strINACCNO_CODE)) lrArgData.setValue("INBANK_CODE",strINBANK_CODE);

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
		}
		else if (strAct.equals("COPY"))
		{			
			strSql  = " Select 'XXXXXXXXXX' REQUEST_YMD , "+"\r\n"+
			          "        'XXXXXXXXXXXXXXXXXXXX' OUTACCOUNT_CODE , "+"\r\n"+
			          "        'XX' OUTBANK_CODE , "+"\r\n"+
			          "        'XXXXXXXXXXXXXXXXXXXX' INACCOUNT_CODE , "+"\r\n"+
			          "        'XX' INBANK_CODE , "+"\r\n"+
			          "        0 TRANSFER_AMT , "+"\r\n"+
			          "        0 TRANSFER_SEQ , "+"\r\n"+
			          "        'XX' COMP_CODE , "+"\r\n"+
			          "        RPAD('X',500,'X') DESCRIPTION "+"\r\n"+
			          " from dual ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

		}
		else if (strAct.equals("DAY_CLOSE"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strCLSE_DAY = CITCommon.toKOR(request.getParameter("CLSE_DAY"));
			
			strSql  = " SELECT \n";
			strSql += " 	ROWNUM, \n";
			strSql += " 	A.COMP_CODE,   \n";
			strSql += " 	A.CLSE_ACC_ID,   \n";
			strSql += " 	A.ACC_ID,   \n";
			strSql += " 	F_T_DATETOSTRING(A.ACCOUNT_FDT) ACCOUNT_FDT,   \n";
			strSql += " 	F_T_DATETOSTRING(A.ACCOUNT_EDT) ACCOUNT_EDT,   \n";
			strSql += " 	NVL(A.CLSE_CLS, 'F') ACC_CLSE_CLS,   \n";
			strSql += " 	B.CLSE_MONTH,   \n";
			strSql += " 	NVL(B.CLSE_CLS, 'F') MON_CLSE_CLS, 				  \n";
			strSql += " 	F_T_DateToString(C.CLSE_DAY) CLSE_DAY,   \n";
			strSql += " 	NVL(C.CLSE_CLS, 'F') DAY_CLSE_CLS ,  \n";
			strSql += " 	D.INPUT_DT_F, \n";
			strSql += " 	D.INPUT_DT_T, \n";
			strSql += " 	D.INPUT_DT_F||'~'||D.INPUT_DT_T INPUT_DT, \n";
			strSql += " 	D.DEPT_CLSE_CLS, \n";
			strSql += " 	(  \n";
			strSql += " 		CASE  \n";
			strSql += " 			WHEN (A.CLSE_CLS='T') OR (B.CLSE_CLS='T') OR (B.CLSE_CLS='T') OR (D.DEPT_CLSE_CLS='T') THEN 'T'  \n";
			strSql += " 			ELSE 'F'  \n";
			strSql += " 		END  \n";
			strSql += " 	) CLSE_CLS \n";
			strSql += " FROM  \n";
			strSql += " 	T_YEAR_CLOSE A,  \n";
			strSql += " 	T_MONTH_CLOSE B,  \n";
			strSql += " 	T_DAY_CLOSE C, \n";
			strSql += " 	( \n";
			strSql += " 	 	-- 부서 입력기간 체크 \n";
			strSql += " 		SELECT \n";
			strSql += " 			 ROWNUM RN, \n";
			strSql += " 			 F_T_DATETOSTRING(NVL(INPUT_DT_F, '19000101')) INPUT_DT_F, \n";
			strSql += " 			 F_T_DATETOSTRING(NVL(INPUT_DT_T, '19000101')) INPUT_DT_T, \n";
			strSql += " 			 CASE \n";
			strSql += " 			 	 WHEN ( F_T_DATETOSTRING(F_T_STRINGTODATE(?)) BETWEEN F_T_DATETOSTRING(NVL(INPUT_DT_F, '19000101')) AND F_T_DATETOSTRING(NVL(INPUT_DT_T, '19000101')) ) \n";
			strSql += " 				 THEN 'F' -- 입력기간 \n";
			strSql += " 				 ELSE 'T' -- 입력마감 \n";
			strSql += " 			END DEPT_CLSE_CLS \n";
			strSql += " 		FROM \n";
			strSql += " 			T_DEPT_CODE_ORG A \n";
			strSql += " 		WHERE   \n";
			strSql += " 			A.COMP_CODE = ? \n";
			strSql += " 			AND DEPT_CODE = ? \n";
			strSql += " 	) D \n";
			strSql += " WHERE   \n";
			strSql += " 	A.COMP_CODE = B.COMP_CODE  \n";
			strSql += " 	AND A.CLSE_ACC_ID = B.CLSE_ACC_ID  \n";
			strSql += " 	AND B.COMP_CODE = C.COMP_CODE  \n";
			strSql += " 	AND B.CLSE_ACC_ID = C.CLSE_ACC_ID  \n";
			strSql += " 	AND B.CLSE_MONTH = C.CLSE_MONTH  \n";
			strSql += " 	AND ROWNUM = D.RN(+) \n";
			strSql += " 	AND A.COMP_CODE = ? \n";
			strSql += " 	AND C.CLSE_DAY = ? ";

			lrArgData.addColumn("CLSE_DAY1", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE1", CITData.VARCHAR2);
			lrArgData.addColumn("DEPT_CODE1", CITData.VARCHAR2);
			
			lrArgData.addColumn("COMP_CODE2", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_DAY2", CITData.VARCHAR2);
			
			lrArgData.addRow();
			
			lrArgData.setValue("CLSE_DAY1", strCLSE_DAY);
			lrArgData.setValue("COMP_CODE1", strCOMP_CODE);
			lrArgData.setValue("DEPT_CODE1", strDEPT_CODE);

			lrArgData.setValue("COMP_CODE2", strCOMP_CODE);
			lrArgData.setValue("CLSE_DAY2", strCLSE_DAY);

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);	
		}
		else if (strAct.equals("AUTO_FBS_CASH_TRANS_SEQ"))
		{
			strSql  = " Select SQ_T_AUTO_FBS_CASH_TRANS.NEXTVAL AUTO_FBS_CASH_TRANS_SEQ From DUAL ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
		}

		try
		{
			lrDataset = CITCommon.toGauceDataSet(lrReturnData);
			GauceInfo.response.enableFirstRow(lrDataset);
			lrDataset.flush();
		}
		catch (Exception ex)
		{
			GauceInfo.response.writeException("USER", "900001", ex.getMessage());
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
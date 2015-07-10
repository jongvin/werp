<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 배민정 작성(2006-01-17)
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
			String	strCOMP_CODE= CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String	strBANK_CODE= CITCommon.toKOR(request.getParameter("BANK_CODE"));
			String	strACCNO_CODE= CITCommon.toKOR(request.getParameter("ACCNO_CODE"));
			String	strDT_F= CITCommon.toKOR(request.getParameter("DT_F"));

			{
				strSql =
							"SELECT C.FBS_DISPLAY_ORDER , "+"\r\n"+ 
							" M.BANK_CODE  ,              "+"\r\n"+
							" D.BANK_MAIN_NAME ,          "+"\r\n"+
							" M.ACCOUNT_NO ,              "+"\r\n"+
							" TO_NUMBER( SUBSTR( M.MAX_VAL ,9 ,20)) REMAIN_AMT ,"+"\r\n"+
							" TO_NUMBER( SUBSTR( M.MAX_VAL ,29,20)) ENABLE_AMT ,"+"\r\n"+
							" M.REMAIN_AMT REMAIN_AMT_B , "+"\r\n"+
							" F_T_DATETOSTRING(SUBSTR(M.MAX_VAL ,49 ,8))||' '||SUBSTR(M.MAX_VAL ,57 ,2)||':'||SUBSTR(M.MAX_VAL ,59 ,2) LAST_DATE "+"\r\n"+
							" FROM                    "+"\r\n"+
							"( select A.BANK_CODE ,   "+"\r\n"+
							"       A.ACCOUNT_NO,     "+"\r\n"+
							"       B.REMAIN_AMT,     "+"\r\n"+
							"       MAX( A.STD_YMD||	"+"\r\n"+	
							"	          LPAD(A.REMAIN_AMT,20,'0')||		"+"\r\n"+
							"	          LPAD(A.ENABLE_AMT,20,'0')||		"+"\r\n"+
							"	          TO_CHAR(nvl(A.LAST_MODIFY_DATE,A.CREATION_DATE),'YYYYMMDDHH24MISS') ) MAX_VAL   "+"\r\n"+    
							"from T_FB_ACCT_REMAIN_DATA A, "+"\r\n"+
							"     T_FB_ACCT_REMAIN_DATA B  "+"\r\n"+
							"where A.BANK_CODE  = B.BANK_CODE(+)  "+"\r\n"+
							"and   A.ACCOUNT_NO = B.ACCOUNT_NO(+) "+"\r\n"+
							"and   A.COMP_CODE  = ? "+"\r\n"+
							"and   A.BANK_CODE like ?||'%' "+"\r\n";
							if(!"".equals(strACCNO_CODE)) 
							strSql +=  "and   A.ACCOUNT_NO = replace(?,'-','') "+"\r\n";
							strSql +=  "and   B.STD_YMD(+) = F_T_STRINGTODATE(?) "+"\r\n"+
							"GROUP BY A.BANK_CODE ,A.ACCOUNT_NO ,B.REMAIN_AMT    ) M , "+"\r\n"+
							" T_ACCNO_CODE   C, "+"\r\n"+
							" T_BANK_MAIN    D  "+"\r\n"+
							"WHERE M.BANK_CODE = D.BANK_MAIN_CODE  "+"\r\n"+
							"AND M.ACCOUNT_NO  = C.ACCOUNT_NO      "+"\r\n"+
							"ORDER BY C.FBS_DISPLAY_ORDER          "+"\r\n";			
/*				
				  "SELECT C.FBS_DISPLAY_ORDER , "+"\r\n"+
				  " A.BANK_CODE , "+"\r\n"+
				  " D.BANK_MAIN_NAME , "+"\r\n"+
				  " A.ACCOUNT_NO , "+"\r\n"+
				  " TO_NUMBER( SUBSTR( A.MAX_VAL ,9 ,20)) REMAIN_AMT ,"+"\r\n"+
				  " TO_NUMBER( SUBSTR( A.MAX_VAL ,29,20)) ENABLE_AMT ,"+"\r\n"+
				  " B.REMAIN_AMT REMAIN_AMT_B ,"+"\r\n"+
				  " F_T_DATETOSTRING(SUBSTR(A.MAX_VAL ,49 ,8))||' '||SUBSTR(A.MAX_VAL ,57 ,2)||':'||SUBSTR(A.MAX_VAL ,59 ,2) LAST_DATE "+"\r\n"+
				  " FROM  "+"\r\n"+
					"( Select					"+"\r\n"+
					"	BANK_CODE ,	"+"\r\n"+
					"	ACCOUNT_NO,		"+"\r\n"+					
					"	MAX( STD_YMD||		"+"\r\n"+					
					"	LPAD(REMAIN_AMT,20,'0')||		"+"\r\n"+
					"	LPAD(ENABLE_AMT,20,'0')||		"+"\r\n"+
					"	TO_CHAR(nvl(LAST_MODIFY_DATE,CREATION_DATE),'YYYYMMDDHH24MISS') ) MAX_VAL "+"\r\n"+
					" From	T_FB_ACCT_REMAIN_DATA "+"\r\n"+
					" Where	COMP_CODE = ? "+"\r\n"+
					" And 	BANK_CODE like ?||'%' "+"\r\n";
					if(!"".equals(strACCNO_CODE)) 
					strSql +=  "And 	ACCOUNT_NO = replace(?,'-','') "+"\r\n";
					strSql += "GROUP BY BANK_CODE ,ACCOUNT_NO ) A ,"+"\r\n"+					
					"( Select					"+"\r\n"+
					"	BANK_CODE ,	"+"\r\n"+
					"	ACCOUNT_NO,	"+"\r\n"+					
					"	REMAIN_AMT	"+"\r\n"+
					" From	T_FB_ACCT_REMAIN_DATA "+"\r\n"+
					" Where	COMP_CODE = ? "+"\r\n"+
					" And 	BANK_CODE like ?||'%' "+"\r\n";
					if(!"".equals(strACCNO_CODE)) 
					strSql += "And 	ACCOUNT_NO = replace(?,'-','') "+"\r\n";
					strSql += "And 	STD_YMD = F_T_STRINGTODATE(?) ) B , "+"\r\n"+
					" T_ACCNO_CODE   C, "+"\r\n"+
					" T_BANK_MAIN    D "+"\r\n"+
					"WHERE A.BANK_CODE = B.BANK_CODE(+) "+"\r\n"+
					"AND A.ACCOUNT_NO  = B.ACCOUNT_NO(+) "+"\r\n"+
					"AND A.ACCOUNT_NO  = C.ACCOUNT_NO "+"\r\n"+
					"AND A.BANK_CODE   = D.BANK_MAIN_CODE "+"\r\n"+
					"ORDER BY C.FBS_DISPLAY_ORDER " ; */
			}
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
			if(!"".equals(strACCNO_CODE)) lrArgData.addColumn("ACCNO_CODE", CITData.VARCHAR2);
//			lrArgData.addColumn("COMP_CODE1", CITData.VARCHAR2);
//			lrArgData.addColumn("BANK_CODE1", CITData.VARCHAR2);
//			if(!"".equals(strACCNO_CODE)) lrArgData.addColumn("ACCNO_CODE1", CITData.VARCHAR2);			
			lrArgData.addColumn("DT_F", CITData.VARCHAR2);

			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("BANK_CODE", strBANK_CODE);
			if(!"".equals(strACCNO_CODE)) lrArgData.setValue("ACCNO_CODE", strACCNO_CODE);
//			lrArgData.setValue("COMP_CODE1", strCOMP_CODE);
//			lrArgData.setValue("BANK_CODE1", strBANK_CODE);
//			if(!"".equals(strACCNO_CODE)) lrArgData.setValue("ACCNO_CODE1", strACCNO_CODE);			
			lrArgData.setValue("DT_F", strDT_F);

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
		}
		else if (strAct.equals("COPY"))
		{			
			strSql  = " Select 'XXXXXXXXXXXXXXXXXXXX' ACCOUNT_NO ,"+"\r\n"+
							  "        'XX' BANK_CODE "+"\r\n"+
			          " from dual \n";
			
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
		
			try
			{
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","COPY Select 오류-> "+ ex.getMessage());
			}
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
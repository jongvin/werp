<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-05)
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
			String strDT_F = CITCommon.toKOR(request.getParameter("DT_F"));
			String strCHUL_TAG = CITCommon.toKOR(request.getParameter("CHUL_TAG"));
			
			strSql  = " SELECT  \n";
			strSql += " 	b.EMP_CLASS_CODE,  \n";
			strSql += " 	f.EMP_CLASS_NAME,  \n";
			if( "1".equals(strCHUL_TAG) ) {
			} else if( "2".equals(strCHUL_TAG) ) {
				strSql += " 	B.TEAM_DEPT_CODE, \n";
				strSql += " 	B.TEAM_DEPT_NAME, \n";
			} else if( "3".equals(strCHUL_TAG) ) {
				strSql += " 	B.DEPT_CODE, \n";
				strSql += " 	B.DEPT_NAME, \n";
			}
			strSql += " 	c.ITEM_CODE,  \n";
			strSql += " 	e.ITEM_NAME,  \n";
			strSql += " 	a.ACC_CODE,  \n";
			strSql += "  	CASE  \n";
			/*
			strSql += "  		WHEN f.EMP_CLASS_NAME IS NULL THEN '합 계'  \n";
			strSql += "  		WHEN B.TEAM_DEPT_NAME IS NULL THEN f.EMP_CLASS_NAME||' 합 계'  \n";
			strSql += "  		WHEN B.DEPT_NAME IS NULL THEN B.TEAM_DEPT_NAME||' 합 계'  \n";
			strSql += "  		WHEN e.ITEM_NAME IS NULL THEN B.DEPT_NAME||' 합 계'  \n";
			strSql += "  		WHEN d.ACC_SHRT_NAME IS NULL THEN e.ITEM_NAME||' 합 계'  \n";
			strSql += "  		ELSE d.ACC_SHRT_NAME  \n";
			*/
			if( "1".equals(strCHUL_TAG) ) {
				strSql += "  		WHEN f.EMP_CLASS_NAME IS NULL THEN '합 계'  \n";
				strSql += "  		WHEN e.ITEM_NAME IS NULL THEN f.EMP_CLASS_NAME||' 합 계'  \n";
				strSql += "  		WHEN d.ACC_SHRT_NAME IS NULL THEN e.ITEM_NAME||' 합 계'  \n";
				strSql += "  		ELSE d.ACC_SHRT_NAME  \n";
			} else if( "2".equals(strCHUL_TAG) ) {
				strSql += "  		WHEN f.EMP_CLASS_NAME IS NULL THEN '합 계'  \n";
				strSql += "  		WHEN B.TEAM_DEPT_NAME IS NULL THEN f.EMP_CLASS_NAME||' 합 계'  \n";
				strSql += "  		WHEN e.ITEM_NAME IS NULL THEN B.TEAM_DEPT_NAME||' 합 계'  \n";
				strSql += "  		WHEN d.ACC_SHRT_NAME IS NULL THEN e.ITEM_NAME||' 합 계'  \n";
				strSql += "  		ELSE d.ACC_SHRT_NAME  \n";
			} else if( "3".equals(strCHUL_TAG) ) {
				strSql += "  		WHEN f.EMP_CLASS_NAME IS NULL THEN '합 계'  \n";
				strSql += "  		WHEN B.DEPT_NAME IS NULL THEN f.EMP_CLASS_NAME||' 합 계'  \n";
				strSql += "  		WHEN e.ITEM_NAME IS NULL THEN B.DEPT_NAME||' 합 계'  \n";
				strSql += "  		WHEN d.ACC_SHRT_NAME IS NULL THEN e.ITEM_NAME||' 합 계'  \n";
				strSql += "  		ELSE d.ACC_SHRT_NAME  \n";
			}
			strSql += "  	END ACC_SHRT_NAME,  \n";
			strSql += "  	CASE  \n";
			strSql += "  		WHEN f.EMP_CLASS_NAME IS NULL THEN '#B4BEFF'  \n";
			if( "1".equals(strCHUL_TAG) ) {
			} else if( "2".equals(strCHUL_TAG) ) {
				strSql += "  		WHEN B.TEAM_DEPT_NAME IS NULL THEN '#C1ECC8'  \n";
			} else if( "3".equals(strCHUL_TAG) ) {
				strSql += "  		WHEN B.DEPT_NAME IS NULL THEN '#D4ECC8'  \n";
			}
			strSql += "  		WHEN e.ITEM_NAME IS NULL THEN '#DFECC8'  \n";
			strSql += "  		WHEN d.ACC_SHRT_NAME IS NULL THEN '#EFEEFF'  \n";
			strSql += "  		ELSE '#FFFFFF'  \n";
			strSql += "  	END ROW_COLOR,  \n";
			strSql += "  	NVL(SUM(a.DB_AMT),0) - NVL(SUM(a.CR_AMT),0) TOT_AMT,  \n";
			strSql += "  	NVL(SUM(CASE WHEN TO_CHAR(a.MAKE_DT,'YYYYMM') =   ?   THEN  \n";
			strSql += "  		a.DB_AMT  \n";
			strSql += "  	ELSE  \n";
			strSql += "  		0  \n";
			strSql += "  	END),0) - NVL(SUM(CASE WHEN TO_CHAR(a.MAKE_DT,'YYYYMM') =   ?   THEN  \n";
			strSql += "  		a.CR_AMT  \n";
			strSql += "  	ELSE  \n";
			strSql += "  		0  \n";
			strSql += "  	END),0) NOW_AMT  \n";
			strSql += " FROM \n";
			strSql += " 	T_ACC_SLIP_BODY1 a,  \n";
			strSql += " 	( \n";
			strSql += " 		SELECT \n";
			strSql += " 			NVL(B.DEPT_CODE,A.DEPT_CODE) TEAM_DEPT_CODE, \n";
			strSql += " 			NVL(B.DEPT_NAME,A.DEPT_NAME) TEAM_DEPT_NAME, \n";
			strSql += " 			A.* \n";
			strSql += " 		FROM \n";
			strSql += " 			( \n";
			strSql += " 				SELECT  \n";
			strSql += " 					A.*, \n";
			strSql += " 					( \n";
			strSql += " 						SELECT \n";
			strSql += " 							DEPT_CODE \n";
			strSql += " 						FROM T_DEPT_CODE_ORG \n";
			strSql += " 						WHERE DEPT_KIND_TAG='0300' \n";
			strSql += " 						CONNECT BY DEPT_CODE=PRIOR P_DEPT_CODE \n";
			strSql += " 						START WITH DEPT_CODE=A.DEPT_CODE \n";
			strSql += " 					) TEAM_DEPT_CODE_I \n";
			strSql += " 				FROM \n";
			strSql += " 					T_DEPT_CODE_ORG A \n";
			strSql += " 			) A, \n";
			strSql += " 			T_DEPT_CODE_ORG B \n";
			strSql += " 		WHERE \n";
			strSql += " 			A.TEAM_DEPT_CODE_I = B.DEPT_CODE(+) \n";
			strSql += " 	) b,  \n";
			strSql += " 	T_FIN_SAL_ACC_CODE c,  \n";
			strSql += " 	T_ACC_CODE d,  \n";
			strSql += " 	T_FIN_SAL_ITEM e,  \n";
			strSql += " 	T_EMP_CLASS f  \n";
			strSql += " WHERE \n";
			strSql += " 	a.MAKE_DT BETWEEN F_T_Stringtodate(SUBSTR(  ?  ,1,4)||'0101') AND LAST_DAY(F_T_Stringtodate(  ?  ||'01'))  \n";
			strSql += " 	AND		a.DEPT_CODE = b.DEPT_CODE  \n";
			strSql += " 	AND		a.ACC_CODE = c.ACC_CODE  \n";
			strSql += " 	AND		a.ACC_CODE = d.ACC_CODE  \n";
			strSql += " 	AND		c.ITEM_CODE = e.ITEM_CODE  \n";
			strSql += " 	AND		b.EMP_CLASS_CODE = f.EMP_CLASS_CODE  \n";
			strSql += " 	AND		a.TRANSFER_TAG = 'F'  \n";
			strSql += " GROUP BY GROUPING SETS  \n";
			strSql += " (  \n";
			strSql += " 	(  \n";
			strSql += " 		b.EMP_CLASS_CODE,  \n";
			strSql += " 		f.EMP_CLASS_NAME,  \n";
			if( "1".equals(strCHUL_TAG) ) {
			} else if( "2".equals(strCHUL_TAG) ) {
				strSql += " 	B.TEAM_DEPT_CODE, \n";
				strSql += " 	B.TEAM_DEPT_NAME, \n";
			} else if( "3".equals(strCHUL_TAG) ) {
				strSql += " 	B.DEPT_CODE, \n";
				strSql += " 	B.DEPT_NAME, \n";
			}
			strSql += " 		c.ITEM_CODE,  \n";
			strSql += " 		e.ITEM_NAME,  \n";
			strSql += " 		a.ACC_CODE,  \n";
			strSql += " 		d.ACC_SHRT_NAME  \n";
			strSql += " 	),  \n";
			strSql += " 	(  \n";
			strSql += " 		b.EMP_CLASS_CODE,  \n";
			strSql += " 		f.EMP_CLASS_NAME,  \n";
			if( "1".equals(strCHUL_TAG) ) {
			} else if( "2".equals(strCHUL_TAG) ) {
				strSql += " 	B.TEAM_DEPT_CODE, \n";
				strSql += " 	B.TEAM_DEPT_NAME, \n";
			} else if( "3".equals(strCHUL_TAG) ) {
				strSql += " 	B.DEPT_CODE, \n";
				strSql += " 	B.DEPT_NAME, \n";
			}
			strSql += " 		c.ITEM_CODE,  \n";
			strSql += " 		e.ITEM_NAME  \n";
			strSql += " 	),  \n";
			if( "1".equals(strCHUL_TAG) ) {
			} else if( "2".equals(strCHUL_TAG) ) {
				strSql += " 	(  \n";
				strSql += " 		b.EMP_CLASS_CODE,  \n";
				strSql += " 		f.EMP_CLASS_NAME, \n";
				strSql += " 		B.TEAM_DEPT_CODE, \n";
				strSql += " 		B.TEAM_DEPT_NAME \n";
				strSql += " 	),  \n";
			} else if( "3".equals(strCHUL_TAG) ) {
				strSql += " 	(  \n";
				strSql += " 		b.EMP_CLASS_CODE,  \n";
				strSql += " 		f.EMP_CLASS_NAME, \n";
				strSql += " 		B.DEPT_CODE, \n";
				strSql += " 		B.DEPT_NAME \n";
				strSql += " 	),  \n";
			}
			strSql += " 	(  \n";
			strSql += " 		b.EMP_CLASS_CODE,  \n";
			strSql += " 		f.EMP_CLASS_NAME \n";
			strSql += " 	)  \n";
			strSql += " )  \n";
			strSql += " ORDER BY  \n";
			strSql += " 	b.EMP_CLASS_CODE,  \n";
			if( "1".equals(strCHUL_TAG) ) {
			} else if( "2".equals(strCHUL_TAG) ) {
				strSql += " 	B.TEAM_DEPT_CODE, \n";
			} else if( "3".equals(strCHUL_TAG) ) {
				strSql += " 	B.DEPT_CODE, \n";
			}
			strSql += " 	c.ITEM_CODE,  \n";
			strSql += " 	a.ACC_CODE  ";
			strSql += "  ";
			
			lrArgData.addColumn("1DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("2DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("3DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("4DT_F", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1DT_F", strDT_F);
			lrArgData.setValue("2DT_F", strDT_F);
			lrArgData.setValue("3DT_F", strDT_F);
			lrArgData.setValue("4DT_F", strDT_F);
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
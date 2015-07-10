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
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MAIN"))
		{
			String strMAKE_COMP_CODE = CITCommon.toKOR(request.getParameter("MAKE_COMP_CODE"));
			String strMAKE_DEPT_CODE = CITCommon.toKOR(request.getParameter("MAKE_DEPT_CODE"));
			String strDT_F = CITCommon.toKOR(request.getParameter("DT_F"));
			String strDT_T = CITCommon.toKOR(request.getParameter("DT_T"));
			String strUPDATE_CLS = CITCommon.toKOR(request.getParameter("UPDATE_CLS"));
			
			strSql  = " SELECT  \n";
			strSql += " 	'F' CHK_CLS,  \n";
			strSql += " 	A.LOG_ID,  \n";
			strSql += " 	A.UPDATE_CLS,  \n";
			strSql += " 	A.MODUSER_NAME,  \n";
			strSql += " 	F_T_DateToString(A.LOG_CRTDATE) LOG_CRTDATE,  \n";
			strSql += " 	A.LOG_CRTUSER_NAME,  \n";
			strSql += " 	A.SLIP_ID ,  \n";
			strSql += " 	A.MAKE_COMP_CODE ,  \n";
			strSql += " 	A.MAKE_DT ,  \n";
			strSql += " 	A.MAKE_DT_TRANS ,  \n";
			strSql += " 	A.MAKE_DEPT_CODE ,  \n";
			strSql += " 	A.MAKE_SEQ ,  \n";
			strSql += " 	A.MAKE_SLIPNO ,  \n";
			strSql += " 	DECODE(A.KEEP_SLIPNO, NULL, NULL, '확정  ') KEEP_STATUS ,  \n";
			strSql += " 	DECODE(A.KEEP_SLIPNO, NULL, 'F', 'T') KEEP_CLS ,  \n";
			strSql += " 	A.KEEP_SLIPNO,  \n";
			strSql += " 	A.MAKE_SLIPCLS_NAME ,  \n";
			strSql += " 	A.WORK_NAME ,  \n";
			strSql += " 	A.SLIP_KIND_TAG,  \n";
			strSql += " 	A.SLIP_KIND_NAME ,  \n";
			strSql += " 	MAX(DECODE(A.MAKE_SLIPLINE, 1, A.SUMMARY1, NULL)) SUMMARY1,  \n";
			strSql += " 	SUM(A.DB_AMT) DB_AMT,  \n";
			strSql += " 	SUM(A.CR_AMT) CR_AMT,  \n";
			strSql += " 	COUNT(*) LINE_COUNT,  \n";
			strSql += " 	A.MAKE_DEPT_NAME,  \n";
			strSql += " 	A.MAKE_NAME,  \n";
			strSql += " 	A.CHARGE_PERS_NAME  \n";
			strSql += " FROM  \n";
			strSql += " 	T_LOG_ACC_SLIP_VIEW	A  \n";
			strSql += " WHERE  \n";
			strSql += " 	A.LOG_CRTDATE = ( \n";
			strSql += " 		SELECT \n";
			strSql += " 			MAX(LOG_CRTDATE) \n";
			strSql += " 		FROM \n";
			strSql += " 		 	T_LOG_ACC_SLIP_HEAD \n";
			strSql += " 		WHERE SLIP_ID = A.SLIP_ID \n";
			strSql += " 		AND MAKE_COMP_CODE LIKE  ?  ||'%'  \n";
			strSql += " 		AND	MAKE_DEPT_CODE LIKE  ?  ||'%'  \n";
			strSql += " 		AND	F_T_StringToDate(F_T_DateToString(LOG_CRTDATE)) BETWEEN F_T_StringToDate( ? ) AND F_T_StringToDate( ? )  \n";
			if(!"".equals(strUPDATE_CLS)) strSql += " 		AND	UPDATE_CLS =  ?  \n";
			strSql += " 	) \n";
			strSql += " 	AND A.MAKE_COMP_CODE LIKE  ?  ||'%'  \n";
			strSql += " 	AND	A.MAKE_DEPT_CODE LIKE  ?  ||'%'  \n";
			strSql += " 	AND	F_T_StringToDate(F_T_DateToString(A.LOG_CRTDATE)) BETWEEN F_T_StringToDate( ? ) AND F_T_StringToDate( ? )  \n";
			if(!"".equals(strUPDATE_CLS)) strSql += " 	AND	A.UPDATE_CLS =  ?  \n";
			strSql += " GROUP BY  \n";
			strSql += " 	A.LOG_ID,  \n";
			strSql += " 	A.UPDATE_CLS,  \n";
			strSql += " 	A.MODUSER_NAME,  \n";
			strSql += " 	A.LOG_CRTDATE,  \n";
			strSql += " 	A.LOG_CRTUSER_NAME,  \n";
			strSql += " 	A.SLIP_ID ,  \n";
			strSql += " 	A.MAKE_COMP_CODE ,  \n";
			strSql += " 	A.MAKE_DT ,  \n";
			strSql += " 	A.MAKE_DT_TRANS ,  \n";
			strSql += " 	A.MAKE_DEPT_CODE ,  \n";
			strSql += " 	A.MAKE_SEQ ,  \n";
			strSql += " 	A.MAKE_SLIPNO ,  \n";
			strSql += " 	A.KEEP_SLIPNO ,  \n";
			strSql += " 	A.MAKE_SLIPCLS_NAME ,  \n";
			strSql += " 	A.WORK_NAME,  \n";
			strSql += " 	A.SLIP_KIND_TAG,  \n";
			strSql += " 	A.SLIP_KIND_NAME,  \n";
			strSql += " 	A.MAKE_DEPT_NAME,  \n";
			strSql += " 	A.MAKE_NAME,  \n";
			strSql += " 	A.CHARGE_PERS_NAME  \n";
			strSql += " ORDER BY  \n";
			strSql += " 	A.LOG_CRTDATE DESC ";
			
			lrArgData.addColumn("1MAKE_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("1MAKE_DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("1DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("1DT_T", CITData.VARCHAR2);
			if(!"".equals(strUPDATE_CLS)) lrArgData.addColumn("1UPDATE_CLS", CITData.VARCHAR2);
			lrArgData.addColumn("2MAKE_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2MAKE_DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("2DT_T", CITData.VARCHAR2);
			if(!"".equals(strUPDATE_CLS)) lrArgData.addColumn("2UPDATE_CLS", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1MAKE_COMP_CODE", strMAKE_COMP_CODE);
			lrArgData.setValue("1MAKE_DEPT_CODE", strMAKE_DEPT_CODE);
			lrArgData.setValue("1DT_F", strDT_F);
			lrArgData.setValue("1DT_T", strDT_T);
			if(!"".equals(strUPDATE_CLS)) lrArgData.setValue("1UPDATE_CLS", strUPDATE_CLS);
			lrArgData.setValue("2MAKE_COMP_CODE", strMAKE_COMP_CODE);
			lrArgData.setValue("2MAKE_DEPT_CODE", strMAKE_DEPT_CODE);
			lrArgData.setValue("2DT_F", strDT_F);
			lrArgData.setValue("2DT_T", strDT_T);
			if(!"".equals(strUPDATE_CLS)) lrArgData.setValue("2UPDATE_CLS", strUPDATE_CLS);
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
		else if (strAct.equals("SUB01"))
		{
			String strSLIP_ID = CITCommon.toKOR(request.getParameter("SLIP_ID"));
			
			strSql  = " SELECT  \n";
			strSql += " 	'F' CHK_CLS,  \n";
			strSql += " 	A.LOG_ID,  \n";
			strSql += " 	A.UPDATE_CLS,  \n";
			strSql += " 	A.LOG_CRTUSERNO,  \n";
			strSql += " 	F_T_DateToString(A.LOG_CRTDATE) LOG_CRTDATE,  \n";
			strSql += " 	A.LOG_CRTUSER_NAME,  \n";
			strSql += " 	A.SLIP_ID ,  \n";
			strSql += " 	A.MAKE_COMP_CODE ,  \n";
			strSql += " 	A.MAKE_DT ,  \n";
			strSql += " 	A.MAKE_DT_TRANS ,  \n";
			strSql += " 	A.MAKE_DEPT_CODE ,  \n";
			strSql += " 	A.MAKE_SEQ ,  \n";
			strSql += " 	A.MAKE_SLIPNO ,  \n";
			strSql += " 	DECODE(A.KEEP_SLIPNO, NULL, NULL, '확정  ') KEEP_STATUS ,  \n";
			strSql += " 	DECODE(A.KEEP_SLIPNO, NULL, 'F', 'T') KEEP_CLS ,  \n";
			strSql += " 	A.KEEP_SLIPNO,  \n";
			strSql += " 	A.MAKE_SLIPCLS_NAME ,  \n";
			strSql += " 	A.WORK_NAME ,  \n";
			strSql += " 	A.SLIP_KIND_TAG,  \n";
			strSql += " 	A.SLIP_KIND_NAME ,  \n";
			strSql += " 	MAX(DECODE(A.MAKE_SLIPLINE, 1, A.SUMMARY1, NULL)) SUMMARY1,  \n";
			strSql += " 	SUM(A.DB_AMT) DB_AMT,  \n";
			strSql += " 	SUM(A.CR_AMT) CR_AMT,  \n";
			strSql += " 	COUNT(*) LINE_COUNT,  \n";
			strSql += " 	A.MAKE_DEPT_NAME,  \n";
			strSql += " 	A.MAKE_NAME,  \n";
			strSql += " 	A.CHARGE_PERS_NAME  \n";
			strSql += " FROM  \n";
			strSql += " 	T_LOG_ACC_SLIP_VIEW	A  \n";
			strSql += " WHERE  \n";
			strSql += " 	A.SLIP_ID =  ?  \n";
			strSql += " GROUP BY  \n";
			strSql += " 	A.LOG_ID,  \n";
			strSql += " 	A.UPDATE_CLS,  \n";
			strSql += " 	A.LOG_CRTUSERNO,  \n";
			strSql += " 	A.LOG_CRTUSER_NAME,  \n";
			strSql += " 	A.LOG_CRTDATE,  \n";
			strSql += " 	A.SLIP_ID ,  \n";
			strSql += " 	A.MAKE_COMP_CODE ,  \n";
			strSql += " 	A.MAKE_DT ,  \n";
			strSql += " 	A.MAKE_DT_TRANS ,  \n";
			strSql += " 	A.MAKE_DEPT_CODE ,  \n";
			strSql += " 	A.MAKE_SEQ ,  \n";
			strSql += " 	A.MAKE_SLIPNO ,  \n";
			strSql += " 	A.KEEP_SLIPNO ,  \n";
			strSql += " 	A.MAKE_SLIPCLS_NAME ,  \n";
			strSql += " 	A.WORK_NAME,  \n";
			strSql += " 	A.SLIP_KIND_TAG,  \n";
			strSql += " 	A.SLIP_KIND_NAME,  \n";
			strSql += " 	A.MAKE_DEPT_NAME,  \n";
			strSql += " 	A.MAKE_NAME,  \n";
			strSql += " 	A.CHARGE_PERS_NAME  \n";
			strSql += " ORDER BY  \n";
			strSql += " 	A.LOG_CRTDATE DESC ";
			
			lrArgData.addColumn("SLIP_ID", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("SLIP_ID", strSLIP_ID);
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
			String strLOG_ID = CITCommon.toKOR(request.getParameter("LOG_ID"));
			
			strSql  = " SELECT  \n";
			strSql += " 	A.LOG_ID,  \n";
			strSql += " 	A.UPDATE_CLS,  \n";
			strSql += " 	A.LOG_CRTUSERNO,  \n";
			strSql += " 	F_T_DateToString(A.LOG_CRTDATE) LOG_CRTDATE,  \n";
			strSql += " 	A.SLIP_ID ,    \n";
			strSql += " 	A.SLIP_IDSEQ ,    \n";
			strSql += " 	A.MAKE_COMP_CODE ,    \n";
			strSql += " 	A.MAKE_DT ,    \n";
			strSql += " 	A.MAKE_SEQ ,    \n";
			strSql += " 	A.SLIP_KIND_TAG ,    \n";
			strSql += " 	DECODE( A.MAKE_SLIPLINE, NULL, NULL, A.MAKE_SLIPNO) MAKE_SLIPNO ,    \n";
			strSql += " 	''||A.MAKE_SLIPLINE MAKE_SLIPLINE,  \n";
			strSql += " 	DECODE( A.MAKE_SLIPLINE, NULL, NULL, A.MAKE_SLIPNO||'-'||A.MAKE_SLIPLINE) MAKE_SLIPNOLINE,   \n";
			strSql += " 	A.KEEP_CLS,   \n";
			strSql += " 	DECODE( A.MAKE_SLIPLINE, NULL, '  '||COUNT(A.ACC_CODE)||' 항목', A.ACC_CODE) ACC_CODE,    \n";
			strSql += " 	DECODE( A.MAKE_SLIPNO, NULL, '  전 체 계   ', DECODE( A.MAKE_SLIPLINE, NULL, '  전 표 계   ', A.ACC_NAME)) ACC_NAME,  \n";
			strSql += " 	A.ACC_REMAIN_POSITION ,    \n";
			strSql += " 	SUM(A.DB_AMT) DB_AMT,     \n";
			strSql += " 	SUM(A.CR_AMT) CR_AMT,    \n";
			strSql += " 	A.SUMMARY_CODE ,    \n";
			strSql += " 	A.SUMMARY1 ,    \n";
			strSql += " 	A.SUMMARY2 ,    \n";
			strSql += " 	A.TAX_COMP_CODE ,    \n";
			strSql += " 	A.TAX_COMP_NAME,    \n";
			strSql += " 	A.COMP_CODE ,    \n";
			strSql += " 	--귀속부서    \n";
			strSql += " 	A.DEPT_CODE ,    \n";
			strSql += " 	A.DEPT_NAME ,    \n";
			strSql += " 	--부문코드    \n";
			strSql += " 	A.CLASS_CODE ,    \n";
			strSql += " 	A.CLASS_CODE_NAME ,    \n";
			strSql += " 	--증빙코드    \n";
			strSql += " 	A.VAT_CODE ,    \n";
			strSql += " 	A.VAT_NAME ,    \n";
			strSql += " 	A.VAT_DT ,    \n";
			strSql += " 	A.SUPAMT ,    \n";
			strSql += " 	A.VATAMT ,      \n";
			strSql += " 	--거래처코드관리      \n";
			strSql += " 	A.CUST_SEQ ,    \n";
			strSql += " 	A.CUST_CODE ,       \n";
			strSql += " 	A.CUST_NAME ,    \n";
			strSql += " 	--은행관리       \n";
			strSql += " 	A.BANK_CODE ,    \n";
			strSql += " 	A.BANK_NAME,  \n";
			strSql += " 	--사원번호      \n";
			strSql += " 	A.EMP_NO ,    \n";
			strSql += " 	A.EMP_NAME  \n";
			strSql += " FROM  \n";
			strSql += " 	T_LOG_ACC_SLIP_VIEW A  \n";
			strSql += " Where \n";
			strSql += " 	A.LOG_ID = ?  \n";
			strSql += " GROUP BY GROUPING SETS  \n";
			strSql += " (  \n";
			strSql += " 	(  \n";
			strSql += " 		A.LOG_ID,  \n";
			strSql += " 		A.UPDATE_CLS,  \n";
			strSql += " 		A.LOG_CRTUSERNO,  \n";
			strSql += " 		A.LOG_CRTDATE,  \n";
			strSql += " 		A.SLIP_ID ,    \n";
			strSql += " 		A.SLIP_IDSEQ ,    \n";
			strSql += " 		A.MAKE_COMP_CODE ,    \n";
			strSql += " 		A.MAKE_DT ,    \n";
			strSql += " 		A.MAKE_SEQ ,    \n";
			strSql += " 		A.SLIP_KIND_TAG ,    \n";
			strSql += " 		A.MAKE_SLIPNO ,    \n";
			strSql += " 		A.MAKE_SLIPLINE, \n";
			strSql += " 		A.KEEP_CLS,   \n";
			strSql += " 		A.ACC_CODE ,    \n";
			strSql += " 		A.ACC_NAME ,    \n";
			strSql += " 		A.ACC_REMAIN_POSITION ,    \n";
			strSql += " 		A.DB_AMT ,      \n";
			strSql += " 		A.CR_AMT ,         \n";
			strSql += " 		A.SUMMARY_CODE ,    \n";
			strSql += " 		A.SUMMARY1 ,    \n";
			strSql += " 		A.SUMMARY2 ,    \n";
			strSql += " 		A.TAX_COMP_CODE ,    \n";
			strSql += " 		A.TAX_COMP_NAME,    \n";
			strSql += " 		A.COMP_CODE ,    \n";
			strSql += " 		--귀속부서    \n";
			strSql += " 		A.DEPT_CODE ,    \n";
			strSql += " 		A.DEPT_NAME ,    \n";
			strSql += " 		--부문코드    \n";
			strSql += " 		A.CLASS_CODE ,    \n";
			strSql += " 		A.CLASS_CODE_NAME ,    \n";
			strSql += " 		--증빙코드    \n";
			strSql += " 		A.VAT_CODE ,    \n";
			strSql += " 		A.VAT_NAME ,    \n";
			strSql += " 		A.VAT_DT ,    \n";
			strSql += " 		A.SUPAMT ,    \n";
			strSql += " 		A.VATAMT ,         \n";
			strSql += " 		--거래처코드관리     \n";
			strSql += " 		A.CUST_SEQ ,    \n";
			strSql += " 		A.CUST_CODE ,       \n";
			strSql += " 		A.CUST_NAME ,    \n";
			strSql += " 		--은행관리      \n";
			strSql += " 		A.BANK_CODE ,    \n";
			strSql += " 		A.BANK_NAME ,  \n";
			strSql += " 		--사원번호    \n";
			strSql += " 		A.EMP_NO ,    \n";
			strSql += " 		A.EMP_NAME  \n";
			strSql += " 	),  \n";
			strSql += " 	(  \n";
			strSql += " 		A.MAKE_SLIPNO,    \n";
			strSql += " 		A.SLIP_ID ,    \n";
			strSql += " 		A.MAKE_COMP_CODE ,    \n";
			strSql += " 		A.MAKE_DT ,    \n";
			strSql += " 		A.MAKE_SEQ ,    \n";
			strSql += " 		A.SLIP_KIND_TAG     \n";
			strSql += " 	)  \n";
			strSql += " )  \n";
			strSql += " Order By \n";
			strSql += " 	A.MAKE_SLIPNO, A.MAKE_SLIPLINE    ";
			
			lrArgData.addColumn("LOG_ID", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("LOG_ID", strLOG_ID);
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
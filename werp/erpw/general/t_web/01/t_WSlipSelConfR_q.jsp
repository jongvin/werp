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
			String strMAKE_PERS = CITCommon.toKOR(request.getParameter("MAKE_PERS"));
			String strCHARGE_PERS = CITCommon.toKOR(request.getParameter("CHARGE_PERS"));
			String strKEEP_CLS = CITCommon.toKOR(request.getParameter("KEEP_CLS"));
			
			strSql  = " SELECT \n";
			strSql += " 	'F' CHK_CLS, \n";
			strSql += " 	A.SLIP_ID , \n";
			strSql += " 	A.MAKE_COMP_CODE , \n";
			strSql += " 	A.MAKE_DT , \n";
			strSql += " 	A.MAKE_DT_TRANS , \n";
			strSql += " 	A.MAKE_DEPT_CODE , \n";
			strSql += " 	A.MAKE_SEQ , \n";
			strSql += " 	A.MAKE_SLIPNO , \n";
			strSql += " 	DECODE(A.KEEP_SLIPNO, NULL, NULL, '확정  ') KEEP_STATUS , \n";
			strSql += " 	DECODE(A.KEEP_SLIPNO, NULL, 'F', 'T') KEEP_CLS , \n";
			strSql += " 	A.KEEP_SLIPNO, \n";
			strSql += " 	C.CODE_LIST_NAME MAKE_SLIPCLS_NAME , \n";
			strSql += " 	D.WORK_NAME WORK_NAME , \n";
			strSql += " 	A.SLIP_KIND_TAG, \n";
			strSql += " 	E.CODE_LIST_NAME SLIP_KIND_NAME , \n";
			strSql += " 	MAX(DECODE(B.MAKE_SLIPLINE, 1, B.SUMMARY1, NULL)) SUMMARY1, \n";
			strSql += " 	SUM(B.DB_AMT) DB_AMT, \n";
			strSql += " 	SUM(B.CR_AMT) CR_AMT, \n";
			strSql += " 	COUNT(*) LINE_COUNT, \n";
			strSql += "	F.DEPT_NAME MAKE_DEPT_NAME, \n";
			strSql += "	G.NAME MAKE_PERS_NAME, \n";
			strSql += "	H.NAME CHARGE_PERS_NAME \n";
			strSql += " FROM \n";
			strSql += " 	T_ACC_SLIP_HEAD	A, \n";
			strSql += " 	T_ACC_SLIP_BODY B, \n";
			strSql += " 	V_T_CODE_LIST C, \n";
			strSql += " 	T_WORK_CODE D, \n";
			strSql += " 	V_T_CODE_LIST E, \n";
			strSql += "	T_DEPT_CODE F, \n";
			strSql += "	Z_AUTHORITY_USER G, \n";
			strSql += "	Z_AUTHORITY_USER H \n";
			strSql += " WHERE \n";
			strSql += " 	A.SLIP_ID = B.SLIP_ID \n";
			strSql += " 	AND A.MAKE_SLIPCLS = C.CODE_LIST_ID(+) \n";
			strSql += " 	AND C.CODE_GROUP_ID = 'MAKE_SLIPCLS' \n";
			strSql += " 	AND A.WORK_CODE = D.WORK_CODE(+) \n";
			strSql += " 	AND A.SLIP_KIND_TAG = E.CODE_LIST_ID(+) \n";
			strSql += " 	AND E.CODE_GROUP_ID = 'SLIP_KIND_TAG' \n";
			strSql += "	AND A.MAKE_DEPT_CODE = F.DEPT_CODE \n";
			strSql += "	AND A.MAKE_PERS = G.EMPNO \n";
			strSql += "	AND A.CHARGE_PERS = H.EMPNO \n";
			strSql += " 	AND	A.MAKE_COMP_CODE LIKE  ? ||'%' \n";
			strSql += " 	AND	A.MAKE_DEPT_CODE LIKE  ? ||'%' \n";
			strSql += " 	AND	A.MAKE_DT BETWEEN  ?  AND  ?  \n";
			strSql += " 	AND	A.MAKE_PERS LIKE  ? ||'%' \n";
			strSql += " 	AND	A.CHARGE_PERS LIKE  ? ||'%' \n";
			strSql += " 	AND \n";
			strSql += " 	( \n";
			strSql += " 		( ?  = 'A') \n";
			strSql += " 		OR \n";
			strSql += " 		( ?  = 'K' AND A.KEEP_SLIPNO IS NOT NULL) \n";
			strSql += " 		OR \n";
			strSql += " 		( ?  = 'M' AND A.KEEP_SLIPNO IS NULL) \n";
			strSql += " 	) \n";
			strSql += " GROUP BY \n";
			strSql += " 	A.SLIP_ID , \n";
			strSql += " 	A.MAKE_COMP_CODE , \n";
			strSql += " 	A.MAKE_DT , \n";
			strSql += " 	A.MAKE_DT_TRANS , \n";
			strSql += " 	A.MAKE_DEPT_CODE , \n";
			strSql += " 	A.MAKE_SEQ , \n";
			strSql += " 	A.MAKE_SLIPNO , \n";
			strSql += " 	A.KEEP_SLIPNO , \n";
			strSql += " 	C.CODE_LIST_NAME , \n";
			strSql += " 	D.WORK_NAME, \n";
			strSql += " 	A.SLIP_KIND_TAG, \n";
			strSql += " 	E.CODE_LIST_NAME, \n";
			strSql += "	F.DEPT_NAME, \n";
			strSql += "	G.NAME, \n";
			strSql += "	H.NAME \n";
			strSql += " ORDER BY \n";
			strSql += " 	A.MAKE_SLIPNO ";
			
			lrArgData.addColumn("MAKE_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("MAKE_DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("DT_T", CITData.VARCHAR2);
			lrArgData.addColumn("MAKE_PERS", CITData.VARCHAR2);
			lrArgData.addColumn("CHARGE_PERS", CITData.VARCHAR2);
			lrArgData.addColumn("KEEP_CLS1", CITData.VARCHAR2);
			lrArgData.addColumn("KEEP_CLS2", CITData.VARCHAR2);
			lrArgData.addColumn("KEEP_CLS3", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("MAKE_COMP_CODE", strMAKE_COMP_CODE);
			lrArgData.setValue("MAKE_DEPT_CODE", strMAKE_DEPT_CODE);
			lrArgData.setValue("DT_F", strDT_F);
			lrArgData.setValue("DT_T", strDT_T);
			lrArgData.setValue("MAKE_PERS", strMAKE_PERS);
			lrArgData.setValue("CHARGE_PERS", strCHARGE_PERS);
			lrArgData.setValue("KEEP_CLS1", strKEEP_CLS);
			lrArgData.setValue("KEEP_CLS2", strKEEP_CLS);
			lrArgData.setValue("KEEP_CLS3", strKEEP_CLS);
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
				GauceInfo.response.writeException("USER", "900001","CLSE_CLS Select 오류-> "+ ex.getMessage());
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
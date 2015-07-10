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
	String strUserNo = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* 세션정보 */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		
		if (strAct.equals("WORK_SLIP_IDSEQ"))
		{
			String strWORK_CODE = CITCommon.toKOR(request.getParameter("WORK_CODE"));
			strSql  = " Select SQ_T_WORK_SLIP_ID.NEXTVAL WORK_SLIP_ID, SQ_T_WORK_SLIP_IDSEQ.NEXTVAL WORK_SLIP_IDSEQ,'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' WORK_CODE,'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' COMP_CODE, 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' DEPT_CODE,0 WORK_SEQ, 'XXXXXXXXXXXXXX' WORK_DT From DUAL ";

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
				GauceInfo.response.writeException("USER", "900001","SLIP_ID Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("MAKE_SLIP"))
		{
			strSql  = " Select 0 WORK_SLIP_ID, 0 WORK_SLIP_IDSEQ,'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' WORK_CODE,'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' COMP_CODE, 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' DEPT_CODE,0 WORK_SEQ, 'XXXXXXXXXXXXXX' WORK_DT From DUAL ";

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
				GauceInfo.response.writeException("USER", "900001","SLIP_ID Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("NEW_WORK_SLIP"))
		{
			String strWORK_SLIP_ID = CITCommon.toKOR(request.getParameter("WORK_SLIP_ID"));
			String strWORK_SLIP_IDSEQ = CITCommon.toKOR(request.getParameter("WORK_SLIP_IDSEQ"));
			String strWORK_CODE = CITCommon.toKOR(request.getParameter("WORK_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));

			try
			{
				strSql = "{call SP_T_WORK_ACC_SLIP_BODY_EMY_I(?,?,?,?,?)}";
				
				lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
				lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
				lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
				lrArgData.addColumn("WORK_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("SLIP_ID", strWORK_SLIP_ID);
				lrArgData.setValue("SLIP_IDSEQ", strWORK_SLIP_IDSEQ);
				lrArgData.setValue("CRTUSERNO", strUserNo);
				lrArgData.setValue("WORK_CODE", strWORK_CODE);
				lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
				
				CITDatabase.executeProcedure(strSql, lrArgData);
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAKE_SEQ Select 오류-> "+ ex.getMessage());
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
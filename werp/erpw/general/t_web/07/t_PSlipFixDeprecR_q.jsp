<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 :  한재원 작성(2006-02-06)
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
		if (strAct.equals("MAIN"))
		{

			String	strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String	strWORK_DT_FROM = CITCommon.toKOR(request.getParameter("WORK_DT_FROM"));
			String	strWORK_DT_TO = CITCommon.toKOR(request.getParameter("WORK_DT_TO"));
		
			String	strWORK_SEQ = CITCommon.toKOR(request.getParameter("WORK_SEQ"));
			String      strDIV = CITCommon.toKOR(request.getParameter("DIV"));
			
			strSql  = "Select \n";
			strSql  += "	a.WORK_SEQ , \n";
			strSql  += "	a.COMP_CODE , \n";
			strSql  += "	F_T_DATETOSTRING(a.WORK_DT) WORK_DT , \n";
			strSql  += "	a.WORK_NAME , \n";
			strSql  += "	F_T_DATETOSTRING(a.WORK_FROM_DT) WORK_FROM_DT , \n";
			strSql  += "	F_T_DATETOSTRING(a.WORK_TO_DT) WORK_TO_DT , \n";
			strSql += " 	to_char(b.SLIP_ID) SLIP_ID,				--전표ID  \n";
			strSql += " 	to_char(b.SLIP_IDSEQ) SLIP_IDSEQ,		--전표ID순번 \n";
			strSql  += "	nvl(b.cnt,0) cnt, \n";
			strSql += " 	c.make_comp_code, \n";
			strSql += " 	a.moduserno, \n";
			strSql += " 	F_T_DATETOSTRING(c.make_dt) make_dt, \n";
			strSql += " 	c.make_seq, \n";
			strSql += " 	c.slip_kind_tag \n";
			strSql  += "From	T_FIX_DEPREC_CAL a,  \n";
			strSql  += " 	     	(select work_seq, slip_id, \n";
			strSql  += " 	     	 	   count(dept_code) cnt, \n";
			strSql  += " 	     	 	   max(slip_idseq) slip_idseq \n";
			strSql  += " 	     	 from  t_fix_furni_sum  \n";  
			strSql  += " 	     	 group by work_seq, slip_id ) b, \n";
			strSql += " 		T_ACC_SLIP_HEAD c \n";
			strSql  += "Where	a.work_seq = b.work_seq(+)  \n";
			strSql += " and	b.slip_id = c.slip_id(+) \n";
			strSql  += "and       b.cnt is not null \n";
			strSql  += "and      a.TRANS_CLS='T' \n";
			strSql  += "and       a.TARGET_CLS  <> '2' \n";
			if(strDIV.equals("D"))
			{
			strSql += " and a.work_seq =  ?    \n";
			}
			else
			{
			strSql  += "and	a.COMP_CODE =  ?  \n";
			strSql  += "And	a.WORK_DT Between  ?  And	 ?  ";
			}
			
			strSql += " and		b.slip_id is null \n";
			strSql  += "Order By a.WORK_DT desc , a.WORK_SEQ desc ";
			if(strDIV.equals("D"))
			{
				lrArgData.addColumn("WORK_SEQ",CITData.NUMBER);
				lrArgData.addRow();
				lrArgData.setValue("WORK_SEQ",strWORK_SEQ);
			}
			else
			{
				lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
				lrArgData.addColumn("WORK_DT_FROM",CITData.DATE);
				lrArgData.addColumn("WORK_DT_TO",CITData.DATE);
				lrArgData.addRow();
				lrArgData.setValue("COMP_CODE",strCOMP_CODE);
				lrArgData.setValue("WORK_DT_FROM",strWORK_DT_FROM);
				lrArgData.setValue("WORK_DT_TO",strWORK_DT_TO);
			}
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

		//발의 번호 순번
		else if (strAct.equals("MAKE_SEQ"))
		{
			String strMAKE_COMP_CODE = CITCommon.toKOR(request.getParameter("MAKE_COMP_CODE"));
			String strMAKE_DT_TRANS = CITCommon.toKOR(request.getParameter("MAKE_DT_TRANS"));
			
			strSql  = " Select F_T_GET_NEW_MAKE_SEQ(?,?) MAKE_SEQ	From DUAL ";
			
			lrArgData.addColumn("MAKE_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("MAKE_DT_TRANS", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("MAKE_COMP_CODE", strMAKE_COMP_CODE);
			lrArgData.setValue("MAKE_DT_TRANS", strMAKE_DT_TRANS);

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
				GauceInfo.response.writeException("USER", "900001","MAKE_SEQ Select 오류-> "+ ex.getMessage());
			}
		}
		
		else if (strAct.equals("WORK_SLIP_IDSEQ"))
		{
			String strGET_TYPE = CITCommon.toKOR(request.getParameter("GET_TYPE"));
			String strWORK_CODE = CITCommon.toKOR(request.getParameter("WORK_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			if("NEW".equals(strGET_TYPE)) {
				strSql  = " Select SQ_T_WORK_SLIP_ID.NEXTVAL WORK_SLIP_ID, SQ_T_WORK_SLIP_IDSEQ.NEXTVAL WORK_SLIP_IDSEQ From DUAL ";
			} else if("CUR".equals(strGET_TYPE)) {
				strSql  = " Select \n";
				strSql += " 	NVL(B.SLIP_ID,0) WORK_SLIP_ID, \n";
				strSql += " 	NVL(B.SLIP_IDSEQ,0) WORK_SLIP_IDSEQ \n";
				strSql += " From DUAL A, \n";
				strSql += " ( \n";
				strSql += " 	Select ROWNUM RN \n";
				strSql += " 	From DUAL \n";
				strSql += " ) A, \n";
				strSql += " ( \n";
				strSql += " 	SELECT ROWNUM RN, SLIP_ID, SLIP_IDSEQ \n";
				strSql += " 	FROM T_WORK_ACC_SLIP_BODY \n";
				strSql += " 	WHERE \n";
				strSql += " 		WORK_CODE =  ?  \n";
				strSql += " 		AND DEPT_CODE =  ?  \n";
				strSql += " 		AND CRTDATE = ( \n";
				strSql += " 			SELECT MAX(CRTDATE) \n";
				strSql += " 			FROM T_WORK_ACC_SLIP_BODY \n";
				strSql += " 			WHERE \n";
				strSql += " 				WORK_CODE =  ?  \n";
				strSql += " 				AND DEPT_CODE =  ?  \n";
				strSql += " 		) \n";
				strSql += " ) B \n";
				strSql += " WHERE \n";
				strSql += " 	A.RN = B.RN(+) ";
				
				lrArgData.addColumn("1WORK_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("2DEPT_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("3WORK_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("4DEPT_CODE", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("1WORK_CODE", strWORK_CODE);
				lrArgData.setValue("2DEPT_CODE", strDEPT_CODE);
				lrArgData.setValue("3WORK_CODE", strWORK_CODE);
				lrArgData.setValue("4DEPT_CODE", strDEPT_CODE);
			} else {
			}

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
		else if (strAct.equals("AUTO_BILL_FIX_SELL_SEQ"))
		{
			strSql  = " Select SQ_T_AUTO_B_F_SELL.NEXTVAL AUTO_BILL_FIX_SELL_SEQ From DUAL ";
                     
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
		else if (strAct.equals("COST_DEPT_KND_TAG"))
		{

			strSql  = " select \n";
			strSql += " 	  a.COST_DEPT_KND_TAG, 	 \n";
			strSql += " 	  a.COST_DEPT_KND_NAME  \n";
			strSql += " from t_cost_dept_kind a \n";
			strSql += " ORDER by  COST_DEPT_KND_TAG  desc";
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("ASSET_CLS_CODE", true);
				lrReturnData.setKey("ITEM_CODE", true);
				lrReturnData.setNotNull("ITEM_NAME", true);
				
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
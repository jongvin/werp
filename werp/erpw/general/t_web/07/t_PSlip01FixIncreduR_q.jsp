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
			String	strASSET_CLS_CODE = CITCommon.toKOR(request.getParameter("ASSET_CLS_CODE"));
			String	strITEM_CODE = CITCommon.toKOR(request.getParameter("ITEM_CODE"));
			String	strITEM_NM_CODE = CITCommon.toKOR(request.getParameter("ITEM_NM_CODE"));
			String	strDEPREC_FINISH = CITCommon.toKOR(request.getParameter("DEPREC_FINISH"));
			String      strINCSUB_YEAR = CITCommon.toKOR(request.getParameter("INCSUB_YEAR"));
			
			String	strFIX_ASSET_SEQ = CITCommon.toKOR(request.getParameter("FIX_ASSET_SEQ"));
			String	strINCREDU_SEQ = CITCommon.toKOR(request.getParameter("INCREDU_SEQ"));
			String      strDIV = CITCommon.toKOR(request.getParameter("DIV"));
			
			strSql  = " select	 \n";
			strSql += " 		'F' CHK_CLS,		    --구분 \n";
			strSql += " 		a.FIX_ASSET_SEQ,	    --취득 순번 \n";
			strSql += " 		a.ASSET_CLS_CODE,   --자산종류코드 \n";
			strSql += " 		a.ITEM_CODE,		--품목코드 \n";
			strSql += " 		a.ITEM_NM_CODE,		--품명코드 \n";
			strSql += " 		a.FIX_ASSET_NO,		--자산순번 \n";
			strSql += " 		a.ASSET_MNG_NO, 	--자산관리번호 \n";
			strSql += " 		a.COMP_CODE,		--사업장코드 \n";
			strSql += " 		a.ASSET_NAME,		--자산명 \n";
			strSql += " 		to_char(g.SLIP_ID) SLIP_ID,			--전표ID  \n";
			strSql += " 		to_char(g.SLIP_IDSEQ) SLIP_IDSEQ,		--전표ID순번 \n";
			strSql += " 		to_char(a.WORK_SEQ) WORK_SEQ,			--작업순번 \n";
			strSql += " 		c.cust_name, \n";
			strSql += " 		F_T_CUST_MASK(c.cust_code) cust_code, \n";
			strSql += " 		d1.dept_name mng_dept_name, \n";
			strSql += " 		d2.dept_name, \n";
			strSql += " 		f.make_comp_code, \n";
			strSql += " 		F_T_DATETOSTRING(f.make_dt) make_dt, \n";
			strSql += " 		f.make_seq, \n";
			strSql += " 		f.slip_kind_tag, \n";
			strSql += " 		0 vat_amt, \n";
			strSql += " 		g.incsub_amt, \n";
			strSql += " 		g.incredu_seq, \n";
			strSql += " 		0 auto_b_f_incsub_seq \n";
			strSql += " from	T_FIX_SHEET a, \n";
			strSql += " 		T_CUST_CODE c, \n";
			strSql += " 		T_DEPT_CODE d1, \n";
			strSql += " 		T_DEPT_CODE d2, \n";
			strSql += " 		T_ACC_SLIP_HEAD f, \n";
			strSql += " 		T_FIX_INCREDU g \n";
			strSql += " where		a.cust_seq=c.cust_seq(+) \n";
			strSql += " and		a.mng_dept_code=d1.dept_code(+) \n";
			strSql += " and		a.dept_code=d2.dept_code(+) \n";
			strSql += " and		g.slip_id = f.slip_id(+) \n";
			strSql += " and		a.fix_asset_seq = g.fix_asset_seq \n";
			strSql += " and		g.incredu_cls = 1 \n";
			//strSql += " and		a.deprec_finish = 1 \n";
			strSql += " and		a.sale_dt is null \n";
			if(strDIV.equals("D"))
			{
			strSql += " and		g.fix_asset_seq =  ?    \n";
			strSql += " and		g.incredu_seq =  ?    \n";
			}
			else
			{
			strSql += " and		a.comp_code = ? \n";
			strSql += " and		a.asset_cls_code = ? \n";
			strSql += " and		a.item_code like '%' ||   ?   || '%' \n";
			strSql += " and		a.item_nm_code like '%' ||   ?   || '%' \n";
			strSql += " and		a.deprec_finish  like '%' ||   ?   || '%' \n";
			strSql += " and		to_char(g.incredu_dt,'YYYY') = ? \n";
			}
			strSql += " and		g.slip_id is null \n";
			strSql += "Order	By	a.fix_asset_seq desc, g.incredu_seq desc ";
			
			if(strDIV.equals("D"))
			{
				lrArgData.addColumn("FIX_ASSET_SEQ",CITData.NUMBER);
				lrArgData.addColumn("INCREDU_SEQ",CITData.NUMBER);
				lrArgData.addRow();
				lrArgData.setValue("FIX_ASSET_SEQ",strFIX_ASSET_SEQ);
				lrArgData.setValue("INCREDU_SEQ",strINCREDU_SEQ);
			}
			else
			{
				lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
				lrArgData.addColumn("ASSET_CLS_CODE",CITData.VARCHAR2);
				lrArgData.addColumn("ITEM_CODE",CITData.VARCHAR2);
				lrArgData.addColumn("ITEM_NM_CODE",CITData.VARCHAR2);
				lrArgData.addColumn("DEPREC_FINISH",CITData.VARCHAR2);
				lrArgData.addColumn("INCSUB_YEAR",CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("COMP_CODE",strCOMP_CODE);
				lrArgData.setValue("ASSET_CLS_CODE",strASSET_CLS_CODE);
				lrArgData.setValue("ITEM_CODE",strITEM_CODE);
				lrArgData.setValue("ITEM_NM_CODE",strITEM_NM_CODE);
				lrArgData.setValue("DEPREC_FINISH",strDEPREC_FINISH);
				lrArgData.setValue("INCSUB_YEAR",strINCSUB_YEAR);
			}
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("FIX_ASSET_SEQ", true);
				lrReturnData.setNotNull("ASSET_CLS_CODE", true);
				lrReturnData.setNotNull("ITEM_CODE", true);
				lrReturnData.setNotNull("ITEM_NM_CODE", true);
				lrReturnData.setNotNull("COMP_CODE", true);
				lrReturnData.setNotNull("ACC_CODE", true);
				lrReturnData.setNotNull("GET_DT", true);
				lrReturnData.setNotNull("ASSET_NAME", true);
				lrReturnData.setNotNull("ASSET_CNT", true);
				lrReturnData.setNotNull("BASE_AMT", true);
				lrReturnData.setNotNull("OLD_DEPREC_AMT", true);
				lrReturnData.setNotNull("GET_COST_AMT", true);
				lrReturnData.setNotNull("INC_SUM_AMT", true);
				lrReturnData.setNotNull("SUB_SUM_AMT", true);
				lrReturnData.setNotNull("FIXED_CLS", true);
				lrReturnData.setNotNull("FIXTURES_CLS", true);
				lrReturnData.setNotNull("ETC_ASSET_TAG", true);
				lrReturnData.setNotNull("CAPITAL_OUT_AMT", true);
				lrReturnData.setNotNull("GAIN_OUT_AMT", true);
				lrReturnData.setNotNull("ITEM_NM_SEQ", true);
				lrReturnData.setNotNull("CHG_GET_AMT", true);
				lrReturnData.setNotNull("START_ASSET_AMT", true);
				lrReturnData.setNotNull("CURR_ASSET_INC_AMT", true);
				lrReturnData.setNotNull("CURR_ASSET_SUB_AMT", true);
				lrReturnData.setNotNull("START_APPROP_AMT", true);
				lrReturnData.setNotNull("CURR_APPROP_SUB_AMT", true);
				lrReturnData.setNotNull("CURR_DEPREC_AMT", true);
				
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
		
		else	if (strAct.equals("ASSET_CLS_CODE"))
		{


			strSql  = "Select  \n";
			strSql  += "	a.ASSET_CLS_CODE ,  \n";
			strSql  += "	a.ASSET_CLS_NAME  \n";
			strSql  += "From	T_FIX_ASSET_CLS_CODE a  \n";
			strSql  += "Order By  \n";
			strSql  += "	a.ASSET_CLS_CODE";


			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);




				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","ASSET_CLS_CODE Select 오류-> "+ ex.getMessage());
				throw new Exception("USER-900001:ASSET_CLS_CODE Select 오류 -> " + ex.getMessage());
			}
		}
		//상각완료구분
		else	if (strAct.equals("DEPREC_FINISH"))
		{


			strSql  = "Select   \n";
			strSql  += "	a.CODE_LIST_ID,   \n";
			strSql  += "	a.CODE_LIST_NAME,   \n";
			strSql  += "	a.SEQ   \n";
			strSql  += "From	V_T_CODE_LIST a   \n";
			strSql  += "Where	a.CODE_GROUP_ID = 'DEPREC_FINISH'   \n";
			strSql  += "And		a.USE_TAG = 'T'   \n";
			strSql  += "Union \n";
			strSql  += "Select \n";
			strSql  += "	'%' , \n";
			strSql  += "	'전체' , \n";
			strSql  += "	-1 \n";
			strSql  += "From	V_T_CODE_LIST a \n";
			strSql  += "Where	a.CODE_GROUP_ID = 'DEPREC_FINISH'   \n";
			strSql  += "Order By   \n";
			strSql  += "	3";


			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","DEPREC_FINISH Select 오류-> "+ ex.getMessage());
				throw new Exception("USER-900001:DEPREC_FINISH Select 오류 -> " + ex.getMessage());
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
		else if (strAct.equals("AUTO_BILL_FIX_INCSUB_SEQ"))
		{
			strSql  = " Select SQ_T_AUTO_B_F_INCSUB.NEXTVAL AUTO_BILL_FIX_INCSUB_SEQ From DUAL ";
                     
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
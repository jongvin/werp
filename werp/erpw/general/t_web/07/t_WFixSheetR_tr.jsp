<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2006-01-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsFIX_SHEET_COPY = null;
	GauceDataSet dsREMOVE = null;
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	Connection conn = null;
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* 세션정보 */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		conn = CITConnectionManager.getConnection(false);
		
		strAct = GauceInfo.request.getParameter("ACT");
		if(!CITCommon.isNull(strAct) && strAct.equals("REMOVE"))
		{
			dsREMOVE = GauceInfo.request.getGauceDataSet("dsREMOVE");
			
			if (dsREMOVE == null) throw new Exception("dsREMOVE이(가) 널(Null)입니다.");
			
			rows = dsREMOVE.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_FIX_REM_GET_SLIP(?)}";
						
					lrArgData.addColumn("FIX_ASSET_SEQ", CITData.NUMBER);

					lrArgData.addRow();

					lrArgData.setValue("FIX_ASSET_SEQ", rows[i].getString(dsREMOVE.indexOfColumn("FIX_ASSET_SEQ")));

					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "전표삭제 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		if(!CITCommon.isNull(strAct) && strAct.equals("FIX_SHEET_COPY"))
		{
			dsFIX_SHEET_COPY = GauceInfo.request.getGauceDataSet("dsFIX_SHEET_COPY");
			rows = dsFIX_SHEET_COPY.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_FIX_SHEET_COPY(?)}";
					
					lrArgData.addColumn("FIX_ASSET_SEQ", CITData.NUMBER);
		
					lrArgData.addRow();
					lrArgData.setValue("FIX_ASSET_SEQ", rows[i].getString(dsFIX_SHEET_COPY.indexOfColumn("FIX_ASSET_SEQ")));
			
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
					
					
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_BUDG_MONTH_AMT_H 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		
		if (CITCommon.isNull(strAct))
		{
			dsMAIN = GauceInfo.request.getGauceDataSet("dsMAIN");
			
			if (dsMAIN == null) throw new Exception("dsMAIN이(가) 널(Null)입니다.");
			
			rows = dsMAIN.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_FIX_SHEET_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("FIX_ASSET_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ASSET_CLS_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("FIX_ASSET_NO", CITData.NUMBER);
						lrArgData.addColumn("ASSET_MNG_NO", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("GET_DT", CITData.VARCHAR2);
						lrArgData.addColumn("ASSET_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("ASSET_SIZE", CITData.VARCHAR2);
						lrArgData.addColumn("PRODUCTION", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("USAGE", CITData.VARCHAR2);
						lrArgData.addColumn("GET_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("DEPREC_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("SRVLIFE", CITData.NUMBER);
						lrArgData.addColumn("ASSET_CNT", CITData.NUMBER);
						lrArgData.addColumn("BASE_AMT", CITData.NUMBER);
						lrArgData.addColumn("OLD_DEPREC_AMT", CITData.NUMBER);
						lrArgData.addColumn("GET_COST_AMT", CITData.NUMBER);
						lrArgData.addColumn("INC_SUM_AMT", CITData.NUMBER);
						lrArgData.addColumn("SUB_SUM_AMT", CITData.NUMBER);
						lrArgData.addColumn("NEW_OLD_ASSET", CITData.VARCHAR2);
						lrArgData.addColumn("INCNTRY_OUTCNTRY_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("FIXED_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("FIXTURES_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("ETC_ASSET_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("DISPOSE_YEAR", CITData.NUMBER);
						lrArgData.addColumn("DEPREC_FINISH", CITData.VARCHAR2);
						lrArgData.addColumn("CAPITAL_OUT_AMT", CITData.NUMBER);
						lrArgData.addColumn("GAIN_OUT_AMT", CITData.NUMBER);
						lrArgData.addColumn("USE_REMARK", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NM_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CHG_GET_AMT", CITData.NUMBER);
						lrArgData.addColumn("SALE_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);
						lrArgData.addColumn("START_ASSET_AMT", CITData.NUMBER);
						lrArgData.addColumn("CURR_ASSET_INC_AMT", CITData.NUMBER);
						lrArgData.addColumn("CURR_ASSET_SUB_AMT", CITData.NUMBER);
						lrArgData.addColumn("START_APPROP_AMT", CITData.NUMBER);
						lrArgData.addColumn("CURR_APPROP_SUB_AMT", CITData.NUMBER);
						lrArgData.addColumn("CURR_DEPREC_AMT", CITData.NUMBER);
						lrArgData.addColumn("REMARK", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_SEQ2", CITData.NUMBER);
						lrArgData.addColumn("ESTIMATE_AMT1", CITData.NUMBER);
						lrArgData.addColumn("ESTIMATE_AMT2", CITData.NUMBER);
						lrArgData.addColumn("FOREIGN_AMT", CITData.NUMBER);
						lrArgData.addColumn("MONEY_CLS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("FIX_ASSET_SEQ", rows[i].getString(dsMAIN.indexOfColumn("FIX_ASSET_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("ASSET_CLS_CODE", rows[i].getString(dsMAIN.indexOfColumn("ASSET_CLS_CODE")));
						lrArgData.setValue("ITEM_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITEM_CODE")));
						lrArgData.setValue("ITEM_NM_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NM_CODE")));
						lrArgData.setValue("FIX_ASSET_NO", rows[i].getString(dsMAIN.indexOfColumn("FIX_ASSET_NO")));
						lrArgData.setValue("ASSET_MNG_NO", rows[i].getString(dsMAIN.indexOfColumn("ASSET_MNG_NO")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("GET_DT", rows[i].getString(dsMAIN.indexOfColumn("GET_DT")));
						lrArgData.setValue("ASSET_NAME", rows[i].getString(dsMAIN.indexOfColumn("ASSET_NAME")));
						lrArgData.setValue("ASSET_SIZE", rows[i].getString(dsMAIN.indexOfColumn("ASSET_SIZE")));
						lrArgData.setValue("PRODUCTION", rows[i].getString(dsMAIN.indexOfColumn("PRODUCTION")));
						lrArgData.setValue("CUST_SEQ", rows[i].getString(dsMAIN.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("USAGE", rows[i].getString(dsMAIN.indexOfColumn("USAGE")));
						lrArgData.setValue("GET_CLS", rows[i].getString(dsMAIN.indexOfColumn("GET_CLS")));
						lrArgData.setValue("DEPREC_CLS", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_CLS")));
						lrArgData.setValue("SRVLIFE", rows[i].getString(dsMAIN.indexOfColumn("SRVLIFE")));
						lrArgData.setValue("ASSET_CNT", rows[i].getString(dsMAIN.indexOfColumn("ASSET_CNT")));
						lrArgData.setValue("BASE_AMT", rows[i].getString(dsMAIN.indexOfColumn("BASE_AMT")));
						lrArgData.setValue("OLD_DEPREC_AMT", rows[i].getString(dsMAIN.indexOfColumn("OLD_DEPREC_AMT")));
						lrArgData.setValue("GET_COST_AMT", rows[i].getString(dsMAIN.indexOfColumn("GET_COST_AMT")));
						lrArgData.setValue("INC_SUM_AMT", rows[i].getString(dsMAIN.indexOfColumn("INC_SUM_AMT")));
						lrArgData.setValue("SUB_SUM_AMT", rows[i].getString(dsMAIN.indexOfColumn("SUB_SUM_AMT")));
						lrArgData.setValue("NEW_OLD_ASSET", rows[i].getString(dsMAIN.indexOfColumn("NEW_OLD_ASSET")));
						lrArgData.setValue("INCNTRY_OUTCNTRY_CLS", rows[i].getString(dsMAIN.indexOfColumn("INCNTRY_OUTCNTRY_CLS")));
						lrArgData.setValue("FIXED_CLS", rows[i].getString(dsMAIN.indexOfColumn("FIXED_CLS")));
						lrArgData.setValue("FIXTURES_CLS", rows[i].getString(dsMAIN.indexOfColumn("FIXTURES_CLS")));
						lrArgData.setValue("ETC_ASSET_TAG", rows[i].getString(dsMAIN.indexOfColumn("ETC_ASSET_TAG")));
						lrArgData.setValue("DISPOSE_YEAR", rows[i].getString(dsMAIN.indexOfColumn("DISPOSE_YEAR")));
						lrArgData.setValue("DEPREC_FINISH", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_FINISH")));
						lrArgData.setValue("CAPITAL_OUT_AMT", rows[i].getString(dsMAIN.indexOfColumn("CAPITAL_OUT_AMT")));
						lrArgData.setValue("GAIN_OUT_AMT", rows[i].getString(dsMAIN.indexOfColumn("GAIN_OUT_AMT")));
						lrArgData.setValue("USE_REMARK", rows[i].getString(dsMAIN.indexOfColumn("USE_REMARK")));
						lrArgData.setValue("MNG_DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("MNG_DEPT_CODE")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("ITEM_NM_SEQ", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NM_SEQ")));
						lrArgData.setValue("CHG_GET_AMT", rows[i].getString(dsMAIN.indexOfColumn("CHG_GET_AMT")));
						lrArgData.setValue("SALE_DT", rows[i].getString(dsMAIN.indexOfColumn("SALE_DT")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAIN.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsMAIN.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("WORK_SEQ", rows[i].getString(dsMAIN.indexOfColumn("WORK_SEQ")));
						lrArgData.setValue("START_ASSET_AMT", rows[i].getString(dsMAIN.indexOfColumn("START_ASSET_AMT")));
						lrArgData.setValue("CURR_ASSET_INC_AMT", rows[i].getString(dsMAIN.indexOfColumn("CURR_ASSET_INC_AMT")));
						lrArgData.setValue("CURR_ASSET_SUB_AMT", rows[i].getString(dsMAIN.indexOfColumn("CURR_ASSET_SUB_AMT")));
						lrArgData.setValue("START_APPROP_AMT", rows[i].getString(dsMAIN.indexOfColumn("START_APPROP_AMT")));
						lrArgData.setValue("CURR_APPROP_SUB_AMT", rows[i].getString(dsMAIN.indexOfColumn("CURR_APPROP_SUB_AMT")));
						lrArgData.setValue("CURR_DEPREC_AMT", rows[i].getString(dsMAIN.indexOfColumn("CURR_DEPREC_AMT")));
						lrArgData.setValue("REMARK", rows[i].getString(dsMAIN.indexOfColumn("REMARK")));
						lrArgData.setValue("CUST_SEQ2", rows[i].getString(dsMAIN.indexOfColumn("CUST_SEQ2")));
						lrArgData.setValue("ESTIMATE_AMT1", rows[i].getString(dsMAIN.indexOfColumn("ESTIMATE_AMT1")));
						lrArgData.setValue("ESTIMATE_AMT2", rows[i].getString(dsMAIN.indexOfColumn("ESTIMATE_AMT2")));
						lrArgData.setValue("FOREIGN_AMT", rows[i].getString(dsMAIN.indexOfColumn("FOREIGN_AMT")));
						lrArgData.setValue("MONEY_CLS", rows[i].getString(dsMAIN.indexOfColumn("MONEY_CLS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIX_SHEET_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("FIX_ASSET_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ASSET_CLS_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("FIX_ASSET_NO", CITData.NUMBER);
						lrArgData.addColumn("ASSET_MNG_NO", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("GET_DT", CITData.VARCHAR2);
						lrArgData.addColumn("ASSET_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("ASSET_SIZE", CITData.VARCHAR2);
						lrArgData.addColumn("PRODUCTION", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("USAGE", CITData.VARCHAR2);
						lrArgData.addColumn("GET_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("DEPREC_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("SRVLIFE", CITData.NUMBER);
						lrArgData.addColumn("ASSET_CNT", CITData.NUMBER);
						lrArgData.addColumn("BASE_AMT", CITData.NUMBER);
						lrArgData.addColumn("OLD_DEPREC_AMT", CITData.NUMBER);
						lrArgData.addColumn("GET_COST_AMT", CITData.NUMBER);
						lrArgData.addColumn("INC_SUM_AMT", CITData.NUMBER);
						lrArgData.addColumn("SUB_SUM_AMT", CITData.NUMBER);
						lrArgData.addColumn("NEW_OLD_ASSET", CITData.VARCHAR2);
						lrArgData.addColumn("INCNTRY_OUTCNTRY_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("FIXED_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("FIXTURES_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("ETC_ASSET_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("DISPOSE_YEAR", CITData.NUMBER);
						lrArgData.addColumn("DEPREC_FINISH", CITData.VARCHAR2);
						lrArgData.addColumn("CAPITAL_OUT_AMT", CITData.NUMBER);
						lrArgData.addColumn("GAIN_OUT_AMT", CITData.NUMBER);
						lrArgData.addColumn("USE_REMARK", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NM_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CHG_GET_AMT", CITData.NUMBER);
						lrArgData.addColumn("SALE_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);
						lrArgData.addColumn("START_ASSET_AMT", CITData.NUMBER);
						lrArgData.addColumn("CURR_ASSET_INC_AMT", CITData.NUMBER);
						lrArgData.addColumn("CURR_ASSET_SUB_AMT", CITData.NUMBER);
						lrArgData.addColumn("START_APPROP_AMT", CITData.NUMBER);
						lrArgData.addColumn("CURR_APPROP_SUB_AMT", CITData.NUMBER);
						lrArgData.addColumn("CURR_DEPREC_AMT", CITData.NUMBER);
						lrArgData.addColumn("REMARK", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_SEQ2", CITData.NUMBER);
						lrArgData.addColumn("ESTIMATE_AMT1", CITData.NUMBER);
						lrArgData.addColumn("ESTIMATE_AMT2", CITData.NUMBER);
						lrArgData.addColumn("FOREIGN_AMT", CITData.NUMBER);
						lrArgData.addColumn("MONEY_CLS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("FIX_ASSET_SEQ", rows[i].getString(dsMAIN.indexOfColumn("FIX_ASSET_SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("ASSET_CLS_CODE", rows[i].getString(dsMAIN.indexOfColumn("ASSET_CLS_CODE")));
						lrArgData.setValue("ITEM_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITEM_CODE")));
						lrArgData.setValue("ITEM_NM_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NM_CODE")));
						lrArgData.setValue("FIX_ASSET_NO", rows[i].getString(dsMAIN.indexOfColumn("FIX_ASSET_NO")));
						lrArgData.setValue("ASSET_MNG_NO", rows[i].getString(dsMAIN.indexOfColumn("ASSET_MNG_NO")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("GET_DT", rows[i].getString(dsMAIN.indexOfColumn("GET_DT")));
						lrArgData.setValue("ASSET_NAME", rows[i].getString(dsMAIN.indexOfColumn("ASSET_NAME")));
						lrArgData.setValue("ASSET_SIZE", rows[i].getString(dsMAIN.indexOfColumn("ASSET_SIZE")));
						lrArgData.setValue("PRODUCTION", rows[i].getString(dsMAIN.indexOfColumn("PRODUCTION")));
						lrArgData.setValue("CUST_SEQ", rows[i].getString(dsMAIN.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("USAGE", rows[i].getString(dsMAIN.indexOfColumn("USAGE")));
						lrArgData.setValue("GET_CLS", rows[i].getString(dsMAIN.indexOfColumn("GET_CLS")));
						lrArgData.setValue("DEPREC_CLS", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_CLS")));
						lrArgData.setValue("SRVLIFE", rows[i].getString(dsMAIN.indexOfColumn("SRVLIFE")));
						lrArgData.setValue("ASSET_CNT", rows[i].getString(dsMAIN.indexOfColumn("ASSET_CNT")));
						lrArgData.setValue("BASE_AMT", rows[i].getString(dsMAIN.indexOfColumn("BASE_AMT")));
						lrArgData.setValue("OLD_DEPREC_AMT", rows[i].getString(dsMAIN.indexOfColumn("OLD_DEPREC_AMT")));
						lrArgData.setValue("GET_COST_AMT", rows[i].getString(dsMAIN.indexOfColumn("GET_COST_AMT")));
						lrArgData.setValue("INC_SUM_AMT", rows[i].getString(dsMAIN.indexOfColumn("INC_SUM_AMT")));
						lrArgData.setValue("SUB_SUM_AMT", rows[i].getString(dsMAIN.indexOfColumn("SUB_SUM_AMT")));
						lrArgData.setValue("NEW_OLD_ASSET", rows[i].getString(dsMAIN.indexOfColumn("NEW_OLD_ASSET")));
						lrArgData.setValue("INCNTRY_OUTCNTRY_CLS", rows[i].getString(dsMAIN.indexOfColumn("INCNTRY_OUTCNTRY_CLS")));
						lrArgData.setValue("FIXED_CLS", rows[i].getString(dsMAIN.indexOfColumn("FIXED_CLS")));
						lrArgData.setValue("FIXTURES_CLS", rows[i].getString(dsMAIN.indexOfColumn("FIXTURES_CLS")));
						lrArgData.setValue("ETC_ASSET_TAG", rows[i].getString(dsMAIN.indexOfColumn("ETC_ASSET_TAG")));
						lrArgData.setValue("DISPOSE_YEAR", rows[i].getString(dsMAIN.indexOfColumn("DISPOSE_YEAR")));
						lrArgData.setValue("DEPREC_FINISH", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_FINISH")));
						lrArgData.setValue("CAPITAL_OUT_AMT", rows[i].getString(dsMAIN.indexOfColumn("CAPITAL_OUT_AMT")));
						lrArgData.setValue("GAIN_OUT_AMT", rows[i].getString(dsMAIN.indexOfColumn("GAIN_OUT_AMT")));
						lrArgData.setValue("USE_REMARK", rows[i].getString(dsMAIN.indexOfColumn("USE_REMARK")));
						lrArgData.setValue("MNG_DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("MNG_DEPT_CODE")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("ITEM_NM_SEQ", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NM_SEQ")));
						lrArgData.setValue("CHG_GET_AMT", rows[i].getString(dsMAIN.indexOfColumn("CHG_GET_AMT")));
						lrArgData.setValue("SALE_DT", rows[i].getString(dsMAIN.indexOfColumn("SALE_DT")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAIN.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsMAIN.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("WORK_SEQ", rows[i].getString(dsMAIN.indexOfColumn("WORK_SEQ")));
						lrArgData.setValue("START_ASSET_AMT", rows[i].getString(dsMAIN.indexOfColumn("START_ASSET_AMT")));
						lrArgData.setValue("CURR_ASSET_INC_AMT", rows[i].getString(dsMAIN.indexOfColumn("CURR_ASSET_INC_AMT")));
						lrArgData.setValue("CURR_ASSET_SUB_AMT", rows[i].getString(dsMAIN.indexOfColumn("CURR_ASSET_SUB_AMT")));
						lrArgData.setValue("START_APPROP_AMT", rows[i].getString(dsMAIN.indexOfColumn("START_APPROP_AMT")));
						lrArgData.setValue("CURR_APPROP_SUB_AMT", rows[i].getString(dsMAIN.indexOfColumn("CURR_APPROP_SUB_AMT")));
						lrArgData.setValue("CURR_DEPREC_AMT", rows[i].getString(dsMAIN.indexOfColumn("CURR_DEPREC_AMT")));
						lrArgData.setValue("REMARK", rows[i].getString(dsMAIN.indexOfColumn("REMARK")));
						lrArgData.setValue("CUST_SEQ2", rows[i].getString(dsMAIN.indexOfColumn("CUST_SEQ2")));
						lrArgData.setValue("ESTIMATE_AMT1", rows[i].getString(dsMAIN.indexOfColumn("ESTIMATE_AMT1")));
						lrArgData.setValue("ESTIMATE_AMT2", rows[i].getString(dsMAIN.indexOfColumn("ESTIMATE_AMT2")));
						lrArgData.setValue("FOREIGN_AMT", rows[i].getString(dsMAIN.indexOfColumn("FOREIGN_AMT")));
						lrArgData.setValue("MONEY_CLS", rows[i].getString(dsMAIN.indexOfColumn("MONEY_CLS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIX_SHEET_D(?)}";
						
						lrArgData.addColumn("FIX_ASSET_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("FIX_ASSET_SEQ", rows[i].getString(dsMAIN.indexOfColumn("FIX_ASSET_SEQ")));
					}
					else
					{
						continue;
					}
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_FIX_SHEET 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		conn.commit();
	}
	catch (Exception ex)
	{
		if (conn != null) conn.rollback();
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITConnectionManager.freeConnection(conn);
			CITCommon.finalServerPage(GauceInfo);
		}
	    catch (Exception ex)
	    {
			if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
	    	GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
	    }
	}
%>

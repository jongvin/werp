<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2006-01-19)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsMAIN2 = null;
	GauceDataSet dsCALC = null;
	GauceDataSet dsFIX_SHEET = null;
	
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
		
		
			
		
		if(CITCommon.isNull(strAct))
		{
			dsMAIN    = GauceInfo.request.getGauceDataSet("dsMAIN");
			
			if (dsMAIN == null) throw new Exception("dsMAIN이(가) 널(Null)입니다.");	
			
			rows = dsMAIN.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_FIX_DEPREC_CAL_TEMP_I(?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("TARGET_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_USENO", CITData.NUMBER);
						lrArgData.addColumn("WORK_FROM_DT", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_TO_DT", CITData.VARCHAR2);
						lrArgData.addColumn("TRANS_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CAL_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("REMARK", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("WORK_SEQ", rows[i].getString(dsMAIN.indexOfColumn("WORK_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_DT")));
						lrArgData.setValue("WORK_NAME", rows[i].getString(dsMAIN.indexOfColumn("WORK_NAME")));
						lrArgData.setValue("TARGET_CLS", rows[i].getString(dsMAIN.indexOfColumn("TARGET_CLS")));
						lrArgData.setValue("WORK_USENO", rows[i].getString(dsMAIN.indexOfColumn("WORK_USENO")));
						lrArgData.setValue("WORK_FROM_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_FROM_DT")));
						lrArgData.setValue("WORK_TO_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_TO_DT")));
						lrArgData.setValue("TRANS_CLS", rows[i].getString(dsMAIN.indexOfColumn("TRANS_CLS")));
						lrArgData.setValue("CAL_CLS", rows[i].getString(dsMAIN.indexOfColumn("CAL_CLS")));
						lrArgData.setValue("REMARK", rows[i].getString(dsMAIN.indexOfColumn("REMARK")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIX_DEPREC_CAL_TEMP_U(?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("TARGET_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_USENO", CITData.NUMBER);
						lrArgData.addColumn("WORK_FROM_DT", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_TO_DT", CITData.VARCHAR2);
						lrArgData.addColumn("TRANS_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CAL_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("REMARK", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("WORK_SEQ", rows[i].getString(dsMAIN.indexOfColumn("WORK_SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_DT")));
						lrArgData.setValue("WORK_NAME", rows[i].getString(dsMAIN.indexOfColumn("WORK_NAME")));
						lrArgData.setValue("TARGET_CLS", rows[i].getString(dsMAIN.indexOfColumn("TARGET_CLS")));
						lrArgData.setValue("WORK_USENO", rows[i].getString(dsMAIN.indexOfColumn("WORK_USENO")));
						lrArgData.setValue("WORK_FROM_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_FROM_DT")));
						lrArgData.setValue("WORK_TO_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_TO_DT")));
						lrArgData.setValue("TRANS_CLS", rows[i].getString(dsMAIN.indexOfColumn("TRANS_CLS")));
						lrArgData.setValue("CAL_CLS", rows[i].getString(dsMAIN.indexOfColumn("CAL_CLS")));
						lrArgData.setValue("REMARK", rows[i].getString(dsMAIN.indexOfColumn("REMARK")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIX_DEPREC_CAL_TEMP_D(?)}";
						
						lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("WORK_SEQ", rows[i].getString(dsMAIN.indexOfColumn("WORK_SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIX_DEPREC_CAL 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
					
	
		
		
			dsMAIN2 	= GauceInfo.request.getGauceDataSet("dsMAIN2");
			
			if (dsMAIN2 == null) throw new Exception("dsMAIN2이(가) 널(Null)입니다.");
		
			rows = dsMAIN2.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_FIX_SUM_TEMP_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);
						lrArgData.addColumn("FIX_ASSET_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("SUM_CNT", CITData.NUMBER);
						lrArgData.addColumn("START_ASSET_AMT", CITData.NUMBER);
						lrArgData.addColumn("CURR_ASSET_INC_AMT", CITData.NUMBER);
						lrArgData.addColumn("CURR_ASSET_SUB_AMT", CITData.NUMBER);
						lrArgData.addColumn("START_APPROP_AMT", CITData.NUMBER);
						lrArgData.addColumn("CURR_APPROP_SUB_AMT", CITData.NUMBER);
						lrArgData.addColumn("CURR_DEPREC_AMT", CITData.NUMBER);
						lrArgData.addColumn("DEPREC_RAT", CITData.NUMBER);
						lrArgData.addColumn("BEFORE_WORK_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BEFORE_ASSET_CNT", CITData.NUMBER);
						lrArgData.addColumn("BEFORE_BASE_AMT", CITData.NUMBER);
						lrArgData.addColumn("BEFORE_OLD_DEPREC_AMT", CITData.NUMBER);
						lrArgData.addColumn("BEFORE_DEPREC_FINISH", CITData.VARCHAR2);
						lrArgData.addColumn("BEFORE_INC_SUM_AMT", CITData.NUMBER);
						lrArgData.addColumn("BEFORE_SUB_SUM_AMT", CITData.NUMBER);
						lrArgData.addColumn("BASE_AMT", CITData.NUMBER);
						lrArgData.addColumn("OLD_DEPREC_AMT", CITData.NUMBER);
						lrArgData.addColumn("DEPREC_FINISH", CITData.VARCHAR2);
						lrArgData.addColumn("INC_SUM_AMT", CITData.NUMBER);
						lrArgData.addColumn("SUB_SUM_AMT", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("WORK_SEQ", rows[i].getString(dsMAIN2.indexOfColumn("WORK_SEQ")));
						lrArgData.setValue("FIX_ASSET_SEQ", rows[i].getString(dsMAIN2.indexOfColumn("FIX_ASSET_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("SUM_CNT", rows[i].getString(dsMAIN2.indexOfColumn("SUM_CNT")));
						lrArgData.setValue("START_ASSET_AMT", rows[i].getString(dsMAIN2.indexOfColumn("START_ASSET_AMT")));
						lrArgData.setValue("CURR_ASSET_INC_AMT", rows[i].getString(dsMAIN2.indexOfColumn("CURR_ASSET_INC_AMT")));
						lrArgData.setValue("CURR_ASSET_SUB_AMT", rows[i].getString(dsMAIN2.indexOfColumn("CURR_ASSET_SUB_AMT")));
						lrArgData.setValue("START_APPROP_AMT", rows[i].getString(dsMAIN2.indexOfColumn("START_APPROP_AMT")));
						lrArgData.setValue("CURR_APPROP_SUB_AMT", rows[i].getString(dsMAIN2.indexOfColumn("CURR_APPROP_SUB_AMT")));
						lrArgData.setValue("CURR_DEPREC_AMT", rows[i].getString(dsMAIN2.indexOfColumn("CURR_DEPREC_AMT")));
						lrArgData.setValue("DEPREC_RAT", rows[i].getString(dsMAIN2.indexOfColumn("DEPREC_RAT")));
						lrArgData.setValue("BEFORE_WORK_SEQ", rows[i].getString(dsMAIN2.indexOfColumn("BEFORE_WORK_SEQ")));
						lrArgData.setValue("BEFORE_ASSET_CNT", rows[i].getString(dsMAIN2.indexOfColumn("BEFORE_ASSET_CNT")));
						lrArgData.setValue("BEFORE_BASE_AMT", rows[i].getString(dsMAIN2.indexOfColumn("BEFORE_BASE_AMT")));
						lrArgData.setValue("BEFORE_OLD_DEPREC_AMT", rows[i].getString(dsMAIN2.indexOfColumn("BEFORE_OLD_DEPREC_AMT")));
						lrArgData.setValue("BEFORE_DEPREC_FINISH", rows[i].getString(dsMAIN2.indexOfColumn("BEFORE_DEPREC_FINISH")));
						lrArgData.setValue("BEFORE_INC_SUM_AMT", rows[i].getString(dsMAIN2.indexOfColumn("BEFORE_INC_SUM_AMT")));
						lrArgData.setValue("BEFORE_SUB_SUM_AMT", rows[i].getString(dsMAIN2.indexOfColumn("BEFORE_SUB_SUM_AMT")));
						lrArgData.setValue("BASE_AMT", rows[i].getString(dsMAIN2.indexOfColumn("BASE_AMT")));
						lrArgData.setValue("OLD_DEPREC_AMT", rows[i].getString(dsMAIN2.indexOfColumn("OLD_DEPREC_AMT")));
						lrArgData.setValue("DEPREC_FINISH", rows[i].getString(dsMAIN2.indexOfColumn("DEPREC_FINISH")));
						lrArgData.setValue("INC_SUM_AMT", rows[i].getString(dsMAIN2.indexOfColumn("INC_SUM_AMT")));
						lrArgData.setValue("SUB_SUM_AMT", rows[i].getString(dsMAIN2.indexOfColumn("SUB_SUM_AMT")));

					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIX_SUM_TEMP_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);
						lrArgData.addColumn("FIX_ASSET_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("SUM_CNT", CITData.NUMBER);
						lrArgData.addColumn("START_ASSET_AMT", CITData.NUMBER);
						lrArgData.addColumn("CURR_ASSET_INC_AMT", CITData.NUMBER);
						lrArgData.addColumn("CURR_ASSET_SUB_AMT", CITData.NUMBER);
						lrArgData.addColumn("START_APPROP_AMT", CITData.NUMBER);
						lrArgData.addColumn("CURR_APPROP_SUB_AMT", CITData.NUMBER);
						lrArgData.addColumn("CURR_DEPREC_AMT", CITData.NUMBER);
						lrArgData.addColumn("DEPREC_RAT", CITData.NUMBER);
						lrArgData.addColumn("BEFORE_WORK_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BEFORE_ASSET_CNT", CITData.NUMBER);
						lrArgData.addColumn("BEFORE_BASE_AMT", CITData.NUMBER);
						lrArgData.addColumn("BEFORE_OLD_DEPREC_AMT", CITData.NUMBER);
						lrArgData.addColumn("BEFORE_DEPREC_FINISH", CITData.VARCHAR2);
						lrArgData.addColumn("BEFORE_INC_SUM_AMT", CITData.NUMBER);
						lrArgData.addColumn("BEFORE_SUB_SUM_AMT", CITData.NUMBER);
						lrArgData.addColumn("BASE_AMT", CITData.NUMBER);
						lrArgData.addColumn("OLD_DEPREC_AMT", CITData.NUMBER);
						lrArgData.addColumn("DEPREC_FINISH", CITData.VARCHAR2);
						lrArgData.addColumn("INC_SUM_AMT", CITData.NUMBER);
						lrArgData.addColumn("SUB_SUM_AMT", CITData.NUMBER);
						lrArgData.addColumn("BEFORE_ASSET_CNT", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("WORK_SEQ", rows[i].getString(dsMAIN2.indexOfColumn("WORK_SEQ")));
						lrArgData.setValue("FIX_ASSET_SEQ", rows[i].getString(dsMAIN2.indexOfColumn("FIX_ASSET_SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("SUM_CNT", rows[i].getString(dsMAIN2.indexOfColumn("SUM_CNT")));
						lrArgData.setValue("START_ASSET_AMT", rows[i].getString(dsMAIN2.indexOfColumn("START_ASSET_AMT")));
						lrArgData.setValue("CURR_ASSET_INC_AMT", rows[i].getString(dsMAIN2.indexOfColumn("CURR_ASSET_INC_AMT")));
						lrArgData.setValue("CURR_ASSET_SUB_AMT", rows[i].getString(dsMAIN2.indexOfColumn("CURR_ASSET_SUB_AMT")));
						lrArgData.setValue("START_APPROP_AMT", rows[i].getString(dsMAIN2.indexOfColumn("START_APPROP_AMT")));
						lrArgData.setValue("CURR_APPROP_SUB_AMT", rows[i].getString(dsMAIN2.indexOfColumn("CURR_APPROP_SUB_AMT")));
						lrArgData.setValue("CURR_DEPREC_AMT", rows[i].getString(dsMAIN2.indexOfColumn("CURR_DEPREC_AMT")));
						lrArgData.setValue("DEPREC_RAT", rows[i].getString(dsMAIN2.indexOfColumn("DEPREC_RAT")));
						lrArgData.setValue("BEFORE_WORK_SEQ", rows[i].getString(dsMAIN2.indexOfColumn("BEFORE_WORK_SEQ")));
						lrArgData.setValue("BEFORE_ASSET_CNT", rows[i].getString(dsMAIN2.indexOfColumn("BEFORE_ASSET_CNT")));
						lrArgData.setValue("BEFORE_BASE_AMT", rows[i].getString(dsMAIN2.indexOfColumn("BEFORE_BASE_AMT")));
						lrArgData.setValue("BEFORE_OLD_DEPREC_AMT", rows[i].getString(dsMAIN2.indexOfColumn("BEFORE_OLD_DEPREC_AMT")));
						lrArgData.setValue("BEFORE_DEPREC_FINISH", rows[i].getString(dsMAIN2.indexOfColumn("BEFORE_DEPREC_FINISH")));
						lrArgData.setValue("BEFORE_INC_SUM_AMT", rows[i].getString(dsMAIN2.indexOfColumn("BEFORE_INC_SUM_AMT")));
						lrArgData.setValue("BEFORE_SUB_SUM_AMT", rows[i].getString(dsMAIN2.indexOfColumn("BEFORE_SUB_SUM_AMT")));
						lrArgData.setValue("BASE_AMT", rows[i].getString(dsMAIN2.indexOfColumn("BASE_AMT")));
						lrArgData.setValue("OLD_DEPREC_AMT", rows[i].getString(dsMAIN2.indexOfColumn("OLD_DEPREC_AMT")));
						lrArgData.setValue("DEPREC_FINISH", rows[i].getString(dsMAIN2.indexOfColumn("DEPREC_FINISH")));
						lrArgData.setValue("INC_SUM_AMT", rows[i].getString(dsMAIN2.indexOfColumn("INC_SUM_AMT")));
						lrArgData.setValue("SUB_SUM_AMT", rows[i].getString(dsMAIN2.indexOfColumn("SUB_SUM_AMT")));
						lrArgData.setValue("BEFORE_ASSET_CNT", rows[i].getString(dsMAIN2.indexOfColumn("BEFORE_ASSET_CNT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIX_SUM_TEMP_D(?,?)}";
						
						lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);
						lrArgData.addColumn("FIX_ASSET_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("WORK_SEQ", rows[i].getString(dsMAIN2.indexOfColumn("WORK_SEQ")));
						lrArgData.setValue("FIX_ASSET_SEQ", rows[i].getString(dsMAIN2.indexOfColumn("FIX_ASSET_SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIX_SUM 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		
		if(!CITCommon.isNull(strAct) && strAct.equals("CALC"))
		{
			dsCALC   	= GauceInfo.request.getGauceDataSet("dsCALC");
			
			if (dsCALC == null) throw new Exception("dsCALC(가) 널(Null)입니다.");	
		
			rows = dsCALC.getDataRows();

			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();

					strSql = "{call  SP_T_CALCPROCESS_TEMP(?,?)}";

					lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);
					lrArgData.addColumn("MODUSERNO", CITData.NUMBER);

					lrArgData.addRow();
					lrArgData.setValue("WORK_SEQ",  rows[i].getString(dsCALC.indexOfColumn("WORK_SEQ")));
					lrArgData.setValue("MODUSERNO",  strUserNo);

					CITDatabase.executeProcedure(strSql, lrArgData);
//					CITDebug.PrintMessages(CITXml.CITData2XML_CR(lrArgData));
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001", "??? 테이블 데이타 갱신 에러01" + ex.getMessage());
				throw new Exception("USER-900001: ??? 테이블 데이타 갱신 오류 -> " + ex.getMessage());
			}
		}
		if(!CITCommon.isNull(strAct) && strAct.equals("APPLY"))
		{
			dsFIX_SHEET 	= GauceInfo.request.getGauceDataSet("dsFIX_SHEET");
			if (dsFIX_SHEET == null) throw new Exception("dsFIX_SHEET(가) 널(Null)입니다.");
			rows = dsFIX_SHEET.getDataRows();

			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();

					strSql = "{call SP_T_APPLY_OR_CANCEL_FIX_DEP_T(?,?, ?, ?, ?,?)}";


					lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);
					lrArgData.addColumn("FIX_ASSET_SEQ", CITData.NUMBER);
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					lrArgData.addColumn("MODUSERNO", CITData.NUMBER);
					lrArgData.addColumn("TRANS_CLS", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("FIX_ASSET_SEQ",  rows[i].getString(dsFIX_SHEET.indexOfColumn("FIX_ASSET_SEQ")));
					lrArgData.setValue("WORK_SEQ",  rows[i].getString(dsFIX_SHEET.indexOfColumn("WORK_SEQ")));
					lrArgData.setValue("COMP_CODE",  rows[i].getString(dsFIX_SHEET.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID",  rows[i].getString(dsFIX_SHEET.indexOfColumn("CLSE_ACC_ID")));
					lrArgData.setValue("MODUSERNO",  strUserNo);
					lrArgData.setValue("TRANS_CLS",  rows[i].getString(dsFIX_SHEET.indexOfColumn("TRANS_CLS")));

					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001", "??? 테이블 데이타 갱신 에러01" + ex.getMessage());
				throw new Exception("USER-900001: ??? 테이블 데이타 갱신 오류 -> " + ex.getMessage());
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

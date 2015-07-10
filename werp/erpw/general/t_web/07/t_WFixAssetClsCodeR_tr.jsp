<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 홍길동 작성(2006-02-10)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	
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
						strSql = "{call SP_T_FIX_ASSET_CLS_CODE_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, ?,?)}";
						
						lrArgData.addColumn("ASSET_CLS_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ASSET_CLS_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("ASSET_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DEPREC_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("SRVLIFE", CITData.NUMBER);
						lrArgData.addColumn("DISLIFE", CITData.NUMBER);
						lrArgData.addColumn("SUM_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("SELL_PORF_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("SELL_LOSS_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("APPR_PROF_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("APPR_LOSS_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CAP_EXP_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("VAT_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CAP_EXP_VAT_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("SELL_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("TRA_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("SELL_VAT_ACC_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ASSET_CLS_CODE", rows[i].getString(dsMAIN.indexOfColumn("ASSET_CLS_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("ASSET_CLS_NAME", rows[i].getString(dsMAIN.indexOfColumn("ASSET_CLS_NAME")));
						lrArgData.setValue("ASSET_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("ASSET_ACC_CODE")));
						lrArgData.setValue("DEPREC_CLS", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_CLS")));
						lrArgData.setValue("SRVLIFE", rows[i].getString(dsMAIN.indexOfColumn("SRVLIFE")));
						lrArgData.setValue("DISLIFE", rows[i].getString(dsMAIN.indexOfColumn("DISLIFE")));
						lrArgData.setValue("SUM_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("SUM_ACC_CODE")));
						lrArgData.setValue("SELL_PORF_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("SELL_PORF_ACC_CODE")));
						lrArgData.setValue("SELL_LOSS_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("SELL_LOSS_ACC_CODE")));
						lrArgData.setValue("APPR_PROF_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("APPR_PROF_ACC_CODE")));
						lrArgData.setValue("APPR_LOSS_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("APPR_LOSS_ACC_CODE")));
						lrArgData.setValue("CAP_EXP_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("CAP_EXP_ACC_CODE")));
						lrArgData.setValue("VAT_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("VAT_ACC_CODE")));
						lrArgData.setValue("CAP_EXP_VAT_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("CAP_EXP_VAT_ACC_CODE")));
						lrArgData.setValue("SELL_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("SELL_ACC_CODE")));
						lrArgData.setValue("TRA_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("TRA_ACC_CODE")));
						lrArgData.setValue("SELL_VAT_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("SELL_VAT_ACC_CODE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIX_ASSET_CLS_CODE_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, ?)}";
						
						lrArgData.addColumn("ASSET_CLS_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ASSET_CLS_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("ASSET_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DEPREC_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("SRVLIFE", CITData.NUMBER);
						lrArgData.addColumn("DISLIFE", CITData.NUMBER);
						lrArgData.addColumn("SUM_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("SELL_PORF_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("SELL_LOSS_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("APPR_PROF_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("APPR_LOSS_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CAP_EXP_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("VAT_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CAP_EXP_VAT_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("SELL_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("TRA_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("SELL_VAT_ACC_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ASSET_CLS_CODE", rows[i].getString(dsMAIN.indexOfColumn("ASSET_CLS_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("ASSET_CLS_NAME", rows[i].getString(dsMAIN.indexOfColumn("ASSET_CLS_NAME")));
						lrArgData.setValue("ASSET_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("ASSET_ACC_CODE")));
						lrArgData.setValue("DEPREC_CLS", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_CLS")));
						lrArgData.setValue("SRVLIFE", rows[i].getString(dsMAIN.indexOfColumn("SRVLIFE")));
						lrArgData.setValue("DISLIFE", rows[i].getString(dsMAIN.indexOfColumn("DISLIFE")));
						lrArgData.setValue("SUM_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("SUM_ACC_CODE")));
						lrArgData.setValue("SELL_PORF_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("SELL_PORF_ACC_CODE")));
						lrArgData.setValue("SELL_LOSS_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("SELL_LOSS_ACC_CODE")));
						lrArgData.setValue("APPR_PROF_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("APPR_PROF_ACC_CODE")));
						lrArgData.setValue("APPR_LOSS_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("APPR_LOSS_ACC_CODE")));
						lrArgData.setValue("CAP_EXP_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("CAP_EXP_ACC_CODE")));
						lrArgData.setValue("VAT_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("VAT_ACC_CODE")));
						lrArgData.setValue("CAP_EXP_VAT_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("CAP_EXP_VAT_ACC_CODE")));
						lrArgData.setValue("SELL_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("SELL_ACC_CODE")));
						lrArgData.setValue("TRA_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("TRA_ACC_CODE")));
						lrArgData.setValue("SELL_VAT_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("SELL_VAT_ACC_CODE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIX_ASSET_CLS_CODE_D(?)}";
						
						lrArgData.addColumn("ASSET_CLS_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ASSET_CLS_CODE", rows[i].getString(dsMAIN.indexOfColumn("ASSET_CLS_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIX_ASSET_CLS_CODE 테이블 데이타 갱신 에러" + ex.getMessage());
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

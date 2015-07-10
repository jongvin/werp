<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2006-01-24)
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
						strSql = "{call SP_T_FIX_CAR_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("FIX_ASSET_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_NO", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_BODY_NO", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_YEAR", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_LENGTH", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_WIDTH", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_HEIGHT", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_WEIGHT", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_CC", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_CYLINDER", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_FORM_NO", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_OIL", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_USE", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_USER", CITData.VARCHAR2);
						lrArgData.addColumn("REGULAR_CHECK_START", CITData.VARCHAR2);
						lrArgData.addColumn("REGULAR_CHECK_END", CITData.VARCHAR2);
						lrArgData.addColumn("GET_TAX", CITData.NUMBER);
						lrArgData.addColumn("REG_TAX", CITData.NUMBER);
						lrArgData.addColumn("VAT_TAX", CITData.NUMBER);
						lrArgData.addColumn("INSURANCE_START", CITData.VARCHAR2);
						lrArgData.addColumn("INSURANCE_END", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("FIX_ASSET_SEQ", rows[i].getString(dsMAIN.indexOfColumn("FIX_ASSET_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("CAR_NO", rows[i].getString(dsMAIN.indexOfColumn("CAR_NO")));
						lrArgData.setValue("CAR_BODY_NO", rows[i].getString(dsMAIN.indexOfColumn("CAR_BODY_NO")));
						lrArgData.setValue("CAR_YEAR", rows[i].getString(dsMAIN.indexOfColumn("CAR_YEAR")));
						lrArgData.setValue("CAR_LENGTH", rows[i].getString(dsMAIN.indexOfColumn("CAR_LENGTH")));
						lrArgData.setValue("CAR_WIDTH", rows[i].getString(dsMAIN.indexOfColumn("CAR_WIDTH")));
						lrArgData.setValue("CAR_HEIGHT", rows[i].getString(dsMAIN.indexOfColumn("CAR_HEIGHT")));
						lrArgData.setValue("CAR_WEIGHT", rows[i].getString(dsMAIN.indexOfColumn("CAR_WEIGHT")));
						lrArgData.setValue("CAR_CC", rows[i].getString(dsMAIN.indexOfColumn("CAR_CC")));
						lrArgData.setValue("CAR_CYLINDER", rows[i].getString(dsMAIN.indexOfColumn("CAR_CYLINDER")));
						lrArgData.setValue("CAR_FORM_NO", rows[i].getString(dsMAIN.indexOfColumn("CAR_FORM_NO")));
						lrArgData.setValue("CAR_OIL", rows[i].getString(dsMAIN.indexOfColumn("CAR_OIL")));
						lrArgData.setValue("CAR_USE", rows[i].getString(dsMAIN.indexOfColumn("CAR_USE")));
						lrArgData.setValue("CAR_USER", rows[i].getString(dsMAIN.indexOfColumn("CAR_USER")));
						lrArgData.setValue("REGULAR_CHECK_START", rows[i].getString(dsMAIN.indexOfColumn("REGULAR_CHECK_START")));
						lrArgData.setValue("REGULAR_CHECK_END", rows[i].getString(dsMAIN.indexOfColumn("REGULAR_CHECK_END")));
						lrArgData.setValue("GET_TAX", rows[i].getString(dsMAIN.indexOfColumn("GET_TAX")));
						lrArgData.setValue("REG_TAX", rows[i].getString(dsMAIN.indexOfColumn("REG_TAX")));
						lrArgData.setValue("VAT_TAX", rows[i].getString(dsMAIN.indexOfColumn("VAT_TAX")));
						lrArgData.setValue("INSURANCE_START", rows[i].getString(dsMAIN.indexOfColumn("INSURANCE_START")));
						lrArgData.setValue("INSURANCE_END", rows[i].getString(dsMAIN.indexOfColumn("INSURANCE_END")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIX_CAR_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("FIX_ASSET_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_NO", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_BODY_NO", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_YEAR", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_LENGTH", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_WIDTH", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_HEIGHT", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_WEIGHT", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_CC", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_CYLINDER", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_FORM_NO", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_OIL", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_USE", CITData.VARCHAR2);
						lrArgData.addColumn("CAR_USER", CITData.VARCHAR2);
						lrArgData.addColumn("REGULAR_CHECK_START", CITData.VARCHAR2);
						lrArgData.addColumn("REGULAR_CHECK_END", CITData.VARCHAR2);
						lrArgData.addColumn("GET_TAX", CITData.NUMBER);
						lrArgData.addColumn("REG_TAX", CITData.NUMBER);
						lrArgData.addColumn("VAT_TAX", CITData.NUMBER);
						lrArgData.addColumn("INSURANCE_START", CITData.VARCHAR2);
						lrArgData.addColumn("INSURANCE_END", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("FIX_ASSET_SEQ", rows[i].getString(dsMAIN.indexOfColumn("FIX_ASSET_SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("CAR_NO", rows[i].getString(dsMAIN.indexOfColumn("CAR_NO")));
						lrArgData.setValue("CAR_BODY_NO", rows[i].getString(dsMAIN.indexOfColumn("CAR_BODY_NO")));
						lrArgData.setValue("CAR_YEAR", rows[i].getString(dsMAIN.indexOfColumn("CAR_YEAR")));
						lrArgData.setValue("CAR_LENGTH", rows[i].getString(dsMAIN.indexOfColumn("CAR_LENGTH")));
						lrArgData.setValue("CAR_WIDTH", rows[i].getString(dsMAIN.indexOfColumn("CAR_WIDTH")));
						lrArgData.setValue("CAR_HEIGHT", rows[i].getString(dsMAIN.indexOfColumn("CAR_HEIGHT")));
						lrArgData.setValue("CAR_WEIGHT", rows[i].getString(dsMAIN.indexOfColumn("CAR_WEIGHT")));
						lrArgData.setValue("CAR_CC", rows[i].getString(dsMAIN.indexOfColumn("CAR_CC")));
						lrArgData.setValue("CAR_CYLINDER", rows[i].getString(dsMAIN.indexOfColumn("CAR_CYLINDER")));
						lrArgData.setValue("CAR_FORM_NO", rows[i].getString(dsMAIN.indexOfColumn("CAR_FORM_NO")));
						lrArgData.setValue("CAR_OIL", rows[i].getString(dsMAIN.indexOfColumn("CAR_OIL")));
						lrArgData.setValue("CAR_USE", rows[i].getString(dsMAIN.indexOfColumn("CAR_USE")));
						lrArgData.setValue("CAR_USER", rows[i].getString(dsMAIN.indexOfColumn("CAR_USER")));
						lrArgData.setValue("REGULAR_CHECK_START", rows[i].getString(dsMAIN.indexOfColumn("REGULAR_CHECK_START")));
						lrArgData.setValue("REGULAR_CHECK_END", rows[i].getString(dsMAIN.indexOfColumn("REGULAR_CHECK_END")));
						lrArgData.setValue("GET_TAX", rows[i].getString(dsMAIN.indexOfColumn("GET_TAX")));
						lrArgData.setValue("REG_TAX", rows[i].getString(dsMAIN.indexOfColumn("REG_TAX")));
						lrArgData.setValue("VAT_TAX", rows[i].getString(dsMAIN.indexOfColumn("VAT_TAX")));
						lrArgData.setValue("INSURANCE_START", rows[i].getString(dsMAIN.indexOfColumn("INSURANCE_START")));
						lrArgData.setValue("INSURANCE_END", rows[i].getString(dsMAIN.indexOfColumn("INSURANCE_END")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIX_CAR_D(?)}";
						
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
				GauceInfo.response.writeException("USER", "900001", "t_fix_car 테이블 데이타 갱신 에러" + ex.getMessage());
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

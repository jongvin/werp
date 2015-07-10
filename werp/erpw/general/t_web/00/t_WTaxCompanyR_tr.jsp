<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2005-11-23)
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
						strSql = "{call SP_T_TAX_COMPANY_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("TAX_COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("BIZNO", CITData.VARCHAR2);
						lrArgData.addColumn("COMPANY_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("BIZNO2", CITData.VARCHAR2);
						lrArgData.addColumn("OPEN_DT", CITData.VARCHAR2);
						lrArgData.addColumn("BOSS", CITData.VARCHAR2);
						lrArgData.addColumn("BOSS_NO", CITData.VARCHAR2);
						lrArgData.addColumn("BIZCOND", CITData.VARCHAR2);
						lrArgData.addColumn("BIZKND", CITData.VARCHAR2);
						lrArgData.addColumn("TELNO", CITData.VARCHAR2);
						lrArgData.addColumn("BIZPLACE_ZIPCODE", CITData.VARCHAR2);
						lrArgData.addColumn("BIZPLACE_ADDR1", CITData.VARCHAR2);
						lrArgData.addColumn("BIZPLACE_ADDR2", CITData.VARCHAR2);
						lrArgData.addColumn("TACOFF", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("TAX_COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("TAX_COMP_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("BIZNO", rows[i].getString(dsMAIN.indexOfColumn("BIZNO")));
						lrArgData.setValue("COMPANY_NAME", rows[i].getString(dsMAIN.indexOfColumn("COMPANY_NAME")));
						lrArgData.setValue("BIZNO2", rows[i].getString(dsMAIN.indexOfColumn("BIZNO2")));
						lrArgData.setValue("OPEN_DT", rows[i].getString(dsMAIN.indexOfColumn("OPEN_DT")));
						lrArgData.setValue("BOSS", rows[i].getString(dsMAIN.indexOfColumn("BOSS")));
						lrArgData.setValue("BOSS_NO", rows[i].getString(dsMAIN.indexOfColumn("BOSS_NO")));
						lrArgData.setValue("BIZCOND", rows[i].getString(dsMAIN.indexOfColumn("BIZCOND")));
						lrArgData.setValue("BIZKND", rows[i].getString(dsMAIN.indexOfColumn("BIZKND")));
						lrArgData.setValue("TELNO", rows[i].getString(dsMAIN.indexOfColumn("TELNO")));
						lrArgData.setValue("BIZPLACE_ZIPCODE", rows[i].getString(dsMAIN.indexOfColumn("BIZPLACE_ZIPCODE")));
						lrArgData.setValue("BIZPLACE_ADDR1", rows[i].getString(dsMAIN.indexOfColumn("BIZPLACE_ADDR1")));
						lrArgData.setValue("BIZPLACE_ADDR2", rows[i].getString(dsMAIN.indexOfColumn("BIZPLACE_ADDR2")));
						lrArgData.setValue("TACOFF", rows[i].getString(dsMAIN.indexOfColumn("TACOFF")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_TAX_COMPANY_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("TAX_COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("BIZNO", CITData.VARCHAR2);
						lrArgData.addColumn("COMPANY_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("BIZNO2", CITData.VARCHAR2);
						lrArgData.addColumn("OPEN_DT", CITData.VARCHAR2);
						lrArgData.addColumn("BOSS", CITData.VARCHAR2);
						lrArgData.addColumn("BOSS_NO", CITData.VARCHAR2);
						lrArgData.addColumn("BIZCOND", CITData.VARCHAR2);
						lrArgData.addColumn("BIZKND", CITData.VARCHAR2);
						lrArgData.addColumn("TELNO", CITData.VARCHAR2);
						lrArgData.addColumn("BIZPLACE_ZIPCODE", CITData.VARCHAR2);
						lrArgData.addColumn("BIZPLACE_ADDR1", CITData.VARCHAR2);
						lrArgData.addColumn("BIZPLACE_ADDR2", CITData.VARCHAR2);
						lrArgData.addColumn("TACOFF", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("TAX_COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("TAX_COMP_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("BIZNO", rows[i].getString(dsMAIN.indexOfColumn("BIZNO")));
						lrArgData.setValue("COMPANY_NAME", rows[i].getString(dsMAIN.indexOfColumn("COMPANY_NAME")));
						lrArgData.setValue("BIZNO2", rows[i].getString(dsMAIN.indexOfColumn("BIZNO2")));
						lrArgData.setValue("OPEN_DT", rows[i].getString(dsMAIN.indexOfColumn("OPEN_DT")));
						lrArgData.setValue("BOSS", rows[i].getString(dsMAIN.indexOfColumn("BOSS")));
						lrArgData.setValue("BOSS_NO", rows[i].getString(dsMAIN.indexOfColumn("BOSS_NO")));
						lrArgData.setValue("BIZCOND", rows[i].getString(dsMAIN.indexOfColumn("BIZCOND")));
						lrArgData.setValue("BIZKND", rows[i].getString(dsMAIN.indexOfColumn("BIZKND")));
						lrArgData.setValue("TELNO", rows[i].getString(dsMAIN.indexOfColumn("TELNO")));
						lrArgData.setValue("BIZPLACE_ZIPCODE", rows[i].getString(dsMAIN.indexOfColumn("BIZPLACE_ZIPCODE")));
						lrArgData.setValue("BIZPLACE_ADDR1", rows[i].getString(dsMAIN.indexOfColumn("BIZPLACE_ADDR1")));
						lrArgData.setValue("BIZPLACE_ADDR2", rows[i].getString(dsMAIN.indexOfColumn("BIZPLACE_ADDR2")));
						lrArgData.setValue("TACOFF", rows[i].getString(dsMAIN.indexOfColumn("TACOFF")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_TAX_COMPANY_D(?)}";
						
						lrArgData.addColumn("TAX_COMP_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("TAX_COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("TAX_COMP_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_TAX_COMPANY 테이블 데이타 갱신 에러" + ex.getMessage());
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

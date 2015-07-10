<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-20)
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
						strSql = "{call SP_T_FIN_SEC_KIND_I(?,?,?,?,?,?)}";
						
						lrArgData.addColumn("SEC_KIND_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("SEC_KIND_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("SEC_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITRP_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITRB_ACC_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SEC_KIND_CODE", rows[i].getString(dsMAIN.indexOfColumn("SEC_KIND_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("SEC_KIND_NAME", rows[i].getString(dsMAIN.indexOfColumn("SEC_KIND_NAME")));
						lrArgData.setValue("SEC_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("SEC_ACC_CODE")));
						lrArgData.setValue("ITRP_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITRP_ACC_CODE")));
						lrArgData.setValue("ITRB_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITRB_ACC_CODE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_SEC_KIND_U(?,?,?,?,?,?)}";
						
						lrArgData.addColumn("SEC_KIND_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("SEC_KIND_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("SEC_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITRP_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITRB_ACC_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SEC_KIND_CODE", rows[i].getString(dsMAIN.indexOfColumn("SEC_KIND_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("SEC_KIND_NAME", rows[i].getString(dsMAIN.indexOfColumn("SEC_KIND_NAME")));
						lrArgData.setValue("SEC_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("SEC_ACC_CODE")));
						lrArgData.setValue("ITRP_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITRP_ACC_CODE")));
						lrArgData.setValue("ITRB_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITRB_ACC_CODE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_SEC_KIND_D(?)}";
						
						lrArgData.addColumn("SEC_KIND_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SEC_KIND_CODE", rows[i].getString(dsMAIN.indexOfColumn("SEC_KIND_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_SEC_KIND 테이블 데이타 갱신 에러" + ex.getMessage());
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

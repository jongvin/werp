<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-19)
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
						strSql = "{call SP_T_FB_LOOKUP_VALUES_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("LOOKUP_TYPE", CITData.VARCHAR2);
						lrArgData.addColumn("LOOKUP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("LOOKUP_VALUE", CITData.VARCHAR2);
						lrArgData.addColumn("USE_YN", CITData.VARCHAR2);
						lrArgData.addColumn("DESCRIPTION", CITData.VARCHAR2);
						lrArgData.addColumn("CREATION_DATE", CITData.VARCHAR2);
						lrArgData.addColumn("CREATION_EMP_NO", CITData.VARCHAR2);
						lrArgData.addColumn("LAST_MODIFY_DATE", CITData.VARCHAR2);
						lrArgData.addColumn("LAST_MODIFY_EMP_NO", CITData.VARCHAR2);
						lrArgData.addColumn("ATTRIBUTE1", CITData.VARCHAR2);
						lrArgData.addColumn("ATTRIBUTE2", CITData.VARCHAR2);
						lrArgData.addColumn("ATTRIBUTE3", CITData.VARCHAR2);
						lrArgData.addColumn("ATTRIBUTE4", CITData.VARCHAR2);
						lrArgData.addColumn("ATTRIBUTE5", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("LOOKUP_TYPE", rows[i].getString(dsMAIN.indexOfColumn("LOOKUP_TYPE")));
						lrArgData.setValue("LOOKUP_CODE", rows[i].getString(dsMAIN.indexOfColumn("LOOKUP_CODE")));
						lrArgData.setValue("LOOKUP_VALUE", rows[i].getString(dsMAIN.indexOfColumn("LOOKUP_VALUE")));
						lrArgData.setValue("USE_YN", rows[i].getString(dsMAIN.indexOfColumn("USE_YN")));
						lrArgData.setValue("DESCRIPTION", rows[i].getString(dsMAIN.indexOfColumn("DESCRIPTION")));
						lrArgData.setValue("CREATION_DATE", rows[i].getString(dsMAIN.indexOfColumn("CREATION_DATE")));
						lrArgData.setValue("CREATION_EMP_NO", strUserNo);
						lrArgData.setValue("LAST_MODIFY_DATE", rows[i].getString(dsMAIN.indexOfColumn("LAST_MODIFY_DATE")));
						lrArgData.setValue("LAST_MODIFY_EMP_NO", strUserNo);
						lrArgData.setValue("ATTRIBUTE1", rows[i].getString(dsMAIN.indexOfColumn("ATTRIBUTE1")));
						lrArgData.setValue("ATTRIBUTE2", rows[i].getString(dsMAIN.indexOfColumn("ATTRIBUTE2")));
						lrArgData.setValue("ATTRIBUTE3", rows[i].getString(dsMAIN.indexOfColumn("ATTRIBUTE3")));
						lrArgData.setValue("ATTRIBUTE4", rows[i].getString(dsMAIN.indexOfColumn("ATTRIBUTE4")));
						lrArgData.setValue("ATTRIBUTE5", rows[i].getString(dsMAIN.indexOfColumn("ATTRIBUTE5")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FB_LOOKUP_VALUES_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("LOOKUP_TYPE", CITData.VARCHAR2);
						lrArgData.addColumn("LOOKUP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("LOOKUP_VALUE", CITData.VARCHAR2);
						lrArgData.addColumn("USE_YN", CITData.VARCHAR2);
						lrArgData.addColumn("DESCRIPTION", CITData.VARCHAR2);
						lrArgData.addColumn("CREATION_DATE", CITData.VARCHAR2);
						lrArgData.addColumn("CREATION_EMP_NO", CITData.VARCHAR2);
						lrArgData.addColumn("LAST_MODIFY_DATE", CITData.VARCHAR2);
						lrArgData.addColumn("LAST_MODIFY_EMP_NO", CITData.VARCHAR2);
						lrArgData.addColumn("ATTRIBUTE1", CITData.VARCHAR2);
						lrArgData.addColumn("ATTRIBUTE2", CITData.VARCHAR2);
						lrArgData.addColumn("ATTRIBUTE3", CITData.VARCHAR2);
						lrArgData.addColumn("ATTRIBUTE4", CITData.VARCHAR2);
						lrArgData.addColumn("ATTRIBUTE5", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("LOOKUP_TYPE", rows[i].getString(dsMAIN.indexOfColumn("LOOKUP_TYPE")));
						lrArgData.setValue("LOOKUP_CODE", rows[i].getString(dsMAIN.indexOfColumn("LOOKUP_CODE")));
						lrArgData.setValue("LOOKUP_VALUE", rows[i].getString(dsMAIN.indexOfColumn("LOOKUP_VALUE")));
						lrArgData.setValue("USE_YN", rows[i].getString(dsMAIN.indexOfColumn("USE_YN")));
						lrArgData.setValue("DESCRIPTION", rows[i].getString(dsMAIN.indexOfColumn("DESCRIPTION")));
						lrArgData.setValue("CREATION_DATE", rows[i].getString(dsMAIN.indexOfColumn("CREATION_DATE")));
						lrArgData.setValue("CREATION_EMP_NO", strUserNo);
						lrArgData.setValue("LAST_MODIFY_DATE", rows[i].getString(dsMAIN.indexOfColumn("LAST_MODIFY_DATE")));
						lrArgData.setValue("LAST_MODIFY_EMP_NO", strUserNo);
						lrArgData.setValue("ATTRIBUTE1", rows[i].getString(dsMAIN.indexOfColumn("ATTRIBUTE1")));
						lrArgData.setValue("ATTRIBUTE2", rows[i].getString(dsMAIN.indexOfColumn("ATTRIBUTE2")));
						lrArgData.setValue("ATTRIBUTE3", rows[i].getString(dsMAIN.indexOfColumn("ATTRIBUTE3")));
						lrArgData.setValue("ATTRIBUTE4", rows[i].getString(dsMAIN.indexOfColumn("ATTRIBUTE4")));
						lrArgData.setValue("ATTRIBUTE5", rows[i].getString(dsMAIN.indexOfColumn("ATTRIBUTE5")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FB_LOOKUP_VALUES_D(?,?)}";
						
						lrArgData.addColumn("LOOKUP_TYPE", CITData.VARCHAR2);
						lrArgData.addColumn("LOOKUP_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("LOOKUP_TYPE", rows[i].getString(dsMAIN.indexOfColumn("LOOKUP_TYPE")));
						lrArgData.setValue("LOOKUP_CODE", rows[i].getString(dsMAIN.indexOfColumn("LOOKUP_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FB_LOOKUP_VALUES 테이블 데이타 갱신 에러" + ex.getMessage());
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

<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 최언회 작성(2005-11-23)
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
						strSql = "{call SP_TB_WT_SECT_I(?,?,?,?,?,?)}";

						lrArgData.addColumn("COM_ID", 			CITData.VARCHAR2);
						lrArgData.addColumn("SECT_CODE", 		CITData.VARCHAR2);
						lrArgData.addColumn("SECT_NAME", 		CITData.VARCHAR2);
						lrArgData.addColumn("SAUP_CODE", 		CITData.VARCHAR2);
						lrArgData.addColumn("ORGAN_CODE", 	CITData.VARCHAR2);
						lrArgData.addColumn("INSERT_EMP", 	CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COM_ID", 				rows[i].getString(dsMAIN.indexOfColumn("COM_ID")));
						lrArgData.setValue("SECT_CODE", 		rows[i].getString(dsMAIN.indexOfColumn("SECT_CODE")));
						lrArgData.setValue("SECT_NAME", 		rows[i].getString(dsMAIN.indexOfColumn("SECT_NAME")));
						lrArgData.setValue("SAUP_CODE", 		rows[i].getString(dsMAIN.indexOfColumn("SAUP_CODE")));
						lrArgData.setValue("ORGAN_CODE", 		rows[i].getString(dsMAIN.indexOfColumn("ORGAN_CODE")));
						lrArgData.setValue("INSERT_EMP", 		strUserNo);
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_TB_WT_SECT_U(?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COM_ID", 			CITData.VARCHAR2);
						lrArgData.addColumn("SECT_CODE", 		CITData.VARCHAR2);
						lrArgData.addColumn("SECT_NAME", 		CITData.VARCHAR2);
						lrArgData.addColumn("SAUP_CODE", 		CITData.VARCHAR2);
						lrArgData.addColumn("ORGAN_CODE", 	CITData.VARCHAR2);
						lrArgData.addColumn("UPDATE_EMP", 	CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COM_ID", 				rows[i].getString(dsMAIN.indexOfColumn("COM_ID")));
						lrArgData.setValue("SECT_CODE", 		rows[i].getString(dsMAIN.indexOfColumn("SECT_CODE")));
						lrArgData.setValue("SECT_NAME", 		rows[i].getString(dsMAIN.indexOfColumn("SECT_NAME")));
						lrArgData.setValue("SAUP_CODE", 		rows[i].getString(dsMAIN.indexOfColumn("SAUP_CODE")));
						lrArgData.setValue("ORGAN_CODE", 		rows[i].getString(dsMAIN.indexOfColumn("ORGAN_CODE")));
						lrArgData.setValue("UPDATE_EMP", 		strUserNo);
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_TB_WT_SECT_D(?,?)}";
						
						lrArgData.addColumn("COM_ID", 		CITData.VARCHAR2);
						lrArgData.addColumn("SECT_CODE", 	CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COM_ID", 			rows[i].getString(dsMAIN.indexOfColumn("COM_ID")));
						lrArgData.setValue("SECT_CODE", 	rows[i].getString(dsMAIN.indexOfColumn("SECT_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "TB_WT_SECT 테이블 데이타 갱신 에러" + ex.getMessage());
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

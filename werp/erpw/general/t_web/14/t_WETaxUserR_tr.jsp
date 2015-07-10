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
						strSql = "{call SP_TB_WT_USER_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";

						lrArgData.addColumn("COM_ID", 		CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NO", 		CITData.VARCHAR2);
						lrArgData.addColumn("EMP_ID", 		CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NAME", 	CITData.VARCHAR2);
						lrArgData.addColumn("PASSWORD", 	CITData.VARCHAR2);
						lrArgData.addColumn("REG_NUM", 		CITData.VARCHAR2);
						lrArgData.addColumn("SECT_CODE", 	CITData.VARCHAR2);
						lrArgData.addColumn("GRADE", 			CITData.VARCHAR2);
						lrArgData.addColumn("TEL_NO", 		CITData.VARCHAR2);
						lrArgData.addColumn("RES_NO", 		CITData.VARCHAR2);
						lrArgData.addColumn("RET_YN", 		CITData.VARCHAR2);
						lrArgData.addColumn("EMAIL", 			CITData.VARCHAR2);
						lrArgData.addColumn("MOBILE", 		CITData.VARCHAR2);
						lrArgData.addColumn("DIV_GROUP", 	CITData.VARCHAR2);
						lrArgData.addColumn("INSERT_EMP", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COM_ID", 			rows[i].getString(dsMAIN.indexOfColumn("COM_ID")));
						lrArgData.setValue("EMP_NO", 			rows[i].getString(dsMAIN.indexOfColumn("EMP_NO")));
						lrArgData.setValue("EMP_ID", 			rows[i].getString(dsMAIN.indexOfColumn("EMP_ID")));
						lrArgData.setValue("EMP_NAME", 		rows[i].getString(dsMAIN.indexOfColumn("EMP_NAME")));
						lrArgData.setValue("PASSWORD", 		rows[i].getString(dsMAIN.indexOfColumn("PASSWORD")));
						lrArgData.setValue("REG_NUM", 		rows[i].getString(dsMAIN.indexOfColumn("REG_NUM")));
						lrArgData.setValue("SECT_CODE", 	rows[i].getString(dsMAIN.indexOfColumn("SECT_CODE")));
						lrArgData.setValue("GRADE", 			rows[i].getString(dsMAIN.indexOfColumn("GRADE")));
						lrArgData.setValue("TEL_NO", 			rows[i].getString(dsMAIN.indexOfColumn("TEL_NO")));
						lrArgData.setValue("RES_NO", 			rows[i].getString(dsMAIN.indexOfColumn("RES_NO")));						
						lrArgData.setValue("RET_YN", 			rows[i].getString(dsMAIN.indexOfColumn("RET_YN")));
						lrArgData.setValue("EMAIL", 			rows[i].getString(dsMAIN.indexOfColumn("EMAIL")));
						lrArgData.setValue("MOBILE", 			rows[i].getString(dsMAIN.indexOfColumn("MOBILE")));
						lrArgData.setValue("DIV_GROUP", 	rows[i].getString(dsMAIN.indexOfColumn("DIV_GROUP")));
						lrArgData.setValue("INSERT_EMP", 	strUserNo);
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_TB_WT_USER_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COM_ID", 		CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NO", 		CITData.VARCHAR2);
						lrArgData.addColumn("EMP_ID", 		CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NAME", 	CITData.VARCHAR2);
						lrArgData.addColumn("PASSWORD", 	CITData.VARCHAR2);
						lrArgData.addColumn("REG_NUM", 		CITData.VARCHAR2);
						lrArgData.addColumn("SECT_CODE", 	CITData.VARCHAR2);
						lrArgData.addColumn("GRADE", 			CITData.VARCHAR2);
						lrArgData.addColumn("TEL_NO", 		CITData.VARCHAR2);
						lrArgData.addColumn("RES_NO", 		CITData.VARCHAR2);
						lrArgData.addColumn("RET_YN", 		CITData.VARCHAR2);
						lrArgData.addColumn("EMAIL", 			CITData.VARCHAR2);
						lrArgData.addColumn("MOBILE", 		CITData.VARCHAR2);
						lrArgData.addColumn("DIV_GROUP", 	CITData.VARCHAR2);
						lrArgData.addColumn("UPDATE_EMP", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COM_ID", 			rows[i].getString(dsMAIN.indexOfColumn("COM_ID")));
						lrArgData.setValue("EMP_NO", 			rows[i].getString(dsMAIN.indexOfColumn("EMP_NO")));
						lrArgData.setValue("EMP_ID", 			rows[i].getString(dsMAIN.indexOfColumn("EMP_ID")));
						lrArgData.setValue("EMP_NAME", 		rows[i].getString(dsMAIN.indexOfColumn("EMP_NAME")));
						lrArgData.setValue("PASSWORD", 		rows[i].getString(dsMAIN.indexOfColumn("PASSWORD")));
						lrArgData.setValue("REG_NUM", 		rows[i].getString(dsMAIN.indexOfColumn("REG_NUM")));
						lrArgData.setValue("SECT_CODE", 	rows[i].getString(dsMAIN.indexOfColumn("SECT_CODE")));
						lrArgData.setValue("GRADE", 			rows[i].getString(dsMAIN.indexOfColumn("GRADE")));
						lrArgData.setValue("TEL_NO", 			rows[i].getString(dsMAIN.indexOfColumn("TEL_NO")));
						lrArgData.setValue("RES_NO", 			rows[i].getString(dsMAIN.indexOfColumn("RES_NO")));						
						lrArgData.setValue("RET_YN", 			rows[i].getString(dsMAIN.indexOfColumn("RET_YN")));
						lrArgData.setValue("EMAIL", 			rows[i].getString(dsMAIN.indexOfColumn("EMAIL")));
						lrArgData.setValue("MOBILE", 			rows[i].getString(dsMAIN.indexOfColumn("MOBILE")));
						lrArgData.setValue("DIV_GROUP", 	rows[i].getString(dsMAIN.indexOfColumn("DIV_GROUP")));
						lrArgData.setValue("UPDATE_EMP", 	strUserNo);
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_TB_WT_USER_D(?,?)}";
						
						lrArgData.addColumn("COM_ID", 	CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NO", 	CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COM_ID", 		rows[i].getString(dsMAIN.indexOfColumn("COM_ID")));
						lrArgData.setValue("EMP_NO", 		rows[i].getString(dsMAIN.indexOfColumn("EMP_NO")));
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

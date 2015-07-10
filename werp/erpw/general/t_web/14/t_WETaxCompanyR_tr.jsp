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
						strSql = "{call SP_TB_WT_PLANT_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
			
						lrArgData.addColumn("COM_ID", 		CITData.VARCHAR2);
						lrArgData.addColumn("REG_NUM", 		CITData.VARCHAR2);
						lrArgData.addColumn("SAUP_CODE", 	CITData.VARCHAR2);
						lrArgData.addColumn("COMPANY", 		CITData.VARCHAR2);
						lrArgData.addColumn("EMPLOYER", 	CITData.VARCHAR2);
						lrArgData.addColumn("ZIP_CODE", 	CITData.VARCHAR2);
						lrArgData.addColumn("ADDRESS", 		CITData.VARCHAR2);
						lrArgData.addColumn("BIZ_COND", 	CITData.VARCHAR2);
						lrArgData.addColumn("BIZ_ITEM", 	CITData.VARCHAR2);
						lrArgData.addColumn("TEL_NO", 		CITData.VARCHAR2);
						lrArgData.addColumn("FAX_NO", 		CITData.VARCHAR2);
						lrArgData.addColumn("TAXPUB_CLASS", CITData.VARCHAR2);
						lrArgData.addColumn("TAX_TYPE", 		CITData.VARCHAR2);
						lrArgData.addColumn("DEAL_CLASS", 	CITData.VARCHAR2);
						lrArgData.addColumn("WEBTAX21_ID", 	CITData.VARCHAR2);
						lrArgData.addColumn("INSERT_EMP", 	CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COM_ID", 			rows[i].getString(dsMAIN.indexOfColumn("COM_ID")));
						lrArgData.setValue("REG_NUM", 		rows[i].getString(dsMAIN.indexOfColumn("REG_NUM")));
						lrArgData.setValue("SAUP_CODE", 	rows[i].getString(dsMAIN.indexOfColumn("SAUP_CODE")));
						lrArgData.setValue("COMPANY", 		rows[i].getString(dsMAIN.indexOfColumn("COMPANY")));
						lrArgData.setValue("EMPLOYER", 		rows[i].getString(dsMAIN.indexOfColumn("EMPLOYER")));
						lrArgData.setValue("ZIP_CODE", 		rows[i].getString(dsMAIN.indexOfColumn("ZIP_CODE")));
						lrArgData.setValue("ADDRESS", 		rows[i].getString(dsMAIN.indexOfColumn("ADDRESS")));
						lrArgData.setValue("BIZ_COND", 		rows[i].getString(dsMAIN.indexOfColumn("BIZ_COND")));
						lrArgData.setValue("BIZ_ITEM", 		rows[i].getString(dsMAIN.indexOfColumn("BIZ_ITEM")));
						lrArgData.setValue("TEL_NO", 			rows[i].getString(dsMAIN.indexOfColumn("TEL_NO")));
						lrArgData.setValue("FAX_NO", 			rows[i].getString(dsMAIN.indexOfColumn("FAX_NO")));
						lrArgData.setValue("TAXPUB_CLASS",rows[i].getString(dsMAIN.indexOfColumn("TAXPUB_CLASS")));
						lrArgData.setValue("TAX_TYPE", 		rows[i].getString(dsMAIN.indexOfColumn("TAX_TYPE")));
						lrArgData.setValue("DEAL_CLASS", 	rows[i].getString(dsMAIN.indexOfColumn("DEAL_CLASS")));
						lrArgData.setValue("WEBTAX21_ID", rows[i].getString(dsMAIN.indexOfColumn("WEBTAX21_ID")));
						lrArgData.setValue("INSERT_EMP", 	strUserNo);
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_TB_WT_PLANT_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COM_ID", 		CITData.VARCHAR2);
						lrArgData.addColumn("REG_NUM", 		CITData.VARCHAR2);
						lrArgData.addColumn("SAUP_CODE", 	CITData.VARCHAR2);
						lrArgData.addColumn("COMPANY", 		CITData.VARCHAR2);
						lrArgData.addColumn("EMPLOYER", 	CITData.VARCHAR2);
						lrArgData.addColumn("ZIP_CODE", 	CITData.VARCHAR2);
						lrArgData.addColumn("ADDRESS", 		CITData.VARCHAR2);
						lrArgData.addColumn("BIZ_COND", 	CITData.VARCHAR2);
						lrArgData.addColumn("BIZ_ITEM", 	CITData.VARCHAR2);
						lrArgData.addColumn("TEL_NO", 		CITData.VARCHAR2);
						lrArgData.addColumn("FAX_NO", 		CITData.VARCHAR2);
						lrArgData.addColumn("TAXPUB_CLASS", CITData.VARCHAR2);
						lrArgData.addColumn("TAX_TYPE", 		CITData.VARCHAR2);
						lrArgData.addColumn("DEAL_CLASS", 	CITData.VARCHAR2);
						lrArgData.addColumn("WEBTAX21_ID", 	CITData.VARCHAR2);
						lrArgData.addColumn("UPDATE_EMP", 	CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COM_ID", 			rows[i].getString(dsMAIN.indexOfColumn("COM_ID")));
						lrArgData.setValue("REG_NUM", 		rows[i].getString(dsMAIN.indexOfColumn("REG_NUM")));
						lrArgData.setValue("SAUP_CODE", 	rows[i].getString(dsMAIN.indexOfColumn("SAUP_CODE")));
						lrArgData.setValue("COMPANY", 		rows[i].getString(dsMAIN.indexOfColumn("COMPANY")));
						lrArgData.setValue("EMPLOYER", 		rows[i].getString(dsMAIN.indexOfColumn("EMPLOYER")));
						lrArgData.setValue("ZIP_CODE", 		rows[i].getString(dsMAIN.indexOfColumn("ZIP_CODE")));
						lrArgData.setValue("ADDRESS", 		rows[i].getString(dsMAIN.indexOfColumn("ADDRESS")));
						lrArgData.setValue("BIZ_COND", 		rows[i].getString(dsMAIN.indexOfColumn("BIZ_COND")));
						lrArgData.setValue("BIZ_ITEM", 		rows[i].getString(dsMAIN.indexOfColumn("BIZ_ITEM")));
						lrArgData.setValue("TEL_NO", 			rows[i].getString(dsMAIN.indexOfColumn("TEL_NO")));
						lrArgData.setValue("FAX_NO", 			rows[i].getString(dsMAIN.indexOfColumn("FAX_NO")));
						lrArgData.setValue("TAXPUB_CLASS",rows[i].getString(dsMAIN.indexOfColumn("TAXPUB_CLASS")));
						lrArgData.setValue("TAX_TYPE", 		rows[i].getString(dsMAIN.indexOfColumn("TAX_TYPE")));
						lrArgData.setValue("DEAL_CLASS", 	rows[i].getString(dsMAIN.indexOfColumn("DEAL_CLASS")));
						lrArgData.setValue("WEBTAX21_ID", rows[i].getString(dsMAIN.indexOfColumn("WEBTAX21_ID")));
						lrArgData.setValue("UPDATE_EMP", 	strUserNo);
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_TB_WT_PLANT_D(?,?)}";
						
						lrArgData.addColumn("COM_ID", 		CITData.VARCHAR2);
						lrArgData.addColumn("REG_NUM", 		CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COM_ID", 			rows[i].getString(dsMAIN.indexOfColumn("COM_ID")));
						lrArgData.setValue("REG_NUM", 		rows[i].getString(dsMAIN.indexOfColumn("REG_NUM")));
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
				GauceInfo.response.writeException("USER", "900001", "TB_WT_PLANT 테이블 데이타 갱신 에러" + ex.getMessage());
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

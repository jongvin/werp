<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-18)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsBATCH = null;
	GauceDataSet dsSEND = null;
	
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
		
		if(!CITCommon.isNull(strAct) && strAct.equals("BATCH"))
		{
			dsBATCH = GauceInfo.request.getGauceDataSet("dsBATCH");
			rows = dsBATCH.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_FB_GET_MAIL_DATA(?,?,?,?)}";
					
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("PAY_DUE_YMD", CITData.VARCHAR2);
					lrArgData.addColumn("VAT_REGISTRATION_NUM", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsBATCH.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("PAY_DUE_YMD", rows[i].getString(dsBATCH.indexOfColumn("PAY_DUE_YMD")));
					lrArgData.setValue("VAT_REGISTRATION_NUM", rows[i].getString(dsBATCH.indexOfColumn("VAT_REGISTRATION_NUM")));
					lrArgData.setValue("CRTUSERNO", strUserNo);
					
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
		if(!CITCommon.isNull(strAct) && strAct.equals("SEND"))
		{
			dsSEND = GauceInfo.request.getGauceDataSet("dsSEND");
			rows = dsSEND.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_FB_SEND_MAIL(?)}";
					
					lrArgData.addColumn("MAIL_SEQ", CITData.NUMBER);

					lrArgData.addRow();
					lrArgData.setValue("MAIL_SEQ", rows[i].getString(dsSEND.indexOfColumn("MAIL_SEQ")));
					
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
		else if (CITCommon.isNull(strAct))
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
						strSql = "{call SP_T_FB_PAYDUE_MAIL_MASTER_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("MAIL_SEQ", CITData.NUMBER);
						lrArgData.addColumn("PAY_DUE_YMD", CITData.VARCHAR2);
						lrArgData.addColumn("VAT_REGISTRATION_NUM", CITData.VARCHAR2);
						lrArgData.addColumn("VENDOR_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("MAIL_SEND_DATE", CITData.VARCHAR2);
						lrArgData.addColumn("MAIL_SEND_YN", CITData.VARCHAR2);
						lrArgData.addColumn("MAIL_SEND_RESULT_MSG", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CREATION_DATE", CITData.VARCHAR2);
						lrArgData.addColumn("CREATION_EMP_NO", CITData.VARCHAR2);
						lrArgData.addColumn("LAST_MODIFY_DATE", CITData.VARCHAR2);
						lrArgData.addColumn("LAST_MODIFY_EMP_NO", CITData.VARCHAR2);
						lrArgData.addColumn("ATTRIBUTE1", CITData.VARCHAR2);
						lrArgData.addColumn("ATTRIBUTE2", CITData.VARCHAR2);
						lrArgData.addColumn("ATTRIBUTE3", CITData.VARCHAR2);
						lrArgData.addColumn("TR_MANAGER_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("TR_MANAGER_EMAIL", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("MAIL_SEQ", rows[i].getString(dsMAIN.indexOfColumn("MAIL_SEQ")));
						lrArgData.setValue("PAY_DUE_YMD", rows[i].getString(dsMAIN.indexOfColumn("PAY_DUE_YMD")));
						lrArgData.setValue("VAT_REGISTRATION_NUM", rows[i].getString(dsMAIN.indexOfColumn("VAT_REGISTRATION_NUM")));
						lrArgData.setValue("VENDOR_NAME", rows[i].getString(dsMAIN.indexOfColumn("VENDOR_NAME")));
						lrArgData.setValue("MAIL_SEND_DATE", rows[i].getString(dsMAIN.indexOfColumn("MAIL_SEND_DATE")));
						lrArgData.setValue("MAIL_SEND_YN", rows[i].getString(dsMAIN.indexOfColumn("MAIL_SEND_YN")));
						lrArgData.setValue("MAIL_SEND_RESULT_MSG", rows[i].getString(dsMAIN.indexOfColumn("MAIL_SEND_RESULT_MSG")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CREATION_DATE", rows[i].getString(dsMAIN.indexOfColumn("CREATION_DATE")));
						lrArgData.setValue("CREATION_EMP_NO", rows[i].getString(dsMAIN.indexOfColumn("CREATION_EMP_NO")));
						lrArgData.setValue("LAST_MODIFY_DATE", rows[i].getString(dsMAIN.indexOfColumn("LAST_MODIFY_DATE")));
						lrArgData.setValue("LAST_MODIFY_EMP_NO", rows[i].getString(dsMAIN.indexOfColumn("LAST_MODIFY_EMP_NO")));
						lrArgData.setValue("ATTRIBUTE1", rows[i].getString(dsMAIN.indexOfColumn("ATTRIBUTE1")));
						lrArgData.setValue("ATTRIBUTE2", rows[i].getString(dsMAIN.indexOfColumn("ATTRIBUTE2")));
						lrArgData.setValue("ATTRIBUTE3", rows[i].getString(dsMAIN.indexOfColumn("ATTRIBUTE3")));
						lrArgData.setValue("TR_MANAGER_NAME", rows[i].getString(dsMAIN.indexOfColumn("TR_MANAGER_NAME")));
						lrArgData.setValue("TR_MANAGER_EMAIL", rows[i].getString(dsMAIN.indexOfColumn("TR_MANAGER_EMAIL")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FB_PAYDUE_MAIL_MASTER_U(?,?,?)}";
						
						lrArgData.addColumn("MAIL_SEQ", CITData.NUMBER);
						lrArgData.addColumn("TR_MANAGER_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("TR_MANAGER_EMAIL", CITData.VARCHAR2);
						lrArgData.addRow();
						lrArgData.setValue("MAIL_SEQ", rows[i].getString(dsMAIN.indexOfColumn("MAIL_SEQ")));
						lrArgData.setValue("TR_MANAGER_NAME", rows[i].getString(dsMAIN.indexOfColumn("TR_MANAGER_NAME")));
						lrArgData.setValue("TR_MANAGER_EMAIL", rows[i].getString(dsMAIN.indexOfColumn("TR_MANAGER_EMAIL")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FB_PAYDUE_MAIL_MASTER_D(?)}";
						
						lrArgData.addColumn("MAIL_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("MAIL_SEQ", rows[i].getString(dsMAIN.indexOfColumn("MAIL_SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FB_PAYDUE_MAIL_MASTER 테이블 데이타 갱신 에러" + ex.getMessage());
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

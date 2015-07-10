<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-23)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsMAIN_D = null;
	
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
			dsMAIN_D = GauceInfo.request.getGauceDataSet("dsMAIN_D");
			
			if (dsMAIN == null) throw new Exception("dsMAIN이(가) 널(Null)입니다.");
			if (dsMAIN_D == null) throw new Exception("dsMAIN_D이(가) 널(Null)입니다.");
			
			rows = dsMAIN.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_BUDG_CODE_I(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("P_BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("LEVEL_SEQ", CITData.NUMBER);
						lrArgData.addColumn("LEGACY_BUDG_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_CODE_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("USE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CONTROL_LEVEL_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_ITEM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MAKE_DEPT", CITData.VARCHAR2);
						lrArgData.addColumn("ASSIGN_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsMAIN.indexOfColumn("BUDG_CODE_NO")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("P_BUDG_CODE_NO", rows[i].getString(dsMAIN.indexOfColumn("P_BUDG_CODE_NO")));
						lrArgData.setValue("LEVEL_SEQ", rows[i].getString(dsMAIN.indexOfColumn("LEVEL_SEQ")));
						lrArgData.setValue("LEGACY_BUDG_CODE", rows[i].getString(dsMAIN.indexOfColumn("LEGACY_BUDG_CODE")));
						lrArgData.setValue("BUDG_CODE_NAME", rows[i].getString(dsMAIN.indexOfColumn("BUDG_CODE_NAME")));
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("USE_CLS", rows[i].getString(dsMAIN.indexOfColumn("USE_CLS")));
						lrArgData.setValue("CONTROL_LEVEL_TAG", rows[i].getString(dsMAIN.indexOfColumn("CONTROL_LEVEL_TAG")));
						lrArgData.setValue("BUDG_ITEM_CODE", rows[i].getString(dsMAIN.indexOfColumn("BUDG_ITEM_CODE")));
						lrArgData.setValue("MAKE_DEPT", rows[i].getString(dsMAIN.indexOfColumn("MAKE_DEPT")));
						lrArgData.setValue("ASSIGN_TAG", rows[i].getString(dsMAIN.indexOfColumn("ASSIGN_TAG")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_BUDG_CODE_U(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("P_BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("LEVEL_SEQ", CITData.NUMBER);
						lrArgData.addColumn("LEGACY_BUDG_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_CODE_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("USE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CONTROL_LEVEL_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_ITEM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MAKE_DEPT", CITData.VARCHAR2);
						lrArgData.addColumn("ASSIGN_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsMAIN.indexOfColumn("BUDG_CODE_NO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("P_BUDG_CODE_NO", rows[i].getString(dsMAIN.indexOfColumn("P_BUDG_CODE_NO")));
						lrArgData.setValue("LEVEL_SEQ", rows[i].getString(dsMAIN.indexOfColumn("LEVEL_SEQ")));
						lrArgData.setValue("LEGACY_BUDG_CODE", rows[i].getString(dsMAIN.indexOfColumn("LEGACY_BUDG_CODE")));
						lrArgData.setValue("BUDG_CODE_NAME", rows[i].getString(dsMAIN.indexOfColumn("BUDG_CODE_NAME")));
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("USE_CLS", rows[i].getString(dsMAIN.indexOfColumn("USE_CLS")));
						lrArgData.setValue("CONTROL_LEVEL_TAG", rows[i].getString(dsMAIN.indexOfColumn("CONTROL_LEVEL_TAG")));
						lrArgData.setValue("BUDG_ITEM_CODE", rows[i].getString(dsMAIN.indexOfColumn("BUDG_ITEM_CODE")));
						lrArgData.setValue("MAKE_DEPT", rows[i].getString(dsMAIN.indexOfColumn("MAKE_DEPT")));
						lrArgData.setValue("ASSIGN_TAG", rows[i].getString(dsMAIN.indexOfColumn("ASSIGN_TAG")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_BUDG_CODE_D(?)}";
						
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsMAIN.indexOfColumn("BUDG_CODE_NO")));
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
				GauceInfo.response.writeException("USER", "900001", "T_BUDG_CODE 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
			rows = dsMAIN_D.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_BUDG_CODE_D(?)}";
						
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsMAIN_D.indexOfColumn("BUDG_CODE_NO")));
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
				GauceInfo.response.writeException("USER", "900001", "T_BUDG_CODE 테이블 데이타 갱신 에러" + ex.getMessage());
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

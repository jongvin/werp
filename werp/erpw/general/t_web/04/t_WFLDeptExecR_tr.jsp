<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsCOPY = null;
	GauceDataSet dsREMOVE = null;
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	int		iCount = 0;
	Connection conn = null;
	
	String		strCOMP_CODE = "";
	String		strCLSE_ACC_ID = "";
	String		strDEPT_CODE = "";
	String		strWORK_YM = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* 세션정보 */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		conn = CITConnectionManager.getConnection(false);
		
		strAct = GauceInfo.request.getParameter("ACT");
		if(!CITCommon.isNull(strAct) && strAct.equals("COPY"))
		{
			dsCOPY = GauceInfo.request.getGauceDataSet("dsCOPY");
			rows = dsCOPY.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_FL_GET_EXEC_CONS_INFO(?,?,?,?,?)}";
					
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("WORK_YM", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsCOPY.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsCOPY.indexOfColumn("CLSE_ACC_ID")));
					lrArgData.setValue("DEPT_CODE", rows[i].getString(dsCOPY.indexOfColumn("DEPT_CODE")));
					lrArgData.setValue("WORK_YM", rows[i].getString(dsCOPY.indexOfColumn("WORK_YM")));
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
		else if(!CITCommon.isNull(strAct) && strAct.equals("REMOVE"))
		{
			dsREMOVE = GauceInfo.request.getGauceDataSet("dsREMOVE");
			rows = dsREMOVE.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_FL_REMOVE_EXEC(?,?,?,?)}";
					
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("WORK_YM", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsREMOVE.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsREMOVE.indexOfColumn("CLSE_ACC_ID")));
					lrArgData.setValue("DEPT_CODE", rows[i].getString(dsREMOVE.indexOfColumn("DEPT_CODE")));
					lrArgData.setValue("WORK_YM", rows[i].getString(dsREMOVE.indexOfColumn("WORK_YM")));
					
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
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						iCount ++;
						strCOMP_CODE = rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE"));
						strCLSE_ACC_ID = rows[i].getString(dsMAIN.indexOfColumn("CLSE_ACC_ID"));
						strDEPT_CODE = rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE"));
						strWORK_YM = rows[i].getString(dsMAIN.indexOfColumn("WORK_YM"));


						strSql = "{call SP_T_FL_MONTH_EXEC_IU(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_YM", CITData.NUMBER);
						lrArgData.addColumn("FLOW_CODE", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("SUM_EXEC_AMT", CITData.NUMBER);
						lrArgData.addColumn("MOD_EXEC_AMT", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsMAIN.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("WORK_YM", rows[i].getString(dsMAIN.indexOfColumn("WORK_YM")));
						lrArgData.setValue("FLOW_CODE", rows[i].getString(dsMAIN.indexOfColumn("FLOW_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("SUM_EXEC_AMT", rows[i].getString(dsMAIN.indexOfColumn("SUM_EXEC_AMT")));
						lrArgData.setValue("MOD_EXEC_AMT", rows[i].getString(dsMAIN.indexOfColumn("MOD_EXEC_AMT")));
					}
					else
					{
						continue;
					}
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
				if(iCount > 0)
				{
					CITData lrArgData = new CITData();

					strSql = "{call SP_T_FL_MONTH_EXEC_SUM(?,?,?,?)}";
					
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("WORK_YM", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", strCOMP_CODE);
					lrArgData.setValue("CLSE_ACC_ID", strCLSE_ACC_ID);
					lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
					lrArgData.setValue("WORK_YM", strWORK_YM);

					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "SP_T_FL_MONTH_EXEC_SUM 테이블 데이타 갱신 에러" + ex.getMessage());
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

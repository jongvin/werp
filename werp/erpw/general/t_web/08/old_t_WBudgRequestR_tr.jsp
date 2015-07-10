<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-30)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsSUB01 = null;
	GauceDataSet dsCOPY = null;
	GauceDataSet dsDVD_MONTHS = null;
	
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
		if(!CITCommon.isNull(strAct) && strAct.equals("DVD"))
		{
			dsDVD_MONTHS = GauceInfo.request.getGauceDataSet("dsDVD_MONTHS");
			rows = dsDVD_MONTHS.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_BUDG_DVD_MONTHS(?,?,?,?,?)}";
					
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsDVD_MONTHS.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsDVD_MONTHS.indexOfColumn("CLSE_ACC_ID")));
					lrArgData.setValue("DEPT_CODE", rows[i].getString(dsDVD_MONTHS.indexOfColumn("DEPT_CODE")));
					lrArgData.setValue("CHG_SEQ", rows[i].getString(dsDVD_MONTHS.indexOfColumn("CHG_SEQ")));
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
		else if(!CITCommon.isNull(strAct) && strAct.equals("COPY"))
		{
			dsCOPY = GauceInfo.request.getGauceDataSet("dsCOPY");
			rows = dsCOPY.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_BUDG_COPY_PREV_YEAR(?,?,?,?)}";
					
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsCOPY.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsCOPY.indexOfColumn("CLSE_ACC_ID")));
					lrArgData.setValue("DEPT_CODE", rows[i].getString(dsCOPY.indexOfColumn("DEPT_CODE")));
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
		else if (CITCommon.isNull(strAct))
		{
			
			dsMAIN = GauceInfo.request.getGauceDataSet("dsMAIN");
			
			if (dsMAIN == null) throw new Exception("dsMAIN이(가) 널(Null)입니다.");
			
			dsSUB01 = GauceInfo.request.getGauceDataSet("dsSUB01");
			
			if (dsSUB01 == null) throw new Exception("dsSUB01이(가) 널(Null)입니다.");
			
			
			
			rows = dsMAIN.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_BUDG_DEPT_ITEM_H_I(?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("RESERVED_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("TARGET_DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_ADD_AMT", CITData.NUMBER);
						lrArgData.addColumn("BUDG_ITEM_REQ_AMT", CITData.NUMBER);
						lrArgData.addColumn("BUDG_ITEM_ASSIGN_AMT", CITData.NUMBER);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);


						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsMAIN.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CHG_SEQ", rows[i].getString(dsMAIN.indexOfColumn("CHG_SEQ")));
						lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsMAIN.indexOfColumn("BUDG_CODE_NO")));
						lrArgData.setValue("RESERVED_SEQ", rows[i].getString(dsMAIN.indexOfColumn("RESERVED_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("TARGET_DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("TARGET_DEPT_CODE")));
						lrArgData.setValue("BUDG_ADD_AMT", rows[i].getString(dsMAIN.indexOfColumn("BUDG_ADD_AMT")));
						lrArgData.setValue("BUDG_ITEM_REQ_AMT", rows[i].getString(dsMAIN.indexOfColumn("BUDG_ITEM_REQ_AMT")));
						lrArgData.setValue("BUDG_ITEM_ASSIGN_AMT", rows[i].getString(dsMAIN.indexOfColumn("BUDG_ITEM_ASSIGN_AMT")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsMAIN.indexOfColumn("REMARKS")));

					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_BUDG_DEPT_ITEM_H_U(?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("RESERVED_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("TARGET_DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_ADD_AMT", CITData.NUMBER);
						lrArgData.addColumn("BUDG_ITEM_REQ_AMT", CITData.NUMBER);
						lrArgData.addColumn("BUDG_ITEM_ASSIGN_AMT", CITData.NUMBER);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);


						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsMAIN.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CHG_SEQ", rows[i].getString(dsMAIN.indexOfColumn("CHG_SEQ")));
						lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsMAIN.indexOfColumn("BUDG_CODE_NO")));
						lrArgData.setValue("RESERVED_SEQ", rows[i].getString(dsMAIN.indexOfColumn("RESERVED_SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("TARGET_DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("TARGET_DEPT_CODE")));
						lrArgData.setValue("BUDG_ADD_AMT", rows[i].getString(dsMAIN.indexOfColumn("BUDG_ADD_AMT")));
						lrArgData.setValue("BUDG_ITEM_REQ_AMT", rows[i].getString(dsMAIN.indexOfColumn("BUDG_ITEM_REQ_AMT")));
						lrArgData.setValue("BUDG_ITEM_ASSIGN_AMT", rows[i].getString(dsMAIN.indexOfColumn("BUDG_ITEM_ASSIGN_AMT")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsMAIN.indexOfColumn("REMARKS")));

					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_BUDG_DEPT_ITEM_H_D(?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("RESERVED_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsMAIN.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CHG_SEQ", rows[i].getString(dsMAIN.indexOfColumn("CHG_SEQ")));
						lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsMAIN.indexOfColumn("BUDG_CODE_NO")));
						lrArgData.setValue("RESERVED_SEQ", rows[i].getString(dsMAIN.indexOfColumn("RESERVED_SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_BUDG_DEPT_ITEM_H 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
			rows = dsSUB01.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_BUDG_MONTH_AMT_H_I(?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("RESERVED_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_YM", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_MONTH_REQ_AMT", CITData.NUMBER);
						lrArgData.addColumn("BUDG_MONTH_ASSIGN_AMT", CITData.NUMBER);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsSUB01.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsSUB01.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CHG_SEQ", rows[i].getString(dsSUB01.indexOfColumn("CHG_SEQ")));
						lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsSUB01.indexOfColumn("BUDG_CODE_NO")));
						lrArgData.setValue("RESERVED_SEQ", rows[i].getString(dsSUB01.indexOfColumn("RESERVED_SEQ")));
						lrArgData.setValue("BUDG_YM", rows[i].getString(dsSUB01.indexOfColumn("BUDG_YM")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("BUDG_MONTH_REQ_AMT", rows[i].getString(dsSUB01.indexOfColumn("BUDG_MONTH_REQ_AMT")));
						lrArgData.setValue("BUDG_MONTH_ASSIGN_AMT", rows[i].getString(dsSUB01.indexOfColumn("BUDG_MONTH_ASSIGN_AMT")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsSUB01.indexOfColumn("REMARKS")));

					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_BUDG_MONTH_AMT_H_U(?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("RESERVED_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_YM", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_MONTH_REQ_AMT", CITData.NUMBER);
						lrArgData.addColumn("BUDG_MONTH_ASSIGN_AMT", CITData.NUMBER);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);


						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsSUB01.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsSUB01.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CHG_SEQ", rows[i].getString(dsSUB01.indexOfColumn("CHG_SEQ")));
						lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsSUB01.indexOfColumn("BUDG_CODE_NO")));
						lrArgData.setValue("RESERVED_SEQ", rows[i].getString(dsSUB01.indexOfColumn("RESERVED_SEQ")));
						lrArgData.setValue("BUDG_YM", rows[i].getString(dsSUB01.indexOfColumn("BUDG_YM")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("BUDG_MONTH_REQ_AMT", rows[i].getString(dsSUB01.indexOfColumn("BUDG_MONTH_REQ_AMT")));
						lrArgData.setValue("BUDG_MONTH_ASSIGN_AMT", rows[i].getString(dsSUB01.indexOfColumn("BUDG_MONTH_ASSIGN_AMT")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsSUB01.indexOfColumn("REMARKS")));
	
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_BUDG_MONTH_AMT_H_D(?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("RESERVED_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_YM", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsSUB01.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsSUB01.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CHG_SEQ", rows[i].getString(dsSUB01.indexOfColumn("CHG_SEQ")));
						lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsSUB01.indexOfColumn("BUDG_CODE_NO")));
						lrArgData.setValue("RESERVED_SEQ", rows[i].getString(dsSUB01.indexOfColumn("RESERVED_SEQ")));
						lrArgData.setValue("BUDG_YM", rows[i].getString(dsSUB01.indexOfColumn("BUDG_YM")));
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
				GauceInfo.response.writeException("USER", "900001", "T_BUDG_MONTH_AMT_H 테이블 데이타 갱신 에러" + ex.getMessage());
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

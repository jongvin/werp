<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-28)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsSUB01 = null;
	GauceDataSet dsSUB03 = null;
	GauceDataSet dsCOPY = null;
	GauceDataSet dsSET = null;
	
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
			dsSUB01 = GauceInfo.request.getGauceDataSet("dsSUB01");
			dsSUB03 = GauceInfo.request.getGauceDataSet("dsSUB03");
			
			if (dsMAIN == null) throw new Exception("dsMAIN이(가) 널(Null)입니다.");
			if (dsSUB01 == null) throw new Exception("dsSUB01이(가) 널(Null)입니다.");
			if (dsSUB03 == null) throw new Exception("dsSUB03이(가) 널(Null)입니다.");
			
			rows = dsMAIN.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_EMPNO_AUTH_I(?,?,?,?,?)}";
						
						lrArgData.addColumn("EMPNO", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_TRANS_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CHG_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("ALL_DEPT_CLS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("EMPNO", rows[i].getString(dsMAIN.indexOfColumn("EMPNO")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("SLIP_TRANS_CLS", rows[i].getString(dsMAIN.indexOfColumn("SLIP_TRANS_CLS")));
						lrArgData.setValue("DEPT_CHG_CLS", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CHG_CLS")));
						lrArgData.setValue("ALL_DEPT_CLS", rows[i].getString(dsMAIN.indexOfColumn("ALL_DEPT_CLS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_EMPNO_AUTH_U(?,?,?,?,?)}";
						
						lrArgData.addColumn("EMPNO", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_TRANS_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CHG_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("ALL_DEPT_CLS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("EMPNO", rows[i].getString(dsMAIN.indexOfColumn("EMPNO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("SLIP_TRANS_CLS", rows[i].getString(dsMAIN.indexOfColumn("SLIP_TRANS_CLS")));
						lrArgData.setValue("DEPT_CHG_CLS", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CHG_CLS")));
						lrArgData.setValue("ALL_DEPT_CLS", rows[i].getString(dsMAIN.indexOfColumn("ALL_DEPT_CLS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_EMPNO_AUTH_D(?)}";
						
						lrArgData.addColumn("EMPNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("EMPNO", rows[i].getString(dsMAIN.indexOfColumn("EMPNO")));
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
				GauceInfo.response.writeException("USER", "900001", "T_EMPNO_AUTH 테이블 데이타 갱신 에러" + ex.getMessage());
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
						strSql = "{call SP_T_EMPNO_AUTH_COMP_I(?,?,?)}";
						
						lrArgData.addColumn("EMPNO", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("EMPNO", rows[i].getString(dsSUB01.indexOfColumn("EMPNO")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_EMPNO_AUTH_COMP_U(?,?,?)}";
						
						lrArgData.addColumn("EMPNO", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("EMPNO", rows[i].getString(dsSUB01.indexOfColumn("EMPNO")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_EMPNO_AUTH_COMP_D(?,?)}";
						
						lrArgData.addColumn("EMPNO", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("EMPNO", rows[i].getString(dsSUB01.indexOfColumn("EMPNO")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_EMPNO_AUTH 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
			rows = dsSUB03.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_EMPNO_AUTH_DEPT_I(?,?,?,?)}";
						
						lrArgData.addColumn("EMPNO", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("EMPNO", rows[i].getString(dsSUB03.indexOfColumn("EMPNO")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB03.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsSUB03.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_EMPNO_AUTH_DEPT_U(?,?,?,?)}";
						
						lrArgData.addColumn("EMPNO", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("EMPNO", rows[i].getString(dsSUB03.indexOfColumn("EMPNO")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB03.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsSUB03.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_EMPNO_AUTH_DEPT_D(?,?,?)}";
						
						lrArgData.addColumn("EMPNO", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("EMPNO", rows[i].getString(dsSUB03.indexOfColumn("EMPNO")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB03.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsSUB03.indexOfColumn("DEPT_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_EMPNO_AUTH 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		else if(strAct.equals("COPY"))
		{
			dsCOPY = GauceInfo.request.getGauceDataSet("dsCOPY");
			
			if (dsCOPY == null) throw new Exception("dsCOPY이(가) 널(Null)입니다.");
			
			rows = dsCOPY.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_COPY_EMP_AUTH(?,?,?)}";
					
					lrArgData.addColumn("EMPNO_SRC", CITData.VARCHAR2);
					lrArgData.addColumn("EMPNO_DST", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("EMPNO_SRC", rows[i].getString(dsCOPY.indexOfColumn("EMPNO_SRC")));
					lrArgData.setValue("EMPNO_DST", rows[i].getString(dsCOPY.indexOfColumn("EMPNO_DST")));
					lrArgData.setValue("CRTUSERNO", strUserNo);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "SP_T_COPY_EMP_AUTH 복사 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		else if(strAct.equals("SET"))
		{
			dsSET = GauceInfo.request.getGauceDataSet("dsSET");
			
			if (dsSET == null) throw new Exception("dsSET이(가) 널(Null)입니다.");
			
			rows = dsSET.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_SET_EMP_AUTH(?,?,?)}";
					
					lrArgData.addColumn("EMPNO", CITData.VARCHAR2);
					lrArgData.addColumn("OPTIONS", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("EMPNO", rows[i].getString(dsSET.indexOfColumn("EMPNO")));
					lrArgData.setValue("OPTIONS", rows[i].getString(dsSET.indexOfColumn("OPTIONS")));
					lrArgData.setValue("CRTUSERNO", strUserNo);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "SP_T_SET_EMP_AUTH 복사 갱신 에러" + ex.getMessage());
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

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
	GauceDataSet dsSUB01 = null;
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	Connection conn = null;
	int		iCnt = 0;
	
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
					++iCnt;
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_FL_FLOW_CODE_I(?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("FLOW_CODE", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("P_NO", CITData.NUMBER);
						lrArgData.addColumn("FLOW_ITEM_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("FLOW_ITEM_KIND", CITData.VARCHAR2);
						lrArgData.addColumn("LEVEL_SEQ", CITData.NUMBER);
						lrArgData.addColumn("IS_LEAF_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_PLN_FUNC_NO", CITData.NUMBER);
						lrArgData.addColumn("DEPT_EXE_FUNC_NO", CITData.NUMBER);
						lrArgData.addColumn("DEPT_FOR_FUNC_NO", CITData.NUMBER);
						lrArgData.addColumn("MNG_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("FLOW_CODE", rows[i].getString(dsMAIN.indexOfColumn("FLOW_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("P_NO", rows[i].getString(dsMAIN.indexOfColumn("P_NO")));
						lrArgData.setValue("FLOW_ITEM_NAME", rows[i].getString(dsMAIN.indexOfColumn("FLOW_ITEM_NAME")));
						lrArgData.setValue("FLOW_ITEM_KIND", rows[i].getString(dsMAIN.indexOfColumn("FLOW_ITEM_KIND")));
						lrArgData.setValue("LEVEL_SEQ", rows[i].getString(dsMAIN.indexOfColumn("LEVEL_SEQ")));
						lrArgData.setValue("IS_LEAF_TAG", rows[i].getString(dsMAIN.indexOfColumn("IS_LEAF_TAG")));
						lrArgData.setValue("DEPT_PLN_FUNC_NO", rows[i].getString(dsMAIN.indexOfColumn("DEPT_PLN_FUNC_NO")));
						lrArgData.setValue("DEPT_EXE_FUNC_NO", rows[i].getString(dsMAIN.indexOfColumn("DEPT_EXE_FUNC_NO")));
						lrArgData.setValue("DEPT_FOR_FUNC_NO", rows[i].getString(dsMAIN.indexOfColumn("DEPT_FOR_FUNC_NO")));
						lrArgData.setValue("MNG_CODE", rows[i].getString(dsMAIN.indexOfColumn("MNG_CODE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FL_FLOW_CODE_U(?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("FLOW_CODE", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("P_NO", CITData.NUMBER);
						lrArgData.addColumn("FLOW_ITEM_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("FLOW_ITEM_KIND", CITData.VARCHAR2);
						lrArgData.addColumn("LEVEL_SEQ", CITData.NUMBER);
						lrArgData.addColumn("IS_LEAF_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_PLN_FUNC_NO", CITData.NUMBER);
						lrArgData.addColumn("DEPT_EXE_FUNC_NO", CITData.NUMBER);
						lrArgData.addColumn("DEPT_FOR_FUNC_NO", CITData.NUMBER);
						lrArgData.addColumn("MNG_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("FLOW_CODE", rows[i].getString(dsMAIN.indexOfColumn("FLOW_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("P_NO", rows[i].getString(dsMAIN.indexOfColumn("P_NO")));
						lrArgData.setValue("FLOW_ITEM_NAME", rows[i].getString(dsMAIN.indexOfColumn("FLOW_ITEM_NAME")));
						lrArgData.setValue("FLOW_ITEM_KIND", rows[i].getString(dsMAIN.indexOfColumn("FLOW_ITEM_KIND")));
						lrArgData.setValue("LEVEL_SEQ", rows[i].getString(dsMAIN.indexOfColumn("LEVEL_SEQ")));
						lrArgData.setValue("IS_LEAF_TAG", rows[i].getString(dsMAIN.indexOfColumn("IS_LEAF_TAG")));
						lrArgData.setValue("DEPT_PLN_FUNC_NO", rows[i].getString(dsMAIN.indexOfColumn("DEPT_PLN_FUNC_NO")));
						lrArgData.setValue("DEPT_EXE_FUNC_NO", rows[i].getString(dsMAIN.indexOfColumn("DEPT_EXE_FUNC_NO")));
						lrArgData.setValue("DEPT_FOR_FUNC_NO", rows[i].getString(dsMAIN.indexOfColumn("DEPT_FOR_FUNC_NO")));
						lrArgData.setValue("MNG_CODE", rows[i].getString(dsMAIN.indexOfColumn("MNG_CODE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FL_FLOW_CODE_D(?)}";
						
						lrArgData.addColumn("FLOW_CODE", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("FLOW_CODE", rows[i].getString(dsMAIN.indexOfColumn("FLOW_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FL_FLOW_CODE 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
			rows = dsMAIN_D.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					++iCnt;
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_FL_FLOW_CODE_D(?)}";
						
						lrArgData.addColumn("FLOW_CODE", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("FLOW_CODE", rows[i].getString(dsMAIN_D.indexOfColumn("FLOW_CODE")));
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
			dsSUB01 = GauceInfo.request.getGauceDataSet("dsSUB01");
			
			if (dsSUB01 == null) throw new Exception("dsSUB01이(가) 널(Null)입니다.");
			
			rows = dsSUB01.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_FL_FLOW_ACC_CODE_I(?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("FLOW_CODE", CITData.NUMBER);
						lrArgData.addColumn("APPLY_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("SIGN_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_SUM_MTHD_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);
						lrArgData.addColumn("SUM_MTHD_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("SETOFF_ACC_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("FLOW_CODE", rows[i].getString(dsSUB01.indexOfColumn("FLOW_CODE")));
						lrArgData.setValue("APPLY_SEQ", rows[i].getString(dsSUB01.indexOfColumn("APPLY_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("SIGN_TAG", rows[i].getString(dsSUB01.indexOfColumn("SIGN_TAG")));
						lrArgData.setValue("SLIP_SUM_MTHD_TAG", rows[i].getString(dsSUB01.indexOfColumn("SLIP_SUM_MTHD_TAG")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsSUB01.indexOfColumn("REMARKS")));
						lrArgData.setValue("SUM_MTHD_TAG", rows[i].getString(dsSUB01.indexOfColumn("SUM_MTHD_TAG")));
						lrArgData.setValue("SETOFF_ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("SETOFF_ACC_CODE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FL_FLOW_ACC_CODE_U(?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("FLOW_CODE", CITData.NUMBER);
						lrArgData.addColumn("APPLY_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("SIGN_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_SUM_MTHD_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);
						lrArgData.addColumn("SUM_MTHD_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("SETOFF_ACC_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("FLOW_CODE", rows[i].getString(dsSUB01.indexOfColumn("FLOW_CODE")));
						lrArgData.setValue("APPLY_SEQ", rows[i].getString(dsSUB01.indexOfColumn("APPLY_SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("SIGN_TAG", rows[i].getString(dsSUB01.indexOfColumn("SIGN_TAG")));
						lrArgData.setValue("SLIP_SUM_MTHD_TAG", rows[i].getString(dsSUB01.indexOfColumn("SLIP_SUM_MTHD_TAG")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsSUB01.indexOfColumn("REMARKS")));
						lrArgData.setValue("SUM_MTHD_TAG", rows[i].getString(dsSUB01.indexOfColumn("SUM_MTHD_TAG")));
						lrArgData.setValue("SETOFF_ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("SETOFF_ACC_CODE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FL_FLOW_ACC_CODE_D(?,?)}";
						
						lrArgData.addColumn("FLOW_CODE", CITData.NUMBER);
						lrArgData.addColumn("APPLY_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("FLOW_CODE", rows[i].getString(dsSUB01.indexOfColumn("FLOW_CODE")));
						lrArgData.setValue("APPLY_SEQ", rows[i].getString(dsSUB01.indexOfColumn("APPLY_SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FL_FLOW_ACC_CODE 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		if(iCnt > 0)
		{
			try
			{
				CITData lrArgData = new CITData();
				strSql = "{call SP_T_SET_FLOW_CODE_LEAF()}";
				
				CITDatabase.executeProcedure(strSql, lrArgData, conn);
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

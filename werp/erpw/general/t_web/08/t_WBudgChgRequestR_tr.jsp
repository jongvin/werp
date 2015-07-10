<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*,java.math.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2005-12-18)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/


	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsSUB01 = null;
	GauceDataSet dsSUB02= null;
	
	GauceDataSet dsCHANGE_CANCEL = null;
	GauceDataSet dsREQUEST_FINISH = null;
	GauceDataSet dsREQUEST_FINISH_CANCEL = null;
	GauceDataSet dsCONFIRM = null;
	GauceDataSet dsCONFIRM_ALL = null;
	GauceDataSet dsDEPT_ALL = null;
	GauceDataSet dsBUDG_ITEM_ALL = null;
	
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
		if(!CITCommon.isNull(strAct) && strAct.equals("CONFIRM"))
		{
			dsCONFIRM = GauceInfo.request.getGauceDataSet("dsCONFIRM");
			rows = dsCONFIRM.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_BUDG_DEPT_CONFIRM(?,?,?,?,?,?)}";
					
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
					lrArgData.addColumn("CONFIRM_TAG", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsCONFIRM.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsCONFIRM.indexOfColumn("CLSE_ACC_ID")));
					lrArgData.setValue("DEPT_CODE", rows[i].getString(dsCONFIRM.indexOfColumn("DEPT_CODE")));
					lrArgData.setValue("CHG_SEQ", rows[i].getString(dsCONFIRM.indexOfColumn("CHG_SEQ")));
					lrArgData.setValue("CONFIRM_TAG", rows[i].getString(dsCONFIRM.indexOfColumn("CONFIRM_TAG")));
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
		else if(!CITCommon.isNull(strAct) && strAct.equals("CONFIRM_ALL"))
		{
			dsCONFIRM_ALL = GauceInfo.request.getGauceDataSet("dsCONFIRM_ALL");
			rows = dsCONFIRM_ALL.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_BUDG_DEPT_CONFIRM_ALL(?,?,?,?,?)}";
					
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
					lrArgData.addColumn("CONFIRM_TAG", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsCONFIRM_ALL.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsCONFIRM_ALL.indexOfColumn("CLSE_ACC_ID")));
					lrArgData.setValue("CHG_SEQ", rows[i].getString(dsCONFIRM_ALL.indexOfColumn("CHG_SEQ")));
					lrArgData.setValue("CONFIRM_TAG", rows[i].getString(dsCONFIRM_ALL.indexOfColumn("CONFIRM_TAG")));
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
		else if(!CITCommon.isNull(strAct) && strAct.equals("DEPT_ALL"))
		{
			dsDEPT_ALL = GauceInfo.request.getGauceDataSet("dsDEPT_ALL");
			rows = dsDEPT_ALL.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_BUDG_DEPT_ITEM_PARENT_ALL(?,?,?,?)}";
					
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsDEPT_ALL.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsDEPT_ALL.indexOfColumn("CLSE_ACC_ID")));
					lrArgData.setValue("CHG_SEQ", rows[i].getString(dsDEPT_ALL.indexOfColumn("CHG_SEQ")));
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
		else if(!CITCommon.isNull(strAct) && strAct.equals("BUDG_ITEM_ALL"))
		{
			dsBUDG_ITEM_ALL = GauceInfo.request.getGauceDataSet("dsBUDG_ITEM_ALL");
			rows = dsBUDG_ITEM_ALL.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_BUDG_DEPT_ITEM_H_ALL(?,?,?,?,?,?)}";
					
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
					lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("MAKE_DEPT", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsBUDG_ITEM_ALL.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsBUDG_ITEM_ALL.indexOfColumn("CLSE_ACC_ID")));
					lrArgData.setValue("CHG_SEQ", rows[i].getString(dsBUDG_ITEM_ALL.indexOfColumn("CHG_SEQ")));
					lrArgData.setValue("DEPT_CODE", rows[i].getString(dsBUDG_ITEM_ALL.indexOfColumn("DEPT_CODE")));
					lrArgData.setValue("MAKE_DEPT", rows[i].getString(dsBUDG_ITEM_ALL.indexOfColumn("MAKE_DEPT")));
					lrArgData.setValue("CRTUSERNO", strUserNo);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "부서별 예산항목일괄 등록 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		else if(!CITCommon.isNull(strAct) && strAct.equals("CHANGE_CANCEL"))
		{
			dsCHANGE_CANCEL = GauceInfo.request.getGauceDataSet("dsCHANGE_CANCEL");
			rows = dsCHANGE_CANCEL.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_BUDG_DEPT_H_D(?,?,?,?)}";
						
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsCHANGE_CANCEL.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsCHANGE_CANCEL.indexOfColumn("CLSE_ACC_ID")));
					lrArgData.setValue("DEPT_CODE", rows[i].getString(dsCHANGE_CANCEL.indexOfColumn("DEPT_CODE")));
					lrArgData.setValue("CHG_SEQ", rows[i].getString(dsCHANGE_CANCEL.indexOfColumn("CHG_SEQ")));
					
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
		else if(!CITCommon.isNull(strAct) && strAct.equals("REQUEST_FINISH"))
		{
			dsREQUEST_FINISH = GauceInfo.request.getGauceDataSet("dsREQUEST_FINISH");
			rows = dsREQUEST_FINISH.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_BUDG_DEPT_REQUEST_FINISH(?,?,?,?,?)}";
						
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
					lrArgData.addColumn("REQUEST_TAG", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsREQUEST_FINISH.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsREQUEST_FINISH.indexOfColumn("CLSE_ACC_ID")));
					lrArgData.setValue("DEPT_CODE", rows[i].getString(dsREQUEST_FINISH.indexOfColumn("DEPT_CODE")));
					lrArgData.setValue("CHG_SEQ", rows[i].getString(dsREQUEST_FINISH.indexOfColumn("CHG_SEQ")));
					lrArgData.setValue("REQUEST_TAG", rows[i].getString(dsREQUEST_FINISH.indexOfColumn("REQUEST_TAG")));
					
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
		else if(!CITCommon.isNull(strAct) && strAct.equals("REQUEST_FINISH_CANCEL"))
		{
			dsREQUEST_FINISH_CANCEL = GauceInfo.request.getGauceDataSet("dsREQUEST_FINISH_CANCEL");
			rows = dsREQUEST_FINISH_CANCEL.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_BUDG_DEPT_REQUEST_FINISH(?,?,?,?,?)}";
						
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
					lrArgData.addColumn("REQUEST_TAG", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsREQUEST_FINISH_CANCEL.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsREQUEST_FINISH_CANCEL.indexOfColumn("CLSE_ACC_ID")));
					lrArgData.setValue("DEPT_CODE", rows[i].getString(dsREQUEST_FINISH_CANCEL.indexOfColumn("DEPT_CODE")));
					lrArgData.setValue("CHG_SEQ", rows[i].getString(dsREQUEST_FINISH_CANCEL.indexOfColumn("CHG_SEQ")));
					lrArgData.setValue("REQUEST_TAG", rows[i].getString(dsREQUEST_FINISH_CANCEL.indexOfColumn("REQUEST_TAG")));
					
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
			
			dsSUB02 = GauceInfo.request.getGauceDataSet("dsSUB02");
			
			if (dsSUB02 == null) throw new Exception("dsSUB02이(가) 널(Null)입니다.");

			rows = dsMAIN.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_BUDG_DEPT_H_I(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CONFIRM_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_APPLY_YM2", CITData.VARCHAR2);
						lrArgData.addColumn("REQUEST_TAG", CITData.VARCHAR2); 

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsMAIN.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CHG_SEQ", rows[i].getString(dsMAIN.indexOfColumn("CHG_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("CONFIRM_TAG", rows[i].getString(dsMAIN.indexOfColumn("CONFIRM_TAG")));
						lrArgData.setValue("BUDG_APPLY_YM2", rows[i].getString(dsMAIN.indexOfColumn("BUDG_APPLY_YM2")));
						lrArgData.setValue("REQUEST_TAG", rows[i].getString(dsMAIN.indexOfColumn("REQUEST_TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_BUDG_DEPT_H_U(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CONFIRM_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_APPLY_YM2", CITData.VARCHAR2);
						lrArgData.addColumn("REQUEST_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsMAIN.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CHG_SEQ", rows[i].getString(dsMAIN.indexOfColumn("CHG_SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("CONFIRM_TAG", rows[i].getString(dsMAIN.indexOfColumn("CONFIRM_TAG")));
						lrArgData.setValue("BUDG_APPLY_YM2", rows[i].getString(dsMAIN.indexOfColumn("BUDG_APPLY_YM2")));
						lrArgData.setValue("REQUEST_TAG", rows[i].getString(dsMAIN.indexOfColumn("REQUEST_TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_BUDG_DEPT_H_D(?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsMAIN.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CHG_SEQ", rows[i].getString(dsMAIN.indexOfColumn("CHG_SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_BUDG_DEPT_H 테이블 데이타 갱신 에러" + ex.getMessage());
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
						strSql = "{call SP_T_BUDG_MONTH_REQ_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("RESERVED_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_YM", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("REASON_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_MONTH_REQ_AMT", CITData.NUMBER);
						lrArgData.addColumn("CHG_AMT", CITData.NUMBER);
						lrArgData.addColumn("BUDG_MONTH_ASSIGN_AMT", CITData.NUMBER);
						lrArgData.addColumn("CONFIRM_KIND", CITData.VARCHAR2);
						lrArgData.addColumn("TAG", CITData.VARCHAR2);
						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsSUB01.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsSUB01.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CHG_SEQ", rows[i].getString(dsSUB01.indexOfColumn("CHG_SEQ")));
						lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsSUB01.indexOfColumn("BUDG_CODE_NO")));
						lrArgData.setValue("RESERVED_SEQ", rows[i].getString(dsSUB01.indexOfColumn("RESERVED_SEQ")));
						lrArgData.setValue("BUDG_YM", rows[i].getString(dsSUB01.indexOfColumn("BUDG_YM")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB01.indexOfColumn("SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("REASON_CODE", rows[i].getString(dsSUB01.indexOfColumn("REASON_CODE")));
						lrArgData.setValue("BUDG_MONTH_REQ_AMT", rows[i].getString(dsSUB01.indexOfColumn("BUDG_MONTH_REQ_AMT")));
						lrArgData.setValue("CHG_AMT", rows[i].getString(dsSUB01.indexOfColumn("CHG_AMT")));
						lrArgData.setValue("BUDG_MONTH_ASSIGN_AMT", rows[i].getString(dsSUB01.indexOfColumn("BUDG_MONTH_ASSIGN_AMT")));
						lrArgData.setValue("CONFIRM_KIND", rows[i].getString(dsSUB01.indexOfColumn("CONFIRM_KIND")));
						lrArgData.setValue("TAG", rows[i].getString(dsSUB01.indexOfColumn("TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_BUDG_MONTH_REQ_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("RESERVED_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_YM", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("REASON_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_MONTH_REQ_AMT", CITData.NUMBER);
						lrArgData.addColumn("CHG_AMT", CITData.NUMBER);
						lrArgData.addColumn("BUDG_MONTH_ASSIGN_AMT", CITData.NUMBER);
						lrArgData.addColumn("CONFIRM_KIND", CITData.VARCHAR2);
						lrArgData.addColumn("TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsSUB01.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsSUB01.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CHG_SEQ", rows[i].getString(dsSUB01.indexOfColumn("CHG_SEQ")));
						lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsSUB01.indexOfColumn("BUDG_CODE_NO")));
						lrArgData.setValue("RESERVED_SEQ", rows[i].getString(dsSUB01.indexOfColumn("RESERVED_SEQ")));
						lrArgData.setValue("BUDG_YM", rows[i].getString(dsSUB01.indexOfColumn("BUDG_YM")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB01.indexOfColumn("SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("REASON_CODE", rows[i].getString(dsSUB01.indexOfColumn("REASON_CODE")));
						lrArgData.setValue("BUDG_MONTH_REQ_AMT", rows[i].getString(dsSUB01.indexOfColumn("BUDG_MONTH_REQ_AMT")));
						lrArgData.setValue("CHG_AMT", rows[i].getString(dsSUB01.indexOfColumn("CHG_AMT")));
						lrArgData.setValue("BUDG_MONTH_ASSIGN_AMT", rows[i].getString(dsSUB01.indexOfColumn("BUDG_MONTH_ASSIGN_AMT")));
						lrArgData.setValue("CONFIRM_KIND", rows[i].getString(dsSUB01.indexOfColumn("CONFIRM_KIND")));
						lrArgData.setValue("TAG", rows[i].getString(dsSUB01.indexOfColumn("TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_BUDG_MONTH_REQ_D(?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("RESERVED_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_YM", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("TAG", CITData.VARCHAR2);
						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsSUB01.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsSUB01.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CHG_SEQ", rows[i].getString(dsSUB01.indexOfColumn("CHG_SEQ")));
						lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsSUB01.indexOfColumn("BUDG_CODE_NO")));
						lrArgData.setValue("RESERVED_SEQ", rows[i].getString(dsSUB01.indexOfColumn("RESERVED_SEQ")));
						lrArgData.setValue("BUDG_YM", rows[i].getString(dsSUB01.indexOfColumn("BUDG_YM")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB01.indexOfColumn("SEQ")));
						lrArgData.setValue("TAG", rows[i].getString(dsSUB01.indexOfColumn("TAG")));
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
				GauceInfo.response.writeException("USER", "900001", "T_BUDG_MONTH_REQ 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		
			rows = dsSUB02.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_BUDG_MONTH_REQ_DETAIL_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("RESERVED_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_YM", CITData.VARCHAR2);
						lrArgData.addColumn("REASON_NO", CITData.NUMBER);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_AMT", CITData.NUMBER);
						lrArgData.addColumn("R_COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("R_CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("R_DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("R_CHG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("R_BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("R_RESERVED_SEQ", CITData.NUMBER);
						lrArgData.addColumn("R_BUDG_YM", CITData.VARCHAR2);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);
						lrArgData.addColumn("TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB02.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsSUB02.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsSUB02.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CHG_SEQ", rows[i].getString(dsSUB02.indexOfColumn("CHG_SEQ")));
						lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsSUB02.indexOfColumn("BUDG_CODE_NO")));
						lrArgData.setValue("RESERVED_SEQ", rows[i].getString(dsSUB02.indexOfColumn("RESERVED_SEQ")));
						lrArgData.setValue("BUDG_YM", rows[i].getString(dsSUB02.indexOfColumn("BUDG_YM")));
						lrArgData.setValue("REASON_NO", rows[i].getString(dsSUB02.indexOfColumn("REASON_NO")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB02.indexOfColumn("SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("CHG_AMT", rows[i].getString(dsSUB02.indexOfColumn("CHG_AMT")));
						lrArgData.setValue("R_COMP_CODE", rows[i].getString(dsSUB02.indexOfColumn("R_COMP_CODE")));
						lrArgData.setValue("R_CLSE_ACC_ID", rows[i].getString(dsSUB02.indexOfColumn("R_CLSE_ACC_ID")));
						lrArgData.setValue("R_DEPT_CODE", rows[i].getString(dsSUB02.indexOfColumn("R_DEPT_CODE")));
						lrArgData.setValue("R_CHG_SEQ", rows[i].getString(dsSUB02.indexOfColumn("R_CHG_SEQ")));
						lrArgData.setValue("R_BUDG_CODE_NO", rows[i].getString(dsSUB02.indexOfColumn("R_BUDG_CODE_NO")));
						lrArgData.setValue("R_RESERVED_SEQ", rows[i].getString(dsSUB02.indexOfColumn("R_RESERVED_SEQ")));
						lrArgData.setValue("R_BUDG_YM", rows[i].getString(dsSUB02.indexOfColumn("R_BUDG_YM")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsSUB02.indexOfColumn("REMARKS")));
						lrArgData.setValue("TAG", rows[i].getString(dsSUB02.indexOfColumn("TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_BUDG_MONTH_REQ_DETAIL_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("RESERVED_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_YM", CITData.VARCHAR2);
						lrArgData.addColumn("REASON_NO", CITData.NUMBER);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_AMT", CITData.NUMBER);
						lrArgData.addColumn("R_COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("R_CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("R_DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("R_CHG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("R_BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("R_RESERVED_SEQ", CITData.NUMBER);
						lrArgData.addColumn("R_BUDG_YM", CITData.VARCHAR2);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);
						lrArgData.addColumn("TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB02.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsSUB02.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsSUB02.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CHG_SEQ", rows[i].getString(dsSUB02.indexOfColumn("CHG_SEQ")));
						lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsSUB02.indexOfColumn("BUDG_CODE_NO")));
						lrArgData.setValue("RESERVED_SEQ", rows[i].getString(dsSUB02.indexOfColumn("RESERVED_SEQ")));
						lrArgData.setValue("BUDG_YM", rows[i].getString(dsSUB02.indexOfColumn("BUDG_YM")));
						lrArgData.setValue("REASON_NO", rows[i].getString(dsSUB02.indexOfColumn("REASON_NO")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB02.indexOfColumn("SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("CHG_AMT", rows[i].getString(dsSUB02.indexOfColumn("CHG_AMT")));
						lrArgData.setValue("R_COMP_CODE", rows[i].getString(dsSUB02.indexOfColumn("R_COMP_CODE")));
						lrArgData.setValue("R_CLSE_ACC_ID", rows[i].getString(dsSUB02.indexOfColumn("R_CLSE_ACC_ID")));
						lrArgData.setValue("R_DEPT_CODE", rows[i].getString(dsSUB02.indexOfColumn("R_DEPT_CODE")));
						lrArgData.setValue("R_CHG_SEQ", rows[i].getString(dsSUB02.indexOfColumn("R_CHG_SEQ")));
						lrArgData.setValue("R_BUDG_CODE_NO", rows[i].getString(dsSUB02.indexOfColumn("R_BUDG_CODE_NO")));
						lrArgData.setValue("R_RESERVED_SEQ", rows[i].getString(dsSUB02.indexOfColumn("R_RESERVED_SEQ")));
						lrArgData.setValue("R_BUDG_YM", rows[i].getString(dsSUB02.indexOfColumn("R_BUDG_YM")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsSUB02.indexOfColumn("REMARKS")));
						lrArgData.setValue("TAG", rows[i].getString(dsSUB02.indexOfColumn("TAG")));
						
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_BUDG_MONTH_REQ_DETAIL_D(?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("RESERVED_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_YM", CITData.VARCHAR2);
						lrArgData.addColumn("REASON_NO", CITData.NUMBER);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("TAG", CITData.VARCHAR2);


						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB02.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsSUB02.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsSUB02.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CHG_SEQ", rows[i].getString(dsSUB02.indexOfColumn("CHG_SEQ")));
						lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsSUB02.indexOfColumn("BUDG_CODE_NO")));
						lrArgData.setValue("RESERVED_SEQ", rows[i].getString(dsSUB02.indexOfColumn("RESERVED_SEQ")));
						lrArgData.setValue("BUDG_YM", rows[i].getString(dsSUB02.indexOfColumn("BUDG_YM")));
						lrArgData.setValue("REASON_NO", rows[i].getString(dsSUB02.indexOfColumn("REASON_NO")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB02.indexOfColumn("SEQ")));
						lrArgData.setValue("TAG", rows[i].getString(dsSUB02.indexOfColumn("TAG")));
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
				GauceInfo.response.writeException("USER", "900001", "T_BUDG_MONTH_REQ 테이블 데이타 갱신 에러" + ex.getMessage());
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

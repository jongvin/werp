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
	
	GauceDataSet dsCONFIRM_KIND_ALL = null;
	GauceDataSet dsCONFIRM_KIND = null;
	GauceDataSet dsCONFIRM_TAG = null;
	GauceDataSet dsCONFIRM_TAG_ALL = null;

	
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
		
		if(!CITCommon.isNull(strAct) && strAct.equals("CONFIRM_KIND_ALL"))
		{
			dsCONFIRM_KIND_ALL = GauceInfo.request.getGauceDataSet("dsCONFIRM_KIND_ALL");
			rows = dsCONFIRM_KIND_ALL.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_BUDG_MON_REQ_CONF_KIND_A(?,?,?,?,?)}";
						
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
					lrArgData.addColumn("CONFIRM_KIND", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsCONFIRM_KIND_ALL.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsCONFIRM_KIND_ALL.indexOfColumn("CLSE_ACC_ID")));
					lrArgData.setValue("DEPT_CODE", rows[i].getString(dsCONFIRM_KIND_ALL.indexOfColumn("DEPT_CODE")));
					lrArgData.setValue("CHG_SEQ", rows[i].getString(dsCONFIRM_KIND_ALL.indexOfColumn("CHG_SEQ")));
					lrArgData.setValue("CONFIRM_KIND", rows[i].getString(dsCONFIRM_KIND_ALL.indexOfColumn("CONFIRM_KIND")));
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "SP_T_BUDG_MON_REQ_CONF_KIND_A 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		else if(!CITCommon.isNull(strAct) && strAct.equals("CONFIRM_KIND"))
		{
			dsCONFIRM_KIND = GauceInfo.request.getGauceDataSet("dsCONFIRM_KIND");
			rows = dsCONFIRM_KIND.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_BUDG_MONTH_REQ_CONF_KIND(?,?,?,?,?,?,?,?)}";
						
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
					lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
					lrArgData.addColumn("RESERVED_SEQ", CITData.NUMBER);
					lrArgData.addColumn("BUDG_YM", CITData.VARCHAR2);
					lrArgData.addColumn("CONFIRM_KIND", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsCONFIRM_KIND.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsCONFIRM_KIND.indexOfColumn("CLSE_ACC_ID")));
					lrArgData.setValue("DEPT_CODE", rows[i].getString(dsCONFIRM_KIND.indexOfColumn("DEPT_CODE")));
					lrArgData.setValue("CHG_SEQ", rows[i].getString(dsCONFIRM_KIND.indexOfColumn("CHG_SEQ")));
					lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsCONFIRM_KIND.indexOfColumn("BUDG_CODE_NO")));
					lrArgData.setValue("RESERVED_SEQ", rows[i].getString(dsCONFIRM_KIND.indexOfColumn("RESERVED_SEQ")));
					lrArgData.setValue("BUDG_YM", rows[i].getString(dsCONFIRM_KIND.indexOfColumn("BUDG_YM")));
					lrArgData.setValue("CONFIRM_KIND", rows[i].getString(dsCONFIRM_KIND.indexOfColumn("CONFIRM_KIND")));
					
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
		else if(!CITCommon.isNull(strAct) && strAct.equals("CONFIRM_TAG"))
		{
			dsCONFIRM_TAG = GauceInfo.request.getGauceDataSet("dsCONFIRM_TAG");
			rows = dsCONFIRM_TAG.getDataRows();
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
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsCONFIRM_TAG.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsCONFIRM_TAG.indexOfColumn("CLSE_ACC_ID")));
					lrArgData.setValue("DEPT_CODE", rows[i].getString(dsCONFIRM_TAG.indexOfColumn("DEPT_CODE")));
					lrArgData.setValue("CHG_SEQ", rows[i].getString(dsCONFIRM_TAG.indexOfColumn("CHG_SEQ")));
					lrArgData.setValue("CONFIRM_TAG", rows[i].getString(dsCONFIRM_TAG.indexOfColumn("CONFIRM_TAG")));
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
		else if(!CITCommon.isNull(strAct) && strAct.equals("CONFIRM_TAG_ALL"))
		{
			dsCONFIRM_TAG_ALL = GauceInfo.request.getGauceDataSet("dsCONFIRM_TAG_ALL");
			rows = dsCONFIRM_TAG_ALL.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_BUDG_DEPT_CHG_CONFIRM_ALL(?,?,?,?)}";
						
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					lrArgData.addColumn("CONFIRM_TAG", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
					
					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsCONFIRM_TAG_ALL.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsCONFIRM_TAG_ALL.indexOfColumn("CLSE_ACC_ID")));
					lrArgData.setValue("CONFIRM_TAG", rows[i].getString(dsCONFIRM_TAG_ALL.indexOfColumn("CONFIRM_TAG")));
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
						lrArgData.addColumn("BUDG_APPLY_YM", CITData.VARCHAR2);
						lrArgData.addColumn("REQUEST_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsMAIN.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CHG_SEQ", rows[i].getString(dsMAIN.indexOfColumn("CHG_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("CONFIRM_TAG", rows[i].getString(dsMAIN.indexOfColumn("CONFIRM_TAG")));
						lrArgData.setValue("BUDG_APPLY_YM", rows[i].getString(dsMAIN.indexOfColumn("BUDG_APPLY_YM")));
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
						lrArgData.addColumn("BUDG_APPLY_YM", CITData.VARCHAR2);
						lrArgData.addColumn("REQUEST_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsMAIN.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CHG_SEQ", rows[i].getString(dsMAIN.indexOfColumn("CHG_SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("CONFIRM_TAG", rows[i].getString(dsMAIN.indexOfColumn("CONFIRM_TAG")));
						lrArgData.setValue("BUDG_APPLY_YM", rows[i].getString(dsMAIN.indexOfColumn("BUDG_APPLY_YM")));
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
						strSql = "{call SP_T_BUDG_MONTH_REQ_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("RESERVED_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_YM", CITData.VARCHAR2);
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
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("REASON_CODE", rows[i].getString(dsSUB01.indexOfColumn("REASON_CODE")));
						lrArgData.setValue("BUDG_MONTH_REQ_AMT", rows[i].getString(dsSUB01.indexOfColumn("BUDG_MONTH_REQ_AMT")));
						lrArgData.setValue("CHG_AMT", rows[i].getString(dsSUB01.indexOfColumn("CHG_AMT")));
						lrArgData.setValue("BUDG_MONTH_ASSIGN_AMT", rows[i].getString(dsSUB01.indexOfColumn("BUDG_MONTH_ASSIGN_AMT")));
						lrArgData.setValue("CONFIRM_KIND", rows[i].getString(dsSUB01.indexOfColumn("CONFIRM_KIND")));
						lrArgData.setValue("TAG", "F");
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_BUDG_MONTH_REQ_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("RESERVED_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_YM", CITData.VARCHAR2);
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
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("REASON_CODE", rows[i].getString(dsSUB01.indexOfColumn("REASON_CODE")));
						lrArgData.setValue("BUDG_MONTH_REQ_AMT", rows[i].getString(dsSUB01.indexOfColumn("BUDG_MONTH_REQ_AMT")));
						lrArgData.setValue("CHG_AMT", rows[i].getString(dsSUB01.indexOfColumn("CHG_AMT")));
						lrArgData.setValue("BUDG_MONTH_ASSIGN_AMT", rows[i].getString(dsSUB01.indexOfColumn("BUDG_MONTH_ASSIGN_AMT")));
						lrArgData.setValue("CONFIRM_KIND", rows[i].getString(dsSUB01.indexOfColumn("CONFIRM_KIND")));
						lrArgData.setValue("TAG", "F");
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_BUDG_MONTH_REQ_D(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("RESERVED_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_YM", CITData.VARCHAR2);
						lrArgData.addColumn("TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsSUB01.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsSUB01.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CHG_SEQ", rows[i].getString(dsSUB01.indexOfColumn("CHG_SEQ")));
						lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsSUB01.indexOfColumn("BUDG_CODE_NO")));
						lrArgData.setValue("RESERVED_SEQ", rows[i].getString(dsSUB01.indexOfColumn("RESERVED_SEQ")));
						lrArgData.setValue("BUDG_YM", rows[i].getString(dsSUB01.indexOfColumn("BUDG_YM")));
						lrArgData.setValue("TAG", "F");
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
						strSql = "{call SP_T_BUDG_MONTH_REQ_DETAIL_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("RESERVED_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_YM", CITData.VARCHAR2);
						lrArgData.addColumn("REASON_NO", CITData.NUMBER);
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
						lrArgData.setValue("TAG", "F");
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_BUDG_MONTH_REQ_DETAIL_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("RESERVED_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_YM", CITData.VARCHAR2);
						lrArgData.addColumn("REASON_NO", CITData.NUMBER);
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
						lrArgData.setValue("TAG", "F");
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_BUDG_MONTH_REQ_DETAIL_D(?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("RESERVED_SEQ", CITData.NUMBER);
						lrArgData.addColumn("BUDG_YM", CITData.VARCHAR2);
						lrArgData.addColumn("REASON_NO", CITData.NUMBER);
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
						lrArgData.setValue("TAG", "F");
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

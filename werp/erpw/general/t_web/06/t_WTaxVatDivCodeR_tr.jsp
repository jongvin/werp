<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-18)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsSUB01 = null;

	
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
	//복사시작
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
						strSql = "{call SP_T_ACC_VAT_DIV_CODE_I(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("DIV_COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DIV_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("DIV_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("DIV_RATIO", CITData.NUMBER);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);
						lrArgData.addColumn("USE_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("MAIN_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("DIV_COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("DIV_COMP_CODE")));
						lrArgData.setValue("DIV_CODE", rows[i].getString(dsMAIN.indexOfColumn("DIV_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("DIV_NAME", rows[i].getString(dsMAIN.indexOfColumn("DIV_NAME")));
						lrArgData.setValue("DIV_RATIO", rows[i].getString(dsMAIN.indexOfColumn("DIV_RATIO")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsMAIN.indexOfColumn("REMARKS")));
						lrArgData.setValue("USE_TAG", rows[i].getString(dsMAIN.indexOfColumn("USE_TAG")));
						lrArgData.setValue("MAIN_TAG", rows[i].getString(dsMAIN.indexOfColumn("MAIN_TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_ACC_VAT_DIV_CODE_U(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("DIV_COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DIV_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("DIV_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("DIV_RATIO", CITData.NUMBER);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);
						lrArgData.addColumn("USE_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("MAIN_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("DIV_COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("DIV_COMP_CODE")));
						lrArgData.setValue("DIV_CODE", rows[i].getString(dsMAIN.indexOfColumn("DIV_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("DIV_NAME", rows[i].getString(dsMAIN.indexOfColumn("DIV_NAME")));
						lrArgData.setValue("DIV_RATIO", rows[i].getString(dsMAIN.indexOfColumn("DIV_RATIO")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsMAIN.indexOfColumn("REMARKS")));
						lrArgData.setValue("USE_TAG", rows[i].getString(dsMAIN.indexOfColumn("USE_TAG")));
						lrArgData.setValue("MAIN_TAG", rows[i].getString(dsMAIN.indexOfColumn("MAIN_TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_ACC_VAT_DIV_CODE_D(?,?)}";
						
						lrArgData.addColumn("DIV_COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DIV_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("DIV_COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("DIV_COMP_CODE")));
						lrArgData.setValue("DIV_CODE", rows[i].getString(dsMAIN.indexOfColumn("DIV_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_ACC_VAT_DIV_CODE 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//복사끝
	//여기에 붙여넣으세요
			
	//복사시작
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
						strSql = "{call SP_T_ACC_VAT_DIV_C_DEPT_I(?,?,?,?)}";
						
						lrArgData.addColumn("DIV_COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DIV_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DIV_DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("DIV_COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("DIV_COMP_CODE")));
						lrArgData.setValue("DIV_CODE", rows[i].getString(dsSUB01.indexOfColumn("DIV_CODE")));
						lrArgData.setValue("DIV_DEPT_CODE", rows[i].getString(dsSUB01.indexOfColumn("DIV_DEPT_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_ACC_VAT_DIV_C_DEPT_U(?,?,?,?)}";
						
						lrArgData.addColumn("DIV_COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DIV_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DIV_DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("DIV_COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("DIV_COMP_CODE")));
						lrArgData.setValue("DIV_CODE", rows[i].getString(dsSUB01.indexOfColumn("DIV_CODE")));
						lrArgData.setValue("DIV_DEPT_CODE", rows[i].getString(dsSUB01.indexOfColumn("DIV_DEPT_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_ACC_VAT_DIV_C_DEPT_D(?,?,?)}";
						
						lrArgData.addColumn("DIV_COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DIV_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DIV_DEPT_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("DIV_COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("DIV_COMP_CODE")));
						lrArgData.setValue("DIV_CODE", rows[i].getString(dsSUB01.indexOfColumn("DIV_CODE")));
						lrArgData.setValue("DIV_DEPT_CODE", rows[i].getString(dsSUB01.indexOfColumn("DIV_DEPT_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_ACC_VAT_DIV_C_DEPT 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//복사끝
	//여기에 붙여넣으세요

			
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

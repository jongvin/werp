<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-05)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsWORK_SLIP_IDSEQ = null;
	GauceDataSet dsMAKE_SLIP = null;
	
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
		
		if(strAct.equals("MAKE_DEFAULT"))
		{
			dsWORK_SLIP_IDSEQ = GauceInfo.request.getGauceDataSet("dsWORK_SLIP_IDSEQ");
			
			if (dsWORK_SLIP_IDSEQ == null) throw new Exception("dsWORK_SLIP_IDSEQ이(가) 널(Null)입니다.");
			
			rows = dsWORK_SLIP_IDSEQ.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_MAKE_DFLT_REFUND_SLIP(?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("WORK_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("WORK_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("WORK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_NO", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REFUND_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("WORK_SLIP_ID", rows[i].getString(dsWORK_SLIP_IDSEQ.indexOfColumn("WORK_SLIP_ID")));
						lrArgData.setValue("WORK_SLIP_IDSEQ", rows[i].getString(dsWORK_SLIP_IDSEQ.indexOfColumn("WORK_SLIP_IDSEQ")));
						lrArgData.setValue("WORK_CODE", rows[i].getString(dsWORK_SLIP_IDSEQ.indexOfColumn("WORK_CODE")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsWORK_SLIP_IDSEQ.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("LOAN_NO", rows[i].getString(dsWORK_SLIP_IDSEQ.indexOfColumn("LOAN_NO")));
						lrArgData.setValue("LOAN_REFUND_SEQ", rows[i].getString(dsWORK_SLIP_IDSEQ.indexOfColumn("LOAN_REFUND_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_LOAN_SHEET 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		if(strAct.equals("MAKE_SLIP"))
		{
			dsMAKE_SLIP = GauceInfo.request.getGauceDataSet("dsMAKE_SLIP");
			
			if (dsMAKE_SLIP == null) throw new Exception("dsMAKE_SLIP이(가) 널(Null)입니다.");
			
			rows = dsMAKE_SLIP.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_MAKE_REFUND_SLIP(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("WORK_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("WORK_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("WORK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_NO", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REFUND_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("WORK_SLIP_ID", rows[i].getString(dsMAKE_SLIP.indexOfColumn("WORK_SLIP_ID")));
						lrArgData.setValue("WORK_SLIP_IDSEQ", rows[i].getString(dsMAKE_SLIP.indexOfColumn("WORK_SLIP_IDSEQ")));
						lrArgData.setValue("WORK_CODE", rows[i].getString(dsMAKE_SLIP.indexOfColumn("WORK_CODE")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAKE_SLIP.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAKE_SLIP.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("LOAN_NO", rows[i].getString(dsMAKE_SLIP.indexOfColumn("LOAN_NO")));
						lrArgData.setValue("LOAN_REFUND_SEQ", rows[i].getString(dsMAKE_SLIP.indexOfColumn("LOAN_REFUND_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_LOAN_SHEET 테이블 데이타 갱신 에러" + ex.getMessage());
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

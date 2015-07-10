<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsMAKE_SLIP = null;
	GauceDataSet dsMAKE_SLIP_RET = null;
	
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
			
			if (dsMAIN == null) throw new Exception("dsMAIN이(가) 널(Null)입니다.");
			
			rows = dsMAIN.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_PAY_EXEC_LIST_N_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("EXEC_KIND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("TARGET_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("TARGET_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT", CITData.NUMBER);
						lrArgData.addColumn("OUT_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("IN_BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("IN_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_PUB_SEQ", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("CHK_BILL_NO", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_OWNER", CITData.VARCHAR2);
						lrArgData.addColumn("EXPR_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", "0");
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("EXEC_KIND_TAG", rows[i].getString(dsMAIN.indexOfColumn("EXEC_KIND_TAG")));
						lrArgData.setValue("TARGET_SLIP_ID", rows[i].getString(dsMAIN.indexOfColumn("TARGET_SLIP_ID")));
						lrArgData.setValue("TARGET_SLIP_IDSEQ", rows[i].getString(dsMAIN.indexOfColumn("TARGET_SLIP_IDSEQ")));
						lrArgData.setValue("EXEC_AMT", rows[i].getString(dsMAIN.indexOfColumn("EXEC_AMT")));
						lrArgData.setValue("OUT_ACC_NO", rows[i].getString(dsMAIN.indexOfColumn("OUT_ACC_NO")));
						lrArgData.setValue("IN_BANK_MAIN_CODE", rows[i].getString(dsMAIN.indexOfColumn("IN_BANK_MAIN_CODE")));
						lrArgData.setValue("IN_ACC_NO", rows[i].getString(dsMAIN.indexOfColumn("IN_ACC_NO")));
						lrArgData.setValue("SLIP_PUB_SEQ", "");
						lrArgData.setValue("SLIP_ID", "");
						lrArgData.setValue("SLIP_IDSEQ", "");
						lrArgData.setValue("CHK_BILL_NO", rows[i].getString(dsMAIN.indexOfColumn("CHK_BILL_NO")));
						lrArgData.setValue("ACCNO_OWNER", rows[i].getString(dsMAIN.indexOfColumn("ACCNO_OWNER")));
						lrArgData.setValue("EXPR_DT", rows[i].getString(dsMAIN.indexOfColumn("EXPR_DT")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_PAY_EXEC_LIST 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
			dsMAKE_SLIP = GauceInfo.request.getGauceDataSet("dsMAKE_SLIP");
			
			if (dsMAKE_SLIP == null) throw new Exception("dsMAKE_SLIP이(가) 널(Null)입니다.");
			
			rows = dsMAKE_SLIP.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_MAKE_PAY_SLIP(?,?,?,?,?,?,?,?,?,?,?)}";
						
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
					lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
					lrArgData.addColumn("SLIP_ID", CITData.NUMBER,true);
					lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER,true);
					lrArgData.addColumn("MAKE_SLIPNO", CITData.VARCHAR2,true);
					lrArgData.addColumn("MAKE_COMP_CODE", CITData.VARCHAR2,true);
					lrArgData.addColumn("MAKE_SEQ", CITData.NUMBER,true);
					lrArgData.addColumn("SLIP_KIND_TAG", CITData.VARCHAR2,true);
					lrArgData.addColumn("MAKE_DT_TRANS", CITData.VARCHAR2,true);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAKE_SLIP.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("WORK_DT", rows[i].getString(dsMAKE_SLIP.indexOfColumn("WORK_DT")));
					lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAKE_SLIP.indexOfColumn("DEPT_CODE")));
					lrArgData.setValue("CRTUSERNO", strUserNo);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
					CITDebug.PrintMessages(CITXml.CITData2XML_CR(lrArgData));
					dsMAKE_SLIP_RET = CITCommon.toGauceDataSet(lrArgData,"dsMAKE_SLIP_RET");
					GauceInfo.response.enableFirstRow(dsMAKE_SLIP_RET);
					dsMAKE_SLIP_RET.flush();
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "SP_T_MAKE_PAY_SLIP 테이블 데이타 갱신 에러" + ex.getMessage());
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

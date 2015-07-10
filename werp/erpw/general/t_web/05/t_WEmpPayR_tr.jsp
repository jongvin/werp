<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	//Dataset이 여러개이면 이부분을 복사에 붙이셔요(시작)
	GauceDataSet dsMAIN = null;
	GauceDataSet dsSUB01 = null;
	GauceDataSet dsREMOVE = null;
	//Dataset이 여러개이면 이부분을 복사에 붙이셔요(끝)
	//Dataset이 여러개이면 아래 나타나는 부분중 '//복사시작' 에서 '//복사끝' 까지를 기존 갱신 페이지의 '//여기에 붙여넣으세요' 자리에 붙여넣으세요
	
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
						strSql = "{call SP_T_FIN_EMP_PAY_MAIN_I(?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CONTENTS", CITData.VARCHAR2);
						lrArgData.addColumn("OUT_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("COST_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CHARGE_PERS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_DT")));
						lrArgData.setValue("WORK_SEQ", rows[i].getString(dsMAIN.indexOfColumn("WORK_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("CONTENTS", rows[i].getString(dsMAIN.indexOfColumn("CONTENTS")));
						lrArgData.setValue("OUT_ACC_NO", rows[i].getString(dsMAIN.indexOfColumn("OUT_ACC_NO")));
						lrArgData.setValue("COST_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("COST_ACC_CODE")));
						lrArgData.setValue("PAY_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("PAY_ACC_CODE")));
						lrArgData.setValue("CHARGE_PERS", rows[i].getString(dsMAIN.indexOfColumn("CHARGE_PERS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_EMP_PAY_MAIN_U(?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CONTENTS", CITData.VARCHAR2);
						lrArgData.addColumn("OUT_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("COST_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CHARGE_PERS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_DT")));
						lrArgData.setValue("WORK_SEQ", rows[i].getString(dsMAIN.indexOfColumn("WORK_SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("CONTENTS", rows[i].getString(dsMAIN.indexOfColumn("CONTENTS")));
						lrArgData.setValue("OUT_ACC_NO", rows[i].getString(dsMAIN.indexOfColumn("OUT_ACC_NO")));
						lrArgData.setValue("COST_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("COST_ACC_CODE")));
						lrArgData.setValue("PAY_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("PAY_ACC_CODE")));
						lrArgData.setValue("CHARGE_PERS", rows[i].getString(dsMAIN.indexOfColumn("CHARGE_PERS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_EMP_PAY_MAIN_D(?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_DT")));
						lrArgData.setValue("WORK_SEQ", rows[i].getString(dsMAIN.indexOfColumn("WORK_SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_EMP_PAY_MAIN 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//복사끝
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
						strSql = "{call SP_T_FIN_EMP_PAY_LIST_I(?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
						lrArgData.addColumn("EXEC_AMT", CITData.NUMBER);
						lrArgData.addColumn("IN_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("IN_BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_OWNER", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("WORK_SEQ", rows[i].getString(dsSUB01.indexOfColumn("WORK_SEQ")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsSUB01.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB01.indexOfColumn("SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("EMP_NO", rows[i].getString(dsSUB01.indexOfColumn("EMP_NO")));
						lrArgData.setValue("EXEC_AMT", rows[i].getString(dsSUB01.indexOfColumn("EXEC_AMT")));
						lrArgData.setValue("IN_ACC_NO", rows[i].getString(dsSUB01.indexOfColumn("IN_ACC_NO")));
						lrArgData.setValue("IN_BANK_MAIN_CODE", rows[i].getString(dsSUB01.indexOfColumn("IN_BANK_MAIN_CODE")));
						lrArgData.setValue("ACCNO_OWNER", rows[i].getString(dsSUB01.indexOfColumn("ACCNO_OWNER")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsSUB01.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsSUB01.indexOfColumn("SLIP_IDSEQ")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_EMP_PAY_LIST_U(?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
						lrArgData.addColumn("EXEC_AMT", CITData.NUMBER);
						lrArgData.addColumn("IN_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("IN_BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_OWNER", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("WORK_SEQ", rows[i].getString(dsSUB01.indexOfColumn("WORK_SEQ")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsSUB01.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB01.indexOfColumn("SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("EMP_NO", rows[i].getString(dsSUB01.indexOfColumn("EMP_NO")));
						lrArgData.setValue("EXEC_AMT", rows[i].getString(dsSUB01.indexOfColumn("EXEC_AMT")));
						lrArgData.setValue("IN_ACC_NO", rows[i].getString(dsSUB01.indexOfColumn("IN_ACC_NO")));
						lrArgData.setValue("IN_BANK_MAIN_CODE", rows[i].getString(dsSUB01.indexOfColumn("IN_BANK_MAIN_CODE")));
						lrArgData.setValue("ACCNO_OWNER", rows[i].getString(dsSUB01.indexOfColumn("ACCNO_OWNER")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsSUB01.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsSUB01.indexOfColumn("SLIP_IDSEQ")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_EMP_PAY_LIST_D(?,?,?,?)}";
						
						lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("WORK_SEQ", rows[i].getString(dsSUB01.indexOfColumn("WORK_SEQ")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsSUB01.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB01.indexOfColumn("SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_EMP_PAY_LIST 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//복사끝
	//여기에 붙여넣으세요
		}
		if(!CITCommon.isNull(strAct) && strAct.equals("REMOVE"))
		{
			dsREMOVE = GauceInfo.request.getGauceDataSet("dsREMOVE");
			
			if (dsREMOVE == null) throw new Exception("dsREMOVE이(가) 널(Null)입니다.");
			
			rows = dsREMOVE.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_FIN_REMOVE_EMP_PAY(?,?,?,?)}";
						
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
					lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsREMOVE.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("WORK_DT", rows[i].getString(dsREMOVE.indexOfColumn("WORK_DT")));
					lrArgData.setValue("WORK_SEQ", rows[i].getString(dsREMOVE.indexOfColumn("WORK_SEQ")));
					lrArgData.setValue("CRTUSERNO", strUserNo);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "전표삭제 테이블 데이타 갱신 에러" + ex.getMessage());
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

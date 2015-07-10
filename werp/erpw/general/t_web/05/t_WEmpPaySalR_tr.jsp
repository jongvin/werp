<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WEmpPaySalR.jsp(사원별급여지급내역현황)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 사원별지급내역현황조회
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-03)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	//Dataset이 여러개이면 이부분을 복사에 붙이셔요(시작)
	GauceDataSet dsMAIN = null;
	GauceDataSet dsSUM = null;
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
		
		if(!CITCommon.isNull(strAct) && strAct.equals("SUM"))
		{
			dsSUM = GauceInfo.request.getGauceDataSet("dsSUM");
			
			if (dsSUM == null) throw new Exception("dsSUM이(가) 널(Null)입니다.");
			
			rows = dsSUM.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_MAKE_PAY_SAL(?,?,?)}";
						
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUM.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("WORK_SEQ", rows[i].getString(dsSUM.indexOfColumn("WORK_SEQ")));
					lrArgData.setValue("CRTUSERNO", strUserNo);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "SP_T_MAKE_PAY_SAL 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
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
						strSql = "{call SP_T_FIN_PAY_SAL_I(?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_YM", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("PAYGBN", CITData.VARCHAR2);
						lrArgData.addColumn("CONTENTS", CITData.VARCHAR2);
						lrArgData.addColumn("IGNORE_COMP_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("ACCNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_SEQ", rows[i].getString(dsMAIN.indexOfColumn("WORK_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("WORK_YM", rows[i].getString(dsMAIN.indexOfColumn("WORK_YM")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_DT")));
						lrArgData.setValue("PAYGBN", rows[i].getString(dsMAIN.indexOfColumn("PAYGBN")));
						lrArgData.setValue("CONTENTS", rows[i].getString(dsMAIN.indexOfColumn("CONTENTS")));
						lrArgData.setValue("IGNORE_COMP_TAG", rows[i].getString(dsMAIN.indexOfColumn("IGNORE_COMP_TAG")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAIN.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsMAIN.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("ACCNO", rows[i].getString(dsMAIN.indexOfColumn("ACCNO")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_PAY_SAL_U(?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_YM", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("PAYGBN", CITData.VARCHAR2);
						lrArgData.addColumn("CONTENTS", CITData.VARCHAR2);
						lrArgData.addColumn("IGNORE_COMP_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("ACCNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_SEQ", rows[i].getString(dsMAIN.indexOfColumn("WORK_SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("WORK_YM", rows[i].getString(dsMAIN.indexOfColumn("WORK_YM")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_DT")));
						lrArgData.setValue("PAYGBN", rows[i].getString(dsMAIN.indexOfColumn("PAYGBN")));
						lrArgData.setValue("CONTENTS", rows[i].getString(dsMAIN.indexOfColumn("CONTENTS")));
						lrArgData.setValue("IGNORE_COMP_TAG", rows[i].getString(dsMAIN.indexOfColumn("IGNORE_COMP_TAG")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAIN.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsMAIN.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("ACCNO", rows[i].getString(dsMAIN.indexOfColumn("ACCNO")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_PAY_SAL_D(?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_PAY_SAL 테이블 데이타 갱신 에러" + ex.getMessage());
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
						strSql = "{call SP_T_FIN_PAY_SAL_LIST_I(?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
						lrArgData.addColumn("IN_OUT_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("SUDANGCD", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("SAFE_MNG_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("AMT", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_SEQ", rows[i].getString(dsSUB01.indexOfColumn("WORK_SEQ")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB01.indexOfColumn("SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("EMP_NO", rows[i].getString(dsSUB01.indexOfColumn("EMP_NO")));
						lrArgData.setValue("IN_OUT_TAG", rows[i].getString(dsSUB01.indexOfColumn("IN_OUT_TAG")));
						lrArgData.setValue("SUDANGCD", rows[i].getString(dsSUB01.indexOfColumn("SUDANGCD")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsSUB01.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("SAFE_MNG_TAG", rows[i].getString(dsSUB01.indexOfColumn("SAFE_MNG_TAG")));
						lrArgData.setValue("AMT", rows[i].getString(dsSUB01.indexOfColumn("AMT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_PAY_SAL_LIST_U(?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
						lrArgData.addColumn("IN_OUT_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("SUDANGCD", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("SAFE_MNG_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("AMT", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_SEQ", rows[i].getString(dsSUB01.indexOfColumn("WORK_SEQ")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB01.indexOfColumn("SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("EMP_NO", rows[i].getString(dsSUB01.indexOfColumn("EMP_NO")));
						lrArgData.setValue("IN_OUT_TAG", rows[i].getString(dsSUB01.indexOfColumn("IN_OUT_TAG")));
						lrArgData.setValue("SUDANGCD", rows[i].getString(dsSUB01.indexOfColumn("SUDANGCD")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsSUB01.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("SAFE_MNG_TAG", rows[i].getString(dsSUB01.indexOfColumn("SAFE_MNG_TAG")));
						lrArgData.setValue("AMT", rows[i].getString(dsSUB01.indexOfColumn("AMT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_PAY_SAL_LIST_D(?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_SEQ", CITData.NUMBER);
						lrArgData.addColumn("SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_SEQ", rows[i].getString(dsSUB01.indexOfColumn("WORK_SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_PAY_SAL_LIST 테이블 데이타 갱신 에러" + ex.getMessage());
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
					
					strSql = "{call SP_T_REMOVE_SAL_PAY(?,?,?,?)}";
						
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

<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	//Dataset이 여러개이면 이부분을 복사에 붙이셔요(시작)
	GauceDataSet dsMAIN = null;
	GauceDataSet dsREMOVE_SLIP = null;
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
		if(!CITCommon.isNull(strAct) && strAct.equals("REMOVE_SLIP"))
		{
	//복사시작
			dsREMOVE_SLIP = GauceInfo.request.getGauceDataSet("dsREMOVE_SLIP");
			
			if (dsREMOVE_SLIP == null) throw new Exception("dsREMOVE_SLIP이(가) 널(Null)입니다.");
			
			rows = dsREMOVE_SLIP.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_REMOVE_CONS_INSUR_SLIP(?,?,?)}";
						
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("INSUR_NO", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsREMOVE_SLIP.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("INSUR_NO", rows[i].getString(dsREMOVE_SLIP.indexOfColumn("INSUR_NO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
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
				GauceInfo.response.writeException("USER", "900001", "T_SET_CONS_INSUR 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//복사끝
		}
		else if (CITCommon.isNull(strAct))
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
						strSql = "{call SP_T_SET_CONS_INSUR_I(?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("INSUR_NO", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("INSUR_DT_F", CITData.VARCHAR2);
						lrArgData.addColumn("INSUR_DT_T", CITData.VARCHAR2);
						lrArgData.addColumn("INSUR_AMT", CITData.NUMBER);
						lrArgData.addColumn("MONTH_DEC_AMT", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_MAKE_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("INSUR_NO", rows[i].getString(dsMAIN.indexOfColumn("INSUR_NO")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("INSUR_DT_F", rows[i].getString(dsMAIN.indexOfColumn("INSUR_DT_F")));
						lrArgData.setValue("INSUR_DT_T", rows[i].getString(dsMAIN.indexOfColumn("INSUR_DT_T")));
						lrArgData.setValue("INSUR_AMT", rows[i].getString(dsMAIN.indexOfColumn("INSUR_AMT")));
						lrArgData.setValue("MONTH_DEC_AMT", rows[i].getString(dsMAIN.indexOfColumn("MONTH_DEC_AMT")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAIN.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsMAIN.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsMAIN.indexOfColumn("REMARKS")));
						lrArgData.setValue("SLIP_MAKE_DT", rows[i].getString(dsMAIN.indexOfColumn("SLIP_MAKE_DT")));
						lrArgData.setValue("CUST_SEQ", rows[i].getString(dsMAIN.indexOfColumn("CUST_SEQ")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_SET_CONS_INSUR_U(?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("INSUR_NO", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("INSUR_DT_F", CITData.VARCHAR2);
						lrArgData.addColumn("INSUR_DT_T", CITData.VARCHAR2);
						lrArgData.addColumn("INSUR_AMT", CITData.NUMBER);
						lrArgData.addColumn("MONTH_DEC_AMT", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_MAKE_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("INSUR_NO", rows[i].getString(dsMAIN.indexOfColumn("INSUR_NO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("INSUR_DT_F", rows[i].getString(dsMAIN.indexOfColumn("INSUR_DT_F")));
						lrArgData.setValue("INSUR_DT_T", rows[i].getString(dsMAIN.indexOfColumn("INSUR_DT_T")));
						lrArgData.setValue("INSUR_AMT", rows[i].getString(dsMAIN.indexOfColumn("INSUR_AMT")));
						lrArgData.setValue("MONTH_DEC_AMT", rows[i].getString(dsMAIN.indexOfColumn("MONTH_DEC_AMT")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAIN.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsMAIN.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsMAIN.indexOfColumn("REMARKS")));
						lrArgData.setValue("SLIP_MAKE_DT", rows[i].getString(dsMAIN.indexOfColumn("SLIP_MAKE_DT")));
						lrArgData.setValue("CUST_SEQ", rows[i].getString(dsMAIN.indexOfColumn("CUST_SEQ")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_SET_CONS_INSUR_D(?,?)}";
						
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("INSUR_NO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("INSUR_NO", rows[i].getString(dsMAIN.indexOfColumn("INSUR_NO")));
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
				GauceInfo.response.writeException("USER", "900001", "T_SET_CONS_INSUR 테이블 데이타 갱신 에러" + ex.getMessage());
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

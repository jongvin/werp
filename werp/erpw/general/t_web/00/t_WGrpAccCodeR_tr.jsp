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
			
			if (dsMAIN == null) throw new Exception("dsMAIN이(가) 널(Null)입니다.");
			if (dsSUB01 == null) throw new Exception("dsSUB01이(가) 널(Null)입니다.");
			
			rows = dsMAIN.getDataRows();
			
			try
			{
								for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_ACC_GRP_I(?,?,?,?,?)}";
						
						lrArgData.addColumn("ACC_GRP_CODE", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_GRP_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("REMARK", CITData.VARCHAR2);
						lrArgData.addColumn("USE_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ACC_GRP_CODE", rows[i].getString(dsMAIN.indexOfColumn("ACC_GRP_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("ACC_GRP_NAME", rows[i].getString(dsMAIN.indexOfColumn("ACC_GRP_NAME")));
						lrArgData.setValue("REMARK", rows[i].getString(dsMAIN.indexOfColumn("REMARK")));
						lrArgData.setValue("USE_TAG", rows[i].getString(dsMAIN.indexOfColumn("USE_TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_ACC_GRP_U(?,?,?,?,?)}";
						
						lrArgData.addColumn("ACC_GRP_CODE", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_GRP_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("REMARK", CITData.VARCHAR2);
						lrArgData.addColumn("USE_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ACC_GRP_CODE", rows[i].getString(dsMAIN.indexOfColumn("ACC_GRP_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("ACC_GRP_NAME", rows[i].getString(dsMAIN.indexOfColumn("ACC_GRP_NAME")));
						lrArgData.setValue("REMARK", rows[i].getString(dsMAIN.indexOfColumn("REMARK")));
						lrArgData.setValue("USE_TAG", rows[i].getString(dsMAIN.indexOfColumn("USE_TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_ACC_GRP_D(?)}";
						
						lrArgData.addColumn("ACC_GRP_CODE", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("ACC_GRP_CODE", rows[i].getString(dsMAIN.indexOfColumn("ACC_GRP_CODE")));
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
						strSql = "{call SP_T_GRP_ACC_CODE_I(?,?)}";
						
						lrArgData.addColumn("ACC_GRP_CODE", CITData.NUMBER);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ACC_GRP_CODE", rows[i].getString(dsSUB01.indexOfColumn("ACC_GRP_CODE")));
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("ACC_CODE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_GRP_ACC_CODE_U(?,?)}";
						
						lrArgData.addColumn("ACC_GRP_CODE", CITData.NUMBER);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ACC_GRP_CODE", rows[i].getString(dsSUB01.indexOfColumn("ACC_GRP_CODE")));
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("ACC_CODE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_GRP_ACC_CODE_D(?,?)}";
						
						lrArgData.addColumn("ACC_GRP_CODE", CITData.NUMBER);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ACC_GRP_CODE", rows[i].getString(dsSUB01.indexOfColumn("ACC_GRP_CODE")));
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("ACC_CODE")));
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

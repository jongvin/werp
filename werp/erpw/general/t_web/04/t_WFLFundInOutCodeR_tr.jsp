<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2006-04-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	//Dataset이 여러개이면 이부분을 복사에 붙이셔요(시작)
	GauceDataSet dsMAIN = null;
	GauceDataSet dsSUB01 = null;
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
						strSql = "{call SP_T_FL_FUND_IN_OUT_CODE_I(?,?,?,?)}";
						
						lrArgData.addColumn("ITEM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("IO_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NAME", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ITEM_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITEM_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("IO_TAG", rows[i].getString(dsMAIN.indexOfColumn("IO_TAG")));
						lrArgData.setValue("ITEM_NAME", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NAME")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FL_FUND_IN_OUT_CODE_U(?,?,?,?)}";
						
						lrArgData.addColumn("ITEM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("IO_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NAME", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ITEM_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITEM_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("IO_TAG", rows[i].getString(dsMAIN.indexOfColumn("IO_TAG")));
						lrArgData.setValue("ITEM_NAME", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NAME")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FL_FUND_IN_OUT_CODE_D(?)}";
						
						lrArgData.addColumn("ITEM_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ITEM_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITEM_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FL_FUND_IN_OUT_CODE 테이블 데이타 갱신 에러" + ex.getMessage());
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
						strSql = "{call SP_T_FL_FUND_REL_FLOW_CODE_I(?,?,?)}";
						
						lrArgData.addColumn("ITEM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("FLOW_CODE_B", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ITEM_CODE", rows[i].getString(dsSUB01.indexOfColumn("ITEM_CODE")));
						lrArgData.setValue("FLOW_CODE_B", rows[i].getString(dsSUB01.indexOfColumn("FLOW_CODE_B")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FL_FUND_REL_FLOW_CODE_U(?,?,?)}";
						
						lrArgData.addColumn("ITEM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("FLOW_CODE_B", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ITEM_CODE", rows[i].getString(dsSUB01.indexOfColumn("ITEM_CODE")));
						lrArgData.setValue("FLOW_CODE_B", rows[i].getString(dsSUB01.indexOfColumn("FLOW_CODE_B")));
						lrArgData.setValue("MODUSERNO", strUserNo);
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FL_FUND_REL_FLOW_CODE_D(?,?)}";
						
						lrArgData.addColumn("ITEM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("FLOW_CODE_B", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("ITEM_CODE", rows[i].getString(dsSUB01.indexOfColumn("ITEM_CODE")));
						lrArgData.setValue("FLOW_CODE_B", rows[i].getString(dsSUB01.indexOfColumn("FLOW_CODE_B")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FL_FUND_REL_FLOW_CODE 테이블 데이타 갱신 에러" + ex.getMessage());
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

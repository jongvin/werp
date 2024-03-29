<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 홍길동 작성(2006-05-12)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	//Dataset이 여러개이면 이부분을 복사에 붙이셔요(시작)
	GauceDataSet dsMAIN = null;
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
						strSql = "{call SP_T_FIX_ITEM_NM_CODE_I(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("ASSET_CLS_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NM_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("SRVLIFE", CITData.NUMBER);
						lrArgData.addColumn("DEPREC_RAT", CITData.NUMBER);
						lrArgData.addColumn("DEPREC_CLS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ASSET_CLS_CODE", rows[i].getString(dsMAIN.indexOfColumn("ASSET_CLS_CODE")));
						lrArgData.setValue("ITEM_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITEM_CODE")));
						lrArgData.setValue("ITEM_NM_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NM_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("ITEM_NM_NAME", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NM_NAME")));
						lrArgData.setValue("SRVLIFE", rows[i].getString(dsMAIN.indexOfColumn("SRVLIFE")));
						lrArgData.setValue("DEPREC_RAT", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_RAT")));
						lrArgData.setValue("DEPREC_CLS", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_CLS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIX_ITEM_NM_CODE_U(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("ASSET_CLS_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NM_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("SRVLIFE", CITData.NUMBER);
						lrArgData.addColumn("DEPREC_RAT", CITData.NUMBER);
						lrArgData.addColumn("DEPREC_CLS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ASSET_CLS_CODE", rows[i].getString(dsMAIN.indexOfColumn("ASSET_CLS_CODE")));
						lrArgData.setValue("ITEM_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITEM_CODE")));
						lrArgData.setValue("ITEM_NM_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NM_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("ITEM_NM_NAME", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NM_NAME")));
						lrArgData.setValue("SRVLIFE", rows[i].getString(dsMAIN.indexOfColumn("SRVLIFE")));
						lrArgData.setValue("DEPREC_RAT", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_RAT")));
						lrArgData.setValue("DEPREC_CLS", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_CLS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIX_ITEM_NM_CODE_D(?,?,?)}";
						
						lrArgData.addColumn("ASSET_CLS_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NM_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ASSET_CLS_CODE", rows[i].getString(dsMAIN.indexOfColumn("ASSET_CLS_CODE")));
						lrArgData.setValue("ITEM_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITEM_CODE")));
						lrArgData.setValue("ITEM_NM_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NM_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIX_ITEM_NM_CODE 테이블 데이타 갱신 에러" + ex.getMessage());
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

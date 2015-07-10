<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* 세션정보 */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		
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
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_BANK_MAIN_I(?,?,?,?,?,?)}";
						
						lrArgData.addColumn("BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_MAIN_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_MAIN_SHORT_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("FBS_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("BANK_MAIN_CODE", rows[i].getString(dsMAIN.indexOfColumn("BANK_MAIN_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("BANK_MAIN_NAME", rows[i].getString(dsMAIN.indexOfColumn("BANK_MAIN_NAME")));
						lrArgData.setValue("BANK_CLS", rows[i].getString(dsMAIN.indexOfColumn("BANK_CLS")));
						lrArgData.setValue("BANK_MAIN_SHORT_NAME", rows[i].getString(dsMAIN.indexOfColumn("BANK_MAIN_SHORT_NAME")));
						lrArgData.setValue("FBS_CODE", rows[i].getString(dsMAIN.indexOfColumn("FBS_CODE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_BANK_MAIN_U(?,?,?,?,?,?)}";
						
						lrArgData.addColumn("BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_MAIN_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_MAIN_SHORT_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("FBS_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("BANK_MAIN_CODE", rows[i].getString(dsMAIN.indexOfColumn("BANK_MAIN_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("BANK_MAIN_NAME", rows[i].getString(dsMAIN.indexOfColumn("BANK_MAIN_NAME")));
						lrArgData.setValue("BANK_CLS", rows[i].getString(dsMAIN.indexOfColumn("BANK_CLS")));
						lrArgData.setValue("BANK_MAIN_SHORT_NAME", rows[i].getString(dsMAIN.indexOfColumn("BANK_MAIN_SHORT_NAME")));
						lrArgData.setValue("FBS_CODE", rows[i].getString(dsMAIN.indexOfColumn("FBS_CODE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_BANK_MAIN_D(?)}";
						
						lrArgData.addColumn("BANK_MAIN_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("BANK_MAIN_CODE", rows[i].getString(dsMAIN.indexOfColumn("BANK_MAIN_CODE")));
					}
					else
					{
						continue;
					}
					
					CITDatabase.executeProcedure(strSql, lrArgData);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_BANK_MAIN 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
	}
	catch (Exception ex)
	{
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITCommon.finalServerPage(GauceInfo);
		}
	    catch (Exception ex)
	    {
			if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
	    	GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
	    }
	}
%>

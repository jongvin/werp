<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WCommonCodeR_tr(공통코드 등록의 Update Query 페이지)
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-04)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsLIST = null;
	
	GauceDataRow[] rowsMain = null;
	GauceDataRow[] rowsList = null;
	
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
			
			rowsMain = dsMAIN.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rowsMain.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rowsMain[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_CODE_GROUP_I(?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CODE_GROUP_NO", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CODE_GROUP_ID", CITData.VARCHAR2);
						lrArgData.addColumn("CODE_GROUP_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("FLEX_FIELD", CITData.VARCHAR2);
						lrArgData.addColumn("OPEN_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("REMARK", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("CODE_GROUP_NO", rowsMain[i].getString(dsMAIN.indexOfColumn("CODE_GROUP_NO")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("CODE_GROUP_ID", rowsMain[i].getString(dsMAIN.indexOfColumn("CODE_GROUP_ID")));
						lrArgData.setValue("CODE_GROUP_NAME", rowsMain[i].getString(dsMAIN.indexOfColumn("CODE_GROUP_NAME")));
						lrArgData.setValue("FLEX_FIELD", rowsMain[i].getString(dsMAIN.indexOfColumn("FLEX_FIELD")));
						lrArgData.setValue("OPEN_TAG", rowsMain[i].getString(dsMAIN.indexOfColumn("OPEN_TAG")));
						lrArgData.setValue("REMARK", rowsMain[i].getString(dsMAIN.indexOfColumn("REMARK")));
					}
					else if (rowsMain[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_CODE_GROUP_U(?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CODE_GROUP_NO", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CODE_GROUP_ID", CITData.VARCHAR2);
						lrArgData.addColumn("CODE_GROUP_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("FLEX_FIELD", CITData.VARCHAR2);
						lrArgData.addColumn("OPEN_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("REMARK", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("CODE_GROUP_NO", rowsMain[i].getString(dsMAIN.indexOfColumn("CODE_GROUP_NO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("CODE_GROUP_ID", rowsMain[i].getString(dsMAIN.indexOfColumn("CODE_GROUP_ID")));
						lrArgData.setValue("CODE_GROUP_NAME", rowsMain[i].getString(dsMAIN.indexOfColumn("CODE_GROUP_NAME")));
						lrArgData.setValue("FLEX_FIELD", rowsMain[i].getString(dsMAIN.indexOfColumn("FLEX_FIELD")));
						lrArgData.setValue("OPEN_TAG", rowsMain[i].getString(dsMAIN.indexOfColumn("OPEN_TAG")));
						lrArgData.setValue("REMARK", rowsMain[i].getString(dsMAIN.indexOfColumn("REMARK")));
					}
					else if (rowsMain[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_CODE_GROUP_D(?)}";
						
						lrArgData.addColumn("CODE_GROUP_NO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("CODE_GROUP_NO", rowsMain[i].getString(dsMAIN.indexOfColumn("CODE_GROUP_NO")));
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
				GauceInfo.response.writeException("USER", "900001", "T_CODE_GROUP 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
			
			dsLIST = GauceInfo.request.getGauceDataSet("dsLIST");
			
			if (dsLIST == null) throw new Exception("dsLIST이(가) 널(Null)입니다.");
			
			rowsList = dsLIST.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rowsList.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rowsList[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_CODE_LIST_I(?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CODE_GROUP_NO", CITData.NUMBER);
						lrArgData.addColumn("CODE_LIST_ID", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CODE_LIST_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("USE_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("CODE_GROUP_NO", rowsList[i].getString(dsLIST.indexOfColumn("CODE_GROUP_NO")));
						lrArgData.setValue("CODE_LIST_ID", rowsList[i].getString(dsLIST.indexOfColumn("CODE_LIST_ID")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("CODE_LIST_NAME", rowsList[i].getString(dsLIST.indexOfColumn("CODE_LIST_NAME")));
						lrArgData.setValue("SEQ", rowsList[i].getString(dsLIST.indexOfColumn("SEQ")));
						lrArgData.setValue("USE_TAG", rowsList[i].getString(dsLIST.indexOfColumn("USE_TAG")));
					}
					else if (rowsList[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_CODE_LIST_U(?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CODE_GROUP_NO", CITData.NUMBER);
						lrArgData.addColumn("CODE_LIST_ID", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CODE_LIST_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("USE_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("CODE_GROUP_NO", rowsList[i].getString(dsLIST.indexOfColumn("CODE_GROUP_NO")));
						lrArgData.setValue("CODE_LIST_ID", rowsList[i].getString(dsLIST.indexOfColumn("CODE_LIST_ID")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("CODE_LIST_NAME", rowsList[i].getString(dsLIST.indexOfColumn("CODE_LIST_NAME")));
						lrArgData.setValue("SEQ", rowsList[i].getString(dsLIST.indexOfColumn("SEQ")));
						lrArgData.setValue("USE_TAG", rowsList[i].getString(dsLIST.indexOfColumn("USE_TAG")));
					}
					else if (rowsList[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_CODE_LIST_D(?,?)}";
						
						lrArgData.addColumn("CODE_GROUP_NO", CITData.NUMBER);
						lrArgData.addColumn("CODE_LIST_ID", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("CODE_GROUP_NO", rowsList[i].getString(dsLIST.indexOfColumn("CODE_GROUP_NO")));
						lrArgData.setValue("CODE_LIST_ID", rowsList[i].getString(dsLIST.indexOfColumn("CODE_LIST_ID")));
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
				GauceInfo.response.writeException("USER", "900001", "T_CODE_LIST 테이블 데이타 갱신 에러" + ex.getMessage());
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

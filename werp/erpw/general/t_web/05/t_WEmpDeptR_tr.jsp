<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 홍길동 작성(2006-01-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	
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
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_DEPT_CODE_ORG3_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_SHORT_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("TAX_COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("GROUP_DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COST_DEPT_KND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("INPUT_DT_F", CITData.VARCHAR2);
						lrArgData.addColumn("INPUT_DT_T", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_GRP_CODE", CITData.NUMBER);
						lrArgData.addColumn("LEGA_DEPT", CITData.VARCHAR2);
						lrArgData.addColumn("SAUP_TAX_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("EMP_CLASS_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("DEPT_NAME", rows[i].getString(dsMAIN.indexOfColumn("DEPT_NAME")));
						lrArgData.setValue("DEPT_SHORT_NAME", rows[i].getString(dsMAIN.indexOfColumn("DEPT_SHORT_NAME")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("TAX_COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("TAX_COMP_CODE")));
						lrArgData.setValue("BUDG_CLS", rows[i].getString(dsMAIN.indexOfColumn("BUDG_CLS")));
						lrArgData.setValue("GROUP_DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("GROUP_DEPT_CODE")));
						lrArgData.setValue("COST_DEPT_KND_TAG", rows[i].getString(dsMAIN.indexOfColumn("COST_DEPT_KND_TAG")));
						lrArgData.setValue("INPUT_DT_F", rows[i].getString(dsMAIN.indexOfColumn("INPUT_DT_F")));
						lrArgData.setValue("INPUT_DT_T", rows[i].getString(dsMAIN.indexOfColumn("INPUT_DT_T")));
						lrArgData.setValue("ACC_GRP_CODE", rows[i].getString(dsMAIN.indexOfColumn("ACC_GRP_CODE")));
						lrArgData.setValue("LEGA_DEPT", rows[i].getString(dsMAIN.indexOfColumn("LEGA_DEPT")));
						lrArgData.setValue("SAUP_TAX_TAG", rows[i].getString(dsMAIN.indexOfColumn("SAUP_TAX_TAG")));
						lrArgData.setValue("EMP_CLASS_CODE", rows[i].getString(dsMAIN.indexOfColumn("EMP_CLASS_CODE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_DEPT_CODE_ORG3_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_SHORT_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("TAX_COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("GROUP_DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COST_DEPT_KND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("INPUT_DT_F", CITData.VARCHAR2);
						lrArgData.addColumn("INPUT_DT_T", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_GRP_CODE", CITData.NUMBER);
						lrArgData.addColumn("LEGA_DEPT", CITData.VARCHAR2);
						lrArgData.addColumn("SAUP_TAX_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("EMP_CLASS_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("DEPT_NAME", rows[i].getString(dsMAIN.indexOfColumn("DEPT_NAME")));
						lrArgData.setValue("DEPT_SHORT_NAME", rows[i].getString(dsMAIN.indexOfColumn("DEPT_SHORT_NAME")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("TAX_COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("TAX_COMP_CODE")));
						lrArgData.setValue("BUDG_CLS", rows[i].getString(dsMAIN.indexOfColumn("BUDG_CLS")));
						lrArgData.setValue("GROUP_DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("GROUP_DEPT_CODE")));
						lrArgData.setValue("COST_DEPT_KND_TAG", rows[i].getString(dsMAIN.indexOfColumn("COST_DEPT_KND_TAG")));
						lrArgData.setValue("INPUT_DT_F", rows[i].getString(dsMAIN.indexOfColumn("INPUT_DT_F")));
						lrArgData.setValue("INPUT_DT_T", rows[i].getString(dsMAIN.indexOfColumn("INPUT_DT_T")));
						lrArgData.setValue("ACC_GRP_CODE", rows[i].getString(dsMAIN.indexOfColumn("ACC_GRP_CODE")));
						lrArgData.setValue("LEGA_DEPT", rows[i].getString(dsMAIN.indexOfColumn("LEGA_DEPT")));
						lrArgData.setValue("SAUP_TAX_TAG", rows[i].getString(dsMAIN.indexOfColumn("SAUP_TAX_TAG")));
						lrArgData.setValue("EMP_CLASS_CODE", rows[i].getString(dsMAIN.indexOfColumn("EMP_CLASS_CODE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_DEPT_CODE_ORG3_D(?)}";
						
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_DEPT_CODE_ORG 테이블 데이타 갱신 에러" + ex.getMessage());
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

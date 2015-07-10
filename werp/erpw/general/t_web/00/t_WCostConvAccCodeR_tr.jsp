<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-10)
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
						strSql = "{call SP_T_SET_COST_CONV_CODE_I(?,?,?,?)}";
						
						lrArgData.addColumn("COST_CONV_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("COST_CONV_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("SALE_ACC_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COST_CONV_CODE", rows[i].getString(dsMAIN.indexOfColumn("COST_CONV_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("COST_CONV_NAME", rows[i].getString(dsMAIN.indexOfColumn("COST_CONV_NAME")));
						lrArgData.setValue("SALE_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("SALE_ACC_CODE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_SET_COST_CONV_CODE_U(?,?,?,?)}";
						
						lrArgData.addColumn("COST_CONV_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("COST_CONV_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("SALE_ACC_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COST_CONV_CODE", rows[i].getString(dsMAIN.indexOfColumn("COST_CONV_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("COST_CONV_NAME", rows[i].getString(dsMAIN.indexOfColumn("COST_CONV_NAME")));
						lrArgData.setValue("SALE_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("SALE_ACC_CODE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_SET_COST_CONV_CODE_D(?)}";
						
						lrArgData.addColumn("COST_CONV_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COST_CONV_CODE", rows[i].getString(dsMAIN.indexOfColumn("COST_CONV_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_SET_COST_CONV_CODE 테이블 데이타 갱신 에러" + ex.getMessage());
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
						strSql = "{call SP_T_SET_COST_CONV_ACC_I(?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COST_CONV_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("R_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("R_ACC_CODE2", CITData.VARCHAR2);
						lrArgData.addColumn("R_ACC_CODE3", CITData.VARCHAR2);
						lrArgData.addColumn("R_ACC_CODE4", CITData.VARCHAR2);
						lrArgData.addColumn("R_ACC_CODE5", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COST_CONV_CODE", rows[i].getString(dsSUB01.indexOfColumn("COST_CONV_CODE")));
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("R_ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("R_ACC_CODE")));
						lrArgData.setValue("R_ACC_CODE2", rows[i].getString(dsSUB01.indexOfColumn("R_ACC_CODE2")));
						lrArgData.setValue("R_ACC_CODE3", rows[i].getString(dsSUB01.indexOfColumn("R_ACC_CODE3")));
						lrArgData.setValue("R_ACC_CODE4", rows[i].getString(dsSUB01.indexOfColumn("R_ACC_CODE4")));
						lrArgData.setValue("R_ACC_CODE5", rows[i].getString(dsSUB01.indexOfColumn("R_ACC_CODE5")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_SET_COST_CONV_ACC_U(?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COST_CONV_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("R_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("R_ACC_CODE2", CITData.VARCHAR2);
						lrArgData.addColumn("R_ACC_CODE3", CITData.VARCHAR2);
						lrArgData.addColumn("R_ACC_CODE4", CITData.VARCHAR2);
						lrArgData.addColumn("R_ACC_CODE5", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COST_CONV_CODE", rows[i].getString(dsSUB01.indexOfColumn("COST_CONV_CODE")));
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("R_ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("R_ACC_CODE")));
						lrArgData.setValue("R_ACC_CODE2", rows[i].getString(dsSUB01.indexOfColumn("R_ACC_CODE2")));
						lrArgData.setValue("R_ACC_CODE3", rows[i].getString(dsSUB01.indexOfColumn("R_ACC_CODE3")));
						lrArgData.setValue("R_ACC_CODE4", rows[i].getString(dsSUB01.indexOfColumn("R_ACC_CODE4")));
						lrArgData.setValue("R_ACC_CODE5", rows[i].getString(dsSUB01.indexOfColumn("R_ACC_CODE5")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_SET_COST_CONV_ACC_D(?,?)}";
						
						lrArgData.addColumn("COST_CONV_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COST_CONV_CODE", rows[i].getString(dsSUB01.indexOfColumn("COST_CONV_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_SET_COST_CONV_ACC 테이블 데이타 갱신 에러" + ex.getMessage());
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

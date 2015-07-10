<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
 
	CITGauceInfo GauceInfo = null;
	
	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;

	String	strSql = "";
	String	strAct = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MAIN"))
		{
			String strWORK_DT = CITCommon.toKOR(request.getParameter("WORK_DT"));
			
			strSql  = " select a.fl_loan_kind_code, \n";
			strSql += " 	   SubStrb(decode(b.FL_LOAN_KIND_TAG,'0','장기 ','단기 ') || b.fl_loan_kind_name,1,200) fl_loan_kind_name , \n";
			strSql += " 	   f_t_datetostring(work_dt) work_dt, \n";
			strSql += " 	   loan_limit_amt, \n";
			strSql += " 	   loan_use_amt, \n";
			strSql += " 	   nvl(loan_limit_amt,0) - nvl(loan_use_amt,0)  loan_useable_amt, \n";
			strSql += " 	   remarks \n";
			strSql += " from   t_fl_day_loan_list a, \n";
			strSql += " 	   t_fl_loan_kind_code b \n";
			strSql += " where  a.fl_loan_kind_code = b.fl_loan_kind_code \n";
			strSql += " and	   work_dt = f_t_stringtodate( ? ) order by b.fl_loan_kind_tag desc,b.fl_loan_kind_code";
			
			lrArgData.addColumn("1WORK_DT", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1WORK_DT", strWORK_DT);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("FL_LOAN_KIND_CODE", true);
				lrReturnData.setKey("WORK_DT", true);

				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
			}
		}
		if (strAct.equals("COPY"))
		{
			
			strSql  = " select 'XXXXXXXXXXXXXXXXXXX' WORK_DT From Dual \n";
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","COPY Select 오류-> "+ ex.getMessage());
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
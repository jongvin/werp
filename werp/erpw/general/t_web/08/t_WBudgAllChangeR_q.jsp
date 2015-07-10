<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2006-01-05)
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

			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			
			/*
			strSql  = " select a.comp_code, \n";
			strSql += " 	   a.clse_acc_id, \n";
			strSql += " 	   a.all_chg_seq, \n";
			strSql += " 	   to_char(a.budg_apply_ym, 'YYYY-MM') budg_apply_ym \n";
			strSql += " from    t_budg_all_change a  \n";
			strSql += " where  a.comp_code= ? \n";
			strSql += " and      a.clse_acc_id =? \n";
			*/
			
			
			strSql  =  " SELECT	a.comp_code, a.clse_acc_id, a.all_chg_seq, 			\n";
			strSql += " 	       to_char(a.budg_apply_ym, 'YYYY-MM') budg_apply_ym, \n";
			strSql += " 		decode(cnt, '',  a.all_chg_seq || '차 미적용', a.all_chg_seq || '차 적용') chg_div   \n";
			strSql += " from	t_budg_all_change a, 											\n";
			strSql += " 		(select comp_code, clse_acc_id, all_chg_seq, to_char(count(*)) cnt 	    \n";
			strSql += " 		 from   t_budg_all_change_dept 									\n";
			strSql += " 		 group by comp_code, clse_acc_id, all_chg_seq) b 				\n";
			strSql += " where	a.comp_code = b.comp_code(+) 									\n";
			strSql += " and	a.clse_acc_id = b.clse_acc_id(+)  									\n";
			strSql += " and	a.all_chg_seq = b.all_chg_seq(+) 									\n";
			strSql += " and   	a.comp_code= ? 												    \n";
			strSql += " and	 a.clse_acc_id =? 												    \n";
			strSql += " order by all_chg_seq 	desc											\n";
		      
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID", strCLSE_ACC_ID);

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("CLSE_ACC_ID", true);
				lrReturnData.setKey("ALL_CHG_SEQ", true);

				
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
		else if (strAct.equals("ALL_CHG_SEQ"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			
			strSql  = " select nvl(max(all_chg_seq),0) + 1 all_chg_seq \n";
			strSql += " from t_budg_all_change \n";
			strSql += " where comp_code =? \n";
			strSql += " and    clse_acc_id = ? ";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID", strCLSE_ACC_ID);

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
				GauceInfo.response.writeException("USER", "900001","ALL_CHG_SEQ Select 오류-> "+ ex.getMessage());
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
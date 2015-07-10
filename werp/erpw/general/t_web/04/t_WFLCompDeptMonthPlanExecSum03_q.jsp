<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Select Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-05-03)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
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
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			
			strSql  = " select a.p_no, \n";
			strSql += " 	   a.flow_code, \n";
			strSql += " 	   lpad(' ', (level-1) *2 ) || flow_item_name flow_item_name, \n";
			strSql += " 	   b_y_exec_amt,   \n";
			strSql += " 	   exec_amt01,     \n";
			strSql += " 	   exec_amt02,     \n";
			strSql += " 	   exec_amt03,     \n";
			strSql += " 	   exec_amt04,     \n";
			strSql += " 	   exec_amt05,     \n";
			strSql += " 	   exec_amt06,     \n";
			strSql += " 	   exec_amt07,     \n";
			strSql += " 	   exec_amt08,     \n";
			strSql += " 	   exec_amt09,     \n";
			strSql += " 	   exec_amt10,     \n";
			strSql += " 	   exec_amt11,     \n";
			strSql += " 	   exec_amt12,     \n";
			strSql += " 	   c_y_exec_amt,  \n";
			strSql += " 	   b_c_y_amt	    \n";
			strSql += " from \n";
			strSql += " 	( \n";
			strSql += " 	select   \n";
			strSql += " 			a.p_no, \n";
			strSql += " 			a.flow_code, \n";
			strSql += " 		    sum(b_y_exec_amt) b_y_exec_amt,   \n";
			strSql += " 			sum(exec_amt01)  exec_amt01,      \n";
			strSql += " 			sum(exec_amt02)  exec_amt02,      \n";
			strSql += " 			sum(exec_amt03)  exec_amt03,      \n";
			strSql += " 			sum(exec_amt04)  exec_amt04,      \n";
			strSql += " 			sum(exec_amt05)  exec_amt05,      \n";
			strSql += " 			sum(exec_amt06)  exec_amt06,      \n";
			strSql += " 			sum(exec_amt07)  exec_amt07,      \n";
			strSql += " 			sum(exec_amt08)  exec_amt08,      \n";
			strSql += " 			sum(exec_amt09)  exec_amt09,      \n";
			strSql += " 			sum(exec_amt10)  exec_amt10,      \n";
			strSql += " 			sum(exec_amt11)  exec_amt11,      \n";
			strSql += " 			sum(exec_amt12)  exec_amt12,      \n";
			strSql += " 			sum(c_y_exec_amt) c_y_exec_amt,   \n";
			strSql += " 			sum(b_c_y_amt)	 b_c_y_amt	      \n";
			strSql += " 	from t_fl_flow_code a, \n";
			strSql += " 		 (select b3.dept_code, \n";
			strSql += " 		 		 b3.flow_code, \n";
			strSql += " 				 decode(nvl(b_y_exec_amt,0), 0, 0, round(b_y_exec_amt/1000000,0))  b_y_exec_amt, \n";
			strSql += " 				 decode(nvl(exec_amt01,0), 0, 0, round(exec_amt01/1000000,0)) exec_amt01,   \n";
			strSql += " 				 decode(nvl(exec_amt02,0), 0, 0, round(exec_amt02/1000000,0)) exec_amt02, \n";
			strSql += " 				 decode(nvl(exec_amt03,0), 0, 0, round(exec_amt03/1000000,0)) exec_amt03, \n";
			strSql += " 				 decode(nvl(exec_amt04,0), 0, 0, round(exec_amt04/1000000,0)) exec_amt04,   \n";
			strSql += " 				 decode(nvl(exec_amt05,0), 0, 0, round(exec_amt05/1000000,0)) exec_amt05, \n";
			strSql += " 				 decode(nvl(exec_amt06,0), 0, 0, round(exec_amt06/1000000,0)) exec_amt06, \n";
			strSql += " 				 decode(nvl(exec_amt07,0), 0, 0, round(exec_amt07/1000000,0)) exec_amt07,   \n";
			strSql += " 				 decode(nvl(exec_amt08,0), 0, 0, round(exec_amt08/1000000,0)) exec_amt08, \n";
			strSql += " 				 decode(nvl(exec_amt09,0), 0, 0, round(exec_amt09/1000000,0)) exec_amt09, \n";
			strSql += " 				 decode(nvl(exec_amt10,0), 0, 0, round(exec_amt10/1000000,0)) exec_amt10,  \n";
			strSql += " 				 decode(nvl(exec_amt11,0), 0, 0, round(exec_amt11/1000000,0)) exec_amt11, \n";
			strSql += " 				 decode(nvl(exec_amt12,0), 0, 0, round(exec_amt12/1000000,0)) exec_amt12, \n";
			strSql += " 				 decode(nvl(c_y_exec_amt,0), 0, 0, round(c_y_exec_amt/1000000,0)) c_y_exec_amt, \n";
			strSql += " 				 round( decode(nvl(b_y_exec_amt,0), 0, 0, b_y_exec_amt/1000000) + decode( nvl(c_y_exec_amt,0), 0, 0, c_y_exec_amt/1000000),0) b_c_y_amt \n";
			strSql += " 		  from  \n";
			strSql += " 				 (select comp_code, clse_acc_id + 1 clse_acc_id, dept_code, flow_code,  b_y_exec_amt \n";
			strSql += " 				  from  \n";
			strSql += " 					 (select comp_code, clse_acc_id, dept_code, flow_code, sum(exec_amt) b_y_exec_amt \n";
			strSql += " 					  from t_fl_month_plan_exec \n";
			strSql += " 					  where comp_code =  ?  \n";
			strSql += " 					  and	clse_acc_id =  ?  - 1 \n";
			strSql += " 					  and	dept_code	=  ?  \n";
			strSql += " 					  group by comp_code, clse_acc_id, dept_code, flow_code) \n";
			strSql += " 				  ) b1, \n";
			strSql += " 				  (	select comp_code, clse_acc_id, dept_code, flow_code,                                                        \n";
			strSql += " 				  		 sum(exec_amt01) exec_amt01,                                             \n";
			strSql += " 						 sum(exec_amt02) exec_amt02,                                             \n";
			strSql += " 						 sum(exec_amt03) exec_amt03,                                             \n";
			strSql += " 						 sum(exec_amt04) exec_amt04,                                             \n";
			strSql += " 						 sum(exec_amt05) exec_amt05,                                             \n";
			strSql += " 						 sum(exec_amt06) exec_amt06,                                             \n";
			strSql += " 						 sum(exec_amt07) exec_amt07,                                             \n";
			strSql += " 						 sum(exec_amt08) exec_amt08,                                             \n";
			strSql += " 						 sum(exec_amt09) exec_amt09,                                             \n";
			strSql += " 						 sum(exec_amt10) exec_amt10,                                             \n";
			strSql += " 						 sum(exec_amt11) exec_amt11,                                             \n";
			strSql += " 						 sum(exec_amt12) exec_amt12                                              \n";
			strSql += " 				  from                                                                           \n";
			strSql += " 				  	  (                                                                          \n";
			strSql += " 					  select comp_code, clse_acc_id, dept_code, flow_code,                                  \n";
			strSql += " 					  		  decode(substr(work_ym, 5,6) ,'01', sum(exec_amt), '') exec_amt01,  \n";
			strSql += " 					  		  decode(substr(work_ym, 5,6) ,'02', sum(exec_amt), '') exec_amt02,  \n";
			strSql += " 							  decode(substr(work_ym, 5,6) ,'03', sum(exec_amt), '') exec_amt03,  \n";
			strSql += " 							  decode(substr(work_ym, 5,6) ,'04', sum(exec_amt), '') exec_amt04,  \n";
			strSql += " 							  decode(substr(work_ym, 5,6) ,'05', sum(exec_amt), '') exec_amt05,  \n";
			strSql += " 							  decode(substr(work_ym, 5,6) ,'06', sum(exec_amt), '') exec_amt06,  \n";
			strSql += " 							  decode(substr(work_ym, 5,6) ,'07', sum(exec_amt), '') exec_amt07,  \n";
			strSql += " 							  decode(substr(work_ym, 5,6) ,'08', sum(exec_amt), '') exec_amt08,  \n";
			strSql += " 							  decode(substr(work_ym, 5,6) ,'09', sum(exec_amt), '') exec_amt09,  \n";
			strSql += " 					  		  decode(substr(work_ym, 5,6) ,'10', sum(exec_amt), '') exec_amt10,  \n";
			strSql += " 							  decode(substr(work_ym, 5,6) ,'11', sum(exec_amt), '') exec_amt11,  \n";
			strSql += " 							  decode(substr(work_ym, 5,6) ,'12', sum(exec_amt), '') exec_amt12   \n";
			strSql += " 					  from t_fl_month_plan_exec                                                  \n";
			strSql += " 					  where comp_code =  ?                                                \n";
			strSql += " 					  and	clse_acc_id =  ?  \n";
			strSql += " 					  and	dept_code	=  ?                                            \n";
			strSql += " 					  group by comp_code, clse_acc_id, dept_code, flow_code,                                \n";
			strSql += " 					  		   substr(work_ym, 5,6))                                             \n";
			strSql += " 				   group by comp_code, clse_acc_id, dept_code, flow_code   ) b2, \n";
			strSql += " 				 (select comp_code, clse_acc_id, flow_code, dept_code, sum(exec_amt) c_y_exec_amt \n";
			strSql += " 				  from t_fl_month_plan_exec \n";
			strSql += " 				  where comp_code =  ?  \n";
			strSql += " 				  and	clse_acc_id =  ?  \n";
			strSql += " 				  and	dept_code	=  ?  \n";
			strSql += " 				  group by comp_code, clse_acc_id, dept_code, flow_code) b3 \n";
			strSql += " 		  where   b3.comp_code = b1.comp_code(+) \n";
			strSql += " 		  and	  b3.comp_code = b2.comp_code(+) \n";
			strSql += " 		  and	  b3.clse_acc_id = b1.clse_acc_id(+) \n";
			strSql += " 		  and	  b3.clse_acc_id = b2.clse_acc_id(+) \n";
			strSql += " 		  and	  b3.dept_code = b1.dept_code(+) \n";
			strSql += " 		  and	  b3.dept_code = b2.dept_code(+)  \n";
			strSql += " 		  and	  b3.flow_code = b1.flow_code(+) \n";
			strSql += " 		  and	  b3.flow_code = b2.flow_code(+) \n";
			strSql += " 		  ) b \n";
			strSql += " 	where a.flow_code = b.flow_code(+) \n";
			strSql += " 	group by grouping sets ((a.p_no, \n";
			strSql += " 							 a.flow_code), \n";
			strSql += " 							(a.p_no)) \n";
			strSql += " 	)	a, \n";
			strSql += " 	t_fl_flow_code b \n";
			strSql += " where a.flow_code = b.flow_code					 \n";
			strSql += " start with a.p_no= 0 \n";
			strSql += " connect by prior a.flow_code = a.p_no \n";
			strSql += " order siblings by level_seq ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("3DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("4COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("5CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("6DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("7COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("8CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("9DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("3DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("4COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("5CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("6DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("7COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("8CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("9DEPT_CODE", strDEPT_CODE);
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
				GauceInfo.response.writeException("USER", "900001","MAIN Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("COPY"))
		{

			
			strSql  = " select '######' comp_code, \n";
			strSql += " 	   '######' clse_acc_id, \n";
			strSql += " 	   '######' dept_code, \n";
			strSql += " 	   '######' b_clse_acc_id, \n";
			strSql += " 	   '######' n_clse_acc_id, \n";
			strSql += " 	   '######' emp_no \n";
			strSql += " from dual ";
			

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
				GauceInfo.response.writeException("USER", "900001","COPY Select ����-> "+ ex.getMessage());
			}
		}
		
	}
	catch (Exception ex)
	{
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "������ �ʱ�ȭ ���� -> " + ex.getMessage());
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
			GauceInfo.response.writeException("SYS", "100002", "������ ���� ���� -> " + ex.getMessage());
		}
	}
%>
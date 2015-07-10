<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2005-11-25)
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
		
		if (strAct.equals("MAIN01"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strALL_CHG_SEQ = CITCommon.toKOR(request.getParameter("ALL_CHG_SEQ"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			
			/*
			strSql  = " SELECT a.comp_code, 	\n";
			strSql += " 	   a.clse_acc_id, 	\n";
			strSql += " 	   a.all_chg_seq, 	\n";
			strSql += " 	   a.dept_code, 	\n";
			strSql += " 	   b.dept_name dept_name, \n";
			strSql += " 	   a.emp_no, \n";
			strSql += " 	   a.grade_code, \n";
			strSql += " 	   c.name grade_name, \n";
			strSql += " 	   a.emp_name \n";
			strSql += " from   t_budg_bf_order_stat a, \n";
			strSql += " 	   t_dept_code b, \n";
			strSql += " 	   (Select 										 \n";
			strSql += " 			   a.CODE_LIST_ID AS CODE, 				 \n";
			strSql += " 		       a.CODE_LIST_NAME AS NAME 				 \n";
			strSql += " 		From   V_T_CODE_LIST a 					   	 \n";
			strSql += " 		Where  a.CODE_GROUP_ID = 'GRADE_CODE' 	 \n";
			strSql += " 		And	   a.USE_TAG = 'T' 						 \n";
			strSql += " 		Order by a.SEQ ) c \n";
			strSql += " where a.dept_code = b.dept_code \n";
			strSql += " and	  a.grade_code = c.code \n";
			strSql += " and   	  a.comp_code= ? \n";
			strSql += " and	  a.clse_acc_id =? \n";
			strSql += " and	  a.all_chg_seq  =   ?    \n";
			strSql += " and	  a.dept_code  like '%' ||    ? || '%'    \n";
			strSql += " order by dept_code, emp_no \n";
			*/


			
			strSql  = " select comp_code, clse_acc_id, all_chg_seq, dept_code, dept_name, \n";
			strSql += " 	   decode(emp_no, null, cnt, to_char(emp_no)) emp_no, \n";
			strSql += " 	   grade_name, \n";
			strSql += " 	   emp_name \n";
			strSql += " from \n";
			strSql += " 	( \n";
			strSql += " 	SELECT a.comp_code, 	 \n";
			strSql += " 	 	   a.clse_acc_id, 	 \n";
			strSql += " 	 	   a.all_chg_seq, 	 \n";
			strSql += " 	 	   a.dept_code, 	 \n";
			strSql += " 	 	   case when grouping(a.emp_name)=0 and grouping(a.dept_code)=0 then \n";
			strSql += " 		   		b.dept_name \n";
			strSql += " 				 When GROUPing(a.dept_code) = 0 Then \n";
			strSql += " 				 '' \n";
			strSql += " 		   end dept_name, \n";
			strSql += " 		   --b.dept_name dept_name,  \n";
			strSql += " 	 	   a.emp_no emp_no,  \n";
			strSql += " 	 	   a.grade_code grade_code,  \n";
			strSql += " 	 	   c.name grade_name,  \n";
			strSql += " 	 	   a.emp_name emp_name, \n";
			strSql += " 		   count(*) ||'명' cnt \n";
			strSql += " 	 from   t_budg_bf_order_stat a,  \n";
			strSql += " 	 	   t_dept_code b,  \n";
			strSql += " 	 	   (Select 										  \n";
			strSql += " 	 			   a.CODE_LIST_ID AS CODE, 				  \n";
			strSql += " 	 		       a.CODE_LIST_NAME AS NAME 				  \n";
			strSql += " 	 		From   V_T_CODE_LIST a 					   	  \n";
			strSql += " 	 		Where  a.CODE_GROUP_ID = 'GRADE_CODE' 	  \n";
			strSql += " 	 		And	   a.USE_TAG = 'T' 						  \n";
			strSql += " 	 		Order by a.SEQ ) c  \n";
			strSql += " 	 where a.dept_code = b.dept_code  \n";
			strSql += " 	 and	  a.grade_code = c.code  \n";
			strSql += " 	 and   a.comp_code=  ?   \n";
			strSql += " 	 and	  a.clse_acc_id = ?   \n";
			strSql += " 	 and	  a.all_chg_seq  = ?      \n";
			strSql += " 	 and	  a.dept_code  like '%'|| ? ||'%' \n";
			strSql += " 	 group by grouping sets( (a.comp_code, 	 \n";
			strSql += " 					 	   	  a.clse_acc_id, 	 \n";
			strSql += " 					 	   	  a.all_chg_seq, 	 \n";
			strSql += " 					 	   	  a.dept_code, 	 \n";
			strSql += " 					 	   	  b.dept_name, \n";
			strSql += " 							  a.emp_no, \n";
			strSql += " 							  a.grade_code, \n";
			strSql += " 							  c.name, \n";
			strSql += " 							  a.emp_name), \n";
			strSql += " 	 	   	  		   		 (a.comp_code, 	 \n";
			strSql += " 					 	   	  a.clse_acc_id, 	 \n";
			strSql += " 					 	   	  a.all_chg_seq, 	 \n";
			strSql += " 					 	   	  a.dept_code, 	 \n";
			strSql += " 					 	   	  b.dept_name))     \n";
			strSql += " 	 order by dept_code, emp_no \n";
			strSql += " 	 ) ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("3ALL_CHG_SEQ", CITData.VARCHAR2);
			lrArgData.addColumn("4DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("3ALL_CHG_SEQ", strALL_CHG_SEQ);
			lrArgData.setValue("4DEPT_CODE", strDEPT_CODE);
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("CLSE_ACC_ID", true);
				lrReturnData.setKey("ALL_CHG_SEQ", true);
				lrReturnData.setKey("DEPT_CODE", true);
				lrReturnData.setKey("DEPT_NAME", true);


				
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
		
		else if (strAct.equals("MAIN02"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strALL_CHG_SEQ = CITCommon.toKOR(request.getParameter("ALL_CHG_SEQ"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			
			strSql  = " SELECT a.comp_code, \n";
			strSql += "  	   a.clse_acc_id, \n";
			strSql += "  	   a.all_chg_seq, \n";
			strSql += "  	   a.dept_code, \n";
			strSql += "  	   a.dept_name, \n";
			strSql += "  	   a.bf_order_dept_name, \n";
			strSql += "  	   decode(a.emp_no, null, cnt, a.emp_no) emp_no, \n";
			strSql += " 	  -- a.emp_no, \n";
			strSql += "  	   a.grade_code, \n";
			strSql += "  	   a.grade_name, \n";
			strSql += "  	   a.bf_order_grade_name, \n";
			strSql += "  	   a.emp_name, \n";
			strSql += "  	   a.order_dt \n";
			strSql += "  from (  \n";
			strSql += " 	SELECT a.comp_code, \n";
			strSql += " 	 	   a.clse_acc_id, \n";
			strSql += " 	 	   a.all_chg_seq, \n";
			strSql += " 	 	   a.dept_code, \n";
			strSql += " 		   case when grouping(a.emp_name)=0 and grouping(a.dept_code)=0 then \n";
			strSql += " 				     b1.dept_name \n";
			strSql += " 				When GROUPing(a.dept_code) = 0 Then \n";
			strSql += " 					 '' \n";
			strSql += " 		   end dept_name, \n";
			strSql += " 	 	   b2.dept_name bf_order_dept_name, \n";
			strSql += " 	 	   a.emp_no, \n";
			strSql += " 	 	   a.grade_code, \n";
			strSql += " 	 	   c1.name grade_name, \n";
			strSql += " 	 	   c2.name bf_order_grade_name, \n";
			strSql += " 	 	   a.emp_name, \n";
			strSql += " 	 	   F_T_DATETOSTRING(a.order_dt) order_dt, \n";
			strSql += " 		   count(*) || '명' cnt \n";
			strSql += " 	 from   t_budg_now_order_stat a, \n";
			strSql += " 	 	   t_dept_code b1, \n";
			strSql += " 	 	   t_dept_code b2, \n";
			strSql += " 	 	   (Select 										 \n";
			strSql += " 	 			   a.CODE_LIST_ID AS CODE, 				 \n";
			strSql += " 	 		       a.CODE_LIST_NAME AS NAME 				 \n";
			strSql += " 	 		From   V_T_CODE_LIST a 					   	 \n";
			strSql += " 	 		Where  a.CODE_GROUP_ID = 'GRADE_CODE' 	 \n";
			strSql += " 	 		And	   a.USE_TAG = 'T' 						 \n";
			strSql += " 	 		Order by a.SEQ ) c1, \n";
			strSql += " 	 		(Select 										 \n";
			strSql += " 	 			   a.CODE_LIST_ID AS CODE, 				 \n";
			strSql += " 	 		       a.CODE_LIST_NAME AS NAME 				 \n";
			strSql += " 	 		From   V_T_CODE_LIST a 					   	 \n";
			strSql += " 	 		Where  a.CODE_GROUP_ID = 'GRADE_CODE' 	 \n";
			strSql += " 	 		And	   a.USE_TAG = 'T' 						 \n";
			strSql += " 	 		Order by a.SEQ ) c2 \n";
			strSql += " 	 where  a.dept_code = b1.dept_code \n";
			strSql += "  	 and    a.bf_order_dept_code = b2.dept_code(+)  \n";
			strSql += "  	 and	   a.grade_code = c1.code(+) \n";
			strSql += "  	 and	   a.grade_code = c2.code(+)  \n";
			strSql += "  	 and    a.comp_code=  ?  \n";
			strSql += " 	 and	a.clse_acc_id =  ?  \n";
			strSql += "  	 and	a.all_chg_seq  =    ?     \n";
			strSql += " 	 and	a.dept_code  like '%' ||     ?  || '%' \n";
			strSql += " 	 group by grouping sets( ( a.comp_code, \n";
			strSql += " 						 	   a.clse_acc_id, \n";
			strSql += " 						 	   a.all_chg_seq, \n";
			strSql += " 						 	   a.dept_code, \n";
			strSql += " 						 	   b1.dept_name, \n";
			strSql += " 						 	   b2.dept_name, \n";
			strSql += " 						 	   a.emp_no, \n";
			strSql += " 						 	   a.grade_code, \n";
			strSql += " 						 	   c1.name, \n";
			strSql += " 						 	   c2.name, \n";
			strSql += " 						 	   a.emp_name, \n";
			strSql += " 						 	   F_T_DATETOSTRING(a.order_dt)), \n";
			strSql += " 							   ( a.comp_code, \n";
			strSql += " 						 	   a.clse_acc_id, \n";
			strSql += " 						 	   a.all_chg_seq, \n";
			strSql += " 						 	   a.dept_code, \n";
			strSql += " 						 	   b1.dept_name)) \n";
			strSql += " 	 ) a    order by a.dept_code, a.emp_no \n";
			strSql += "  ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("3ALL_CHG_SEQ", CITData.VARCHAR2);
			lrArgData.addColumn("4DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("3ALL_CHG_SEQ", strALL_CHG_SEQ);
			lrArgData.setValue("4DEPT_CODE", strDEPT_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("CLSE_ACC_ID", true);
				lrReturnData.setKey("ALL_CHG_SEQ", true);
				lrReturnData.setKey("DEPT_CODE", true);
				lrReturnData.setKey("DEPT_NAME", true);


				
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
		
		else if (strAct.equals("SUB01"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strALL_CHG_SEQ = CITCommon.toKOR(request.getParameter("ALL_CHG_SEQ"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strEMP_NO = CITCommon.toKOR(request.getParameter("EMP_NO"));
			
			strSql  = " SELECT a.comp_code, \n";
			strSql += " 	   a.clse_acc_id, \n";
			strSql += " 	   a.all_chg_seq, \n";
			strSql += " 	   a.dept_code, \n";
			strSql += " 	   a.emp_no, \n";
			strSql += " 	   a.budg_code_no, \n";
			strSql += " 	   d.budg_code_name, \n";
			strSql += " 	   a.item_no, \n";
			strSql += " 	   d.item_name, \n";
			strSql += " 	   to_char(a.budg_ym,'YYYY-MM') budg_ym, \n";
			strSql += " 	   a.unit_cost, \n";
			strSql += " 	   a.qty, \n";
			strSql += " 	   a.amt \n";
			strSql += " from   t_budg_bf_base_amt a, \n";
			strSql += " 	   t_dept_code b1, \n";
			strSql += " 	   (Select \n";
			strSql += " 	   		   a.budg_code_no, \n";
			strSql += " 	   		   a.budg_code_name, \n";
			strSql += " 	   		   b.item_no, \n";
			strSql += " 	   		   b.item_name \n";
			strSql += " 	   	from   t_budg_code a, \n";
			strSql += " 	   		   t_budg_item_cost b \n";
			strSql += " 	   	where  a.budg_code_no = b.budg_code_no \n";
			strSql += " 	   ) d \n";
			strSql += " where a.dept_code = b1.dept_code \n";
			strSql += " and          a.budg_code_no = d.budg_code_no \n";
			strSql += " and	  a.item_no = d.item_no \n";
			strSql += " and         a.comp_code= ? \n";
			strSql += " and	  a.clse_acc_id =? \n";
			strSql += " and	  a.all_chg_seq = ? ";
			strSql += " and	  a.dept_code = ? ";
			strSql += " and	  a.emp_no = ? "; 
			strSql += " order by  dept_code, emp_no, budg_code_no, item_no, budg_ym";
			

			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("ALL_CHG_SEQ", CITData.VARCHAR2);
			lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("ALL_CHG_SEQ", strALL_CHG_SEQ);
			lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("EMP_NO", strEMP_NO);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("CLSE_ACC_ID", true);
				lrReturnData.setKey("ALL_CHG_SEQ", true);
				lrReturnData.setKey("DEPT_CODE", true);
				lrReturnData.setKey("EMP_NO", true);
				lrReturnData.setKey("BUDG_CODE_NO", true);
				lrReturnData.setKey("ITEM_NO", true);
				lrReturnData.setKey("BUDG_YM", true);



				
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
		
		else if (strAct.equals("SUB02"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strALL_CHG_SEQ = CITCommon.toKOR(request.getParameter("ALL_CHG_SEQ"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strEMP_NO = CITCommon.toKOR(request.getParameter("EMP_NO"));
			
			strSql  = " SELECT a.comp_code, \n";
			strSql += " 	     a.clse_acc_id, \n";
			strSql += " 	     a.all_chg_seq, \n";
			strSql += " 	     a.dept_code, \n";
			strSql += " 	     a.emp_no, \n";
			strSql += " 	   a.budg_code_no, \n";
			strSql += " 	   d.budg_code_name, \n";
			strSql += " 	   a.item_no, \n";
			strSql += " 	   d.item_name, \n";
			strSql += " 	   to_char(a.budg_ym,'YYYY-MM') budg_ym, \n";
			strSql += " 	   a.unit_cost, \n";
			strSql += " 	   to_char(a.qty,'999.99') qty, \n";
			strSql += " 	   a.amt \n";
			strSql += " from   t_budg_now_appl_amt a, \n";
			strSql += " 	   t_dept_code b1, \n";
			strSql += " 	   (Select \n";
			strSql += " 	   		   a.budg_code_no, \n";
			strSql += " 	   		   a.budg_code_name, \n";
			strSql += " 	   		   b.item_no, \n";
			strSql += " 	   		   b.item_name \n";
			strSql += " 	   	from   t_budg_code a, \n";
			strSql += " 	   		   t_budg_item_cost b \n";
			strSql += " 	   	where  a.budg_code_no = b.budg_code_no \n";
			strSql += " 	   ) d \n";
			strSql += " where a.dept_code = b1.dept_code \n";
			strSql += " and    a.budg_code_no = d.budg_code_no \n";
			strSql += " and	  a.item_no = d.item_no \n";
			strSql += " and         a.comp_code= ? \n";
			strSql += " and	  a.clse_acc_id =? \n";
			strSql += " and	  a.all_chg_seq = ? ";
			strSql += " and	  a.dept_code = ? ";
			strSql += " and	  a.emp_no = ? ";
			strSql += " order by  dept_code, emp_no, budg_code_no, item_no, budg_ym";

			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("ALL_CHG_SEQ", CITData.NUMBER);
			lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("ALL_CHG_SEQ", strALL_CHG_SEQ);
			lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("EMP_NO", strEMP_NO);

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("CLSE_ACC_ID", true);
				lrReturnData.setKey("ALL_CHG_SEQ", true);
				lrReturnData.setKey("DEPT_CODE", true);
				lrReturnData.setKey("DEPT_NAME", true);


				
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
			
			strSql  =  " SELECT	a.all_chg_seq, 																\n";
			strSql += " 		decode(nvl(b.cnt,0), 0, a.all_chg_seq || '차  미적용', a.all_chg_seq || '차 적용') all_chg_seq_disp   \n";
			strSql += " from	t_budg_all_change a, 																	\n";
			strSql += " 		(select comp_code, clse_acc_id, all_chg_seq, count(*) cnt 											\n";
			strSql += " 		 from   t_budg_all_change_dept 															\n";
			strSql += " 		 group by comp_code, clse_acc_id, all_chg_seq) b 													\n";
			strSql += " where	a.comp_code = b.comp_code(+) 															\n";
			strSql += " and	a.clse_acc_id = b.clse_acc_id(+)  \n";
			strSql += " and	a.all_chg_seq = b.all_chg_seq(+) 															\n";
			strSql += " and   	a.comp_code= ? 																			\n";
			strSql += " and	 a.clse_acc_id =? 																			\n";
			strSql += " order by all_chg_seq 	desc																	\n";
		
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID", CITData.NUMBER);
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
				GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
			}
		}
		
		else if (strAct.equals("BUDG_ALL_CHANGE"))
		{
			
			strSql  = " Select 'XXXXXXXXXX' COMP_CODE, 'XXXXXXXXXX' CLSE_ACC_ID , 0 ALL_CHG_SEQ,  'XXXXXXXXXX' APPLY_YN from dual \n";
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
		
		else if (strAct.equals("DEPT"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			

			strSql  = "select  '' DEPT_CODE, '전  체' DEPT_NAME, '전  체' DEPT_SHORT_NAME \n";
			strSql += "from dual a \n";
			strSql += "union all \n";
			strSql += "select a.DEPT_CODE, a.DEPT_NAME, a.DEPT_SHORT_NAME \n";
			strSql += "from T_DEPT_CODE a, \n";
			strSql += "	 ( \n";
			strSql += "	  SELECT DEPT_CODE \n";
			strSql += "	  FROM T_BUDG_DEPT \n";
			strSql += "	  group by DEPT_CODE \n";
			strSql += "	 ) b \n";
			strSql  += "WHERE \n";
			strSql  += "     a.COMP_CODE = ?   \n";
			strSql += "	and a.DEPT_CODE = b.DEPT_CODE \n";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
				

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				lrReturnData.setKey("COMP_CODE",true);
				lrReturnData.setKey("DEPT_CODE",true);

				lrReturnData.setColumnDisplaySize("DEPT_NAME", 100);
				lrReturnData.setColumnDisplaySize("DEPT_SHORT_NAME", 200);


				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null)
				{
					GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
				}
				else
				{
					throw new Exception("USER-900001:MAIN Select 오류 -> " + ex.getMessage());
				}
			}
		}
		//인원변동부서
		if (strAct.equals("CHG_DEPT"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strALL_CHG_SEQ = CITCommon.toKOR(request.getParameter("ALL_CHG_SEQ"));
			
			strSql   = " select '0' dept_code, '인원변동부서' dept_name, 10000000000 cnt  from dual	    \n";
			strSql += " union  ";
			strSql += " select a.dept_code, \n";
			strSql += " 	   c.dept_name || ' ' || (a.cnt-b.cnt) || '명' dept_name, \n";
			strSql += " 	  (a.cnt-b.cnt) cnt  \n";
			strSql += " from   		 \n";
			strSql += " 	( \n";
			strSql += " 		select comp_code, \n";
			strSql += " 			   clse_acc_id, \n";
			strSql += " 			   all_chg_seq, \n";
			strSql += " 			   dept_code, \n";
			strSql += " 			   count(*) cnt \n";
			strSql += " 		from   t_budg_now_order_stat a \n";
			strSql += " 		where  a.comp_code=   ?     \n";
			strSql += " 		and	   a.clse_acc_id =  ?     \n";
			strSql += " 		and	   a.all_chg_seq  =  ?        \n";
			strSql += " 		group by comp_code, \n";
			strSql += " 			     clse_acc_id, \n";
			strSql += " 			     all_chg_seq, \n";
			strSql += " 			     dept_code  \n";
			strSql += " 	) a, \n";
			strSql += " 	(		  \n";
			strSql += " 		select comp_code, \n";
			strSql += " 			   clse_acc_id, \n";
			strSql += " 			   all_chg_seq, \n";
			strSql += " 			   dept_code, \n";
			strSql += " 			   count(*) cnt \n";
			strSql += " 		from   t_budg_bf_order_stat a \n";
			strSql += " 		where  a.comp_code=   ?     \n";
			strSql += " 		and	   a.clse_acc_id =  ?     \n";
			strSql += " 		and	   a.all_chg_seq  =  ?        \n";
			strSql += " 		group by comp_code, \n";
			strSql += " 			     clse_acc_id, \n";
			strSql += " 			     all_chg_seq, \n";
			strSql += " 			     dept_code \n";
			strSql += " 	) b, \n";
			strSql += " 	t_dept_code c \n";
			strSql += " where a.comp_code = b.comp_code  \n";
			strSql += " and	  a.clse_acc_id = b.clse_acc_id \n";
			strSql += " and	  a.all_chg_seq = b.all_chg_seq \n";
			strSql += " and	  a.dept_code = b.dept_code \n";
			strSql += " and	  a.dept_code = c.dept_code(+) \n";
			strSql += " and	  a.cnt-b.cnt > 0 \n";
			strSql += " order by 3 desc ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("3ALL_CHG_SEQ", CITData.VARCHAR2);
			lrArgData.addColumn("5COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("6CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("7ALL_CHG_SEQ", CITData.VARCHAR2);
			
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("3ALL_CHG_SEQ", strALL_CHG_SEQ);
			lrArgData.setValue("5COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("6CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("7ALL_CHG_SEQ", strALL_CHG_SEQ);

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
				GauceInfo.response.writeException("USER", "900001","CHG_DEPT Select 오류-> "+ ex.getMessage());
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
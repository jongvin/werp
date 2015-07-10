<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("v_test_plan_result_input_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_yymm = dSet.indexOfColumn("yymm");
   	int idx_yymmdd = dSet.indexOfColumn("yymmdd");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_d_seq = dSet.indexOfColumn("d_seq");
   	int idx_comm_wbs_code = dSet.indexOfColumn("comm_wbs_code");
   	int idx_test_item = dSet.indexOfColumn("test_item");
   	int idx_test_plan = dSet.indexOfColumn("test_plan");
   	int idx_test_times = dSet.indexOfColumn("test_times");
   	int idx_test_pass = dSet.indexOfColumn("test_pass");
   	int idx_test_fail = dSet.indexOfColumn("test_fail");
   	int idx_test_reexam = dSet.indexOfColumn("test_reexam");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		
		String ls_yymmdd = rows.getString(idx_yymmdd);
		String ls_dept_code = rows.getString(idx_dept_code);
		
		String sSql = " INSERT INTO v_test_result_detail 							" + 
       "      (  select 																	" +
       "               to_date('" + ls_yymmdd + "', 'yyyymmdd'), 				" +
       "               '" + ls_dept_code + "',										" +
       "               a.d_seq,															" +
       "               a.comm_wbs_code,												" +
       "               a.branch_class,													" +
       "               a.test_item,														" +
		 "	              a.test_times,													" +
		 "               '',																	" +
		 "               '',																	" +
		 "               '',																	" +
		 "               '',																	" +
		 "               ''																	" +
		 "          from v_test_plan a,													" +
		 "	              (select dept_code,												" +
		 "						       seq,														" +
		 "								 max(confirm_dt)										" +
		 "						  from v_test_plan_master									" +
		 "						 where confirm_section = 3		 							" +
		 "					 group by dept_code , seq 										" +
		 "												) b									" +
	    "          where a.dept_code = b.dept_code and								" +
		 "	               a.dept_code = '" + ls_dept_code + "' and				" +
	    "                a.seq = b.seq 													" +
	    "        )  ";             
       try
		{   
		  stmt = conn.prepareStatement(sSql);
		  gpstatement.gp_stmt = stmt;
		  stmt.executeUpdate();
		  stmt.close();
		}
		catch (Exception ex)
		{
			res.writeException("AA", "99999", "Query1 : " + ex.getMessage() + "\n쿼리:" + sSql);
		}
      
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update v_test_result_detail set " + 
                            "yymm=?,  " + 
                            "dept_code=?,  " + 
                            "d_seq=?,  " + 
                            "comm_wbs_code=?,  " + 
                            "test_item=?,  " + 
                            "test_plan=?,  " + 
                            "test_times=?,  " + 
                            "test_pass=?,  " + 
                            "test_fail=?,  " + 
                            "test_reexam=?,  " + 
                            "remark=?  where d_seq=? and yymm=? and dept_code=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_yymm);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_d_seq);
      gpstatement.bindColumn(4, idx_comm_wbs_code);
      gpstatement.bindColumn(5, idx_test_item);
      gpstatement.bindColumn(6, idx_test_plan);
      gpstatement.bindColumn(7, idx_test_times);
      gpstatement.bindColumn(8, idx_test_pass);
      gpstatement.bindColumn(9, idx_test_fail);
      gpstatement.bindColumn(10, idx_test_reexam);
      gpstatement.bindColumn(11, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(12, idx_d_seq);
      gpstatement.bindColumn(13, idx_yymm);
      gpstatement.bindColumn(14, idx_dept_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from v_test_result_detail where yymm=? and dept_code=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_yymm);
      gpstatement.bindColumn(2, idx_dept_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
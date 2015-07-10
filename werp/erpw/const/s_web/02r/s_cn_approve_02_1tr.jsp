<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_mssql_confirm_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_cn_approve_02_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_unq_num = dSet.indexOfColumn("unq_num");
   	int idx_amt_1 = dSet.indexOfColumn("amt_1");
   	int idx_exe_amt_1 = dSet.indexOfColumn("exe_amt_1");
   	int idx_sub_amt_1 = dSet.indexOfColumn("sub_amt_1");
   	int idx_amt_2 = dSet.indexOfColumn("amt_2");
   	int idx_exe_amt_2 = dSet.indexOfColumn("exe_amt_2");
   	int idx_sub_amt_2 = dSet.indexOfColumn("sub_amt_2");
   	int idx_amt_3 = dSet.indexOfColumn("amt_3");
   	int idx_exe_amt_3 = dSet.indexOfColumn("exe_amt_3");
   	int idx_sub_amt_3 = dSet.indexOfColumn("sub_amt_3");
   	int idx_subsum_amt = dSet.indexOfColumn("subsum_amt");
   	int idx_subsum_exeamt = dSet.indexOfColumn("subsum_exeamt");
   	int idx_subsum_subamt = dSet.indexOfColumn("subsum_subamt");
   	int idx_sum_amt = dSet.indexOfColumn("sum_amt");
   	int idx_sum_exeamt = dSet.indexOfColumn("sum_exeamt");
   	int idx_sum_subamt = dSet.indexOfColumn("sum_subamt");
   	int idx_a_1 = dSet.indexOfColumn("a_1");
   	int idx_b_1 = dSet.indexOfColumn("b_1");
   	int idx_c_1 = dSet.indexOfColumn("c_1");
   	int idx_a_2 = dSet.indexOfColumn("a_2");
   	int idx_b_2 = dSet.indexOfColumn("b_2");
   	int idx_c_2 = dSet.indexOfColumn("c_2");
   	int idx_sub_a = dSet.indexOfColumn("sub_a");
   	int idx_sub_b = dSet.indexOfColumn("sub_b");
   	int idx_sub_c = dSet.indexOfColumn("sub_c");
   	int idx_a_3 = dSet.indexOfColumn("a_3");
   	int idx_b_3 = dSet.indexOfColumn("b_3");
   	int idx_c_3 = dSet.indexOfColumn("c_3");
   	int idx_tot_a = dSet.indexOfColumn("tot_a");
   	int idx_tot_b = dSet.indexOfColumn("tot_b");
   	int idx_tot_c = dSet.indexOfColumn("tot_c");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_CN_APPROVE_02 ( unq_num," + 
                    "amt_1," + 
                    "exe_amt_1," + 
                    "sub_amt_1," + 
                    "amt_2," + 
                    "exe_amt_2," + 
                    "sub_amt_2," + 
                    "amt_3," + 
                    "exe_amt_3," + 
                    "sub_amt_3," + 
                    "subsum_amt," + 
                    "subsum_exeamt," + 
                    "subsum_subamt," + 
                    "sum_amt," + 
                    "sum_exeamt," + 
                    "sum_subamt," + 
                    "a_1," + 
                    "b_1," + 
                    "c_1," + 
                    "a_2," + 
                    "b_2," + 
                    "c_2," + 
                    "sub_a," + 
                    "sub_b," + 
                    "sub_c," + 
                    "a_3," + 
                    "b_3," + 
                    "c_3," + 
                    "tot_a," + 
                    "tot_b," + 
                    "tot_c )      ";
      sSql = sSql + " VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_unq_num);
      gpstatement.bindColumn(2, idx_amt_1);
      gpstatement.bindColumn(3, idx_exe_amt_1);
      gpstatement.bindColumn(4, idx_sub_amt_1);
      gpstatement.bindColumn(5, idx_amt_2);
      gpstatement.bindColumn(6, idx_exe_amt_2);
      gpstatement.bindColumn(7, idx_sub_amt_2);
      gpstatement.bindColumn(8, idx_amt_3);
      gpstatement.bindColumn(9, idx_exe_amt_3);
      gpstatement.bindColumn(10, idx_sub_amt_3);
      gpstatement.bindColumn(11, idx_subsum_amt);
      gpstatement.bindColumn(12, idx_subsum_exeamt);
      gpstatement.bindColumn(13, idx_subsum_subamt);
      gpstatement.bindColumn(14, idx_sum_amt);
      gpstatement.bindColumn(15, idx_sum_exeamt);
      gpstatement.bindColumn(16, idx_sum_subamt);
      gpstatement.bindColumn(17, idx_a_1);
      gpstatement.bindColumn(18, idx_b_1);
      gpstatement.bindColumn(19, idx_c_1);
      gpstatement.bindColumn(20, idx_a_2);
      gpstatement.bindColumn(21, idx_b_2);
      gpstatement.bindColumn(22, idx_c_2);
      gpstatement.bindColumn(23, idx_sub_a);
      gpstatement.bindColumn(24, idx_sub_b);
      gpstatement.bindColumn(25, idx_sub_c);
      gpstatement.bindColumn(26, idx_a_3);
      gpstatement.bindColumn(27, idx_b_3);
      gpstatement.bindColumn(28, idx_c_3);
      gpstatement.bindColumn(29, idx_tot_a);
      gpstatement.bindColumn(30, idx_tot_b);
      gpstatement.bindColumn(31, idx_tot_c);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
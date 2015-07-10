<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_gen_income_list_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_appl_date = dSet.indexOfColumn("appl_date");
   	int idx_in_co_div = dSet.indexOfColumn("in_co_div");
   	int idx_gen_income_code = dSet.indexOfColumn("gen_income_code");
   	int idx_cont = dSet.indexOfColumn("cont");
   	int idx_in_amt = dSet.indexOfColumn("in_amt");
   	int idx_co_amt = dSet.indexOfColumn("co_amt");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_gen_income_list ( comp_code," + 
                    "spec_no_seq," + 
                    "seq," + 
                    "appl_date," + 
                    "in_co_div," + 
                    "gen_income_code," + 
                    "cont," + 
                    "in_amt," + 
                    "co_amt," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_comp_code);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_appl_date);
      gpstatement.bindColumn(5, idx_in_co_div);
      gpstatement.bindColumn(6, idx_gen_income_code);
      gpstatement.bindColumn(7, idx_cont);
      gpstatement.bindColumn(8, idx_in_amt);
      gpstatement.bindColumn(9, idx_co_amt);
      gpstatement.bindColumn(10, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_gen_income_list set " + 
		                      "comp_code=?," + 
                            "spec_no_seq=?,  " + 
                            "seq=?,  " + 
                            "appl_date=?,  " + 
                            "in_co_div=?,  " + 
                            "gen_income_code=?,  " + 
                            "cont=?,  " + 
                            "in_amt=?,  " + 
                            "co_amt=?,  " + 
                            "remark=?  where comp_code=?  and spec_no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_comp_code);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_appl_date);
      gpstatement.bindColumn(5, idx_in_co_div);
      gpstatement.bindColumn(6, idx_gen_income_code);
      gpstatement.bindColumn(7, idx_cont);
      gpstatement.bindColumn(8, idx_in_amt);
      gpstatement.bindColumn(9, idx_co_amt);
      gpstatement.bindColumn(10, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(11, idx_comp_code);
      gpstatement.bindColumn(12, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_gen_income_list where comp_code=?  and spec_no_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_comp_code);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
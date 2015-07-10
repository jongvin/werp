<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("r_received_plan_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_received_plan_year = dSet.indexOfColumn("received_plan_year");
   	int idx_key_received_plan_year = dSet.indexOfColumn("key_received_plan_year");
   	int idx_no = dSet.indexOfColumn("no");
   	int idx_key_no = dSet.indexOfColumn("key_no");
   	int idx_const_name = dSet.indexOfColumn("const_name");
   	int idx_order_no = dSet.indexOfColumn("order_no");
   	int idx_const_tag = dSet.indexOfColumn("const_tag");
   	int idx_pq_tag = dSet.indexOfColumn("pq_tag");
   	int idx_receive_tag = dSet.indexOfColumn("receive_tag");
   	int idx_constkind_tag = dSet.indexOfColumn("constkind_tag");
   	int idx_masterdept_tag = dSet.indexOfColumn("masterdept_tag");
   	int idx_new_tag = dSet.indexOfColumn("new_tag");
   	int idx_received_plan_amt = dSet.indexOfColumn("received_plan_amt");
   	int idx_pre_profit_rate = dSet.indexOfColumn("pre_profit_rate");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_decision_yn = dSet.indexOfColumn("decision_yn");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO R_RECEIVED_YEAR_PLAN ( received_plan_year," + 
                    "no," + 
                    "const_name," + 
                    "order_no," + 
                    "const_tag," + 
                    "pq_tag," + 
                    "receive_tag," + 
                    "constkind_tag," + 
                    "masterdept_tag," + 
                    "new_tag," + 
                    "received_plan_amt," + 
						  "pre_profit_rate, " + 
                    "remark, " +
                    "decision_yn )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12 , :13, :14 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_received_plan_year) ;
      gpstatement.bindColumn(2, idx_no);
      gpstatement.bindColumn(3, idx_const_name);
      gpstatement.bindColumn(4, idx_order_no);
      gpstatement.bindColumn(5, idx_const_tag);
      gpstatement.bindColumn(6, idx_pq_tag);
      gpstatement.bindColumn(7, idx_receive_tag);
      gpstatement.bindColumn(8, idx_constkind_tag);
      gpstatement.bindColumn(9, idx_masterdept_tag);
      gpstatement.bindColumn(10, idx_new_tag);
      gpstatement.bindColumn(11, idx_received_plan_amt);
      gpstatement.bindColumn(12, idx_pre_profit_rate);
      gpstatement.bindColumn(13, idx_remark);
      gpstatement.bindColumn(14, idx_decision_yn);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update r_received_year_plan set " + 
                            "received_plan_year=?,  " + 
                            "no=?,  " + 
                            "const_name=?,  " + 
                            "order_no=?,  " + 
                            "const_tag=?,  " + 
                            "pq_tag=?,  " + 
                            "receive_tag=?,  " + 
                            "constkind_tag=?,  " + 
                            "masterdept_tag=?,  " + 
                            "new_tag=?,  " + 
                            "received_plan_amt=?,  " + 
									 "pre_profit_rate=? , " +
                            "remark=? , " +
                            "decision_yn=?  where masterdept_tag=?  and " + 
                            "received_plan_year=? " +
                            "            and no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_received_plan_year);
      gpstatement.bindColumn(2, idx_no);
      gpstatement.bindColumn(3, idx_const_name);
      gpstatement.bindColumn(4, idx_order_no);
      gpstatement.bindColumn(5, idx_const_tag);
      gpstatement.bindColumn(6, idx_pq_tag);
      gpstatement.bindColumn(7, idx_receive_tag);
      gpstatement.bindColumn(8, idx_constkind_tag);
      gpstatement.bindColumn(9, idx_masterdept_tag);
      gpstatement.bindColumn(10, idx_new_tag);
      gpstatement.bindColumn(11, idx_received_plan_amt);
      gpstatement.bindColumn(12, idx_pre_profit_rate);
      gpstatement.bindColumn(13, idx_remark);
      gpstatement.bindColumn(14, idx_decision_yn);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(15, idx_masterdept_tag);
      gpstatement.bindColumn(16, idx_key_received_plan_year);
      gpstatement.bindColumn(17, idx_key_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from r_received_year_plan where masterdept_tag=? and received_plan_year=? " +
      							"  and no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_masterdept_tag); 
      gpstatement.bindColumn(2, idx_key_received_plan_year);
      gpstatement.bindColumn(3, idx_key_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
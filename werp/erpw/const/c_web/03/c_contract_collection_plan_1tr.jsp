<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_contract_collection_plan_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_plan_date = dSet.indexOfColumn("plan_date");
   	int idx_extablish_time = dSet.indexOfColumn("extablish_time");
   	int idx_extablish_tag = dSet.indexOfColumn("extablish_tag");
   	int idx_cash_amt = dSet.indexOfColumn("cash_amt");
   	int idx_bill_amt = dSet.indexOfColumn("bill_amt");
   	int idx_collection_plan_amt = dSet.indexOfColumn("collection_plan_amt");
   	int idx_cash_date = dSet.indexOfColumn("cash_date");
   	int idx_bill_date = dSet.indexOfColumn("bill_date");
   	int idx_collection_cond = dSet.indexOfColumn("collection_cond");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_key_plan_date = dSet.indexOfColumn("key_plan_date");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO r_contract_collection_plan ( dept_code,     " + 
                    "        plan_date,                                       " + 
                    "        extablish_time,                                  " + 
                    "        extablish_tag,                                   " + 
                    "        cash_amt,                                        " + 
                    "        bill_amt,                                        " + 
                    "        collection_plan_amt,                             " + 
                    "        cash_date,                                       " + 
                    "        bill_date,                                       " + 
                    "        collection_cond,                                 " + 
                    "        remark )                                         ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_plan_date);
      gpstatement.bindColumn(3, idx_extablish_time);
      gpstatement.bindColumn(4, idx_extablish_tag);
      gpstatement.bindColumn(5, idx_cash_amt);
      gpstatement.bindColumn(6, idx_bill_amt);
      gpstatement.bindColumn(7, idx_collection_plan_amt);
      gpstatement.bindColumn(8, idx_cash_date);
      gpstatement.bindColumn(9, idx_bill_date);
      gpstatement.bindColumn(10, idx_collection_cond);
      gpstatement.bindColumn(11, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update r_contract_collection_plan set         " + 
                    "       dept_code=?,                           " + 
                    "       plan_date=?,                           " + 
                    "       extablish_time=?,                      " + 
                    "       extablish_tag=?,                       " + 
                    "       cash_amt=?,                            " + 
                    "       bill_amt=?,                            " + 
                    "       collection_plan_amt=?,                 " + 
                    "       cash_date=?,                           " + 
                    "       bill_date=?,                           " + 
                    "       collection_cond=?,                     " + 
                    "       remark=?  where dept_code=? and plan_date=?  ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_plan_date);
      gpstatement.bindColumn(3, idx_extablish_time);
      gpstatement.bindColumn(4, idx_extablish_tag);
      gpstatement.bindColumn(5, idx_cash_amt);
      gpstatement.bindColumn(6, idx_bill_amt);
      gpstatement.bindColumn(7, idx_collection_plan_amt);
      gpstatement.bindColumn(8, idx_cash_date);
      gpstatement.bindColumn(9, idx_bill_date);
      gpstatement.bindColumn(10, idx_collection_cond);
      gpstatement.bindColumn(11, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(12, idx_dept_code);
      gpstatement.bindColumn(13, idx_key_plan_date);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from r_contract_collection_plan where dept_code=? and plan_date=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_key_plan_date);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
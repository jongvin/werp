<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_mssql_confirm_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_request_list_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_unq_num = dSet.indexOfColumn("unq_num");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_requestseq = dSet.indexOfColumn("requestseq");
   	int idx_requestdate = dSet.indexOfColumn("requestdate");
   	int idx_long_name = dSet.indexOfColumn("long_name");
   	int idx_order_class = dSet.indexOfColumn("order_class");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_balsin = dSet.indexOfColumn("balsin");
   	int idx_ssize = dSet.indexOfColumn("ssize");
   	int idx_unitcode = dSet.indexOfColumn("unitcode");
   	int idx_bud_qty = dSet.indexOfColumn("bud_qty");
   	int idx_bud_price = dSet.indexOfColumn("bud_price");
   	int idx_bud_tot = dSet.indexOfColumn("bud_tot");
   	int idx_requiretime = dSet.indexOfColumn("requiretime");
   	int idx_pre_request_qty = dSet.indexOfColumn("pre_request_qty");
   	int idx_request_qty = dSet.indexOfColumn("request_qty");
   	int idx_tot_request_qty = dSet.indexOfColumn("tot_request_qty");
   	int idx_exe_amt = dSet.indexOfColumn("exe_amt");
   	int idx_proj_content = dSet.indexOfColumn("proj_content");
   	int idx_check_method = dSet.indexOfColumn("check_method");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_REQUEST_LIST ( unq_num," + 
                    "no_seq," + 
                    "requestseq," + 
                    "requestdate," + 
                    "long_name," + 
                    "order_class," + 
                    "name," + 
                    "balsin," + 
                    "ssize," + 
                    "unitcode," + 
                    "bud_qty," + 
                    "bud_price," + 
                    "bud_tot," + 
                    "requiretime," + 
                    "pre_request_qty," + 
                    "request_qty," + 
                    "tot_request_qty," + 
                    "exe_amt," + 
                    "proj_content," + 
                    "check_method )      ";
      sSql = sSql + " VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_unq_num);
      gpstatement.bindColumn(2, idx_no_seq);
      gpstatement.bindColumn(3, idx_requestseq);
      gpstatement.bindColumn(4, idx_requestdate);
      gpstatement.bindColumn(5, idx_long_name);
      gpstatement.bindColumn(6, idx_order_class);
      gpstatement.bindColumn(7, idx_name);
      gpstatement.bindColumn(8, idx_balsin);
      gpstatement.bindColumn(9, idx_ssize);
      gpstatement.bindColumn(10, idx_unitcode);
      gpstatement.bindColumn(11, idx_bud_qty);
      gpstatement.bindColumn(12, idx_bud_price);
      gpstatement.bindColumn(13, idx_bud_tot);
      gpstatement.bindColumn(14, idx_requiretime);
      gpstatement.bindColumn(15, idx_pre_request_qty);
      gpstatement.bindColumn(16, idx_request_qty);
      gpstatement.bindColumn(17, idx_tot_request_qty);
      gpstatement.bindColumn(18, idx_exe_amt);
      gpstatement.bindColumn(19, idx_proj_content);
      gpstatement.bindColumn(20, idx_check_method);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_request_list set " + 
                            "unq_num=?,  " + 
                            "no_seq=?,  " + 
                            "requestseq=?,  " + 
                            "requestdate=?,  " + 
                            "long_name=?,  " + 
                            "order_class=?,  " + 
                            "name=?,  " + 
                            "balsin=?,  " + 
                            "ssize=?,  " + 
                            "unitcode=?,  " + 
                            "bud_qty=?,  " + 
                            "bud_price=?,  " + 
                            "bud_tot=?,  " + 
                            "requiretime=?,  " + 
                            "pre_request_qty=?,  " + 
                            "request_qty=?,  " + 
                            "tot_request_qty=?,  " + 
                            "exe_amt=?,  " + 
                            "proj_content=?,  " + 
                            "check_method=?  where unq_num=? and no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_unq_num);
      gpstatement.bindColumn(2, idx_no_seq);
      gpstatement.bindColumn(3, idx_requestseq);
      gpstatement.bindColumn(4, idx_requestdate);
      gpstatement.bindColumn(5, idx_long_name);
      gpstatement.bindColumn(6, idx_order_class);
      gpstatement.bindColumn(7, idx_name);
      gpstatement.bindColumn(8, idx_balsin);
      gpstatement.bindColumn(9, idx_ssize);
      gpstatement.bindColumn(10, idx_unitcode);
      gpstatement.bindColumn(11, idx_bud_qty);
      gpstatement.bindColumn(12, idx_bud_price);
      gpstatement.bindColumn(13, idx_bud_tot);
      gpstatement.bindColumn(14, idx_requiretime);
      gpstatement.bindColumn(15, idx_pre_request_qty);
      gpstatement.bindColumn(16, idx_request_qty);
      gpstatement.bindColumn(17, idx_tot_request_qty);
      gpstatement.bindColumn(18, idx_exe_amt);
      gpstatement.bindColumn(19, idx_proj_content);
      gpstatement.bindColumn(20, idx_check_method);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(21, idx_unq_num);
      gpstatement.bindColumn(22, idx_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_request_list where unq_num=? and no_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_unq_num);
      gpstatement.bindColumn(2, idx_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
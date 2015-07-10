<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_subs_reg_winner_batch_1tr"); gpstatement.gp_dataset = dSet;
	int idx_unq_no = dSet.indexOfColumn("unq_no"); 
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_cust_code = dSet.indexOfColumn("cust_code");
   	int idx_cust_name = dSet.indexOfColumn("cust_name");
   	int idx_seq_no = dSet.indexOfColumn("seq_no");
   	int idx_subs_order = dSet.indexOfColumn("subs_order");
   	int idx_reg_no = dSet.indexOfColumn("reg_no");
   	int idx_subs_date = dSet.indexOfColumn("subs_date");
   	int idx_dong = dSet.indexOfColumn("dong");
   	int idx_ho = dSet.indexOfColumn("ho");
   	int idx_phone = dSet.indexOfColumn("phone");
   	int idx_bank = dSet.indexOfColumn("bank");
   	int idx_process = dSet.indexOfColumn("process");
	int idx_error_process = dSet.indexOfColumn("error_process");
	int idx_error_data = dSet.indexOfColumn("error_data");
	int idx_error_data_message = dSet.indexOfColumn("error_data_message");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_SUBS_REG_BATCH ( unq_no," + 
                    "dept_code," + 
                    "sell_code," + 
                    "cust_code," + 
                    "cust_name," + 
                    "seq_no," + 
                    "subs_order," + 
                    "reg_no," + 
                    "subs_date," + 
                    "dong," + 
                    "ho," + 
                    "phone," + 
                    "bank," +
			        "process," + 
		            "error_process," +
		            "error_data," +
		            "error_data_message )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_unq_no);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_sell_code);
      gpstatement.bindColumn(4, idx_cust_code);
      gpstatement.bindColumn(5, idx_cust_name);
      gpstatement.bindColumn(6, idx_seq_no);
      gpstatement.bindColumn(7, idx_subs_order);
      gpstatement.bindColumn(8, idx_reg_no);
      gpstatement.bindColumn(9, idx_subs_date);
      gpstatement.bindColumn(10, idx_dong);
      gpstatement.bindColumn(11, idx_ho);
      gpstatement.bindColumn(12, idx_phone);
      gpstatement.bindColumn(13, idx_bank);
	  gpstatement.bindColumn(14, idx_process);
	  gpstatement.bindColumn(15, idx_error_process);
	  gpstatement.bindColumn(16, idx_error_data);
	  gpstatement.bindColumn(17, idx_error_data_message);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_subs_reg_batch set " + 
                            "unq_no=?,  " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "cust_code=?,  " + 
                            "cust_name=?,  " + 
                            "seq_no=?,  " + 
                            "subs_order=?,  " + 
                            "reg_no=?,  " + 
                            "subs_date=?,  " + 
                            "dong=?,  " + 
                            "ho=?,  " + 
                            "phone=?,  " + 
                            "bank=?,  " + 
							"process=?, " + 
							"error_process=?, " + 
							"error_data=?, " + 
							"error_data_message=? where unq_no=? " +
                            "                  and dept_code=? " +
                            "                  and sell_code=? " +
						    "                  and cust_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_unq_no);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_sell_code);
      gpstatement.bindColumn(4, idx_cust_code);
      gpstatement.bindColumn(5, idx_cust_name);
      gpstatement.bindColumn(6, idx_seq_no);
      gpstatement.bindColumn(7, idx_subs_order);
      gpstatement.bindColumn(8, idx_reg_no);
      gpstatement.bindColumn(9, idx_subs_date);
      gpstatement.bindColumn(10, idx_dong);
      gpstatement.bindColumn(11, idx_ho);
      gpstatement.bindColumn(12, idx_phone);
      gpstatement.bindColumn(13, idx_bank);
	  gpstatement.bindColumn(14, idx_process);
	  gpstatement.bindColumn(15, idx_error_process);
	  gpstatement.bindColumn(16, idx_error_data);
	  gpstatement.bindColumn(17, idx_error_data_message);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(18, idx_unq_no);
      gpstatement.bindColumn(19, idx_dept_code);
      gpstatement.bindColumn(20, idx_sell_code);
      gpstatement.bindColumn(21, idx_cust_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_subs_reg_batch where unq_no=? " +
                            "                  and dept_code=? " +
                            "                  and sell_code=? " +
						    "                  and cust_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_unq_no);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_sell_code);
      gpstatement.bindColumn(4, idx_cust_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
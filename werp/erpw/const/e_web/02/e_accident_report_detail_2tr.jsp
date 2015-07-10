<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("e_accident_report_detail_2tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_d_seq = dSet.indexOfColumn("d_seq");
   	int idx_item_name = dSet.indexOfColumn("item_name");
   	int idx_item_size = dSet.indexOfColumn("item_size");
   	int idx_item_qty = dSet.indexOfColumn("item_qty");
   	int idx_item_price = dSet.indexOfColumn("item_price");
   	int idx_dis_amt = dSet.indexOfColumn("dis_amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO e_disaster_report_detail_item ( dept_code," + 
                    "seq," + 
                    "d_seq," + 
                    "item_name," + 
                    "item_size," + 
                    "item_qty," + 
                    "item_price," + 
                    "dis_amt )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_d_seq);
      gpstatement.bindColumn(4, idx_item_name);
      gpstatement.bindColumn(5, idx_item_size);
      gpstatement.bindColumn(6, idx_item_qty);
      gpstatement.bindColumn(7, idx_item_price);
      gpstatement.bindColumn(8, idx_dis_amt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update e_disaster_report_detail_item set " + 
                            "dept_code=?,  " + 
                            "seq=?,  " + 
                            "d_seq=?," + 
                    			 "item_name=?," + 
                    			 "item_size=?," + 
                    			 "item_qty=?," + 
                    			 "item_price=?," + 
                    			 "dis_amt=?  where dept_code=? and seq=? and d_seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_d_seq);
      gpstatement.bindColumn(4, idx_item_name);
      gpstatement.bindColumn(5, idx_item_size);
      gpstatement.bindColumn(6, idx_item_qty);
      gpstatement.bindColumn(7, idx_item_price);
      gpstatement.bindColumn(8, idx_dis_amt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
 		gpstatement.bindColumn(9, idx_dept_code);
 		gpstatement.bindColumn(10, idx_seq);
      gpstatement.bindColumn(11, idx_d_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from e_disaster_report_detail_item where dept_code=? and seq=? and d_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
 		gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_d_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
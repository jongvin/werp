<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("e_sa_eval_hq_monthly_pop_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymm = dSet.indexOfColumn("yymm");
   	int idx_part_code = dSet.indexOfColumn("part_code");
   	int idx_item_code = dSet.indexOfColumn("item_code");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_d_seq = dSet.indexOfColumn("d_seq");
   	int idx_contents = dSet.indexOfColumn("contents");
   	int idx_ol_point = dSet.indexOfColumn("ol_point");
   	int idx_select_type = dSet.indexOfColumn("select_type");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_order_number = dSet.indexOfColumn("order_number");
	 int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO e_comp_opinion_detail ( dept_code," + 
					  " yymm," + 
				      " part_code," + 
					  " item_code," + 
					  " seq," +
					  " d_seq," +
					  " contents,"+
					  " or_point," + 
					  " select_type," + 
					  " remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_part_code);
      gpstatement.bindColumn(4, idx_item_code);
      gpstatement.bindColumn(5, idx_seq);
      gpstatement.bindColumn(6, idx_d_seq);
      gpstatement.bindColumn(7, idx_contents);
      gpstatement.bindColumn(8, idx_ol_point);
      gpstatement.bindColumn(9, idx_select_type);
      gpstatement.bindColumn(10, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = " update e_comp_opinion_detail set " + 
                    " select_type=?," + 
                    " remark=?  where dept_code=? and yymm=? and item_code=? and seq=? "+ 
						  " and d_seq=? and order_number=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_select_type);
      gpstatement.bindColumn(2, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(3, idx_dept_code);
      gpstatement.bindColumn(4, idx_yymm);
      gpstatement.bindColumn(5, idx_item_code);
      gpstatement.bindColumn(6, idx_seq);
      gpstatement.bindColumn(7, idx_d_seq);
      gpstatement.bindColumn(8, idx_order_number);
		stmt.executeUpdate();
      stmt.close();
      
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from e_comp_opinion_detail  where dept_code=? and yymm=? and item_code=? and seq=? and d_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_item_code);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_d_seq);   
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
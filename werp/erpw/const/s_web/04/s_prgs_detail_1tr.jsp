<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_prgs_detail_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymm = dSet.indexOfColumn("yymm");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_order_number = dSet.indexOfColumn("order_number");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_detail_unq_num = dSet.indexOfColumn("detail_unq_num");
   	int idx_pre_prgs_qty = dSet.indexOfColumn("pre_prgs_qty");
   	int idx_pre_prgs_amt = dSet.indexOfColumn("pre_prgs_amt");
   	int idx_pre_prgs_rt = dSet.indexOfColumn("pre_prgs_rt");
   	int idx_tm_prgs_qty = dSet.indexOfColumn("tm_prgs_qty");
   	int idx_tm_prgs_amt = dSet.indexOfColumn("tm_prgs_amt");
   	int idx_tm_prgs_rt = dSet.indexOfColumn("tm_prgs_rt");
   	int idx_tot_prgs_qty = dSet.indexOfColumn("tot_prgs_qty");
   	int idx_tot_prgs_amt = dSet.indexOfColumn("tot_prgs_amt");
   	int idx_tot_prgs_rt = dSet.indexOfColumn("tot_prgs_rt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO s_prgs_detail ( dept_code," + 
                    "yymm," + 
                    "seq," + 
                    "order_number," + 
                    "spec_no_seq," + 
                    "detail_unq_num," + 
                    "pre_prgs_qty," + 
                    "pre_prgs_amt," + 
                    "pre_prgs_rt," + 
                    "tm_prgs_qty," + 
                    "tm_prgs_amt," + 
                    "tm_prgs_rt," + 
                    "tot_prgs_qty," + 
                    "tot_prgs_amt," + 
                    "tot_prgs_rt )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_order_number);
      gpstatement.bindColumn(5, idx_spec_no_seq);
      gpstatement.bindColumn(6, idx_detail_unq_num);
      gpstatement.bindColumn(7, idx_pre_prgs_qty);
      gpstatement.bindColumn(8, idx_pre_prgs_amt);
      gpstatement.bindColumn(9, idx_pre_prgs_rt);
      gpstatement.bindColumn(10, idx_tm_prgs_qty);
      gpstatement.bindColumn(11, idx_tm_prgs_amt);
      gpstatement.bindColumn(12, idx_tm_prgs_rt);
      gpstatement.bindColumn(13, idx_tot_prgs_qty);
      gpstatement.bindColumn(14, idx_tot_prgs_amt);
      gpstatement.bindColumn(15, idx_tot_prgs_rt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_prgs_detail set " + 
                            "dept_code=?,  " + 
                            "yymm=?,  " + 
                            "seq=?,  " + 
                            "order_number=?,  " + 
                            "spec_no_seq=?,  " + 
                            "detail_unq_num=?,  " + 
                            "pre_prgs_qty=?,  " + 
                            "pre_prgs_amt=?,  " + 
                            "pre_prgs_rt=?,  " + 
                            "tm_prgs_qty=?,  " + 
                            "tm_prgs_amt=?,  " + 
                            "tm_prgs_rt=?,  " + 
                            "tot_prgs_qty=?,  " + 
                            "tot_prgs_amt=?,  " + 
                            "tot_prgs_rt=?  where (dept_code=? and yymm=? and seq=? and order_number=? and spec_no_seq=? and detail_unq_num=?) ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_order_number);
      gpstatement.bindColumn(5, idx_spec_no_seq);
      gpstatement.bindColumn(6, idx_detail_unq_num);
      gpstatement.bindColumn(7, idx_pre_prgs_qty);
      gpstatement.bindColumn(8, idx_pre_prgs_amt);
      gpstatement.bindColumn(9, idx_pre_prgs_rt);
      gpstatement.bindColumn(10, idx_tm_prgs_qty);
      gpstatement.bindColumn(11, idx_tm_prgs_amt);
      gpstatement.bindColumn(12, idx_tm_prgs_rt);
      gpstatement.bindColumn(13, idx_tot_prgs_qty);
      gpstatement.bindColumn(14, idx_tot_prgs_amt);
      gpstatement.bindColumn(15, idx_tot_prgs_rt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(16, idx_dept_code);
      gpstatement.bindColumn(17, idx_yymm);
      gpstatement.bindColumn(18, idx_seq);
      gpstatement.bindColumn(19, idx_order_number);
      gpstatement.bindColumn(20, idx_spec_no_seq);
      gpstatement.bindColumn(21, idx_detail_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_prgs_detail where  (dept_code=? and yymm=? and seq=? and order_number=? and spec_no_seq=? and detail_unq_num=?) "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_order_number);
      gpstatement.bindColumn(5, idx_spec_no_seq);
      gpstatement.bindColumn(6, idx_detail_unq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
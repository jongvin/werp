<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_estimate_detail_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_order_number = dSet.indexOfColumn("order_number");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_detail_unq_num = dSet.indexOfColumn("detail_unq_num");
   	int idx_est_qty = dSet.indexOfColumn("est_qty");
   	int idx_est_price = dSet.indexOfColumn("est_price");
   	int idx_est_amt = dSet.indexOfColumn("est_amt");
   	int idx_ctrl_qty = dSet.indexOfColumn("ctrl_qty");
   	int idx_ctrl_price = dSet.indexOfColumn("ctrl_price");
   	int idx_ctrl_amt = dSet.indexOfColumn("ctrl_amt");
   	int idx_emat_price = dSet.indexOfColumn("emat_price");
   	int idx_emat_amt = dSet.indexOfColumn("emat_amt");
   	int idx_elab_price = dSet.indexOfColumn("elab_price");
   	int idx_elab_amt = dSet.indexOfColumn("elab_amt");
   	int idx_eexp_price = dSet.indexOfColumn("eexp_price");
   	int idx_eexp_amt = dSet.indexOfColumn("eexp_amt");
   	int idx_cmat_price = dSet.indexOfColumn("cmat_price");
   	int idx_cmat_amt = dSet.indexOfColumn("cmat_amt");
   	int idx_clab_price = dSet.indexOfColumn("clab_price");
   	int idx_clab_amt = dSet.indexOfColumn("clab_amt");
   	int idx_cexp_price = dSet.indexOfColumn("cexp_price");
   	int idx_cexp_amt = dSet.indexOfColumn("cexp_amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO s_estimate_detail ( dept_code," + 
                    "order_number," + 
                    "sbcr_code," + 
                    "spec_no_seq," + 
                    "detail_unq_num," + 
                    "est_qty," + 
                    "est_price," + 
                    "est_amt," + 
                    "ctrl_qty," + 
                    "ctrl_price," + 
                    "ctrl_amt," + 
                    "emat_price," + 
                    "emat_amt," + 
                    "elab_price," + 
                    "elab_amt," + 
                    "eexp_price," + 
                    "eexp_amt," + 
                    "cmat_price," + 
                    "cmat_amt," + 
                    "clab_price," + 
                    "clab_amt," + 
                    "cexp_price," + 
                    "cexp_amt )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_sbcr_code);
      gpstatement.bindColumn(4, idx_spec_no_seq);
      gpstatement.bindColumn(5, idx_detail_unq_num);
      gpstatement.bindColumn(6, idx_est_qty);
      gpstatement.bindColumn(7, idx_est_price);
      gpstatement.bindColumn(8, idx_est_amt);
      gpstatement.bindColumn(9, idx_ctrl_qty);
      gpstatement.bindColumn(10, idx_ctrl_price);
      gpstatement.bindColumn(11, idx_ctrl_amt);
      gpstatement.bindColumn(12, idx_emat_price);
      gpstatement.bindColumn(13, idx_emat_amt);
      gpstatement.bindColumn(14, idx_elab_price);
      gpstatement.bindColumn(15, idx_elab_amt);
      gpstatement.bindColumn(16, idx_eexp_price);
      gpstatement.bindColumn(17, idx_eexp_amt);
      gpstatement.bindColumn(18, idx_cmat_price);
      gpstatement.bindColumn(19, idx_cmat_amt);
      gpstatement.bindColumn(20, idx_clab_price);
      gpstatement.bindColumn(21, idx_clab_amt);
      gpstatement.bindColumn(22, idx_cexp_price);
      gpstatement.bindColumn(23, idx_cexp_amt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_estimate_detail set " + 
                            "dept_code=?,  " + 
                            "order_number=?,  " + 
                            "sbcr_code=?,  " + 
                            "spec_no_seq=?,  " + 
                            "detail_unq_num=?,  " + 
                            "est_qty=?,  " + 
                            "est_price=?,  " + 
                            "est_amt=?,  " + 
                            "ctrl_qty=?,  " + 
                            "ctrl_price=?,  " + 
                            "ctrl_amt=?,  " + 
                            "emat_price=?,  " + 
                            "emat_amt=?,  " + 
                            "elab_price=?,  " + 
                            "elab_amt=?,  " + 
                            "eexp_price=?,  " + 
                            "eexp_amt=?,  " + 
                            "cmat_price=?,  " + 
                            "cmat_amt=?,  " + 
                            "clab_price=?,  " + 
                            "clab_amt=?,  " + 
                            "cexp_price=?,  " + 
                            "cexp_amt=?  where (dept_code=? and order_number=? and sbcr_code=? and spec_no_seq=? and detail_unq_num=?)";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_sbcr_code);
      gpstatement.bindColumn(4, idx_spec_no_seq);
      gpstatement.bindColumn(5, idx_detail_unq_num);
      gpstatement.bindColumn(6, idx_est_qty);
      gpstatement.bindColumn(7, idx_est_price);
      gpstatement.bindColumn(8, idx_est_amt);
      gpstatement.bindColumn(9, idx_ctrl_qty);
      gpstatement.bindColumn(10, idx_ctrl_price);
      gpstatement.bindColumn(11, idx_ctrl_amt);
      gpstatement.bindColumn(12, idx_emat_price);
      gpstatement.bindColumn(13, idx_emat_amt);
      gpstatement.bindColumn(14, idx_elab_price);
      gpstatement.bindColumn(15, idx_elab_amt);
      gpstatement.bindColumn(16, idx_eexp_price);
      gpstatement.bindColumn(17, idx_eexp_amt);
      gpstatement.bindColumn(18, idx_cmat_price);
      gpstatement.bindColumn(19, idx_cmat_amt);
      gpstatement.bindColumn(20, idx_clab_price);
      gpstatement.bindColumn(21, idx_clab_amt);
      gpstatement.bindColumn(22, idx_cexp_price);
      gpstatement.bindColumn(23, idx_cexp_amt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(24, idx_dept_code);
      gpstatement.bindColumn(25, idx_order_number);
      gpstatement.bindColumn(26, idx_sbcr_code);
      gpstatement.bindColumn(27, idx_spec_no_seq);
      gpstatement.bindColumn(28, idx_detail_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_estimate_detail where (dept_code=? and order_number=? and sbcr_code=? and spec_no_seq=? and detail_unq_num=?) "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_sbcr_code);
      gpstatement.bindColumn(4, idx_spec_no_seq);
      gpstatement.bindColumn(5, idx_detail_unq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
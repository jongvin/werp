<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_subs_master_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_subs_no = dSet.indexOfColumn("subs_no");
   	int idx_cust_code = dSet.indexOfColumn("cust_code");
   	int idx_spouse_rrn = dSet.indexOfColumn("spouse_rrn");
   	int idx_spouse_name = dSet.indexOfColumn("spouse_name");
   	int idx_pyong = dSet.indexOfColumn("pyong");
   	int idx_style = dSet.indexOfColumn("style");
   	int idx_classify = dSet.indexOfColumn("classify");
   	int idx_class = dSet.indexOfColumn("class");
   	int idx_subs_date = dSet.indexOfColumn("subs_date");
   	int idx_subs_order = dSet.indexOfColumn("subs_order");
   	int idx_deposit_no = dSet.indexOfColumn("deposit_no");
   	int idx_subs_amt = dSet.indexOfColumn("subs_amt");
   	int idx_bank_head_code = dSet.indexOfColumn("bank_head_code");
   	int idx_refund_deposit_no = dSet.indexOfColumn("refund_deposit_no");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_preparation_order = dSet.indexOfColumn("preparation_order");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_subs_master ( dept_code," + 
                    "sell_code," + 
                    "subs_no," + 
                    "cust_code," + 
                    "spouse_rrn," + 
                    "spouse_name," + 
                    "pyong," + 
                    "style," + 
                    "classify," + 
                    "class," + 
                    "subs_date," + 
                    "subs_order," + 
                    "deposit_no," + 
                    "subs_amt," + 
                    "bank_head_code," + 
                    "refund_deposit_no," + 
                    "remark , " +
                    "preparation_order)      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_subs_no);
      gpstatement.bindColumn(4, idx_cust_code);
      gpstatement.bindColumn(5, idx_spouse_rrn);
      gpstatement.bindColumn(6, idx_spouse_name);
      gpstatement.bindColumn(7, idx_pyong);
      gpstatement.bindColumn(8, idx_style);
      gpstatement.bindColumn(9, idx_classify);
      gpstatement.bindColumn(10, idx_class);
      gpstatement.bindColumn(11, idx_subs_date);
      gpstatement.bindColumn(12, idx_subs_order);
      gpstatement.bindColumn(13, idx_deposit_no);
      gpstatement.bindColumn(14, idx_subs_amt);
      gpstatement.bindColumn(15, idx_bank_head_code);
      gpstatement.bindColumn(16, idx_refund_deposit_no);
      gpstatement.bindColumn(17, idx_remark);
      gpstatement.bindColumn(18, idx_preparation_order);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_subs_master set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "subs_no=?,  " + 
                            "cust_code=?,  " + 
                            "spouse_rrn=?,  " + 
                            "spouse_name=?,  " + 
                            "pyong=?,  " + 
                            "style=?,  " + 
                            "classify=?,  " + 
                            "class=?,  " + 
                            "subs_date=?,  " + 
                            "subs_order=?,  " + 
                            "deposit_no=?,  " + 
                            "subs_amt=?,  " + 
                            "bank_head_code=?,  " + 
                            "refund_deposit_no=?,  " + 
                            "remark=?  where dept_code=? and sell_code=? and subs_no=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_subs_no);
      gpstatement.bindColumn(4, idx_cust_code);
      gpstatement.bindColumn(5, idx_spouse_rrn);
      gpstatement.bindColumn(6, idx_spouse_name);
      gpstatement.bindColumn(7, idx_pyong);
      gpstatement.bindColumn(8, idx_style);
      gpstatement.bindColumn(9, idx_classify);
      gpstatement.bindColumn(10, idx_class);
      gpstatement.bindColumn(11, idx_subs_date);
      gpstatement.bindColumn(12, idx_subs_order);
      gpstatement.bindColumn(13, idx_deposit_no);
      gpstatement.bindColumn(14, idx_subs_amt);
      gpstatement.bindColumn(15, idx_bank_head_code);
      gpstatement.bindColumn(16, idx_refund_deposit_no);
      gpstatement.bindColumn(17, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(18, idx_dept_code);
      gpstatement.bindColumn(19, idx_sell_code);
      gpstatement.bindColumn(20, idx_subs_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_subs_master where dept_code=? and sell_code=? and subs_no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_subs_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
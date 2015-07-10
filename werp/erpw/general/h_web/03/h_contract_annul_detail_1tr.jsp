<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_contract_annul_detail_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_dongho = dSet.indexOfColumn("dongho");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_detail_seq = dSet.indexOfColumn("detail_seq");
   	int idx_ap_cust_code = dSet.indexOfColumn("ap_cust_code");
   	int idx_ap_cust_name = dSet.indexOfColumn("ap_cust_name");
   	int idx_ap_cust_div = dSet.indexOfColumn("ap_cust_div");
   	int idx_ap_pay_amt = dSet.indexOfColumn("ap_pay_amt");
   	int idx_col1 = dSet.indexOfColumn("col1");
   	int idx_col2 = dSet.indexOfColumn("col2");
   	int idx_col3 = dSet.indexOfColumn("col3");
   	int idx_date1 = dSet.indexOfColumn("date1");
   	int idx_date2 = dSet.indexOfColumn("date2");
   	int idx_num1 = dSet.indexOfColumn("num1");
   	int idx_num2 = dSet.indexOfColumn("num2");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_SALE_ANNUL_DETAIL ( dept_code," + 
                    "sell_code," + 
                    "dongho," + 
                    "seq," + 
                    "detail_seq," + 
                    "ap_cust_code," + 
                    "ap_cust_name," + 
                    "ap_cust_div," + 
                    "ap_pay_amt," + 
                    "col1," + 
                    "col2," + 
                    "col3," + 
                    "date1," + 
                    "date2," + 
                    "num1," + 
                    "num2 )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, (SELECT nvl(MAX(detail_seq),0) +1 FROM H_SALE_annul_detail WHERE dept_code = :5 AND sell_code = :6 and dongho=:7 and seq=:8),  :9, :10, :11, :12, :13, :14, :15, :16, :17,:18,:19 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
		gpstatement.bindColumn(5, idx_dept_code);
      gpstatement.bindColumn(6, idx_sell_code);
      gpstatement.bindColumn(7, idx_dongho);
      gpstatement.bindColumn(8, idx_seq);

      //gpstatement.bindColumn(5, idx_detail_seq);
      gpstatement.bindColumn(9, idx_ap_cust_code);
      gpstatement.bindColumn(10, idx_ap_cust_name);
      gpstatement.bindColumn(11, idx_ap_cust_div);
      gpstatement.bindColumn(12, idx_ap_pay_amt);
      gpstatement.bindColumn(13, idx_col1);
      gpstatement.bindColumn(14, idx_col2);
      gpstatement.bindColumn(15, idx_col3);
      gpstatement.bindColumn(16, idx_date1);
      gpstatement.bindColumn(17, idx_date2);
      gpstatement.bindColumn(18, idx_num1);
      gpstatement.bindColumn(19, idx_num2);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_sale_annul_detail set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "dongho=?,  " + 
                            "seq=?,  " + 
	                          "detail_seq=?,"+
                            "ap_cust_code=?,  " + 
                            "ap_cust_name=?,  " + 
                            "ap_cust_div=?,  " + 
                            "ap_pay_amt=?,  " + 
                            "col1=?,  " + 
                            "col2=?,  " + 
                            "col3=?,  " + 
                            "date1=?,  " + 
                            "date2=?,  " + 
                            "num1=?,  " + 
                            "num2=?  where dept_code=? and sell_code=? and dongho=? and seq=? and detail_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
		gpstatement.bindColumn(5, idx_detail_seq);
      gpstatement.bindColumn(6, idx_ap_cust_code);
      gpstatement.bindColumn(7, idx_ap_cust_name);
      gpstatement.bindColumn(8, idx_ap_cust_div);
      gpstatement.bindColumn(9, idx_ap_pay_amt);
      gpstatement.bindColumn(10, idx_col1);
      gpstatement.bindColumn(11, idx_col2);
      gpstatement.bindColumn(12, idx_col3);
      gpstatement.bindColumn(13, idx_date1);
      gpstatement.bindColumn(14, idx_date2);
      gpstatement.bindColumn(15, idx_num1);
      gpstatement.bindColumn(16, idx_num2);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(17, idx_dept_code);
      gpstatement.bindColumn(18, idx_sell_code);
      gpstatement.bindColumn(19, idx_dongho);
      gpstatement.bindColumn(20, idx_seq);
      gpstatement.bindColumn(21, idx_detail_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_sale_annul_detail where dept_code=? and sell_code=? and dongho=? and seq=? and detail_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_detail_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
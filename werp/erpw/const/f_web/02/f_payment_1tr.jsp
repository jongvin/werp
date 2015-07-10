<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("f_payment_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_pay_date = dSet.indexOfColumn("pay_date");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_res_type = dSet.indexOfColumn("res_type");
   	int idx_pay_detail = dSet.indexOfColumn("pay_detail");
   	int idx_cust_code = dSet.indexOfColumn("cust_code");
   	int idx_cust_name = dSet.indexOfColumn("cust_name");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_vat = dSet.indexOfColumn("vat");
   	int idx_fund_type = dSet.indexOfColumn("fund_type");
   	int idx_key_pay_date = dSet.indexOfColumn("key_pay_date");
   	int idx_key_seq = dSet.indexOfColumn("key_seq");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO F_PAYMENT ( dept_code," + 
                    "pay_date," + 
                    "seq," + 
                    "res_type," + 
                    "pay_detail," + 
                    "cust_code," + 
                    "cust_name," + 
                    "amt," + 
                    "vat," + 
                    "fund_type )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_pay_date);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_res_type);
      gpstatement.bindColumn(5, idx_pay_detail);
      gpstatement.bindColumn(6, idx_cust_code);
      gpstatement.bindColumn(7, idx_cust_name);
      gpstatement.bindColumn(8, idx_amt);
      gpstatement.bindColumn(9, idx_vat);
      gpstatement.bindColumn(10, idx_fund_type);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update f_payment set " + 
                            "dept_code=?,  " + 
                            "pay_date=?,  " + 
                            "seq=?,  " + 
                            "res_type=?,  " + 
                            "pay_detail=?,  " + 
                            "cust_code=?,  " + 
                            "cust_name=?,  " + 
                            "amt=?,  " + 
                            "vat=?,  " + 
                            "fund_type=?  where dept_code=? "+
                            " and pay_date=?  " + 
                            " and seq=?  ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_pay_date);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_res_type);
      gpstatement.bindColumn(5, idx_pay_detail);
      gpstatement.bindColumn(6, idx_cust_code);
      gpstatement.bindColumn(7, idx_cust_name);
      gpstatement.bindColumn(8, idx_amt);
      gpstatement.bindColumn(9, idx_vat);
      gpstatement.bindColumn(10, idx_fund_type);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(11, idx_dept_code);
      gpstatement.bindColumn(12, idx_key_pay_date);
      gpstatement.bindColumn(13, idx_key_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from f_payment where dept_code=? " +
                            " and pay_date=?  " + 
                            " and seq=?  ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_pay_date);
      gpstatement.bindColumn(3, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_contract_detail_2tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_dongho = dSet.indexOfColumn("dongho");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_pyong = dSet.indexOfColumn("pyong");
   	int idx_opt_name = dSet.indexOfColumn("opt_name");
   	int idx_opt_base = dSet.indexOfColumn("opt_base");
   	int idx_opt_finish = dSet.indexOfColumn("opt_finish");
   	int idx_opt_ref = dSet.indexOfColumn("opt_ref");
   	int idx_contract_date = dSet.indexOfColumn("contract_date");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_amt_vat = dSet.indexOfColumn("amt_vat");
   	int idx_norm_prem_tag = dSet.indexOfColumn("norm_prem_tag");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_sale_ontime_master ( dept_code," + 
                    "sell_code," + 
                    "dongho," + 
                    "seq," + 
                    "pyong," + 
                    "opt_name," + 
                    "opt_base," + 
                    "opt_finish," + 
                    "opt_ref," + 
                    "contract_date," + 
                    "amt," + 
                    "amt_vat," + 
                    "norm_prem_tag," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_pyong);
      gpstatement.bindColumn(6, idx_opt_name);
      gpstatement.bindColumn(7, idx_opt_base);
      gpstatement.bindColumn(8, idx_opt_finish);
      gpstatement.bindColumn(9, idx_opt_ref);
      gpstatement.bindColumn(10, idx_contract_date);
      gpstatement.bindColumn(11, idx_amt);
      gpstatement.bindColumn(12, idx_amt_vat);
      gpstatement.bindColumn(13, idx_norm_prem_tag);
      gpstatement.bindColumn(14, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_sale_ontime_master set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "dongho=?,  " + 
                            "seq=?,  " + 
                            "pyong=?,  " + 
                            "opt_name=?,  " + 
                            "opt_base=?,  " + 
                            "opt_finish=?,  " + 
                            "opt_ref=?,  " + 
                            "contract_date=?,  " + 
                            "amt=?,  " + 
                            "amt_vat=?,  " + 
                            "norm_prem_tag=?,  " + 
                            "remark=?  where dept_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_pyong);
      gpstatement.bindColumn(6, idx_opt_name);
      gpstatement.bindColumn(7, idx_opt_base);
      gpstatement.bindColumn(8, idx_opt_finish);
      gpstatement.bindColumn(9, idx_opt_ref);
      gpstatement.bindColumn(10, idx_contract_date);
      gpstatement.bindColumn(11, idx_amt);
      gpstatement.bindColumn(12, idx_amt_vat);
      gpstatement.bindColumn(13, idx_norm_prem_tag);
      gpstatement.bindColumn(14, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(15, idx_dept_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_sale_ontime_master where dept_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_base_pyong_detail_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
   	int idx_degree_code = dSet.indexOfColumn("degree_code");
   	int idx_key_degree_code = dSet.indexOfColumn("key_degree_code");
   	int idx_agree_date = dSet.indexOfColumn("agree_date");
   	int idx_land_amt = dSet.indexOfColumn("land_amt");
   	int idx_build_amt = dSet.indexOfColumn("build_amt");
   	int idx_vat_amt = dSet.indexOfColumn("vat_amt");
   	int idx_sell_amt = dSet.indexOfColumn("sell_amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_BASE_PYONG_DETAIL ( dept_code," + 
                    "sell_code," + 
                    "spec_unq_num," + 
                    "degree_code," + 
                    "agree_date," + 
                    "land_amt," + 
                    "build_amt," + 
                    "vat_amt," + 
                    "sell_amt )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_spec_unq_num);
      gpstatement.bindColumn(4, idx_degree_code);
      gpstatement.bindColumn(5, idx_agree_date);
      gpstatement.bindColumn(6, idx_land_amt);
      gpstatement.bindColumn(7, idx_build_amt);
      gpstatement.bindColumn(8, idx_vat_amt);
      gpstatement.bindColumn(9, idx_sell_amt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_base_pyong_detail set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "spec_unq_num=?,  " + 
                            "degree_code=?,  " + 
                            "agree_date=?,  " + 
                            "land_amt=?,  " + 
                            "build_amt=?,  " + 
                            "vat_amt=?,  " + 
                            "sell_amt=?  where dept_code=? " +
                            "              and sell_code=? " +
                            "              and spec_unq_num=? " +
                            "              and degree_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_spec_unq_num);
      gpstatement.bindColumn(4, idx_degree_code);
      gpstatement.bindColumn(5, idx_agree_date);
      gpstatement.bindColumn(6, idx_land_amt);
      gpstatement.bindColumn(7, idx_build_amt);
      gpstatement.bindColumn(8, idx_vat_amt);
      gpstatement.bindColumn(9, idx_sell_amt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(10, idx_dept_code);
      gpstatement.bindColumn(11, idx_sell_code);
      gpstatement.bindColumn(12, idx_spec_unq_num);
      gpstatement.bindColumn(13, idx_key_degree_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_base_pyong_detail where dept_code=? " +
                            "              and sell_code=? " +
                            "              and spec_unq_num=? " +
                            "              and degree_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_spec_unq_num);
      gpstatement.bindColumn(4, idx_key_degree_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
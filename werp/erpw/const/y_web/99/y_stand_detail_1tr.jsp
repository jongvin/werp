<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("y_stand_detail_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_high_detail_code = dSet.indexOfColumn("high_detail_code");
   	int idx_detail_code = dSet.indexOfColumn("detail_code");
   	int idx_res_class = dSet.indexOfColumn("res_class");
   	int idx_mat_code = dSet.indexOfColumn("mat_code");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_ssize = dSet.indexOfColumn("ssize");
   	int idx_unit = dSet.indexOfColumn("unit");
   	int idx_mat_price = dSet.indexOfColumn("mat_price");
   	int idx_lab_price = dSet.indexOfColumn("lab_price");
   	int idx_exp_price = dSet.indexOfColumn("exp_price");
   	int idx_equ_price = dSet.indexOfColumn("equ_price");
   	int idx_sub_price = dSet.indexOfColumn("sub_price");
   	int idx_name_key = dSet.indexOfColumn("name_key");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_old_detail_code = dSet.indexOfColumn("old_detail_code");
	int idx_limit_budget_yn = dSet.indexOfColumn("limit_budget_yn");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO y_stand_detail ( high_detail_code," + 
                    "detail_code," + 
                    "res_class," + 
                    "mat_code," + 
                    "name," + 
                    "ssize," + 
                    "unit," + 
                    "mat_price," + 
                    "lab_price," + 
                    "exp_price," + 
                    "equ_price," + 
                    "sub_price," + 
                    "name_key," + 
                    "remark, "+
				    "limit_budget_yn)      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_high_detail_code);
      gpstatement.bindColumn(2, idx_detail_code);
      gpstatement.bindColumn(3, idx_res_class);
      gpstatement.bindColumn(4, idx_mat_code);
      gpstatement.bindColumn(5, idx_name);
      gpstatement.bindColumn(6, idx_ssize);
      gpstatement.bindColumn(7, idx_unit);
      gpstatement.bindColumn(8, idx_mat_price);
      gpstatement.bindColumn(9, idx_lab_price);
      gpstatement.bindColumn(10, idx_exp_price);
      gpstatement.bindColumn(11, idx_equ_price);
      gpstatement.bindColumn(12, idx_sub_price);
      gpstatement.bindColumn(13, idx_name_key);
      gpstatement.bindColumn(14, idx_remark);
	  gpstatement.bindColumn(15, idx_limit_budget_yn);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update y_stand_detail set " + 
                            "high_detail_code=?,  " + 
                            "detail_code=?,  " + 
                            "res_class=?,  " + 
                            "mat_code=?,  " + 
                            "name=?,  " + 
                            "ssize=?,  " + 
                            "unit=?,  " + 
                            "mat_price=?,  " + 
                            "lab_price=?,  " + 
                            "exp_price=?,  " + 
                            "equ_price=?,  " + 
                            "sub_price=?,  " + 
                            "name_key=?,  " + 
                            "remark=?, limit_budget_yn=?  where (high_detail_code=? and detail_code=?)";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_high_detail_code);
      gpstatement.bindColumn(2, idx_detail_code);
      gpstatement.bindColumn(3, idx_res_class);
      gpstatement.bindColumn(4, idx_mat_code);
      gpstatement.bindColumn(5, idx_name);
      gpstatement.bindColumn(6, idx_ssize);
      gpstatement.bindColumn(7, idx_unit);
      gpstatement.bindColumn(8, idx_mat_price);
      gpstatement.bindColumn(9, idx_lab_price);
      gpstatement.bindColumn(10, idx_exp_price);
      gpstatement.bindColumn(11, idx_equ_price);
      gpstatement.bindColumn(12, idx_sub_price);
      gpstatement.bindColumn(13, idx_name_key);
      gpstatement.bindColumn(14, idx_remark);
	  gpstatement.bindColumn(15, idx_limit_budget_yn);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(16, idx_high_detail_code);
      gpstatement.bindColumn(17, idx_old_detail_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from y_stand_detail where (high_detail_code=? and detail_code=?)"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_high_detail_code);
      gpstatement.bindColumn(2, idx_old_detail_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
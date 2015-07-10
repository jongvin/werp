<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_estimate_detail_excel_temp_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_unq_num = dSet.indexOfColumn("unq_num");
   	int idx_detail_unq_num = dSet.indexOfColumn("detail_unq_num");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_ssize = dSet.indexOfColumn("ssize");
   	int idx_unit = dSet.indexOfColumn("unit");
   	int idx_est_qty = dSet.indexOfColumn("est_qty");
   	int idx_emat_price = dSet.indexOfColumn("emat_price");
   	int idx_emat_amt = dSet.indexOfColumn("emat_amt");
   	int idx_elab_price = dSet.indexOfColumn("elab_price");
   	int idx_elab_amt = dSet.indexOfColumn("elab_amt");
   	int idx_eexp_price = dSet.indexOfColumn("eexp_price");
   	int idx_eexp_amt = dSet.indexOfColumn("eexp_amt");
   	int idx_est_price = dSet.indexOfColumn("est_price");
   	int idx_est_amt = dSet.indexOfColumn("est_amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_ESTIMATE_TEMP ( dept_code," + 
                    "detail_unq_num," + 
                    "name," + 
                    "ssize," + 
                    "unit," + 
                    "est_qty," + 
                    "emat_price," + 
                    "emat_amt," + 
                    "elab_price," + 
                    "elab_amt," + 
                    "eexp_price," + 
                    "eexp_amt," + 
                    "est_price," + 
                    "est_amt,unq_num )      ";
      sSql = sSql + " VALUES ( :1, replace(:2,',',''), :3, :4, :5, replace(:6,',',''), replace(:7,',',''), replace(:8,',',''), replace(:9,',',''), replace(:10,',',''), replace(:11,',',''), replace(:12,',',''), replace(:13,',',''), replace(:14,',',''),:15 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_detail_unq_num);
      gpstatement.bindColumn(3, idx_name);
      gpstatement.bindColumn(4, idx_ssize);
      gpstatement.bindColumn(5, idx_unit);
      gpstatement.bindColumn(6, idx_est_qty);
      gpstatement.bindColumn(7, idx_emat_price);
      gpstatement.bindColumn(8, idx_emat_amt);
      gpstatement.bindColumn(9, idx_elab_price);
      gpstatement.bindColumn(10, idx_elab_amt);
      gpstatement.bindColumn(11, idx_eexp_price);
      gpstatement.bindColumn(12, idx_eexp_amt);
      gpstatement.bindColumn(13, idx_est_price);
      gpstatement.bindColumn(14, idx_est_amt);
      gpstatement.bindColumn(15, idx_unq_num);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_estimate_temp set " + 
                            "dept_code=?,  " + 
                            "detail_unq_num=?,  " + 
                            "name=?,  " + 
                            "ssize=?,  " + 
                            "unit=?,  " + 
                            "est_qty=?,  " + 
                            "emat_price=?,  " + 
                            "emat_amt=?,  " + 
                            "elab_price=?,  " + 
                            "elab_amt=?,  " + 
                            "eexp_price=?,  " + 
                            "eexp_amt=?,  " + 
                            "est_price=?,  " + 
                            "est_amt=?,unq_num=?  where dept_code=? " +
                            "             and unq_num=? " +
                            "             and detail_unq_num=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_detail_unq_num);
      gpstatement.bindColumn(3, idx_name);
      gpstatement.bindColumn(4, idx_ssize);
      gpstatement.bindColumn(5, idx_unit);
      gpstatement.bindColumn(6, idx_est_qty);
      gpstatement.bindColumn(7, idx_emat_price);
      gpstatement.bindColumn(8, idx_emat_amt);
      gpstatement.bindColumn(9, idx_elab_price);
      gpstatement.bindColumn(10, idx_elab_amt);
      gpstatement.bindColumn(11, idx_eexp_price);
      gpstatement.bindColumn(12, idx_eexp_amt);
      gpstatement.bindColumn(13, idx_est_price);
      gpstatement.bindColumn(14, idx_est_amt);
      gpstatement.bindColumn(15, idx_unq_num);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(16, idx_dept_code);
      gpstatement.bindColumn(17, idx_unq_num);
      gpstatement.bindColumn(18, idx_detail_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_estimate_temp where dept_code=? " +
                            "             and unq_num=? " +
                    "                              and detail_unq_num=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_unq_num);
      gpstatement.bindColumn(3, idx_detail_unq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
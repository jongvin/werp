<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("y_projmng_amt_detail_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_wbs_code = dSet.indexOfColumn("wbs_code");
   	int idx_detail_code = dSet.indexOfColumn("detail_code");
   	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_ssize = dSet.indexOfColumn("ssize");
   	int idx_unit = dSet.indexOfColumn("unit");
   	int idx_qty = dSet.indexOfColumn("qty");
   	int idx_persion_qty = dSet.indexOfColumn("persion_qty");
   	int idx_month_qty = dSet.indexOfColumn("month_qty");
   	int idx_day_qty = dSet.indexOfColumn("day_qty");
   	int idx_price = dSet.indexOfColumn("price");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_acntcode = dSet.indexOfColumn("acntcode");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_input_dt = dSet.indexOfColumn("input_dt");
   	int idx_input_name = dSet.indexOfColumn("input_name");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO Y_PROJMNG_AMT ( dept_code," + 
                    "wbs_code," + 
                    "detail_code," + 
                    "spec_unq_num," + 
                    "name," + 
                    "ssize," + 
                    "unit," + 
                    "qty," + 
                    "persion_qty," + 
                    "month_qty," + 
                    "day_qty," + 
                    "price," + 
                    "amt," + 
                    "acntcode," + 
                    "remark," + 
                    "input_dt," + 
                    "input_name )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_wbs_code);
      gpstatement.bindColumn(3, idx_detail_code);
      gpstatement.bindColumn(4, idx_spec_unq_num);
      gpstatement.bindColumn(5, idx_name);
      gpstatement.bindColumn(6, idx_ssize);
      gpstatement.bindColumn(7, idx_unit);
      gpstatement.bindColumn(8, idx_qty);
      gpstatement.bindColumn(9, idx_persion_qty);
      gpstatement.bindColumn(10, idx_month_qty);
      gpstatement.bindColumn(11, idx_day_qty);
      gpstatement.bindColumn(12, idx_price);
      gpstatement.bindColumn(13, idx_amt);
      gpstatement.bindColumn(14, idx_acntcode);
      gpstatement.bindColumn(15, idx_remark);
      gpstatement.bindColumn(16, idx_input_dt);
      gpstatement.bindColumn(17, idx_input_name);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update y_projmng_amt set " + 
                            "dept_code=?,  " + 
                            "wbs_code=?,  " + 
                            "detail_code=?,  " + 
                            "spec_unq_num=?,  " + 
                            "name=?,  " + 
                            "ssize=?,  " + 
                            "unit=?,  " + 
                            "qty=?,  " + 
                            "persion_qty=?,  " + 
                            "month_qty=?,  " + 
                            "day_qty=?,  " + 
                            "price=?,  " + 
                            "amt=?,  " + 
                            "acntcode=?,  " + 
                            "remark=?,  " + 
                            "input_dt=?,  " + 
                            "input_name=?  where dept_code=? " +
                            " and wbs_code=? " +
                            " and detail_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_wbs_code);
      gpstatement.bindColumn(3, idx_detail_code);
      gpstatement.bindColumn(4, idx_spec_unq_num);
      gpstatement.bindColumn(5, idx_name);
      gpstatement.bindColumn(6, idx_ssize);
      gpstatement.bindColumn(7, idx_unit);
      gpstatement.bindColumn(8, idx_qty);
      gpstatement.bindColumn(9, idx_persion_qty);
      gpstatement.bindColumn(10, idx_month_qty);
      gpstatement.bindColumn(11, idx_day_qty);
      gpstatement.bindColumn(12, idx_price);
      gpstatement.bindColumn(13, idx_amt);
      gpstatement.bindColumn(14, idx_acntcode);
      gpstatement.bindColumn(15, idx_remark);
      gpstatement.bindColumn(16, idx_input_dt);
      gpstatement.bindColumn(17, idx_input_name);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(18, idx_dept_code);
      gpstatement.bindColumn(19, idx_wbs_code);
      gpstatement.bindColumn(20, idx_detail_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from y_projmng_amt where dept_code=? " +
                                            " and wbs_code=? " +
                                            " and detail_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_wbs_code);
      gpstatement.bindColumn(3, idx_detail_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
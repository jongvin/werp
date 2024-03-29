<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_estimate_list_selyn_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_order_number = dSet.indexOfColumn("order_number");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_est_yn = dSet.indexOfColumn("est_yn");
   	int idx_select_yn = dSet.indexOfColumn("select_yn");
   	int idx_charge_name = dSet.indexOfColumn("charge_name");
   	int idx_note = dSet.indexOfColumn("note");
   	int idx_re_est_yn = dSet.indexOfColumn("re_est_yn");
   	int idx_est_dt = dSet.indexOfColumn("est_dt");
   	int idx_re_est_dt = dSet.indexOfColumn("re_est_dt");
   	int idx_noentry_recommen = dSet.indexOfColumn("noentry_recommen");
   	int idx_injung_yn = dSet.indexOfColumn("injung_yn");
   	int idx_input_ctrl_amt = dSet.indexOfColumn("input_ctrl_amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO s_estimate_list ( dept_code," + 
                    "order_number," + 
                    "sbcr_code," + 
                    "est_yn," + 
                    "select_yn, " + 
                    "charge_name," + 
                    "note,noentry_recommen,injung_yn  )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5 ,:6, :7,:8, :9) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_sbcr_code);
      gpstatement.bindColumn(4, idx_est_yn);
      gpstatement.bindColumn(5, idx_select_yn);
      gpstatement.bindColumn(6, idx_charge_name);
      gpstatement.bindColumn(7, idx_note);
      gpstatement.bindColumn(8, idx_noentry_recommen);
      gpstatement.bindColumn(9, idx_injung_yn);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_estimate_list set " + 
                            "dept_code=?,  " + 
                            "order_number=?,  " + 
                            "sbcr_code=?,  " + 
                            "est_yn=?,  " + 
                            "select_yn=?,  " + 
                            "charge_name=?,  " + 
                            "note=? , " + 
                            "re_est_yn=?, " +
                            "est_dt=TO_DATE(?,'yyyy.mm.dd hh24:mi')," +
                            "re_est_dt=TO_DATE(?,'yyyy.mm.dd hh24:mi')," +
                            "noentry_recommen=?, " +
                            "injung_yn=?,input_ctrl_amt=? " +
                            " where (dept_code=? and order_number=? and sbcr_code = ?)";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_sbcr_code);
      gpstatement.bindColumn(4, idx_est_yn);
      gpstatement.bindColumn(5, idx_select_yn);
      gpstatement.bindColumn(6, idx_charge_name);
      gpstatement.bindColumn(7, idx_note);
      gpstatement.bindColumn(8, idx_re_est_yn);
      gpstatement.bindColumn(9, idx_est_dt);
      gpstatement.bindColumn(10, idx_re_est_dt);
      gpstatement.bindColumn(11, idx_noentry_recommen);
      gpstatement.bindColumn(12, idx_injung_yn);
      gpstatement.bindColumn(13, idx_input_ctrl_amt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(14, idx_dept_code);
      gpstatement.bindColumn(15, idx_order_number);
      gpstatement.bindColumn(16, idx_sbcr_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_estimate_list where (dept_code=? and order_number=? and sbcr_code = ?) "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_sbcr_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
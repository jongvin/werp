<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_sbc_approve_process_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_approve_class = dSet.indexOfColumn("approve_class");
   	int idx_request_dt = dSet.indexOfColumn("request_dt");
   	int idx_approve_dt = dSet.indexOfColumn("approve_dt");
   	int idx_order_number = dSet.indexOfColumn("order_number");
   	int idx_chg_degree = dSet.indexOfColumn("chg_degree");
   	int idx_order_name = dSet.indexOfColumn("order_name");
   	int idx_sbc_name = dSet.indexOfColumn("sbc_name");
   	int idx_chg_resign = dSet.indexOfColumn("chg_resign");
   	int idx_plan_start_dt = dSet.indexOfColumn("plan_start_dt");
   	int idx_plan_end_dt = dSet.indexOfColumn("plan_end_dt");
   	int idx_sbc_amt = dSet.indexOfColumn("sbc_amt");
   	int idx_vat = dSet.indexOfColumn("vat");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO s_chg_cn_list ( dept_code," + 
                    "approve_class," + 
                    "request_dt," + 
                    "approve_dt," + 
                    "order_number," + 
                    "chg_degree," + 
                    "order_name," + 
                    "sbc_name," + 
                    "chg_resign," + 
                    "plan_start_dt," + 
                    "plan_end_dt," + 
                    "sbc_amt," + 
                    "vat )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_approve_class);
      gpstatement.bindColumn(3, idx_request_dt);
      gpstatement.bindColumn(4, idx_approve_dt);
      gpstatement.bindColumn(5, idx_order_number);
      gpstatement.bindColumn(6, idx_chg_degree);
      gpstatement.bindColumn(7, idx_order_name);
      gpstatement.bindColumn(8, idx_sbc_name);
      gpstatement.bindColumn(9, idx_chg_resign);
      gpstatement.bindColumn(10, idx_plan_start_dt);
      gpstatement.bindColumn(11, idx_plan_end_dt);
      gpstatement.bindColumn(12, idx_sbc_amt);
      gpstatement.bindColumn(13, idx_vat);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_chg_cn_list set " + 
                            "dept_code=?,  " + 
                            "approve_class=?,  " + 
                            "request_dt=?,  " + 
                            "approve_dt=?,  " + 
                            "order_number=?,  " + 
                            "chg_degree=?,  " + 
                            "order_name=?,  " + 
                            "sbc_name=?,  " + 
                            "chg_resign=?,  " + 
                            "plan_start_dt=?,  " + 
                            "plan_end_dt=?,  " + 
                            "sbc_amt=?,  " + 
                            "vat=?  where dept_code=? " + 
                            " and order_number=? " +
                            " and chg_degree=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_approve_class);
      gpstatement.bindColumn(3, idx_request_dt);
      gpstatement.bindColumn(4, idx_approve_dt);
      gpstatement.bindColumn(5, idx_order_number);
      gpstatement.bindColumn(6, idx_chg_degree);
      gpstatement.bindColumn(7, idx_order_name);
      gpstatement.bindColumn(8, idx_sbc_name);
      gpstatement.bindColumn(9, idx_chg_resign);
      gpstatement.bindColumn(10, idx_plan_start_dt);
      gpstatement.bindColumn(11, idx_plan_end_dt);
      gpstatement.bindColumn(12, idx_sbc_amt);
      gpstatement.bindColumn(13, idx_vat);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(14, idx_dept_code);
      gpstatement.bindColumn(15, idx_order_number);
      gpstatement.bindColumn(16, idx_chg_degree);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_chg_cn_list where dept_code=? " +
                            " and order_number=? " +
                            " and chg_degree=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_chg_degree);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
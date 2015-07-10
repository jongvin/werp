<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_order_approve_process_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_order_number = dSet.indexOfColumn("order_number");
   	int idx_approve_class = dSet.indexOfColumn("approve_class");
   	int idx_request_dt = dSet.indexOfColumn("request_dt");
   	int idx_approve_dt = dSet.indexOfColumn("approve_dt");
   	int idx_order_name = dSet.indexOfColumn("order_name");
   	int idx_start_dt = dSet.indexOfColumn("start_dt");
   	int idx_end_dt = dSet.indexOfColumn("end_dt");
   	int idx_cnt_amt = dSet.indexOfColumn("cnt_amt");
   	int idx_exe_amt = dSet.indexOfColumn("exe_amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_ORDER_LIST ( dept_code," + 
                    "order_number," + 
                    "approve_class," + 
                    "request_dt," + 
                    "approve_dt," + 
                    "order_name," + 
                    "start_dt," + 
                    "end_dt," + 
                    "cnt_amt," + 
                    "exe_amt )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_approve_class);
      gpstatement.bindColumn(4, idx_request_dt);
      gpstatement.bindColumn(5, idx_approve_dt);
      gpstatement.bindColumn(6, idx_order_name);
      gpstatement.bindColumn(7, idx_start_dt);
      gpstatement.bindColumn(8, idx_end_dt);
      gpstatement.bindColumn(9, idx_cnt_amt);
      gpstatement.bindColumn(10, idx_exe_amt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_order_list set " + 
                            "dept_code=?,  " + 
                            "order_number=?,  " + 
                            "approve_class=?,  " + 
                            "request_dt=?,  " + 
                            "approve_dt=?,  " + 
                            "order_name=?,  " + 
                            "start_dt=?,  " + 
                            "end_dt=?,  " + 
                            "cnt_amt=?,  " + 
                            "exe_amt=?  where dept_code=? " +
                            " and order_number=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_approve_class);
      gpstatement.bindColumn(4, idx_request_dt);
      gpstatement.bindColumn(5, idx_approve_dt);
      gpstatement.bindColumn(6, idx_order_name);
      gpstatement.bindColumn(7, idx_start_dt);
      gpstatement.bindColumn(8, idx_end_dt);
      gpstatement.bindColumn(9, idx_cnt_amt);
      gpstatement.bindColumn(10, idx_exe_amt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(11, idx_dept_code);
      gpstatement.bindColumn(12, idx_order_number);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_order_list where dept_code=? " +
      				" and order_number=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
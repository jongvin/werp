<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_order_list_selyn_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_order_number = dSet.indexOfColumn("order_number");
   	int idx_profession_wbs_code = dSet.indexOfColumn("profession_wbs_code");
   	int idx_approve_class = dSet.indexOfColumn("approve_class");
   	int idx_check_date = dSet.indexOfColumn("check_date");
   	int idx_request_dt = dSet.indexOfColumn("request_dt");
   	int idx_approve_dt = dSet.indexOfColumn("approve_dt");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_open_yn = dSet.indexOfColumn("open_yn");
   	int idx_open_dt = dSet.indexOfColumn("open_dt");
   	int idx_open_per = dSet.indexOfColumn("open_per");
   	int idx_estimate_dt = dSet.indexOfColumn("estimate_dt");
   	int idx_remark = dSet.indexOfColumn("note");
   	
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO s_order_list ( dept_code," + 
                    "order_number," + 
                    "profession_wbs_code," + 
                    "approve_class," + 
                    "check_date," + 
                    "request_dt," + 
                    "approve_dt," + 
                    "sbcr_code, " + 
                    "remark " + 
                    "  )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_profession_wbs_code);
      gpstatement.bindColumn(4, idx_approve_class);
      gpstatement.bindColumn(5, idx_check_date);
      gpstatement.bindColumn(6, idx_request_dt);
      gpstatement.bindColumn(7, idx_approve_dt);
      gpstatement.bindColumn(8, idx_sbcr_code);
      gpstatement.bindColumn(9, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_order_list set " + 
                            "dept_code=?,  " + 
                            "order_number=?,  " + 
                            "profession_wbs_code=?,  " + 
                            "approve_class=?,  " + 
                            "check_date=?,  " + 
                            "request_dt=?,  " + 
                            "approve_dt=?,  " + 
                            "sbcr_code=?,   " + 
                            "open_yn=?,open_dt=TO_DATE(?,'yyyy.mm.dd hh24:mi:ss'),open_per=?, " +
                            "estimate_dt=TO_DATE(?,'yyyy.mm.dd hh24:mi:ss'), note=? " +
                            "   where (dept_code=? and order_number=?)";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_profession_wbs_code);
      gpstatement.bindColumn(4, idx_approve_class);
      gpstatement.bindColumn(5, idx_check_date);
      gpstatement.bindColumn(6, idx_request_dt);
      gpstatement.bindColumn(7, idx_approve_dt);
      gpstatement.bindColumn(8, idx_sbcr_code);
      gpstatement.bindColumn(9, idx_open_yn);
      gpstatement.bindColumn(10, idx_open_dt);
      gpstatement.bindColumn(11, idx_open_per);
      gpstatement.bindColumn(12, idx_estimate_dt);
      gpstatement.bindColumn(13, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(14, idx_dept_code);
      gpstatement.bindColumn(15, idx_order_number);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_order_list where (dept_code=? and order_number=?)"; 
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
<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("y_outside_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_detail_code = dSet.indexOfColumn("detail_code");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_ssize = dSet.indexOfColumn("ssize");
   	int idx_unit = dSet.indexOfColumn("unit");
   	int idx_mat_code = dSet.indexOfColumn("mat_code");
   	int idx_cnt_qty = dSet.indexOfColumn("cnt_qty");
   	int idx_qty = dSet.indexOfColumn("qty");
   	int idx_work_dt = dSet.indexOfColumn("work_dt");
   	int idx_request_dt = dSet.indexOfColumn("request_dt");
   	int idx_approve_dt = dSet.indexOfColumn("approve_dt");
   	int idx_approve_class = dSet.indexOfColumn("approve_class");
   	int idx_name_key = dSet.indexOfColumn("name_key");
   	int idx_approve_chk = dSet.indexOfColumn("approve_chk");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_approval_name = dSet.indexOfColumn("approval_name");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO y_outside ( dept_code," + 
                    "spec_unq_num," + 
                    "no_seq," + 
                    "spec_no_seq," + 
                    "detail_code," + 
                    "name," + 
                    "ssize," + 
                    "unit," + 
                    "mat_code," + 
                    "cnt_qty," + 
                    "qty," + 
                    "work_dt," + 
                    "request_dt," + 
                    "approve_dt," + 
                    "approve_class,name_key,approve_chk,remark,approval_name )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16 ,:17, :18, :19) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_spec_unq_num);
      gpstatement.bindColumn(3, idx_no_seq);
      gpstatement.bindColumn(4, idx_spec_no_seq);
      gpstatement.bindColumn(5, idx_detail_code);
      gpstatement.bindColumn(6, idx_name);
      gpstatement.bindColumn(7, idx_ssize);
      gpstatement.bindColumn(8, idx_unit);
      gpstatement.bindColumn(9, idx_mat_code);
      gpstatement.bindColumn(10, idx_cnt_qty);
      gpstatement.bindColumn(11, idx_qty);
      gpstatement.bindColumn(12, idx_work_dt);
      gpstatement.bindColumn(13, idx_request_dt);
      gpstatement.bindColumn(14, idx_approve_dt);
      gpstatement.bindColumn(15, idx_approve_class);
      gpstatement.bindColumn(16, idx_name_key);
      gpstatement.bindColumn(17, idx_approve_chk);
      gpstatement.bindColumn(18, idx_remark);
      gpstatement.bindColumn(19, idx_approval_name);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update y_outside set " + 
                            "dept_code=?,  " + 
                            "spec_unq_num=?,  " + 
                            "no_seq=?,  " + 
                            "spec_no_seq=?,  " + 
                            "detail_code=?,  " + 
                            "name=?,  " + 
                            "ssize=?,  " + 
                            "unit=?,  " + 
                            "mat_code=?,  " + 
                            "cnt_qty=?,  " + 
                            "qty=?,  " + 
                            "work_dt=?,  " + 
                            "request_dt=?,  " + 
                            "approve_dt=?,  " + 
                            "approve_class=?,name_key=?,approve_chk=?,remark=?, " + 
                            " approval_name=? where dept_code=? and spec_unq_num=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_spec_unq_num);
      gpstatement.bindColumn(3, idx_no_seq);
      gpstatement.bindColumn(4, idx_spec_no_seq);
      gpstatement.bindColumn(5, idx_detail_code);
      gpstatement.bindColumn(6, idx_name);
      gpstatement.bindColumn(7, idx_ssize);
      gpstatement.bindColumn(8, idx_unit);
      gpstatement.bindColumn(9, idx_mat_code);
      gpstatement.bindColumn(10, idx_cnt_qty);
      gpstatement.bindColumn(11, idx_qty);
      gpstatement.bindColumn(12, idx_work_dt);
      gpstatement.bindColumn(13, idx_request_dt);
      gpstatement.bindColumn(14, idx_approve_dt);
      gpstatement.bindColumn(15, idx_approve_class);
      gpstatement.bindColumn(16, idx_name_key);
      gpstatement.bindColumn(17, idx_approve_chk);
      gpstatement.bindColumn(18, idx_remark);
      gpstatement.bindColumn(19, idx_approval_name);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(20, idx_dept_code);
      gpstatement.bindColumn(21, idx_spec_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from y_outside where dept_code=? and spec_unq_num=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_spec_unq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
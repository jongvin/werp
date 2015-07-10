<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../comm_function/conn_gauce_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_login_status_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_seq_key = dSet.indexOfColumn("seq_key");
   	int idx_log_tag = dSet.indexOfColumn("log_tag");
   	int idx_user_id = dSet.indexOfColumn("user_id");
   	int idx_empno = dSet.indexOfColumn("empno");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_long_name = dSet.indexOfColumn("long_name");
   	int idx_ip_address = dSet.indexOfColumn("ip_address");
   	int idx_start_time = dSet.indexOfColumn("start_time");
   	int idx_end_time = dSet.indexOfColumn("end_time");
   	int idx_remarks = dSet.indexOfColumn("remarks");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO z_login_status ( seq_key," + 
                    "log_tag," + 
                    "user_id," + 
                    "empno," + 
                    "name," + 
                    "dept_code," + 
                    "long_name," + 
                    "ip_address," + 
                    "start_time," + 
                    "end_time," + 
                    "remarks )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_seq_key);
      gpstatement.bindColumn(2, idx_log_tag);
      gpstatement.bindColumn(3, idx_user_id);
      gpstatement.bindColumn(4, idx_empno);
      gpstatement.bindColumn(5, idx_name);
      gpstatement.bindColumn(6, idx_dept_code);
      gpstatement.bindColumn(7, idx_long_name);
      gpstatement.bindColumn(8, idx_ip_address);
      gpstatement.bindColumn(9, idx_start_time);
      gpstatement.bindColumn(10, idx_end_time);
      gpstatement.bindColumn(11, idx_remarks);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update z_login_status set " + 
                            "seq_key=?,  " + 
                            "log_tag=?,  " + 
                            "user_id=?,  " + 
                            "empno=?,  " + 
                            "name=?,  " + 
                            "dept_code=?,  " + 
                            "long_name=?,  " + 
                            "ip_address=?,  " + 
                            "start_time=?,  " + 
                            "end_time=?,  " + 
                            "remarks=?  where seq_key=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_seq_key);
      gpstatement.bindColumn(2, idx_log_tag);
      gpstatement.bindColumn(3, idx_user_id);
      gpstatement.bindColumn(4, idx_empno);
      gpstatement.bindColumn(5, idx_name);
      gpstatement.bindColumn(6, idx_dept_code);
      gpstatement.bindColumn(7, idx_long_name);
      gpstatement.bindColumn(8, idx_ip_address);
      gpstatement.bindColumn(9, idx_start_time);
      gpstatement.bindColumn(10, idx_end_time);
      gpstatement.bindColumn(11, idx_remarks);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(12, idx_seq_key);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from z_login_status where seq_key=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_seq_key);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../comm_function/conn_tr_end.jsp"%>
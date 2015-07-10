<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("z_dept_code_approve_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
   	int idx_approve_class = dSet.indexOfColumn("approve_class");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_long_name = dSet.indexOfColumn("long_name");
   	int idx_short_name = dSet.indexOfColumn("short_name");
   	int idx_dept_proj_tag = dSet.indexOfColumn("dept_proj_tag");
   	int idx_receive_code = dSet.indexOfColumn("receive_code");
   	int idx_request_dt = dSet.indexOfColumn("request_dt");
   	int idx_create_dt = dSet.indexOfColumn("create_dt");
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO Z_DEPT_APPROVE ( spec_unq_num," + 
                    "approve_class," + 
                    "dept_code," + 
                    "long_name," + 
                    "short_name," + 
                    "dept_proj_tag," + 
                    "receive_code," + 
                    "request_dt," + 
                    "create_dt,comp_code )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9,:10) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_spec_unq_num) ;
      gpstatement.bindColumn(2, idx_approve_class);
      gpstatement.bindColumn(3, idx_dept_code);
      gpstatement.bindColumn(4, idx_long_name);
      gpstatement.bindColumn(5, idx_short_name);
      gpstatement.bindColumn(6, idx_dept_proj_tag);
      gpstatement.bindColumn(7, idx_receive_code);
      gpstatement.bindColumn(8, idx_request_dt);
      gpstatement.bindColumn(9, idx_create_dt);
      gpstatement.bindColumn(10, idx_comp_code);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update Z_DEPT_APPROVE set " + 
                            "spec_unq_num=?,  " + 
                            "approve_class=?,  " + 
                            "dept_code=?,  " + 
                            "long_name=?,  " + 
                            "short_name=?,  " + 
                            "dept_proj_tag=?,  " + 
                            "receive_code=?,  " + 
                            "request_dt=?,  " + 
                            "create_dt=? ,comp_code=? where spec_unq_num=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_spec_unq_num) ;
      gpstatement.bindColumn(2, idx_approve_class);
      gpstatement.bindColumn(3, idx_dept_code);
      gpstatement.bindColumn(4, idx_long_name);
      gpstatement.bindColumn(5, idx_short_name);
      gpstatement.bindColumn(6, idx_dept_proj_tag);
      gpstatement.bindColumn(7, idx_receive_code);
      gpstatement.bindColumn(8, idx_request_dt);
      gpstatement.bindColumn(9, idx_create_dt);
      gpstatement.bindColumn(10, idx_comp_code);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(11, idx_spec_unq_num) ;
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from Z_DEPT_APPROVE where spec_unq_num=? " ;
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_spec_unq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
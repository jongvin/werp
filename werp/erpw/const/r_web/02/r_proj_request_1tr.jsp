<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("r_proj_request_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_receive_code = dSet.indexOfColumn("receive_code");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_const_position = dSet.indexOfColumn("const_position");
   	int idx_pq_tag = dSet.indexOfColumn("pq_tag");
   	int idx_const_from = dSet.indexOfColumn("const_from");
   	int idx_const_to = dSet.indexOfColumn("const_to");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_parent_dept_code = dSet.indexOfColumn("parent_dept_code");
   	int idx_approve_class = dSet.indexOfColumn("approve_class");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO r_receive_code ( receive_code," + 
                    "name," + 
                    "const_position," + 
                    "pq_tag," + 
                    "const_from," + 
                    "const_to," + 
                    "dept_code," + 
                    "parent_dept_code," + 
                    "approve_class )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_receive_code);
      gpstatement.bindColumn(2, idx_name);
      gpstatement.bindColumn(3, idx_const_position);
      gpstatement.bindColumn(4, idx_pq_tag);
      gpstatement.bindColumn(5, idx_const_from);
      gpstatement.bindColumn(6, idx_const_to);
      gpstatement.bindColumn(7, idx_dept_code);
      gpstatement.bindColumn(8, idx_parent_dept_code);
      gpstatement.bindColumn(9, idx_approve_class);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update r_receive_code set " + 
                            "receive_code=?,  " + 
                            "name=?,  " + 
                            "const_position=?,  " + 
                            "pq_tag=?,  " + 
                            "const_from=?,  " + 
                            "const_to=?,  " + 
                            "dept_code=?,  " + 
                            "parent_dept_code=?,  " + 
                            "approve_class=?  where receive_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_receive_code);
      gpstatement.bindColumn(2, idx_name);
      gpstatement.bindColumn(3, idx_const_position);
      gpstatement.bindColumn(4, idx_pq_tag);
      gpstatement.bindColumn(5, idx_const_from);
      gpstatement.bindColumn(6, idx_const_to);
      gpstatement.bindColumn(7, idx_dept_code);
      gpstatement.bindColumn(8, idx_parent_dept_code);
      gpstatement.bindColumn(9, idx_approve_class);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(10, idx_receive_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from r_receive_code where receive_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_receive_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_spec_class_child_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_old_dept_code = dSet.indexOfColumn("old_dept_code");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO c_spec_class_child ( spec_no_seq," + 
                    "dept_code," + 
                    "no_seq )      ";
      sSql = sSql + " VALUES ( :1, :2, :3 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_spec_no_seq);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_no_seq);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update c_spec_class_child set " + 
                            "spec_no_seq=?,  " + 
                            "dept_code=?,  " + 
                            "no_seq=?  where (spec_no_seq=? and dept_code = ?)";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_spec_no_seq);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_no_seq);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(4, idx_spec_no_seq);
      gpstatement.bindColumn(5, idx_old_dept_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from c_spec_class_child where (spec_no_seq=? and dept_code = ?) "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_spec_no_seq);
      gpstatement.bindColumn(2, idx_old_dept_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
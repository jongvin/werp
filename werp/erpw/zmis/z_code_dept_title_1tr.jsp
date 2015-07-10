<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("z_code_dept_title_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_seq_key = dSet.indexOfColumn("dept_seq_key");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_level1 = dSet.indexOfColumn("level1");
   	int idx_title_name = dSet.indexOfColumn("title_name");
   	int idx_level_code = dSet.indexOfColumn("level_code");
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO z_code_dept_title ( dept_seq_key," + 
                    "no_seq," + 
                    "level1," + 
                    "title_name," + 
                    "level_code,  " + 
                    "comp_code )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_seq_key);
      gpstatement.bindColumn(2, idx_no_seq);
      gpstatement.bindColumn(3, idx_level1);
      gpstatement.bindColumn(4, idx_title_name);
      gpstatement.bindColumn(5, idx_level_code);
      gpstatement.bindColumn(6, idx_comp_code);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update z_code_dept_title set " + 
                            "dept_seq_key=?,  " + 
                            "no_seq=?,  " + 
                            "level1=?,  " + 
                            "title_name=?,  " + 
                            "level_code=?,  " + 
                            "comp_code=?  " + 
                            " where dept_seq_key=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_seq_key);
      gpstatement.bindColumn(2, idx_no_seq);
      gpstatement.bindColumn(3, idx_level1);
      gpstatement.bindColumn(4, idx_title_name);
      gpstatement.bindColumn(5, idx_level_code);
      gpstatement.bindColumn(6, idx_comp_code);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(7, idx_dept_seq_key);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from z_code_dept_title where dept_seq_key=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_seq_key);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../comm_function/conn_tr_end.jsp"%>
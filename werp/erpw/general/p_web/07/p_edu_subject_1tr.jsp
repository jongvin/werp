<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_edu_subject_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_edu_year = dSet.indexOfColumn("edu_year");
   	int idx_edu_code = dSet.indexOfColumn("edu_code");
   	int idx_edu_degree = dSet.indexOfColumn("edu_degree");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_subject = dSet.indexOfColumn("subject");
   	int idx_inst_no = dSet.indexOfColumn("inst_no");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_edu_subject ( edu_year," + 
                    "edu_code," + 
                    "edu_degree," + 
                    "spec_no_seq," + 
                    "no_seq," + 
                    "subject," + 
                    "inst_no )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_edu_year);
      gpstatement.bindColumn(2, idx_edu_code);
      gpstatement.bindColumn(3, idx_edu_degree);
      gpstatement.bindColumn(4, idx_spec_no_seq);
      gpstatement.bindColumn(5, idx_no_seq);
      gpstatement.bindColumn(6, idx_subject);
      gpstatement.bindColumn(7, idx_inst_no);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_edu_subject set " + 
                            "edu_year=?,  " + 
                            "edu_code=?,  " + 
                            "edu_degree=?,  " + 
                            "spec_no_seq=?,  " + 
                            "no_seq=?,  " + 
                            "subject=?,  " + 
                            "inst_no=?  where edu_year=? and edu_code=? and edu_degree=? and spec_no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_edu_year);
      gpstatement.bindColumn(2, idx_edu_code);
      gpstatement.bindColumn(3, idx_edu_degree);
      gpstatement.bindColumn(4, idx_spec_no_seq);
      gpstatement.bindColumn(5, idx_no_seq);
      gpstatement.bindColumn(6, idx_subject);
      gpstatement.bindColumn(7, idx_inst_no);      
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_edu_year);
      gpstatement.bindColumn(9, idx_edu_code);
      gpstatement.bindColumn(10, idx_edu_degree);
      gpstatement.bindColumn(11, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_edu_subject where edu_year=? and edu_code=? and edu_degree=? and spec_no_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_edu_year);
      gpstatement.bindColumn(2, idx_edu_code);
      gpstatement.bindColumn(3, idx_edu_degree);
      gpstatement.bindColumn(4, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_emp_inter_degree_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_employ_degree = dSet.indexOfColumn("employ_degree");
   	int idx_interview_degree = dSet.indexOfColumn("interview_degree");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_closing_tag = dSet.indexOfColumn("closing_tag");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_emp_inter_degree ( employ_degree," + 
                    "interview_degree," + 
                    "remark, " +
                    "closing_tag )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_employ_degree);
      gpstatement.bindColumn(2, idx_interview_degree);
      gpstatement.bindColumn(3, idx_remark);
      gpstatement.bindColumn(4, idx_closing_tag);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_emp_inter_degree set " + 
                            "employ_degree=?,  " + 
                            "interview_degree=?,  " + 
                            "remark=?, " +
                            "closing_tag=?  where employ_degree=? and interview_degree=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_employ_degree);
      gpstatement.bindColumn(2, idx_interview_degree);
      gpstatement.bindColumn(3, idx_remark);
      gpstatement.bindColumn(4, idx_closing_tag);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(5, idx_employ_degree);
      gpstatement.bindColumn(6, idx_interview_degree);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_emp_inter_degree where employ_degree=? and interview_degree=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_employ_degree);
      gpstatement.bindColumn(2, idx_interview_degree);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
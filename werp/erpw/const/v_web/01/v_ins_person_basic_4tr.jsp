<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("v_ins_person_basic_4tr");
     gpstatement.gp_dataset = dSet;
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_dt = dSet.indexOfColumn("dt");
   	int idx_study_course = dSet.indexOfColumn("study_course");
   	int idx_edu_organ = dSet.indexOfColumn("edu_organ");
   	int idx_edu_time = dSet.indexOfColumn("edu_time");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO v_ip_manage ( emp_no," + 
                    "seq," + 
                    "dt," + 
                    "study_course," + 
                    "edu_organ," + 
                    "edu_time," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_dt);
      gpstatement.bindColumn(4, idx_study_course);
      gpstatement.bindColumn(5, idx_edu_organ);
      gpstatement.bindColumn(6, idx_edu_time);
      gpstatement.bindColumn(7, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update v_ip_manage set " + 
                            "emp_no=?,  " + 
                            "seq=?,  " + 
                            "dt=?,  " + 
                            "study_course=?,  " + 
                            "edu_organ=?,  " + 
                            "edu_time=?,  " + 
                            "remark=?  where emp_no=? and seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_dt);
      gpstatement.bindColumn(4, idx_study_course);
      gpstatement.bindColumn(5, idx_edu_organ);
      gpstatement.bindColumn(6, idx_edu_time);
      gpstatement.bindColumn(7, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_emp_no);
      gpstatement.bindColumn(9, idx_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from v_ip_manage where emp_no=? and seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
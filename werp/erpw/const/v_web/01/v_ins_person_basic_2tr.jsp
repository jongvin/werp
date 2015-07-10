<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("v_ins_person_basic_2tr");
     gpstatement.gp_dataset = dSet;
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_school_name = dSet.indexOfColumn("school_name");
   	int idx_major = dSet.indexOfColumn("major");
   	int idx_grade = dSet.indexOfColumn("grade");
   	int idx_graduation_dt = dSet.indexOfColumn("graduation_dt");
   	int idx_school_section = dSet.indexOfColumn("school_section");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO v_ip_achievement ( emp_no," + 
                    "seq," + 
                    "school_name," + 
                    "major," + 
                    "grade," + 
                    "graduation_dt," + 
                    "school_section )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_school_name);
      gpstatement.bindColumn(4, idx_major);
      gpstatement.bindColumn(5, idx_grade);
      gpstatement.bindColumn(6, idx_graduation_dt);
      gpstatement.bindColumn(7, idx_school_section);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update v_ip_achievement set " + 
                            "emp_no=?,  " + 
                            "seq=?,  " + 
                            "school_name=?,  " + 
                            "major=?,  " + 
                            "grade=?,  " + 
                            "graduation_dt=?,  " + 
                            "school_section=?  where emp_no=? and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_school_name);
      gpstatement.bindColumn(4, idx_major);
      gpstatement.bindColumn(5, idx_grade);
      gpstatement.bindColumn(6, idx_graduation_dt);
      gpstatement.bindColumn(7, idx_school_section);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_emp_no);
      gpstatement.bindColumn(9, idx_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from v_ip_achievement where emp_no=? and seq=? "; 
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
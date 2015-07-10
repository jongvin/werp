<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("v_ins_person_basic_5tr");
     gpstatement.gp_dataset = dSet;
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_obtain_dt = dSet.indexOfColumn("obtain_dt");
   	int idx_licenss_item = dSet.indexOfColumn("licenss_item");
   	int idx_reg_number = dSet.indexOfColumn("reg_number");
   	int idx_issue_organ = dSet.indexOfColumn("issue_organ");
   	int idx_grade = dSet.indexOfColumn("grade");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO v_ip_license ( emp_no," + 
                    "seq," + 
                    "obtain_dt," + 
                    "licenss_item," + 
                    "reg_number," + 
                    "issue_organ," + 
                    "grade," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_obtain_dt);
      gpstatement.bindColumn(4, idx_licenss_item);
      gpstatement.bindColumn(5, idx_reg_number);
      gpstatement.bindColumn(6, idx_issue_organ);
      gpstatement.bindColumn(7, idx_grade);
      gpstatement.bindColumn(8, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update v_ip_license set " + 
                            "emp_no=?,  " + 
                            "seq=?,  " + 
                            "obtain_dt=?,  " + 
                            "licenss_item=?,  " + 
                            "reg_number=?,  " + 
                            "issue_organ=?,  " + 
                            "grade=?,  " + 
                            "remark=?  where emp_no=? and seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_obtain_dt);
      gpstatement.bindColumn(4, idx_licenss_item);
      gpstatement.bindColumn(5, idx_reg_number);
      gpstatement.bindColumn(6, idx_issue_organ);
      gpstatement.bindColumn(7, idx_grade);
      gpstatement.bindColumn(8, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(9, idx_emp_no);
      gpstatement.bindColumn(10, idx_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from v_ip_license where emp_no=? and seq=?";  
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
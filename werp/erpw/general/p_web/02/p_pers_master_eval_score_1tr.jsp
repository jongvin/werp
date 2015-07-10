<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_pers_master_eval_score_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_eval_year = dSet.indexOfColumn("eval_year");
   	int idx_upper_score = dSet.indexOfColumn("upper_score");
   	int idx_latter_score = dSet.indexOfColumn("latter_score");
   	int idx_total_score = dSet.indexOfColumn("total_score");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_pers_eval_score ( emp_no," + 
                    "eval_year," + 
                    "upper_score," + 
                    "latter_score," + 
                    "total_score," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_eval_year);
      gpstatement.bindColumn(3, idx_upper_score);
      gpstatement.bindColumn(4, idx_latter_score);
      gpstatement.bindColumn(5, idx_total_score);
      gpstatement.bindColumn(6, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_pers_eval_score set " + 
                            "emp_no=?,  " + 
                            "eval_year=?,  " + 
                            "upper_score=?,  " + 
                            "latter_score=?,  " + 
                            "total_score=?,  " + 
                            "remark=?  where emp_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_eval_year);
      gpstatement.bindColumn(3, idx_upper_score);
      gpstatement.bindColumn(4, idx_latter_score);
      gpstatement.bindColumn(5, idx_total_score);
      gpstatement.bindColumn(6, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(7, idx_emp_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_pers_eval_score where emp_no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_emp_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
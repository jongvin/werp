<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_month_tot_list_1tr");
     gpstatement.gp_dataset = dSet;
     int idx_dept_code = dSet.indexOfColumn("dept_code");
     int idx_yymm = dSet.indexOfColumn("yymm");
     int idx_cnt_bigo1 = dSet.indexOfColumn("cnt_bigo1");
     int idx_cnt_bigo2 = dSet.indexOfColumn("cnt_bigo2");
     int idx_cnt_bigo3 = dSet.indexOfColumn("cnt_bigo3");
     int idx_cnt_amt_bigo = dSet.indexOfColumn("cnt_amt_bigo");
     int idx_wbs_progress_month = dSet.indexOfColumn("wbs_progress_month");
     int idx_wbs_progress_next = dSet.indexOfColumn("wbs_progress_next");
     int idx_safety_month = dSet.indexOfColumn("safety_month");
     int idx_safety_next = dSet.indexOfColumn("safety_next");
     int idx_q_month = dSet.indexOfColumn("q_month");
     int idx_q_next = dSet.indexOfColumn("q_next");
     int idx_problem_bigo = dSet.indexOfColumn("problem_bigo");
     int idx_opinion_bigo = dSet.indexOfColumn("opinion_bigo");
     int idx_decision_bigo = dSet.indexOfColumn("decision_bigo");
     int idx_delay_int = dSet.indexOfColumn("delay_int");
     int idx_delay_date = dSet.indexOfColumn("delay_date");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = 	" INSERT INTO c_week_status ( dept_code," +
							"yymm,   " +
						  	"cnt_bigo1,   " +
         				"cnt_bigo2,   " +
         				"cnt_bigo3,   " +
         				"cnt_amt_bigo,   " +
         				"wbs_progress_month,   " +
         				"wbs_progress_next,   " +
         				"safety_month,   " +
         				"safety_next,   " +
         				"q_month,   " +
         				"q_next,   " +
         				"problem_bigo,   " +
         				"opinion_bigo,   " +
         				"decision_bigo )	";
		       sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_cnt_bigo1);
      gpstatement.bindColumn(4, idx_cnt_bigo2);
      gpstatement.bindColumn(5, idx_cnt_bigo3);
      gpstatement.bindColumn(6, idx_cnt_amt_bigo);
      gpstatement.bindColumn(7, idx_wbs_progress_month);
      gpstatement.bindColumn(8, idx_wbs_progress_next);
      gpstatement.bindColumn(9, idx_safety_month);
      gpstatement.bindColumn(10, idx_safety_next);
      gpstatement.bindColumn(11, idx_q_month);
      gpstatement.bindColumn(12, idx_q_next);
      gpstatement.bindColumn(13, idx_problem_bigo);
      gpstatement.bindColumn(14, idx_opinion_bigo);
      gpstatement.bindColumn(15, idx_decision_bigo);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update c_spec_const_input set " + 
							"cnt_bigo1=?,                 " +
         				"cnt_bigo2=?,                 " +
         				"cnt_bigo3=?,                 " +
         				"cnt_amt_bigo=?,              " +
         				"wbs_progress_month=?,        " +
         				"wbs_progress_next=?,         " +
         				"safety_month=?,              " +
         				"safety_next=?,               " +
         				"q_month=?,                   " +
         				"q_next=?,                    " +
         				"problem_bigo=?,              " +
         				"opinion_bigo=?,              " +
         				"decision_bigo=?, 					" +
         				"delay_int=?,						" +
         				"delay_date=? where dept_code=? and yymm=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_cnt_bigo1);
      gpstatement.bindColumn(2, idx_cnt_bigo2);
      gpstatement.bindColumn(3, idx_cnt_bigo3);
      gpstatement.bindColumn(4, idx_cnt_amt_bigo);
      gpstatement.bindColumn(5, idx_wbs_progress_month);
      gpstatement.bindColumn(6, idx_wbs_progress_next);
      gpstatement.bindColumn(7, idx_safety_month);
      gpstatement.bindColumn(8, idx_safety_next);
      gpstatement.bindColumn(9, idx_q_month);
      gpstatement.bindColumn(10, idx_q_next);
      gpstatement.bindColumn(11, idx_problem_bigo);
      gpstatement.bindColumn(12, idx_opinion_bigo);
      gpstatement.bindColumn(13, idx_decision_bigo);
      gpstatement.bindColumn(14, idx_delay_int);
      gpstatement.bindColumn(15, idx_delay_date);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(16, idx_dept_code);
      gpstatement.bindColumn(17, idx_yymm);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from c_spec_const_input where dept_code=? and yymm=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
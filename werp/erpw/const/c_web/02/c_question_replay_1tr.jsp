<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_question_replay_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymm = dSet.indexOfColumn("yymm");
   	int idx_main_process_bigo = dSet.indexOfColumn("main_process_bigo");
   	int idx_hang_1 = dSet.indexOfColumn("hang_1");
   	int idx_question_1 = dSet.indexOfColumn("question_1");
   	int idx_replay_1 = dSet.indexOfColumn("replay_1");
   	int idx_bigo_1 = dSet.indexOfColumn("bigo_1");
   	int idx_hang_2 = dSet.indexOfColumn("hang_2");
   	int idx_question_2 = dSet.indexOfColumn("question_2");
   	int idx_replay_2 = dSet.indexOfColumn("replay_2");
   	int idx_bigo_2 = dSet.indexOfColumn("bigo_2");
   	int idx_hang_3 = dSet.indexOfColumn("hang_3");
   	int idx_question_3 = dSet.indexOfColumn("question_3");
   	int idx_replay_3 = dSet.indexOfColumn("replay_3");
   	int idx_bigo_3 = dSet.indexOfColumn("bigo_3");
   	int idx_hang_4 = dSet.indexOfColumn("hang_4");
   	int idx_question_4 = dSet.indexOfColumn("question_4");
   	int idx_replay_4 = dSet.indexOfColumn("replay_4");
   	int idx_bigo_4 = dSet.indexOfColumn("bigo_4");
   	int idx_bigo_1_chumbu = dSet.indexOfColumn("bigo_1_chumbu");
   	int idx_bigo_2_chumbu = dSet.indexOfColumn("bigo_2_chumbu");
   	int idx_bigo_3_chumbu = dSet.indexOfColumn("bigo_3_chumbu");
   	int idx_bigo_4_chumbu = dSet.indexOfColumn("bigo_4_chumbu");
   	int idx_cdir = dSet.indexOfColumn("cdir");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO c_question_replay ( dept_code," + 
                    "yymm," + 
                    "main_process_bigo," + 
                    "hang_1," + 
                    "question_1," + 
                    "replay_1," + 
                    "bigo_1," + 
                    "hang_2," + 
                    "question_2," + 
                    "replay_2," + 
                    "bigo_2," + 
                    "hang_3," + 
                    "question_3," + 
                    "replay_3," + 
                    "bigo_3," + 
                    "hang_4," + 
                    "question_4," + 
                    "replay_4," + 
                    "bigo_4, bigo_1_chumbu,bigo_2_chumbu,bigo_3_chumbu,bigo_4_chumbu)      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_main_process_bigo);
      gpstatement.bindColumn(4, idx_hang_1);
      gpstatement.bindColumn(5, idx_question_1);
      gpstatement.bindColumn(6, idx_replay_1);
      gpstatement.bindColumn(7, idx_bigo_1);
      gpstatement.bindColumn(8, idx_hang_2);
      gpstatement.bindColumn(9, idx_question_2);
      gpstatement.bindColumn(10, idx_replay_2);
      gpstatement.bindColumn(11, idx_bigo_2);
      gpstatement.bindColumn(12, idx_hang_3);
      gpstatement.bindColumn(13, idx_question_3);
      gpstatement.bindColumn(14, idx_replay_3);
      gpstatement.bindColumn(15, idx_bigo_3);
      gpstatement.bindColumn(16, idx_hang_4);
      gpstatement.bindColumn(17, idx_question_4);
      gpstatement.bindColumn(18, idx_replay_4);
      gpstatement.bindColumn(19, idx_bigo_4);
      gpstatement.bindColumn(20, idx_bigo_1_chumbu);
      gpstatement.bindColumn(21, idx_bigo_2_chumbu);
      gpstatement.bindColumn(22, idx_bigo_3_chumbu);
      gpstatement.bindColumn(23, idx_bigo_4_chumbu);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update c_question_replay set " + 
                            "dept_code=?,  " + 
                            "yymm=?,  " + 
                            "main_process_bigo=?,  " + 
                            "hang_1=?,  " + 
                            "question_1=?,  " + 
                            "replay_1=?,  " + 
                            "bigo_1=?,  " + 
                            "hang_2=?,  " + 
                            "question_2=?,  " + 
                            "replay_2=?,  " + 
                            "bigo_2=?,  " + 
                            "hang_3=?,  " + 
                            "question_3=?,  " + 
                            "replay_3=?,  " + 
                            "bigo_3=?,  " + 
                            "hang_4=?,  " + 
                            "question_4=?,  " + 
                            "replay_4=?,  " + 
                            "bigo_4=?,bigo_1_chumbu=?,bigo_2_chumbu=?,bigo_3_chumbu=?,bigo_4_chumbu=?  " + 
                            "  where dept_code=? and yymm=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_main_process_bigo);
      gpstatement.bindColumn(4, idx_hang_1);
      gpstatement.bindColumn(5, idx_question_1);
      gpstatement.bindColumn(6, idx_replay_1);
      gpstatement.bindColumn(7, idx_bigo_1);
      gpstatement.bindColumn(8, idx_hang_2);
      gpstatement.bindColumn(9, idx_question_2);
      gpstatement.bindColumn(10, idx_replay_2);
      gpstatement.bindColumn(11, idx_bigo_2);
      gpstatement.bindColumn(12, idx_hang_3);
      gpstatement.bindColumn(13, idx_question_3);
      gpstatement.bindColumn(14, idx_replay_3);
      gpstatement.bindColumn(15, idx_bigo_3);
      gpstatement.bindColumn(16, idx_hang_4);
      gpstatement.bindColumn(17, idx_question_4);
      gpstatement.bindColumn(18, idx_replay_4);
      gpstatement.bindColumn(19, idx_bigo_4);
      gpstatement.bindColumn(20, idx_bigo_1_chumbu);
      gpstatement.bindColumn(21, idx_bigo_2_chumbu);
      gpstatement.bindColumn(22, idx_bigo_3_chumbu);
      gpstatement.bindColumn(23, idx_bigo_4_chumbu);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(24, idx_dept_code);
      gpstatement.bindColumn(25, idx_yymm);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from c_question_replay where dept_code=? and yymm=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
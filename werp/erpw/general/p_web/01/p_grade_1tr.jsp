<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_grade_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_grade_code = dSet.indexOfColumn("grade_code");
   	int idx_grade_name = dSet.indexOfColumn("grade_name");
   	int idx_order_seq = dSet.indexOfColumn("order_seq");
   	int idx_use_yn = dSet.indexOfColumn("use_yn");
   	int idx_level_code = dSet.indexOfColumn("level_code");
   	int idx_retire_rate = dSet.indexOfColumn("retire_rate");
   	int idx_levelup_obj_yn = dSet.indexOfColumn("levelup_obj_yn");
   	int idx_levelup_year = dSet.indexOfColumn("levelup_year");
   	int idx_levelup_paystep = dSet.indexOfColumn("levelup_paystep");
   	int idx_start_paystep = dSet.indexOfColumn("start_paystep");
   	int idx_limit_paystep = dSet.indexOfColumn("limit_paystep");
   	int idx_minus_year = dSet.indexOfColumn("minus_year");
   	int idx_old_grade_code = dSet.indexOfColumn("old_grade_code");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_code_grade ( grade_code," + 
                    "grade_name," + 
                    "order_seq," + 
                    "use_yn," + 
                    "level_code," + 
                    "retire_rate," + 
                    "levelup_obj_yn," + 
                    "levelup_year," + 
                    "levelup_paystep," + 
                    "start_paystep," + 
                    "limit_paystep," + 
                    "minus_year," + 
                    "old_grade_code )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_grade_code);
      gpstatement.bindColumn(2, idx_grade_name);
      gpstatement.bindColumn(3, idx_order_seq);
      gpstatement.bindColumn(4, idx_use_yn);
      gpstatement.bindColumn(5, idx_level_code);
      gpstatement.bindColumn(6, idx_retire_rate);
      gpstatement.bindColumn(7, idx_levelup_obj_yn);
      gpstatement.bindColumn(8, idx_levelup_year);
      gpstatement.bindColumn(9, idx_levelup_paystep);
      gpstatement.bindColumn(10, idx_start_paystep);
      gpstatement.bindColumn(11, idx_limit_paystep);
      gpstatement.bindColumn(12, idx_minus_year);
      gpstatement.bindColumn(13, idx_old_grade_code);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_code_grade set " + 
                            "grade_code=?,  " + 
                            "grade_name=?,  " + 
                            "order_seq=?,  " + 
                            "use_yn=?,  " + 
                            "level_code=?,  " + 
                            "retire_rate=?,  " + 
                            "levelup_obj_yn=?,  " + 
                            "levelup_year=?,  " + 
                            "levelup_paystep=?,  " + 
                            "start_paystep=?,  " + 
                            "limit_paystep=?,  " + 
                            "minus_year=?,  " + 
                            "old_grade_code=?  where grade_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_grade_code);
      gpstatement.bindColumn(2, idx_grade_name);
      gpstatement.bindColumn(3, idx_order_seq);
      gpstatement.bindColumn(4, idx_use_yn);
      gpstatement.bindColumn(5, idx_level_code);
      gpstatement.bindColumn(6, idx_retire_rate);
      gpstatement.bindColumn(7, idx_levelup_obj_yn);
      gpstatement.bindColumn(8, idx_levelup_year);
      gpstatement.bindColumn(9, idx_levelup_paystep);
      gpstatement.bindColumn(10, idx_start_paystep);
      gpstatement.bindColumn(11, idx_limit_paystep);
      gpstatement.bindColumn(12, idx_minus_year);
      gpstatement.bindColumn(13, idx_old_grade_code);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(14, idx_grade_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_code_grade where grade_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_grade_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
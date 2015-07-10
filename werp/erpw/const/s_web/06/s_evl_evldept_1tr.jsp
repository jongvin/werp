<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_evl_evldept_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_evl_year = dSet.indexOfColumn("evl_year");
   	int idx_degree = dSet.indexOfColumn("degree");
   	int idx_evl_class = dSet.indexOfColumn("evl_class");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_long_name = dSet.indexOfColumn("long_name");
   	int idx_evl_yn = dSet.indexOfColumn("evl_yn");
   	int idx_t_id = dSet.indexOfColumn("t_id");
   	int idx_t_name = dSet.indexOfColumn("t_name");
   	int idx_a_id = dSet.indexOfColumn("a_id");
   	int idx_a_name = dSet.indexOfColumn("a_name");
   	int idx_m_id = dSet.indexOfColumn("m_id");
   	int idx_m_name = dSet.indexOfColumn("m_name");
   	int idx_e_id = dSet.indexOfColumn("e_id");
   	int idx_e_name = dSet.indexOfColumn("e_name");
   	int idx_c_id = dSet.indexOfColumn("c_id");
   	int idx_c_name = dSet.indexOfColumn("c_name");
   	int idx_j_id = dSet.indexOfColumn("j_id");
   	int idx_j_name = dSet.indexOfColumn("j_name");
   	int idx_mat_id = dSet.indexOfColumn("mat_id");
   	int idx_mat_name = dSet.indexOfColumn("mat_name");
   	int idx_id2 = dSet.indexOfColumn("id2");
   	int idx_name2 = dSet.indexOfColumn("name2");
   	int idx_eva_score = dSet.indexOfColumn("eva_score");
   	int idx_ctrl_score = dSet.indexOfColumn("ctrl_score");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_EVL_EVLDEPT ( evl_year," + 
                    "degree," + 
                    "evl_class," + 
                    "dept_code," + 
                    "long_name," + 
                    "evl_yn," + 
                    "t_id," + 
                    "t_name," + 
                    "a_id," + 
                    "a_name," + 
                    "m_id," + 
                    "m_name," + 
                    "e_id," + 
                    "e_name," + 
                    "c_id," + 
                    "c_name," + 
                    "j_id," + 
                    "j_name," + 
                    "mat_id," + 
                    "mat_name," + 
                    "id2," + 
                    "name2," + 
                    "eva_score," + 
                    "ctrl_score )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_evl_year);
      gpstatement.bindColumn(2, idx_degree);
      gpstatement.bindColumn(3, idx_evl_class);
      gpstatement.bindColumn(4, idx_dept_code);
      gpstatement.bindColumn(5, idx_long_name);
      gpstatement.bindColumn(6, idx_evl_yn);
      gpstatement.bindColumn(7, idx_t_id);
      gpstatement.bindColumn(8, idx_t_name);
      gpstatement.bindColumn(9, idx_a_id);
      gpstatement.bindColumn(10, idx_a_name);
      gpstatement.bindColumn(11, idx_m_id);
      gpstatement.bindColumn(12, idx_m_name);
      gpstatement.bindColumn(13, idx_e_id);
      gpstatement.bindColumn(14, idx_e_name);
      gpstatement.bindColumn(15, idx_c_id);
      gpstatement.bindColumn(16, idx_c_name);
      gpstatement.bindColumn(17, idx_j_id);
      gpstatement.bindColumn(18, idx_j_name);
      gpstatement.bindColumn(19, idx_mat_id);
      gpstatement.bindColumn(20, idx_mat_name);
      gpstatement.bindColumn(21, idx_id2);
      gpstatement.bindColumn(22, idx_name2);
      gpstatement.bindColumn(23, idx_eva_score);
      gpstatement.bindColumn(24, idx_ctrl_score);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_evl_evldept set " + 
                            "evl_year=?,  " + 
                            "degree=?,  " + 
                            "evl_class=?,  " + 
                            "dept_code=?,  " + 
                            "long_name=?,  " + 
                            "evl_yn=?,  " + 
                            "t_id=?,  " + 
                            "t_name=?,  " + 
                            "a_id=?,  " + 
                            "a_name=?,  " + 
                            "m_id=?,  " + 
                            "m_name=?,  " + 
                            "e_id=?,  " + 
                            "e_name=?,  " + 
                            "c_id=?,  " + 
                            "c_name=?,  " + 
                            "j_id=?,  " + 
                            "j_name=?,  " + 
                            "mat_id=?,  " + 
                            "mat_name=?,  " + 
                            "id2=?,  " + 
                            "name2=?,  " + 
                            "eva_score=?,  " + 
                            "ctrl_score=?  where evl_year=? " +
                            "                and degree=? " +
                            "                and evl_class=? " +
                            "                and dept_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_evl_year);
      gpstatement.bindColumn(2, idx_degree);
      gpstatement.bindColumn(3, idx_evl_class);
      gpstatement.bindColumn(4, idx_dept_code);
      gpstatement.bindColumn(5, idx_long_name);
      gpstatement.bindColumn(6, idx_evl_yn);
      gpstatement.bindColumn(7, idx_t_id);
      gpstatement.bindColumn(8, idx_t_name);
      gpstatement.bindColumn(9, idx_a_id);
      gpstatement.bindColumn(10, idx_a_name);
      gpstatement.bindColumn(11, idx_m_id);
      gpstatement.bindColumn(12, idx_m_name);
      gpstatement.bindColumn(13, idx_e_id);
      gpstatement.bindColumn(14, idx_e_name);
      gpstatement.bindColumn(15, idx_c_id);
      gpstatement.bindColumn(16, idx_c_name);
      gpstatement.bindColumn(17, idx_j_id);
      gpstatement.bindColumn(18, idx_j_name);
      gpstatement.bindColumn(19, idx_mat_id);
      gpstatement.bindColumn(20, idx_mat_name);
      gpstatement.bindColumn(21, idx_id2);
      gpstatement.bindColumn(22, idx_name2);
      gpstatement.bindColumn(23, idx_eva_score);
      gpstatement.bindColumn(24, idx_ctrl_score);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(25, idx_evl_year);
      gpstatement.bindColumn(26, idx_degree);
      gpstatement.bindColumn(27, idx_evl_class);
      gpstatement.bindColumn(28, idx_dept_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_evl_evldept where evl_year=? " + 
                            "                and degree=? " +
                            "                and evl_class=? " +
                            "                and dept_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_evl_year);
      gpstatement.bindColumn(2, idx_degree);
      gpstatement.bindColumn(3, idx_evl_class);
      gpstatement.bindColumn(4, idx_dept_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
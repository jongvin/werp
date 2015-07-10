<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_week_status_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_week_date = dSet.indexOfColumn("week_date");
   	int idx_master_confirm = dSet.indexOfColumn("master_confirm");
   	int idx_a_this = dSet.indexOfColumn("a_this");
   	int idx_a_next = dSet.indexOfColumn("a_next");
   	int idx_c_this = dSet.indexOfColumn("c_this");
   	int idx_c_next = dSet.indexOfColumn("c_next");
   	int idx_l_this = dSet.indexOfColumn("l_this");
   	int idx_l_next = dSet.indexOfColumn("l_next");
   	int idx_e_this = dSet.indexOfColumn("e_this");
   	int idx_e_next = dSet.indexOfColumn("e_next");
   	int idx_m_this = dSet.indexOfColumn("m_this");
   	int idx_m_next = dSet.indexOfColumn("m_next");
   	int idx_t_this = dSet.indexOfColumn("t_this");
   	int idx_t_next = dSet.indexOfColumn("t_next");
   	int idx_main_this = dSet.indexOfColumn("main_this");
   	int idx_main_next = dSet.indexOfColumn("main_next");
   	int idx_problem_this = dSet.indexOfColumn("problem_this");
   	int idx_problem_next = dSet.indexOfColumn("problem_next");
   	int idx_photo_addr = dSet.indexOfColumn("photo_addr");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO c_week_status ( dept_code," + 
                    "week_date," + 
                    "master_confirm," + 
                    "a_this," + 
                    "a_next," + 
                    "c_this," + 
                    "c_next," + 
                    "l_this," + 
                    "l_next," + 
                    "e_this," + 
                    "e_next," + 
                    "m_this," + 
                    "m_next," + 
                    "t_this," + 
                    "t_next," + 
                    "main_this," + 
                    "main_next," + 
                    "problem_this," + 
                    "problem_next," + 
                    "photo_addr )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_week_date);
      gpstatement.bindColumn(3, idx_master_confirm);
      gpstatement.bindColumn(4, idx_a_this);
      gpstatement.bindColumn(5, idx_a_next);
      gpstatement.bindColumn(6, idx_c_this);
      gpstatement.bindColumn(7, idx_c_next);
      gpstatement.bindColumn(8, idx_l_this);
      gpstatement.bindColumn(9, idx_l_next);
      gpstatement.bindColumn(10, idx_e_this);
      gpstatement.bindColumn(11, idx_e_next);
      gpstatement.bindColumn(12, idx_m_this);
      gpstatement.bindColumn(13, idx_m_next);
      gpstatement.bindColumn(14, idx_t_this);
      gpstatement.bindColumn(15, idx_t_next);
      gpstatement.bindColumn(16, idx_main_this);
      gpstatement.bindColumn(17, idx_main_next);
      gpstatement.bindColumn(18, idx_problem_this);
      gpstatement.bindColumn(19, idx_problem_next);
      gpstatement.bindColumn(20, idx_photo_addr);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update c_week_status set " + 
                            "dept_code=?,  " + 
                            "week_date=?,  " + 
                            "master_confirm=?,  " + 
                            "a_this=?,  " + 
                            "a_next=?,  " + 
                            "c_this=?,  " + 
                            "c_next=?,  " + 
                            "l_this=?,  " + 
                            "l_next=?,  " + 
                            "e_this=?,  " + 
                            "e_next=?,  " + 
                            "m_this=?,  " + 
                            "m_next=?,  " + 
                            "t_this=?,  " + 
                            "t_next=?,  " + 
                            "main_this=?,  " + 
                            "main_next=?,  " + 
                            "problem_this=?,  " + 
                            "problem_next=?,  " + 
                            "photo_addr=?  where dept_code=? and week_date=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_week_date);
      gpstatement.bindColumn(3, idx_master_confirm);
      gpstatement.bindColumn(4, idx_a_this);
      gpstatement.bindColumn(5, idx_a_next);
      gpstatement.bindColumn(6, idx_c_this);
      gpstatement.bindColumn(7, idx_c_next);
      gpstatement.bindColumn(8, idx_l_this);
      gpstatement.bindColumn(9, idx_l_next);
      gpstatement.bindColumn(10, idx_e_this);
      gpstatement.bindColumn(11, idx_e_next);
      gpstatement.bindColumn(12, idx_m_this);
      gpstatement.bindColumn(13, idx_m_next);
      gpstatement.bindColumn(14, idx_t_this);
      gpstatement.bindColumn(15, idx_t_next);
      gpstatement.bindColumn(16, idx_main_this);
      gpstatement.bindColumn(17, idx_main_next);
      gpstatement.bindColumn(18, idx_problem_this);
      gpstatement.bindColumn(19, idx_problem_next);
      gpstatement.bindColumn(20, idx_photo_addr);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(21, idx_dept_code);
      gpstatement.bindColumn(22, idx_week_date);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from c_week_status where dept_code=? and week_date=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_week_date);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
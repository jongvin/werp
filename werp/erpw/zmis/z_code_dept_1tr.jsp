<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("z_code_dept_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
   	int idx_long_name = dSet.indexOfColumn("long_name");
   	int idx_short_name = dSet.indexOfColumn("short_name");
   	int idx_english_name = dSet.indexOfColumn("english_name");
   	int idx_dept_seq_key = dSet.indexOfColumn("dept_seq_key");
   	int idx_dept_proj_tag = dSet.indexOfColumn("dept_proj_tag");
   	int idx_use_tag = dSet.indexOfColumn("use_tag");
   	int idx_const_start_date = dSet.indexOfColumn("const_start_date");
   	int idx_const_end_date = dSet.indexOfColumn("const_end_date");
   	int idx_chg_const_start_date = dSet.indexOfColumn("chg_const_start_date");
   	int idx_chg_const_end_date = dSet.indexOfColumn("chg_const_end_date");
   	int idx_const_term = dSet.indexOfColumn("const_term");
   	int idx_chg_const_term = dSet.indexOfColumn("chg_const_term");
   	int idx_process_code = dSet.indexOfColumn("process_code");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO z_code_dept ( dept_code," + 
                    "comp_code," + 
                    "long_name," + 
                    "short_name," + 
                    "english_name," + 
                    "dept_seq_key," + 
                    "dept_proj_tag," + 
                    "use_tag,      " + 
                    "const_start_date,      " +
                    "const_end_date,      " +
                    "chg_const_start_date,      " +
                    "chg_const_end_date, " + 
                    "const_term, " + 
                    "chg_const_term, " + 
                    "process_code)      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8 ,:9, :10, :11, :12, :13, :14, :15 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_comp_code);
      gpstatement.bindColumn(3, idx_long_name);
      gpstatement.bindColumn(4, idx_short_name);
      gpstatement.bindColumn(5, idx_english_name);
      gpstatement.bindColumn(6, idx_dept_seq_key);
      gpstatement.bindColumn(7, idx_dept_proj_tag);
      gpstatement.bindColumn(8, idx_use_tag);
      gpstatement.bindColumn(9, idx_const_start_date);
      gpstatement.bindColumn(10, idx_const_end_date);
      gpstatement.bindColumn(11, idx_chg_const_start_date);
      gpstatement.bindColumn(12, idx_chg_const_end_date);
      gpstatement.bindColumn(13, idx_const_term);
      gpstatement.bindColumn(14, idx_chg_const_term);
      gpstatement.bindColumn(15, idx_process_code);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update z_code_dept set " + 
                            "dept_code=?,  " + 
                            "comp_code=?,  " + 
                            "long_name=?,  " + 
                            "short_name=?,  " + 
                            "english_name=?,  " + 
                            "dept_seq_key=?,  " + 
                            "dept_proj_tag=?,  " + 
                            "use_tag=?, " +   
                            "const_start_date=?, " +   
                            "const_end_date=?, " +   
                            "chg_const_start_date=?, " +   
                            "chg_const_end_date=?, " +   
                            "const_term=?, " +   
                            "chg_const_term=?, " +   
                            "process_code=? " +   
                            " where (dept_code=?)";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_comp_code);
      gpstatement.bindColumn(3, idx_long_name);
      gpstatement.bindColumn(4, idx_short_name);
      gpstatement.bindColumn(5, idx_english_name);
      gpstatement.bindColumn(6, idx_dept_seq_key);
      gpstatement.bindColumn(7, idx_dept_proj_tag);
      gpstatement.bindColumn(8, idx_use_tag);
      gpstatement.bindColumn(9, idx_const_start_date);
      gpstatement.bindColumn(10, idx_const_end_date);
      gpstatement.bindColumn(11, idx_chg_const_start_date);
      gpstatement.bindColumn(12, idx_chg_const_end_date);
      gpstatement.bindColumn(13, idx_const_term);
      gpstatement.bindColumn(14, idx_chg_const_term);
      gpstatement.bindColumn(15, idx_process_code);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(16, idx_dept_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from z_code_dept where (dept_code=?) "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../comm_function/conn_tr_end.jsp"%>
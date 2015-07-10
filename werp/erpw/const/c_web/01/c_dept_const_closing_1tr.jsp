<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_dept_const_closing_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymmdd = dSet.indexOfColumn("yymmdd");
   	int idx_key_yymmdd = dSet.indexOfColumn("key_yymmdd");
   	int idx_bonsa_close = dSet.indexOfColumn("bonsa_close");
   	int idx_cost_close = dSet.indexOfColumn("cost_close");
   	int idx_s_close = dSet.indexOfColumn("s_close");
   	int idx_m_close = dSet.indexOfColumn("m_close");
   	int idx_l_close = dSet.indexOfColumn("l_close");
   	int idx_q_close = dSet.indexOfColumn("q_close");
   	int idx_f_close = dSet.indexOfColumn("f_close");
   	int idx_bigo1 = dSet.indexOfColumn("bigo1");
   	int idx_bigo2 = dSet.indexOfColumn("bigo2");
   	int idx_bigo3 = dSet.indexOfColumn("bigo3");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO c_spec_const_closing ( dept_code," + 
		              "yymm, " +
                    "bonsa_close, " +
						  "cost_close, " +
						  "s_close, " +
						  "m_close, " +
						  "l_close, " +
						  "q_close, " +
						  "f_close, " +
						  "bigo1, " +
						  "bigo2, " +
						  "bigo3	 )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_bonsa_close);
      gpstatement.bindColumn(4, idx_cost_close);
      gpstatement.bindColumn(5, idx_s_close);
      gpstatement.bindColumn(6, idx_m_close);
      gpstatement.bindColumn(7, idx_l_close);
      gpstatement.bindColumn(8, idx_q_close);
      gpstatement.bindColumn(9, idx_f_close);
      gpstatement.bindColumn(10, idx_bigo1);
      gpstatement.bindColumn(11, idx_bigo2);
      gpstatement.bindColumn(12, idx_bigo3);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update c_spec_const_closing set " + 
                    "dept_code=?," +
                    "yymm=?, " +
                    "bonsa_close=?, " +
						  "cost_close=?, " +
						  "s_close=?, " +
						  "m_close=?, " +
						  "l_close=?, " +
						  "q_close=?, " +
						  "f_close=?, " +
						  "bigo1=?, " +
						  "bigo2=?, " +
						  "bigo3=?  where dept_code=? and yymm=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_bonsa_close);
      gpstatement.bindColumn(4, idx_cost_close);
      gpstatement.bindColumn(5, idx_s_close);
      gpstatement.bindColumn(6, idx_m_close);
      gpstatement.bindColumn(7, idx_l_close);
      gpstatement.bindColumn(8, idx_q_close);
      gpstatement.bindColumn(9, idx_f_close);
      gpstatement.bindColumn(10, idx_bigo1);
      gpstatement.bindColumn(11, idx_bigo2);
      gpstatement.bindColumn(12, idx_bigo3);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(13, idx_dept_code);
      gpstatement.bindColumn(14, idx_key_yymmdd);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from c_spec_const_closing where dept_code=? and yymm=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_key_yymmdd);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
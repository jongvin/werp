<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_title_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_title_code = dSet.indexOfColumn("title_code");
   	int idx_title_name = dSet.indexOfColumn("title_name");
   	int idx_title_evaluator1 = dSet.indexOfColumn("title_evaluator1");
   	int idx_title_evaluator2 = dSet.indexOfColumn("title_evaluator2");
   	int idx_seq = dSet.indexOfColumn("seq");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_code_title ( title_code," + 
                    "title_name, title_evaluator1, title_evaluator2, seq )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_title_code);
      gpstatement.bindColumn(2, idx_title_name);
      gpstatement.bindColumn(3, idx_title_evaluator1);
      gpstatement.bindColumn(4, idx_title_evaluator2);
      gpstatement.bindColumn(5, idx_seq);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_code_title set " + 
                            "title_code=?,  " + 
                            "title_name=?, title_evaluator1=?, title_evaluator2=?, seq=?  where title_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_title_code);
      gpstatement.bindColumn(2, idx_title_name);
      gpstatement.bindColumn(3, idx_title_evaluator1);
      gpstatement.bindColumn(4, idx_title_evaluator2);
      gpstatement.bindColumn(5, idx_seq);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(6, idx_title_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_code_title where title_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_title_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
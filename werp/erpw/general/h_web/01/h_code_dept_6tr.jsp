<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_code_dept_5tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_rank_code = dSet.indexOfColumn("rank_code");
	int idx_key_1 = dSet.indexOfColumn("key_1");
   	int idx_key_2 = dSet.indexOfColumn("key_2");
   	int idx_draw_date = dSet.indexOfColumn("draw_date");
   	int idx_refund_date = dSet.indexOfColumn("refund_date");
   	int idx_contract_date = dSet.indexOfColumn("contract_date");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_subs_regist ( dept_code," + 
                    "rank_code," + 
                    "draw_date," + 
                    "refund_date," + 
                    "contract_date )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_rank_code);
      gpstatement.bindColumn(3, idx_draw_date);
      gpstatement.bindColumn(4, idx_refund_date);
      gpstatement.bindColumn(5, idx_contract_date);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_subs_regist set " + 
                            "dept_code=?,  " + 
                            "rank_code=?,  " + 
                            "draw_date=?,  " + 
                            "refund_date=?,  " + 
                            "contract_date=?  "+
	                        "where dept_code=?  and rank_code=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_rank_code);
      gpstatement.bindColumn(3, idx_draw_date);
      gpstatement.bindColumn(4, idx_refund_date);
      gpstatement.bindColumn(5, idx_contract_date);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(6, idx_key_1);
      gpstatement.bindColumn(7, idx_key_2);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_subs_regist where dept_code=? and rank_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_key_1);
      gpstatement.bindColumn(2, idx_key_2);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
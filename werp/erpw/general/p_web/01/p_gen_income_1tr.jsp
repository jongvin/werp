<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_gen_income_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_gen_income_code = dSet.indexOfColumn("gen_income_code");
   	int idx_gen_income_name = dSet.indexOfColumn("gen_income_name");
   	int idx_use_yn = dSet.indexOfColumn("use_yn");
   	int idx_print_order = dSet.indexOfColumn("print_order");
   	int idx_amt = dSet.indexOfColumn("amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_code_gen_income ( gen_income_code," + 
                    "gen_income_name," + 
                    "use_yn," + 
                    "print_order, amt )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_gen_income_code);
      gpstatement.bindColumn(2, idx_gen_income_name);
      gpstatement.bindColumn(3, idx_use_yn);
      gpstatement.bindColumn(4, idx_print_order);
      gpstatement.bindColumn(5, idx_amt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_code_gen_income set " + 
                            "gen_income_code=?,  " + 
                            "gen_income_name=?,  " + 
                            "use_yn=?,  " + 
                            "print_order=?, amt=?  where gen_income_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_gen_income_code);
      gpstatement.bindColumn(2, idx_gen_income_name);
      gpstatement.bindColumn(3, idx_use_yn);
      gpstatement.bindColumn(4, idx_print_order);
      gpstatement.bindColumn(5, idx_amt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(6, idx_gen_income_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_code_gen_income where gen_income_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_gen_income_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
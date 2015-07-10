<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_gena_acnt_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_gena_acnt_code = dSet.indexOfColumn("gena_acnt_code");
   	int idx_gena_acnt_name = dSet.indexOfColumn("gena_acnt_name");
   	int idx_use_yn = dSet.indexOfColumn("use_yn");
   	int idx_print_order = dSet.indexOfColumn("print_order");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_code_gena_acnt ( gena_acnt_code," + 
                    "gena_acnt_name," + 
                    "use_yn," + 
                    "print_order )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_gena_acnt_code);
      gpstatement.bindColumn(2, idx_gena_acnt_name);
      gpstatement.bindColumn(3, idx_use_yn);
      gpstatement.bindColumn(4, idx_print_order);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_code_gena_acnt set " + 
                            "gena_acnt_code=?,  " + 
                            "gena_acnt_name=?,  " + 
                            "use_yn=?,  " + 
                            "print_order=?  where gena_acnt_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_gena_acnt_code);
      gpstatement.bindColumn(2, idx_gena_acnt_name);
      gpstatement.bindColumn(3, idx_use_yn);
      gpstatement.bindColumn(4, idx_print_order);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(5, idx_gena_acnt_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_code_gena_acnt where gena_acnt_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_gena_acnt_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
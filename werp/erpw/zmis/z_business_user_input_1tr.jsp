<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("z_business_user_input_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_user_code = dSet.indexOfColumn("user_code");
   	int idx_password = dSet.indexOfColumn("password");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_vender_code = dSet.indexOfColumn("vender_code");
   	int idx_sbcr_name = dSet.indexOfColumn("sbcr_name");
   	int idx_businessman_number = dSet.indexOfColumn("businessman_number");
   	int idx_gubun = dSet.indexOfColumn("gubun");
   	int idx_note = dSet.indexOfColumn("note");
   	int idx_comp_user_code = dSet.indexOfColumn("comp_user_code");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO z_webuser_code ( user_code," + 
                    "password," + 
                    "sbcr_code," +
                    "vender_code," +
                    "sbcr_name," +
                    "businessman_number," + 
                    "gubun," + 
                    "note " + 
                    " )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_user_code);
      gpstatement.bindColumn(2, idx_password);
      gpstatement.bindColumn(3, idx_sbcr_code);
      gpstatement.bindColumn(4, idx_vender_code);
      gpstatement.bindColumn(5, idx_sbcr_name);
      gpstatement.bindColumn(6, idx_businessman_number);
      gpstatement.bindColumn(7, idx_gubun);
      gpstatement.bindColumn(8, idx_note);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update z_webuser_code set " + 
                            "user_code=?,  " + 
                            "password=?,  " + 
                            "sbcr_code=?, " +
                            "vender_code=?, " +
                            "sbcr_name=?, " +
                            "businessman_number=?,  " + 
                            "gubun=?,  " + 
                            "note=? " + 
                            "  where user_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_user_code);
      gpstatement.bindColumn(2, idx_password);
      gpstatement.bindColumn(3, idx_sbcr_code);
      gpstatement.bindColumn(4, idx_vender_code);
      gpstatement.bindColumn(5, idx_sbcr_name);
      gpstatement.bindColumn(6, idx_businessman_number);
      gpstatement.bindColumn(7, idx_gubun);
      gpstatement.bindColumn(8, idx_note);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(9, idx_comp_user_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from z_webuser_code where user_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_comp_user_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../comm_function/conn_tr_end.jsp"%>
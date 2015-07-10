<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../comm_function/conn_tr_pool.jsp"%><% 
     GauceDataSet dSet = req.getGauceDataSet("z_code_comp_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
   	int idx_comp_name = dSet.indexOfColumn("comp_name");
   	int idx_comp_addr = dSet.indexOfColumn("comp_addr");
   	int idx_comp_owner = dSet.indexOfColumn("comp_owner");
   	int idx_business_number = dSet.indexOfColumn("business_number");
   	int idx_uptae = dSet.indexOfColumn("uptae");
   	int idx_upjong = dSet.indexOfColumn("upjong");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO z_code_comp ( comp_code," + 
                    "comp_name, comp_addr, comp_owner,business_number,uptae,upjong )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4 ,:5 ,:6 ,:7) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_comp_code);
      gpstatement.bindColumn(2, idx_comp_name);
      gpstatement.bindColumn(3, idx_comp_addr);
      gpstatement.bindColumn(4, idx_comp_owner);
      gpstatement.bindColumn(5, idx_business_number);
      gpstatement.bindColumn(6, idx_uptae);
      gpstatement.bindColumn(7, idx_upjong);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update z_code_comp set " + 
                            "comp_code=?,  " + 
                            "comp_name=?, comp_addr=?, comp_owner=?,business_number=?,uptae=?,upjong=?  where comp_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_comp_code);
      gpstatement.bindColumn(2, idx_comp_name);
      gpstatement.bindColumn(3, idx_comp_addr);
      gpstatement.bindColumn(4, idx_comp_owner);
      gpstatement.bindColumn(5, idx_business_number);
      gpstatement.bindColumn(6, idx_uptae);
      gpstatement.bindColumn(7, idx_upjong);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_comp_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from z_code_comp where comp_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_comp_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../comm_function/conn_tr_end.jsp"%>
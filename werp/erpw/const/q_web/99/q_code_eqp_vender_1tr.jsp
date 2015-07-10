<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("q_code_eqp_vender_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_regist_no = dSet.indexOfColumn("regist_no");
   	int idx_key_regist_no = dSet.indexOfColumn("key_regist_no");
   	int idx_eqp_vender_name = dSet.indexOfColumn("eqp_vender_name");
   	int idx_pregident_name = dSet.indexOfColumn("pregident_name");
   	int idx_address = dSet.indexOfColumn("address");
   	int idx_tel_no = dSet.indexOfColumn("tel_no");
   	int idx_company_no = dSet.indexOfColumn("company_no");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_cust_type = dSet.indexOfColumn("cust_type");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO Q_CODE_EQP_VENDER ( regist_no," + 
                    "eqp_vender_name," + 
                    "pregident_name," + 
                    "address," + 
                    "tel_no," + 
                    "company_no," + 
                    "remark, " +
                    "cust_type  )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_regist_no);
      gpstatement.bindColumn(2, idx_eqp_vender_name);
      gpstatement.bindColumn(3, idx_pregident_name);
      gpstatement.bindColumn(4, idx_address);
      gpstatement.bindColumn(5, idx_tel_no);
      gpstatement.bindColumn(6, idx_company_no);
      gpstatement.bindColumn(7, idx_remark);
      gpstatement.bindColumn(8, idx_cust_type);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update q_code_eqp_vender set " + 
                            "regist_no=?,  " + 
                            "eqp_vender_name=?,  " + 
                            "pregident_name=?,  " + 
                            "address=?,  " + 
                            "tel_no=?,  " + 
                            "company_no=?,  " + 
                            "remark=?, " +
                            "cust_type=?  where regist_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_regist_no);
      gpstatement.bindColumn(2, idx_eqp_vender_name);
      gpstatement.bindColumn(3, idx_pregident_name);
      gpstatement.bindColumn(4, idx_address);
      gpstatement.bindColumn(5, idx_tel_no);
      gpstatement.bindColumn(6, idx_company_no);
      gpstatement.bindColumn(7, idx_remark);
      gpstatement.bindColumn(8, idx_cust_type);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(9, idx_key_regist_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from q_code_eqp_vender where regist_no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_key_regist_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
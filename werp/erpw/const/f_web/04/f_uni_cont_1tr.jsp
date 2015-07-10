<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("f_uni_cont_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_cust_code = dSet.indexOfColumn("cust_code");
   	int idx_company_tag = dSet.indexOfColumn("company_tag");
   	int idx_operation_tag = dSet.indexOfColumn("operation_tag");
   	int idx_division_rate = dSet.indexOfColumn("division_rate");
   	int idx_charger = dSet.indexOfColumn("charger");
   	int idx_tel = dSet.indexOfColumn("tel");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO F_UNI_CONT ( dept_code," + 
                    "cust_code," + 
                    "company_tag," + 
                    "operation_tag," + 
                    "division_rate, " + 
                    "charger, " + 
                    "tel, " + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_cust_code );
      gpstatement.bindColumn(3, idx_company_tag);
      gpstatement.bindColumn(4, idx_operation_tag);
      gpstatement.bindColumn(5, idx_division_rate);
      gpstatement.bindColumn(6, idx_charger);
      gpstatement.bindColumn(7, idx_tel);
      gpstatement.bindColumn(8, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
       String sSql = "update f_uni_cont "+
       					   "set dept_code=?,  " + 
                            "cust_code=?,  " + 
                            "company_tag=?,  " + 
                            "operation_tag=?,  " + 
                            "division_rate=?,  " + 
                            "charger=?,  " + 
                            "tel=?,  " + 
                            "remark=?  " +
                      "where dept_code=?  and " +
                            "cust_code=? ";
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_cust_code);
      gpstatement.bindColumn(3, idx_company_tag);
      gpstatement.bindColumn(4, idx_operation_tag);
      gpstatement.bindColumn(5, idx_division_rate);
      gpstatement.bindColumn(6, idx_charger);
      gpstatement.bindColumn(7, idx_tel);
      gpstatement.bindColumn(8, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(9, idx_dept_code);
      gpstatement.bindColumn(10, idx_cust_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from f_uni_cont where dept_code=? and cust_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_cust_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
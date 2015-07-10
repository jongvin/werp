<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("r_contract_succesful_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_cont_no = dSet.indexOfColumn("cont_no");
   	int idx_chg_degree = dSet.indexOfColumn("chg_degree");
   	int idx_membership_no = dSet.indexOfColumn("membership_no");
   	int idx_customer_no = dSet.indexOfColumn("customer_no");
   	int idx_company_tag = dSet.indexOfColumn("company_tag");
   	int idx_operation_tag = dSet.indexOfColumn("operation_tag");
   	int idx_division_rate = dSet.indexOfColumn("division_rate");
   	int idx_division_amt = dSet.indexOfColumn("division_amt");
   	int idx_operation_rate = dSet.indexOfColumn("operation_rate");
   	int idx_operation_amt = dSet.indexOfColumn("operation_amt");
   	int idx_charger = dSet.indexOfColumn("charger");
   	int idx_tel = dSet.indexOfColumn("tel");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO R_CONTRACT_SUCCESFUL_BID ( dept_code," + 
                    "cont_no," + 
                    "chg_degree," + 
                    "membership_no," + 
                    "customer_no," + 
                    "company_tag," + 
                    "operation_tag," + 
                    "division_rate," + 
                    "division_amt," + 
                    "operation_rate," + 
                    "operation_amt," + 
                    "charger," + 
                    "tel," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_cont_no);
      gpstatement.bindColumn(3, idx_chg_degree);
      gpstatement.bindColumn(4, idx_membership_no);
      gpstatement.bindColumn(5, idx_customer_no);
      gpstatement.bindColumn(6, idx_company_tag);
      gpstatement.bindColumn(7, idx_operation_tag);
      gpstatement.bindColumn(8, idx_division_rate);
      gpstatement.bindColumn(9, idx_division_amt);
      gpstatement.bindColumn(10, idx_operation_rate);
      gpstatement.bindColumn(11, idx_operation_amt);
      gpstatement.bindColumn(12, idx_charger);
      gpstatement.bindColumn(13, idx_tel);
      gpstatement.bindColumn(14, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update r_contract_succesful_bid set " + 
                            "dept_code=?,  " + 
                            "cont_no=?,  " + 
                            "chg_degree=?,  " + 
                            "membership_no=?,  " + 
                            "customer_no=?,  " + 
                            "company_tag=?,  " + 
                            "operation_tag=?,  " + 
                            "division_rate=?,  " + 
                            "division_amt=?,  " + 
                            "operation_rate=?,  " + 
                            "operation_amt=?,  " + 
                            "charger=?,  " + 
                            "tel=?,  " + 
                            "remark=?  where dept_code=? " +
                            " and cont_no=? " +
                            " and chg_degree=? " +
                            " and membership_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_cont_no);
      gpstatement.bindColumn(3, idx_chg_degree);
      gpstatement.bindColumn(4, idx_membership_no);
      gpstatement.bindColumn(5, idx_customer_no);
      gpstatement.bindColumn(6, idx_company_tag);
      gpstatement.bindColumn(7, idx_operation_tag);
      gpstatement.bindColumn(8, idx_division_rate);
      gpstatement.bindColumn(9, idx_division_amt);
      gpstatement.bindColumn(10, idx_operation_rate);
      gpstatement.bindColumn(11, idx_operation_amt);
      gpstatement.bindColumn(12, idx_charger);
      gpstatement.bindColumn(13, idx_tel);
      gpstatement.bindColumn(14, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(15, idx_dept_code);
      gpstatement.bindColumn(16, idx_cont_no);
      gpstatement.bindColumn(17, idx_chg_degree);
      gpstatement.bindColumn(18, idx_membership_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from r_contract_succesful_bid where dept_code=? " +
                            " and cont_no=? " +
                            " and chg_degree=? " +
                            " and membership_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_cont_no);
      gpstatement.bindColumn(3, idx_chg_degree);
      gpstatement.bindColumn(4, idx_membership_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
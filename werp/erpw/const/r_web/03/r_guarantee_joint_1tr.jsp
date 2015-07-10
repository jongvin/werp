<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("r_guarantee_joint_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_guarantee_no = dSet.indexOfColumn("guarantee_no");
   	int idx_order_no = dSet.indexOfColumn("order_no");
   	int idx_seal_no = dSet.indexOfColumn("seal_no");
   	int idx_const_name = dSet.indexOfColumn("const_name");
   	int idx_const_start_date = dSet.indexOfColumn("const_start_date");
   	int idx_const_end_date = dSet.indexOfColumn("const_end_date");
   	int idx_const_amt = dSet.indexOfColumn("const_amt");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_membership_no = dSet.indexOfColumn("membership_no");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO R_GENERAL_GUARANTEE_JOINT ( guarantee_no," + 
                    "order_no," + 
                    "seal_no," + 
                    "const_name," + 
                    "const_start_date," + 
                    "const_end_date," + 
                    "const_amt," + 
                    "remark," + 
                    "membership_no )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_guarantee_no);
      gpstatement.bindColumn(2, idx_order_no);
      gpstatement.bindColumn(3, idx_seal_no);
      gpstatement.bindColumn(4, idx_const_name);
      gpstatement.bindColumn(5, idx_const_start_date);
      gpstatement.bindColumn(6, idx_const_end_date);
      gpstatement.bindColumn(7, idx_const_amt);
      gpstatement.bindColumn(8, idx_remark);
      gpstatement.bindColumn(9, idx_membership_no);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update r_general_guarantee_joint set " + 
                            "guarantee_no=?,  " + 
                            "order_no=?,  " + 
                            "seal_no=?,  " + 
                            "const_name=?,  " + 
                            "const_start_date=?,  " + 
                            "const_end_date=?,  " + 
                            "const_amt=?,  " + 
                            "remark=?,  " + 
                            "membership_no=?  where guarantee_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_guarantee_no);
      gpstatement.bindColumn(2, idx_order_no);
      gpstatement.bindColumn(3, idx_seal_no);
      gpstatement.bindColumn(4, idx_const_name);
      gpstatement.bindColumn(5, idx_const_start_date);
      gpstatement.bindColumn(6, idx_const_end_date);
      gpstatement.bindColumn(7, idx_const_amt);
      gpstatement.bindColumn(8, idx_remark);
      gpstatement.bindColumn(9, idx_membership_no);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(10, idx_guarantee_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from r_general_guarantee_joint where guarantee_no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_guarantee_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
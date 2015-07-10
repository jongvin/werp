<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("v_tech_proposal_plan_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_year = dSet.indexOfColumn("year");
   	int idx_const_summary = dSet.indexOfColumn("const_summary");
   	int idx_leader_name = dSet.indexOfColumn("leader_name");
   	int idx_sale_amt = dSet.indexOfColumn("sale_amt");
   	int idx_save_amt = dSet.indexOfColumn("save_amt");
   	int idx_admit = dSet.indexOfColumn("admit");
   	int idx_man_num = dSet.indexOfColumn("man_num");
	 
	 int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
	String sSql = " INSERT INTO v_tech_proposal_plan_master ( YEAR," + 
                    "DEPT_CODE," + 
                    "CONST_SUMMARY," + 
                    "LEADER_NAME," + 
                    "SALE_AMT," + 
                    "SAVE_AMT, "+
						  "ADMIT,"+
						  "MAN_NUM )";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ,'1' ,:7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_year);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_const_summary);
      gpstatement.bindColumn(4, idx_leader_name);
      gpstatement.bindColumn(5, idx_sale_amt);
      gpstatement.bindColumn(6, idx_save_amt);
      gpstatement.bindColumn(7, idx_man_num);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update v_tech_proposal_plan_master set " + 
                      "CONST_SUMMARY=?,  " + 
                      "LEADER_NAME=?,  " + 
                      "SALE_AMT=?,  " + 
                      "SAVE_AMT=?,  " + 
                      "ADMIT=?,  " + 
                      "MAN_NUM=? " + 
							 " where DEPT_CODE=? and TO_CHAR(YEAR,'YYYY.MM.DD')=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_const_summary);
      gpstatement.bindColumn(2, idx_leader_name);
      gpstatement.bindColumn(3, idx_sale_amt);
      gpstatement.bindColumn(4, idx_save_amt);
      gpstatement.bindColumn(5, idx_admit);
      gpstatement.bindColumn(6, idx_man_num);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(7, idx_dept_code);
      gpstatement.bindColumn(8, idx_year);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from v_tech_proposal_plan_master where DEPT_CODE=? and TO_CHAR(YEAR,'YYYY.MM.DD')=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_year);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
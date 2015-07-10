<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("v_env_price_exe_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_section = dSet.indexOfColumn("section");
   	int idx_env_item = dSet.indexOfColumn("env_item");
   	int idx_contents = dSet.indexOfColumn("contents");
   	int idx_contract_amt = dSet.indexOfColumn("contract_amt");
   	int idx_exe_amt = dSet.indexOfColumn("exe_amt");
   	int idx_before_amt = dSet.indexOfColumn("before_amt");
   	int idx_plan_amt = dSet.indexOfColumn("plan_amt");
   	int idx_tot_amt = dSet.indexOfColumn("tot_amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO v_env_amt ( dept_code," + 
                    "seq," + 
                    "section," + 
                    "env_item," + 
                    "contents," + 
                    "contract_amt," + 
                    "exe_amt," + 
                    "before_amt," + 
                    "plan_amt," + 
                    "tot_amt )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_section);
      gpstatement.bindColumn(4, idx_env_item);
      gpstatement.bindColumn(5, idx_contents);
      gpstatement.bindColumn(6, idx_contract_amt);
      gpstatement.bindColumn(7, idx_exe_amt);
      gpstatement.bindColumn(8, idx_before_amt);
      gpstatement.bindColumn(9, idx_plan_amt);
      gpstatement.bindColumn(10, idx_tot_amt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update v_env_amt set " + 
                            "dept_code=?,  " + 
                            "seq=?,  " + 
                            "section=?,  " + 
                            "env_item=?,  " + 
                            "contents=?,  " + 
                            "contract_amt=?,  " + 
                            "exe_amt=?,  " + 
                            "before_amt=?,  " + 
                            "plan_amt=?,  " + 
                            "tot_amt=?  where dept_code=? and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_section);
      gpstatement.bindColumn(4, idx_env_item);
      gpstatement.bindColumn(5, idx_contents);
      gpstatement.bindColumn(6, idx_contract_amt);
      gpstatement.bindColumn(7, idx_exe_amt);
      gpstatement.bindColumn(8, idx_before_amt);
      gpstatement.bindColumn(9, idx_plan_amt);
      gpstatement.bindColumn(10, idx_tot_amt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(11, idx_dept_code);
      gpstatement.bindColumn(12, idx_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from v_env_amt where dept_code=? and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
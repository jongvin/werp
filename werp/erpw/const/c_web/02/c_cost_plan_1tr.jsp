<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_cost_plan_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_chg_no_seq = dSet.indexOfColumn("chg_no_seq");
   	int idx_yymm = dSet.indexOfColumn("yymm");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_cost_amt = dSet.indexOfColumn("cost_amt");
   	int idx_cnt_amt = dSet.indexOfColumn("cnt_amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO c_cost_plan ( dept_code," + 
                    "yymm," + 
                    "amt," + 
                    "cost_amt,cnt_amt,chg_no_seq )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5 , :6) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_amt);
      gpstatement.bindColumn(4, idx_cost_amt);
      gpstatement.bindColumn(5, idx_cnt_amt);
      gpstatement.bindColumn(6, idx_chg_no_seq);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update c_cost_plan set " + 
                            "dept_code=?,  " + 
                            "yymm=?,  " + 
                            "amt=?,  " + 
                            "cost_amt=?, " + 
                            "cnt_amt=?, " + 
                            "chg_no_seq=? " + 
                            " where dept_code=? and chg_no_seq=? and yymm=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_amt);
      gpstatement.bindColumn(4, idx_cost_amt);
      gpstatement.bindColumn(5, idx_cnt_amt);
      gpstatement.bindColumn(6, idx_chg_no_seq);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(7, idx_dept_code);
      gpstatement.bindColumn(8, idx_chg_no_seq);
      gpstatement.bindColumn(9, idx_yymm);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from c_cost_plan where dept_code=? and chg_no_seq=? and yymm=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      gpstatement.bindColumn(3, idx_yymm);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
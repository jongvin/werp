<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("y_chg_budget_parent_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_chg_no_seq = dSet.indexOfColumn("chg_no_seq");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_sum_code = dSet.indexOfColumn("sum_code");
   	int idx_direct_class = dSet.indexOfColumn("direct_class");
   	int idx_wbs_code = dSet.indexOfColumn("wbs_code");
   	int idx_llevel = dSet.indexOfColumn("llevel");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_ssize = dSet.indexOfColumn("ssize");
   	int idx_unit = dSet.indexOfColumn("unit");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_input_dt = dSet.indexOfColumn("input_dt");
   	int idx_input_name = dSet.indexOfColumn("input_name");
   	int idx_parent_sum_code = dSet.indexOfColumn("parent_sum_code");
   	int idx_invest_class = dSet.indexOfColumn("invest_class");
   	int idx_division = dSet.indexOfColumn("division");
   	
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO y_chg_budget_parent ( dept_code," + 
                    "chg_no_seq," + 
                    "spec_no_seq," + 
                    "no_seq," + 
                    "sum_code," + 
                    "direct_class," + 
                    "wbs_code," + 
                    "llevel," + 
                    "name," + 
                    "ssize," + 
                    "unit," + 
                    "remark," + 
                    "input_dt," + 
                    "input_name, " + 
                    "parent_sum_code, " +
                    "invest_class,division) " ;
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, TO_DATE(:13,'YYYY.MM.DD'), :14, :15, :16, :17) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_no_seq);
      gpstatement.bindColumn(5, idx_sum_code);
      gpstatement.bindColumn(6, idx_direct_class);
      gpstatement.bindColumn(7, idx_wbs_code);
      gpstatement.bindColumn(8, idx_llevel);
      gpstatement.bindColumn(9, idx_name);
      gpstatement.bindColumn(10, idx_ssize);
      gpstatement.bindColumn(11, idx_unit);
      gpstatement.bindColumn(12, idx_remark);
      gpstatement.bindColumn(13, idx_input_dt);
      gpstatement.bindColumn(14, idx_input_name);
      gpstatement.bindColumn(15, idx_parent_sum_code);
      gpstatement.bindColumn(16, idx_invest_class);
      gpstatement.bindColumn(17, idx_division);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update y_chg_budget_parent set " + 
                            "dept_code=?,  " + 
                            "chg_no_seq=?,  " + 
                            "spec_no_seq=?,  " + 
                            "no_seq=?,  " + 
                            "sum_code=?,  " + 
                            "direct_class=?,  " + 
                            "wbs_code=?,  " + 
                            "llevel=?,  " + 
                            "name=?,  " + 
                            "ssize=?,  " + 
                            "unit=?,  " + 
                            "remark=?,  " + 
                            "input_dt=TO_DATE(?,'YYYY.MM.DD'),  " + 
                            "input_name=?, " + 
                            "parent_sum_code=?, " + 
                            "invest_class=?, " + 
                            "division=? " + 
                            "  where (dept_code=? and chg_no_seq=? and spec_no_seq=?)";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_no_seq);
      gpstatement.bindColumn(5, idx_sum_code);
      gpstatement.bindColumn(6, idx_direct_class);
      gpstatement.bindColumn(7, idx_wbs_code);
      gpstatement.bindColumn(8, idx_llevel);
      gpstatement.bindColumn(9, idx_name);
      gpstatement.bindColumn(10, idx_ssize);
      gpstatement.bindColumn(11, idx_unit);
      gpstatement.bindColumn(12, idx_remark);
      gpstatement.bindColumn(13, idx_input_dt);
      gpstatement.bindColumn(14, idx_input_name);
      gpstatement.bindColumn(15, idx_parent_sum_code);
      gpstatement.bindColumn(16, idx_invest_class);
      gpstatement.bindColumn(17, idx_division);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(18, idx_dept_code);
      gpstatement.bindColumn(19, idx_chg_no_seq);
      gpstatement.bindColumn(20, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from y_chg_budget_parent where(dept_code=? and chg_no_seq=? and spec_no_seq=?) "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
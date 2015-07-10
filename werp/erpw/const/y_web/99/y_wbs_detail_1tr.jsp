<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("y_wbs_detail_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_no = dSet.indexOfColumn("no");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_direct_class = dSet.indexOfColumn("direct_class");
   	int idx_wbs_code = dSet.indexOfColumn("wbs_code");
   	int idx_llevel = dSet.indexOfColumn("llevel");
   	int idx_invest_class = dSet.indexOfColumn("invest_class");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_ssize = dSet.indexOfColumn("ssize");
   	int idx_unit = dSet.indexOfColumn("unit");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_input_dt = dSet.indexOfColumn("input_dt");
   	int idx_input_name = dSet.indexOfColumn("input_name");
   	int idx_division = dSet.indexOfColumn("division");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO Y_WBS_DETAIL ( no," + 
                    "spec_no_seq," + 
                    "no_seq," + 
                    "direct_class," + 
                    "wbs_code," + 
                    "llevel," + 
                    "invest_class," + 
                    "name," + 
                    "ssize," + 
                    "unit," + 
                    "remark," + 
                    "input_dt," + 
                    "input_name,division )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_no_seq);
      gpstatement.bindColumn(4, idx_direct_class);
      gpstatement.bindColumn(5, idx_wbs_code);
      gpstatement.bindColumn(6, idx_llevel);
      gpstatement.bindColumn(7, idx_invest_class);
      gpstatement.bindColumn(8, idx_name);
      gpstatement.bindColumn(9, idx_ssize);
      gpstatement.bindColumn(10, idx_unit);
      gpstatement.bindColumn(11, idx_remark);
      gpstatement.bindColumn(12, idx_input_dt);
      gpstatement.bindColumn(13, idx_input_name);
      gpstatement.bindColumn(14, idx_division);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update y_wbs_detail set " + 
                            "no=?,  " + 
                            "spec_no_seq=?,  " + 
                            "no_seq=?,  " + 
                            "direct_class=?,  " + 
                            "wbs_code=?,  " + 
                            "llevel=?,  " + 
                            "invest_class=?,  " + 
                            "name=?,  " + 
                            "ssize=?,  " + 
                            "unit=?,  " + 
                            "remark=?,  " + 
                            "input_dt=?,  " + 
                            "input_name=?,division=?  where no=? and spec_no_seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_no_seq);
      gpstatement.bindColumn(4, idx_direct_class);
      gpstatement.bindColumn(5, idx_wbs_code);
      gpstatement.bindColumn(6, idx_llevel);
      gpstatement.bindColumn(7, idx_invest_class);
      gpstatement.bindColumn(8, idx_name);
      gpstatement.bindColumn(9, idx_ssize);
      gpstatement.bindColumn(10, idx_unit);
      gpstatement.bindColumn(11, idx_remark);
      gpstatement.bindColumn(12, idx_input_dt);
      gpstatement.bindColumn(13, idx_input_name);
      gpstatement.bindColumn(14, idx_division);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(15, idx_no);
      gpstatement.bindColumn(16, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from y_wbs_detail where no=? and spec_no_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
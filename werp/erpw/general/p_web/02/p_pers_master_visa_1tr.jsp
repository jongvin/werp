<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_pers_master_visa_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_resident_no = dSet.indexOfColumn("resident_no");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_nation_code = dSet.indexOfColumn("nation_code");
   	int idx_visa_div_code = dSet.indexOfColumn("visa_div_code");
   	int idx_s_date = dSet.indexOfColumn("s_date");
   	int idx_e_date = dSet.indexOfColumn("e_date");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_pers_visa ( resident_no," + 
                    "spec_no_seq," + 
                    "seq," + 
                    "nation_code," + 
                    "visa_div_code," + 
                    "s_date," + 
                    "e_date," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_nation_code);
      gpstatement.bindColumn(5, idx_visa_div_code);
      gpstatement.bindColumn(6, idx_s_date);
      gpstatement.bindColumn(7, idx_e_date);
      gpstatement.bindColumn(8, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_pers_visa set " + 
                            "resident_no=?,  " + 
                            "spec_no_seq=?,  " + 
                            "seq=?,  " + 
                            "nation_code=?,  " + 
                            "visa_div_code=?,  " + 
                            "s_date=?,  " + 
                            "e_date=?,  " + 
                            "remark=?  where resident_no=? and spec_no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_nation_code);
      gpstatement.bindColumn(5, idx_visa_div_code);
      gpstatement.bindColumn(6, idx_s_date);
      gpstatement.bindColumn(7, idx_e_date);
      gpstatement.bindColumn(8, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(9, idx_resident_no);
      gpstatement.bindColumn(10, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_pers_visa where resident_no=? and spec_no_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
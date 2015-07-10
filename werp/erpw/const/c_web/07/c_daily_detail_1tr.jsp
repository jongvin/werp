<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_daily_detail_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymmdd = dSet.indexOfColumn("yymmdd");
   	int idx_tag = dSet.indexOfColumn("tag");
   	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_ssize_1 = dSet.indexOfColumn("ssize_1");
   	int idx_ssize_2 = dSet.indexOfColumn("ssize_2");
   	int idx_bef_cnt = dSet.indexOfColumn("bef_cnt");
   	int idx_cnt = dSet.indexOfColumn("cnt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO c_daily_detail ( dept_code," + 
                    "yymmdd," + 
                    "tag," + 
                    "spec_unq_num," + 
                    "no_seq," + 
                    "name," + 
                    "ssize_1," + 
                    "ssize_2," + 
                    "bef_cnt," + 
                    "cnt )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_tag);
      gpstatement.bindColumn(4, idx_spec_unq_num);
      gpstatement.bindColumn(5, idx_no_seq);
      gpstatement.bindColumn(6, idx_name);
      gpstatement.bindColumn(7, idx_ssize_1);
      gpstatement.bindColumn(8, idx_ssize_2);
      gpstatement.bindColumn(9, idx_bef_cnt);
      gpstatement.bindColumn(10, idx_cnt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update c_daily_detail set " + 
                            "dept_code=?,  " + 
                            "yymmdd=?,  " + 
                            "tag=?,  " + 
                            "spec_unq_num=?,  " + 
                            "no_seq=?,  " + 
                            "name=?,  " + 
                            "ssize_1=?,  " + 
                            "ssize_2=?,  " + 
                            "bef_cnt=?,  " + 
                            "cnt=?  where dept_code=? and yymmdd=? and tag=? and spec_unq_num=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_tag);
      gpstatement.bindColumn(4, idx_spec_unq_num);
      gpstatement.bindColumn(5, idx_no_seq);
      gpstatement.bindColumn(6, idx_name);
      gpstatement.bindColumn(7, idx_ssize_1);
      gpstatement.bindColumn(8, idx_ssize_2);
      gpstatement.bindColumn(9, idx_bef_cnt);
      gpstatement.bindColumn(10, idx_cnt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(11, idx_dept_code);
      gpstatement.bindColumn(12, idx_yymmdd);
      gpstatement.bindColumn(13, idx_tag);
      gpstatement.bindColumn(14, idx_spec_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from c_daily_detail where dept_code=?and yymmdd=? and tag=? and spec_unq_num=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_tag);
      gpstatement.bindColumn(4, idx_spec_unq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
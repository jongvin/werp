<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_input_find_2tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymmdd = dSet.indexOfColumn("yymmdd");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_input_unq_num = dSet.indexOfColumn("input_unq_num");
   	int idx_detailseq = dSet.indexOfColumn("detailseq");
   	int idx_mtrcode = dSet.indexOfColumn("mtrcode");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_ssize = dSet.indexOfColumn("ssize");
   	int idx_unitcode = dSet.indexOfColumn("unitcode");
   	int idx_qty = dSet.indexOfColumn("noout_qty");
   	int idx_proc_yn = dSet.indexOfColumn("proc_yn");
   	int idx_re_amt = dSet.indexOfColumn("re_amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_TMAT_STOCK ( dept_code," + 
                    "yymmdd," + 
                    "seq," + 
                    "input_unq_num," + 
                    "detailseq," + 
                    "mtrcode," + 
                    "name," + 
                    "ssize," + 
                    "unitcode," + 
                    "qty," + 
                    "proc_yn,amt)      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11,:12 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_input_unq_num);
      gpstatement.bindColumn(5, idx_detailseq);
      gpstatement.bindColumn(6, idx_mtrcode);
      gpstatement.bindColumn(7, idx_name);
      gpstatement.bindColumn(8, idx_ssize);
      gpstatement.bindColumn(9, idx_unitcode);
      gpstatement.bindColumn(10, idx_qty);
      gpstatement.bindColumn(11, idx_proc_yn);
      gpstatement.bindColumn(12, idx_re_amt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_tmat_stock set " + 
                            "dept_code=?,  " + 
                            "yymmdd=?,  " + 
                            "seq=?,  " + 
                            "input_unq_num=?,  " + 
                            "detailseq=?,  " + 
                            "mtrcode=?,  " + 
                            "name=?,  " + 
                            "ssize=?,  " + 
                            "unitcode=?,  " + 
                            "qty=?,  " + 
                            "proc_yn=?,amt=? where dept_code=? " +
                            "            and yymmdd=? " +
                            "            and seq=? " +
                            "            and input_unq_num=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_input_unq_num);
      gpstatement.bindColumn(5, idx_detailseq);
      gpstatement.bindColumn(6, idx_mtrcode);
      gpstatement.bindColumn(7, idx_name);
      gpstatement.bindColumn(8, idx_ssize);
      gpstatement.bindColumn(9, idx_unitcode);
      gpstatement.bindColumn(10, idx_qty);
      gpstatement.bindColumn(11, idx_proc_yn);
      gpstatement.bindColumn(12, idx_re_amt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(13, idx_dept_code);
      gpstatement.bindColumn(14, idx_yymmdd);
      gpstatement.bindColumn(15, idx_seq);
      gpstatement.bindColumn(16, idx_input_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_tmat_stock where dept_code=? " +
                            "            and yymmdd=? " +
                            "            and seq=? " +
                            "            and input_unq_num=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_input_unq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
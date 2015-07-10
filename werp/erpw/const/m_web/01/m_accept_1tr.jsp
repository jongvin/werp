<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_accept_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_requestseq = dSet.indexOfColumn("requestseq");
   	int idx_approtitle = dSet.indexOfColumn("approtitle");
   	int idx_requestdate = dSet.indexOfColumn("requestdate");
   	int idx_receipdate = dSet.indexOfColumn("receipdate");
   	int idx_proj_content = dSet.indexOfColumn("proj_content");
   	int idx_head_content = dSet.indexOfColumn("head_content");
   	int idx_chg_cnt = dSet.indexOfColumn("chg_cnt");
   	int idx_approve_class = dSet.indexOfColumn("approve_class");
   	int idx_order_class = dSet.indexOfColumn("order_class");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_REQUEST ( dept_code," + 
                    "requestseq," + 
                    "chg_cnt," +
                    "approtitle," + 
                    "requestdate," + 
                    "receipdate," + 
                    "proj_content," + 
                    "head_content )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_requestseq);
      gpstatement.bindColumn(3, idx_chg_cnt);
      gpstatement.bindColumn(4, idx_approtitle);
      gpstatement.bindColumn(5, idx_requestdate);
      gpstatement.bindColumn(6, idx_receipdate);
      gpstatement.bindColumn(7, idx_proj_content);
      gpstatement.bindColumn(8, idx_head_content);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update m_request set " + 
                            "dept_code=?,  " + 
                            "requestseq=?,  " + 
                            "chg_cnt=?, " +
                            "approtitle=?,  " + 
                            "requestdate=?,  " + 
                            "receipdate=?,  " + 
                            "proj_content=?,  " + 
                            "head_content=?,approve_class=?,order_class=?  where dept_code=? " +
                            " and requestseq=?" +
                            " and chg_cnt=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_requestseq);
      gpstatement.bindColumn(3, idx_chg_cnt);
      gpstatement.bindColumn(4, idx_approtitle);
      gpstatement.bindColumn(5, idx_requestdate);
      gpstatement.bindColumn(6, idx_receipdate);
      gpstatement.bindColumn(7, idx_proj_content);
      gpstatement.bindColumn(8, idx_head_content);
      gpstatement.bindColumn(9, idx_approve_class);
      gpstatement.bindColumn(10, idx_order_class);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(11, idx_dept_code);
      gpstatement.bindColumn(12, idx_requestseq);
      gpstatement.bindColumn(13, idx_chg_cnt);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from m_request where dept_code=? " +
      				" and requestseq=?" + 
      				" and chg_cnt=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_requestseq);
      gpstatement.bindColumn(3, idx_chg_cnt);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
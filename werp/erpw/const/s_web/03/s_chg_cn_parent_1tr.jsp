<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_chg_cn_parent_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_order_number = dSet.indexOfColumn("order_number");
   	int idx_chg_degree = dSet.indexOfColumn("chg_degree");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_direct_class = dSet.indexOfColumn("direct_class");
   	int idx_llevel = dSet.indexOfColumn("llevel");
   	int idx_sum_code = dSet.indexOfColumn("sum_code");
   	int idx_parent_sum_code = dSet.indexOfColumn("parent_sum_code");
   	int idx_invest_class = dSet.indexOfColumn("invest_class");
   	int idx_copy_yn = dSet.indexOfColumn("copy_yn");
   	int idx_name = dSet.indexOfColumn("name");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO s_chg_cn_parent ( dept_code," + 
                    "order_number," + 
                    "chg_degree," + 
                    "spec_no_seq," + 
                    "seq," + 
                    "direct_class," + 
                    "llevel," + 
                    "sum_code," + 
                    "parent_sum_code," + 
                    "invest_class," + 
                    "copy_yn," + 
                    "name )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_chg_degree);
      gpstatement.bindColumn(4, idx_spec_no_seq);
      gpstatement.bindColumn(5, idx_seq);
      gpstatement.bindColumn(6, idx_direct_class);
      gpstatement.bindColumn(7, idx_llevel);
      gpstatement.bindColumn(8, idx_sum_code);
      gpstatement.bindColumn(9, idx_parent_sum_code);
      gpstatement.bindColumn(10, idx_invest_class);
      gpstatement.bindColumn(11, idx_copy_yn);
      gpstatement.bindColumn(12, idx_name);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update s_chg_cn_parent set " + 
                            "dept_code=?,  " + 
                            "order_number=?,  " + 
                            "chg_degree=?,  " + 
                            "spec_no_seq=?,  " + 
                            "seq=?,  " + 
                            "direct_class=?,  " + 
                            "llevel=?,  " + 
                            "sum_code=?,  " + 
                            "parent_sum_code=?,  " + 
                            "invest_class=?,  " + 
                            "copy_yn=?,  " + 
                            "name=?  where (dept_code=? and order_number=? and chg_degree=? and spec_no_seq=?) ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_chg_degree);
      gpstatement.bindColumn(4, idx_spec_no_seq);
      gpstatement.bindColumn(5, idx_seq);
      gpstatement.bindColumn(6, idx_direct_class);
      gpstatement.bindColumn(7, idx_llevel);
      gpstatement.bindColumn(8, idx_sum_code);
      gpstatement.bindColumn(9, idx_parent_sum_code);
      gpstatement.bindColumn(10, idx_invest_class);
      gpstatement.bindColumn(11, idx_copy_yn);
      gpstatement.bindColumn(12, idx_name);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(13, idx_dept_code);
      gpstatement.bindColumn(14, idx_order_number);
      gpstatement.bindColumn(15, idx_chg_degree);
      gpstatement.bindColumn(16, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from s_chg_cn_parent where (dept_code=? and order_number=? and chg_degree=? and spec_no_seq=?) "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_chg_degree);
      gpstatement.bindColumn(4, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_contract_dongho_chg_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_dongho = dSet.indexOfColumn("dongho");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_pyong = dSet.indexOfColumn("pyong");
   	int idx_style = dSet.indexOfColumn("style");
   	int idx_class = dSet.indexOfColumn("class");
   	int idx_option_code = dSet.indexOfColumn("option_code");
   	int idx_cust_code = dSet.indexOfColumn("cust_code");
   	int idx_contract_yn = dSet.indexOfColumn("contract_yn");
   	int idx_contract_date = dSet.indexOfColumn("contract_date");
   	int idx_chg_div = dSet.indexOfColumn("chg_div");
   	int idx_chg_date = dSet.indexOfColumn("chg_date");
   	int idx_last_contract_date = dSet.indexOfColumn("last_contract_date");
   	int idx_chg_dongho = dSet.indexOfColumn("chg_dongho");
   	int idx_chg_seq = dSet.indexOfColumn("chg_seq");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
      String sSql = "update h_sale_master set " + 
                            "cust_code=?,  " + 
                            "contract_yn=?,  " + 
                            "contract_date=?,  " + 
                            "chg_div=?,  " + 
                            "chg_date=?,  " + 
                            "last_contract_date=?,  " + 
                            "chg_dongho=?,  " + 
                            "chg_seq=?  where dept_code=? " + 
                            "             and sell_code=? " +
                            "             and dongho=? " +
                            "             and seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_cust_code);
      gpstatement.bindColumn(2, idx_contract_yn);
      gpstatement.bindColumn(3, idx_contract_date);
      gpstatement.bindColumn(4, idx_chg_div);
      gpstatement.bindColumn(5, idx_chg_date);
      gpstatement.bindColumn(6, idx_last_contract_date);
      gpstatement.bindColumn(7, idx_chg_dongho);
      gpstatement.bindColumn(8, idx_chg_seq);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(9, idx_dept_code);
      gpstatement.bindColumn(10, idx_sell_code);
      gpstatement.bindColumn(11, idx_dongho);
      gpstatement.bindColumn(12, idx_seq);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update h_sale_master set " + 
                            "cust_code=?,  " + 
                            "contract_yn=?,  " + 
                            "contract_date=?,  " + 
                            "chg_div=?,  " + 
                            "chg_date=?,  " + 
                            "last_contract_date=?,  " + 
                            "chg_dongho=?,  " + 
                            "chg_seq=?  where dept_code=? " + 
                            "             and sell_code=? " +
                            "             and dongho=? " +
                            "             and seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_cust_code);
      gpstatement.bindColumn(2, idx_contract_yn);
      gpstatement.bindColumn(3, idx_contract_date);
      gpstatement.bindColumn(4, idx_chg_div);
      gpstatement.bindColumn(5, idx_chg_date);
      gpstatement.bindColumn(6, idx_last_contract_date);
      gpstatement.bindColumn(7, idx_chg_dongho);
      gpstatement.bindColumn(8, idx_chg_seq);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(9, idx_dept_code);
      gpstatement.bindColumn(10, idx_sell_code);
      gpstatement.bindColumn(11, idx_dongho);
      gpstatement.bindColumn(12, idx_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from h_sale_master where dept_code=? " +
                                         "       and sell_code=?" +
                                         "       and dongho=? " +
                                         "       and seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
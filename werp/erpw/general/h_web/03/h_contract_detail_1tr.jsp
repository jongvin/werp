<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_contract_detail_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_dongho = dSet.indexOfColumn("dongho");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_degree_code = dSet.indexOfColumn("degree_code");
   	int idx_key_degree_code = dSet.indexOfColumn("key_degree_code");
   	int idx_agree_date = dSet.indexOfColumn("agree_date");
   	int idx_land_amt = dSet.indexOfColumn("land_amt");
   	int idx_build_amt = dSet.indexOfColumn("build_amt");
   	int idx_vat_amt = dSet.indexOfColumn("vat_amt");
   	int idx_sell_amt = dSet.indexOfColumn("sell_amt");
   	int idx_f_pay_yn = dSet.indexOfColumn("f_pay_yn");
   	int idx_tot_amt = dSet.indexOfColumn("tot_amt");
   	int idx_work_date = dSet.indexOfColumn("work_date");
   	int idx_work_no = dSet.indexOfColumn("work_no");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_SALE_AGREE ( dept_code," + 
                    "sell_code," + 
                    "dongho," + 
                    "seq," + 
                    "degree_code," + 
                    "agree_date," + 
                    "land_amt," + 
                    "build_amt," + 
                    "vat_amt," + 
                    "sell_amt," + 
                    "f_pay_yn," + 
                    "tot_amt," + 
                    "work_date," + 
                    "work_no )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_degree_code);
      gpstatement.bindColumn(6, idx_agree_date);
      gpstatement.bindColumn(7, idx_land_amt);
      gpstatement.bindColumn(8, idx_build_amt);
      gpstatement.bindColumn(9, idx_vat_amt);
      gpstatement.bindColumn(10, idx_sell_amt);
      gpstatement.bindColumn(11, idx_f_pay_yn);
      gpstatement.bindColumn(12, idx_tot_amt);
      gpstatement.bindColumn(13, idx_work_date);
      gpstatement.bindColumn(14, idx_work_no);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_sale_agree set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "dongho=?,  " + 
                            "seq=?,  " + 
                            "degree_code=?,  " + 
                            "agree_date=?,  " + 
                            "land_amt=?,  " + 
                            "build_amt=?,  " + 
                            "vat_amt=?,  " + 
                            "sell_amt=?,  " + 
                            "f_pay_yn=?,  " + 
                            "tot_amt=?,  " + 
                            "work_date=?,  " + 
                            "work_no=?  where dept_code=? " +
                            "             and sell_code=? " +
                            "             and dongho=? " +
                            "             and seq=? " +
                            "             and degree_code=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_degree_code);
      gpstatement.bindColumn(6, idx_agree_date);
      gpstatement.bindColumn(7, idx_land_amt);
      gpstatement.bindColumn(8, idx_build_amt);
      gpstatement.bindColumn(9, idx_vat_amt);
      gpstatement.bindColumn(10, idx_sell_amt);
      gpstatement.bindColumn(11, idx_f_pay_yn);
      gpstatement.bindColumn(12, idx_tot_amt);
      gpstatement.bindColumn(13, idx_work_date);
      gpstatement.bindColumn(14, idx_work_no);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(15, idx_dept_code);
      gpstatement.bindColumn(16, idx_sell_code);
      gpstatement.bindColumn(17, idx_dongho);
      gpstatement.bindColumn(18, idx_seq);
      gpstatement.bindColumn(19, idx_key_degree_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_sale_agree where dept_code=? " + 
                            "             and sell_code=? " +
                            "             and dongho=? " +
                            "             and seq=? " +
                            "             and degree_code=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_key_degree_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
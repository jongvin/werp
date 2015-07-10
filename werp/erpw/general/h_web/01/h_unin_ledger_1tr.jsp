<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_unin_ledger_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_union_code = dSet.indexOfColumn("union_code");
   	int idx_union_name = dSet.indexOfColumn("union_name");
   	int idx_zip_code = dSet.indexOfColumn("zip_code");
   	int idx_addr1 = dSet.indexOfColumn("addr1");
   	int idx_addr2 = dSet.indexOfColumn("addr2");
   	int idx_fax = dSet.indexOfColumn("fax");
   	int idx_phone = dSet.indexOfColumn("phone");
   	int idx_union_members = dSet.indexOfColumn("union_members");
   	int idx_union_div_code = dSet.indexOfColumn("union_div_code");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_old_union_code = dSet.indexOfColumn("old_union_code");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_unin_ledger ( dept_code," + 
                    "sell_code," + 
                    "union_code," + 
                    "union_name," + 
                    "zip_code," + 
                    "addr1," + 
                    "addr2," + 
                    "fax," + 
                    "phone," + 
                    "union_members," + 
                    "union_div_code," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_union_code);
      gpstatement.bindColumn(4, idx_union_name);
      gpstatement.bindColumn(5, idx_zip_code);
      gpstatement.bindColumn(6, idx_addr1);
      gpstatement.bindColumn(7, idx_addr2);
      gpstatement.bindColumn(8, idx_fax);
      gpstatement.bindColumn(9, idx_phone);
      gpstatement.bindColumn(10, idx_union_members);
      gpstatement.bindColumn(11, idx_union_div_code);
      gpstatement.bindColumn(12, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_unin_ledger set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "union_code=?,  " + 
                            "union_name=?,  " + 
                            "zip_code=?,  " + 
                            "addr1=?,  " + 
                            "addr2=?,  " + 
                            "fax=?,  " + 
                            "phone=?,  " + 
                            "union_members=?,  " + 
                            "union_div_code=?,  " + 
                            "remark=?  where dept_code=? and sell_code=? and union_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_union_code);
      gpstatement.bindColumn(4, idx_union_name);
      gpstatement.bindColumn(5, idx_zip_code);
      gpstatement.bindColumn(6, idx_addr1);
      gpstatement.bindColumn(7, idx_addr2);
      gpstatement.bindColumn(8, idx_fax);
      gpstatement.bindColumn(9, idx_phone);
      gpstatement.bindColumn(10, idx_union_members);
      gpstatement.bindColumn(11, idx_union_div_code);
      gpstatement.bindColumn(12, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(13, idx_dept_code);
      gpstatement.bindColumn(14, idx_sell_code);
      gpstatement.bindColumn(15, idx_old_union_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_unin_ledger where dept_code=? and sell_code=? and union_code=?  "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_old_union_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
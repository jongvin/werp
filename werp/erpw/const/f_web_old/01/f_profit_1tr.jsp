<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("f_profit_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_inst_date = dSet.indexOfColumn("inst_date");
   	int idx_key_inst_date = dSet.indexOfColumn("key_inst_date");
   	int idx_slip_spec_unq_num = dSet.indexOfColumn("slip_spec_unq_num");
   	int idx_rqst_date = dSet.indexOfColumn("rqst_date");
   	int idx_cont = dSet.indexOfColumn("cont");
   	int idx_vatcode = dSet.indexOfColumn("vatcode");
   	int idx_acntcode = dSet.indexOfColumn("acntcode");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_vat = dSet.indexOfColumn("vat");
   	int idx_cust_code = dSet.indexOfColumn("cust_code");
   	int idx_cust_name = dSet.indexOfColumn("cust_name");
   	int idx_tax_amt = dSet.indexOfColumn("tax_amt");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_invoice_num = dSet.indexOfColumn("invoice_num");
   	int idx_wbs_code = dSet.indexOfColumn("wbs_code");
    int  rowCnt = dSet.getDataRowCnt();
	
	String ls_dept_code = "";
	String sSql = "";
	Statement stmt1 = null;
    ResultSet rset = null;

    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;

	//전표가 발생되었나 검색한후 발생된경우만 추가삭제변경 함 시작.
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT || rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE || rows.getJobType() == GauceDataRow.TB_JOB_DELETE){
		stmt1 = conn.createStatement();
		sSql = "SELECT a.invoice_num,F_APPROVAL_YN(b.complete_flag,b.relation_invoice_group_id) YN  " +
			                     "FROM F_PROFIT_DETAIL a LEFT JOIN efin_invoice_header_itf b on a.invoice_num = b.invoice_group_id  " +
		                         "WHERE a.DEPT_CODE =  '" + rows.getString(idx_dept_code) + "' " +
		                         "AND a.slip_spec_unq_num = " + rows.getString(idx_slip_spec_unq_num) + " " +
			                     "AND nvl(rtrim(a.invoice_num),' ') <> ' '";
        rset = stmt1.executeQuery(sSql);
        while (rset.next()){
			if (true) {
				if (rset.getString("YN").equals("N")) {
					rset.close(); stmt1.close(); throw new Exception("이미 전표발행된 자료가 존재하여 수정할수 없습니다.");
				}
			}
        }
        rset.close();
        stmt1.close();
	}
	//전표가 발생되었나 검색한후 발생된경우만 추가삭제변경 함 종료.

	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		sSql = " INSERT INTO F_PROFIT_DETAIL ( dept_code," + 
                    "inst_date," + 
                    "slip_spec_unq_num," +
                    "rqst_date," + 
                    "cont," + 
                    "vatcode," + 
                    "acntcode," + 
                    "amt," + 
                    "vat," + 
                    "cust_code," + 
                    "cust_name," + 
                    "tax_amt," + 
                    "remark," + 
                    "invoice_num ,wbs_code)      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_inst_date);
      gpstatement.bindColumn(3, idx_slip_spec_unq_num);
      gpstatement.bindColumn(4, idx_rqst_date);
      gpstatement.bindColumn(5, idx_cont);
      gpstatement.bindColumn(6, idx_vatcode);
      gpstatement.bindColumn(7, idx_acntcode);
      gpstatement.bindColumn(8, idx_amt);
      gpstatement.bindColumn(9, idx_vat);
      gpstatement.bindColumn(10, idx_cust_code);
      gpstatement.bindColumn(11, idx_cust_name);
      gpstatement.bindColumn(12, idx_tax_amt);
      gpstatement.bindColumn(13, idx_remark);
      gpstatement.bindColumn(14, idx_invoice_num);
      gpstatement.bindColumn(15, idx_wbs_code);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      sSql = "update f_profit_detail set " + 
                            "dept_code=?,  " + 
                            "inst_date=?,  " + 
                            "slip_spec_unq_num=?,  " + 
                            "rqst_date=?,  " + 
                            "cont=?,  " + 
                            "vatcode=?,  " + 
                            "acntcode=?,  " + 
                            "amt=?,  " + 
                            "vat=?,  " + 
                            "cust_code=?,  " + 
                            "cust_name=?,  " + 
                            "tax_amt=?,  " + 
                            "remark=?,  " + 
                            "invoice_num=?,wbs_code=?  where dept_code=? " +
                            "                 and inst_date=? " +
                            "                 and slip_spec_unq_num=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_inst_date);
      gpstatement.bindColumn(3, idx_slip_spec_unq_num);
      gpstatement.bindColumn(4, idx_rqst_date);
      gpstatement.bindColumn(5, idx_cont);
      gpstatement.bindColumn(6, idx_vatcode);
      gpstatement.bindColumn(7, idx_acntcode);
      gpstatement.bindColumn(8, idx_amt);
      gpstatement.bindColumn(9, idx_vat);
      gpstatement.bindColumn(10, idx_cust_code);
      gpstatement.bindColumn(11, idx_cust_name);
      gpstatement.bindColumn(12, idx_tax_amt);
      gpstatement.bindColumn(13, idx_remark);
      gpstatement.bindColumn(14, idx_invoice_num);
      gpstatement.bindColumn(15, idx_wbs_code);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(16, idx_dept_code);
      gpstatement.bindColumn(17, idx_key_inst_date);
      gpstatement.bindColumn(18, idx_slip_spec_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      sSql = "delete from f_profit_detail where dept_code=? " +
                            "                 and inst_date=? " +
                            "                 and slip_spec_unq_num=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_key_inst_date);
      gpstatement.bindColumn(3, idx_slip_spec_unq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
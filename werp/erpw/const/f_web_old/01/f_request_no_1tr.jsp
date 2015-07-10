<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("f_request_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_rqst_date = dSet.indexOfColumn("rqst_date");
   	int idx_slip_seq = dSet.indexOfColumn("slip_seq");
   	int idx_slip_spec_unq_num = dSet.indexOfColumn("slip_spec_unq_num");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_key_rqst_date = dSet.indexOfColumn("key_rqst_date");
   	int idx_key_slip_seq = dSet.indexOfColumn("key_slip_seq");
   	int idx_key_seq = dSet.indexOfColumn("key_seq");
   	int idx_res_type = dSet.indexOfColumn("res_type");
   	int idx_cont = dSet.indexOfColumn("cont");
   	int idx_order_number = dSet.indexOfColumn("order_number");
   	int idx_cust_code = dSet.indexOfColumn("cust_code");
   	int idx_cust_name = dSet.indexOfColumn("cust_name");
   	int idx_vatcode = dSet.indexOfColumn("vatcode");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_vat = dSet.indexOfColumn("vat");
   	int idx_acntcode = dSet.indexOfColumn("acntcode");
   	int idx_fund_type = dSet.indexOfColumn("fund_type");
   	int idx_cost_type = dSet.indexOfColumn("cost_type");
   	int idx_receipt_rqst_type = dSet.indexOfColumn("receipt_rqst_type");
   	int idx_receipt_date = dSet.indexOfColumn("receipt_date");
   	int idx_credit_card_no = dSet.indexOfColumn("credit_card_no");
   	int idx_card_user = dSet.indexOfColumn("card_user");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
	int idx_wbs_code = dSet.indexOfColumn("wbs_code");
   	int idx_slipdate = dSet.indexOfColumn("slipdate");
   	int idx_invoice_num = dSet.indexOfColumn("invoice_num");
   	int idx_cr_class = dSet.indexOfColumn("cr_class");
   	int idx_profit_amt = dSet.indexOfColumn("profit_amt");
	int idx_prepay_date1 = dSet.indexOfColumn("prepay_date1");
	int idx_prepay_date2 = dSet.indexOfColumn("prepay_date2");
	int idx_prepay_acntcode = dSet.indexOfColumn("prepay_acntcode");
	int idx_fa_qnty = dSet.indexOfColumn("fa_qnty");
	int idx_mdfy_yn = dSet.indexOfColumn("mdfy_yn");
    int rowCnt = dSet.getDataRowCnt();

	String ls_dept_code = "";
	String sSql = "";
	Statement stmt1 = null;
    ResultSet rset = null;

    for(int i=0; i< rowCnt; i++){ 
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
		ls_dept_code = rows.getString(idx_dept_code);

	//전표가 발생되었나 검색한후 발생된경우만 추가삭제변경 함 시작.
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT || rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE || rows.getJobType() == GauceDataRow.TB_JOB_DELETE){
		stmt1 = conn.createStatement();
		sSql = "SELECT a.invoice_num,F_APPROVAL_YN(b.complete_flag,b.relation_invoice_group_id) YN " +
			                     "FROM F_REQUEST a LEFT JOIN efin_invoice_header_itf b on a.invoice_num = b.invoice_group_id " +
		                         "WHERE a.DEPT_CODE =  '" + rows.getString(idx_dept_code) + "' " +
		                         "AND a.slip_seq = " + rows.getString(idx_slip_seq) + " " +
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
		  sSql = " INSERT INTO F_REQUEST ( dept_code," + 
                    "rqst_date," + 
                    "slip_seq," + 
                    "slip_spec_unq_num," +
                    "seq," + 
                    "res_type," + 
                    "cr_class," +
                    "cont," + 
                    "order_number," + 
                    "cust_code," + 
                    "cust_name," + 
                    "vatcode," + 
                    "amt," + 
                    "vat," + 
                    "profit_amt," +
                    "acntcode," + 
                    "fund_type," + 
                    "cost_type," + 
                    "receipt_rqst_type," + 
                    "receipt_date," + 
                    "credit_card_no," + 
                    "card_user," + 
                    "spec_no_seq," + 
                    "spec_unq_num," + 
			        "wbs_code," +
                    "slipdate," + 
                    "invoice_num," +
			        "prepay_date1," +
			        "prepay_date2," +
			        "prepay_acntcode," +
			        "fa_qnty," +
			        "mdfy_yn,spec_no_yn)      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, " +
		                      ":22, :23,:24,:25,:26,:27,:28,:29,:30,:31,:32,'N' ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_rqst_date);
      gpstatement.bindColumn(3, idx_slip_seq);
      gpstatement.bindColumn(4, idx_slip_spec_unq_num);
      gpstatement.bindColumn(5, idx_seq);
      gpstatement.bindColumn(6, idx_res_type);
      gpstatement.bindColumn(7, idx_cr_class);
      gpstatement.bindColumn(8, idx_cont);
      gpstatement.bindColumn(9, idx_order_number);
      gpstatement.bindColumn(10, idx_cust_code);
      gpstatement.bindColumn(11, idx_cust_name);
      gpstatement.bindColumn(12, idx_vatcode);
      gpstatement.bindColumn(13, idx_amt);
      gpstatement.bindColumn(14, idx_vat);
      gpstatement.bindColumn(15, idx_profit_amt);
      gpstatement.bindColumn(16, idx_acntcode);
      gpstatement.bindColumn(17, idx_fund_type);
      gpstatement.bindColumn(18, idx_cost_type);
      gpstatement.bindColumn(19, idx_receipt_rqst_type);
      gpstatement.bindColumn(20, idx_receipt_date);
      gpstatement.bindColumn(21, idx_credit_card_no);
      gpstatement.bindColumn(22, idx_card_user);
      gpstatement.bindColumn(23, idx_spec_no_seq);
      gpstatement.bindColumn(24, idx_spec_unq_num);
      gpstatement.bindColumn(25, idx_wbs_code);
      gpstatement.bindColumn(26, idx_slipdate);
      gpstatement.bindColumn(27, idx_invoice_num);
	  gpstatement.bindColumn(28, idx_prepay_date1);
	  gpstatement.bindColumn(29, idx_prepay_date2);
	  gpstatement.bindColumn(30, idx_prepay_acntcode);
	  gpstatement.bindColumn(31, idx_fa_qnty);
	  gpstatement.bindColumn(32, idx_mdfy_yn);

      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){

 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
        sSql = "update f_request set " + 
                            "dept_code=?,  " + 
                            "rqst_date=?,  " + 
                            "slip_seq=?,  " + 
                            "slip_spec_unq_num=?, " +
                            "seq=?,  " + 
                            "res_type=?,  " + 
                            "cont=?,  " + 
                            "order_number=?,  " + 
                            "cust_code=?,  " + 
                            "cust_name=?,  " + 
                            "vatcode=?,  " + 
                            "amt=?,  " + 
                            "vat=?,  " + 
                            "acntcode=?,  " + 
                            "fund_type=?,  " + 
                            "cost_type=?,  " + 
                            "receipt_rqst_type=?,  " + 
                            "receipt_date=?,  " + 
                            "credit_card_no=?,  " + 
                            "card_user=?,  " + 
                            "spec_no_seq=?,  " + 
                            "spec_unq_num=?,  " + 
	                        "wbs_code=?,  " + 
                            "slipdate=?,  " + 
                            "cr_class=?, " +
                            "profit_amt=?, " +
                            "invoice_num=?,  " +
							"prepay_date1=?,  " +
							"prepay_date2=?,  " +
							"prepay_acntcode=?,  " +
							"fa_qnty=?,  " +
							"mdfy_yn=?  " +
                            " where dept_code=? " +
                            "                 and rqst_date=? " +
                            "                 and slip_seq=? " +
                            "                 and slip_spec_unq_num=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_rqst_date);
      gpstatement.bindColumn(3, idx_slip_seq);
      gpstatement.bindColumn(4, idx_slip_spec_unq_num);
      gpstatement.bindColumn(5, idx_seq);
      gpstatement.bindColumn(6, idx_res_type);
      gpstatement.bindColumn(7, idx_cont);
      gpstatement.bindColumn(8, idx_order_number);
      gpstatement.bindColumn(9, idx_cust_code);
      gpstatement.bindColumn(10, idx_cust_name);
      gpstatement.bindColumn(11, idx_vatcode);
      gpstatement.bindColumn(12, idx_amt);
      gpstatement.bindColumn(13, idx_vat);
      gpstatement.bindColumn(14, idx_acntcode);
      gpstatement.bindColumn(15, idx_fund_type);
      gpstatement.bindColumn(16, idx_cost_type);
      gpstatement.bindColumn(17, idx_receipt_rqst_type);
      gpstatement.bindColumn(18, idx_receipt_date);
      gpstatement.bindColumn(19, idx_credit_card_no);
      gpstatement.bindColumn(20, idx_card_user);
      gpstatement.bindColumn(21, idx_spec_no_seq);
      gpstatement.bindColumn(22, idx_spec_unq_num);
	  gpstatement.bindColumn(23, idx_wbs_code);
      gpstatement.bindColumn(24, idx_slipdate);
      gpstatement.bindColumn(25, idx_cr_class);
      gpstatement.bindColumn(26, idx_profit_amt);
      gpstatement.bindColumn(27, idx_invoice_num);
      gpstatement.bindColumn(28, idx_prepay_date1);
	  gpstatement.bindColumn(29, idx_prepay_date2);
	  gpstatement.bindColumn(30, idx_prepay_acntcode);
	  gpstatement.bindColumn(31, idx_fa_qnty);
	  gpstatement.bindColumn(32, idx_mdfy_yn);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(33, idx_dept_code);
      gpstatement.bindColumn(34, idx_key_rqst_date);
      gpstatement.bindColumn(35, idx_key_slip_seq);
      gpstatement.bindColumn(36, idx_slip_spec_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
        sSql = "delete from f_request where dept_code=? " +
                            "                 and rqst_date=? " +
                            "                 and slip_seq=? " +
                            "                 and slip_spec_unq_num=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_key_rqst_date);
      gpstatement.bindColumn(3, idx_key_slip_seq);
      gpstatement.bindColumn(4, idx_slip_spec_unq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }

	if (ls_dept_code.equals("A05266")) {
		//품질안전팀의 경우 하자보수 충당금 잔액초과 여부 체크
		//if (true)
		//	throw new Exception("충당금 잔액을 초과 하였습니다.");
	}
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_approval_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_approym = dSet.indexOfColumn("approym");
   	int idx_approseq = dSet.indexOfColumn("approseq");
   	int idx_chg_cnt = dSet.indexOfColumn("chg_cnt");
   	int idx_approdate = dSet.indexOfColumn("approdate");
   	int idx_approtitle = dSet.indexOfColumn("approtitle");
   	int idx_app_tag = dSet.indexOfColumn("app_tag");
   	int idx_charge = dSet.indexOfColumn("charge");
   	int idx_vattag = dSet.indexOfColumn("vattag");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_vatamt = dSet.indexOfColumn("vatamt");
   	int idx_cash_rt = dSet.indexOfColumn("cash_rt");
   	int idx_bill_rt = dSet.indexOfColumn("bill_rt");
   	int idx_prepayment = dSet.indexOfColumn("prepayment");
   	int idx_deliverymethod = dSet.indexOfColumn("deliverymethod");
   	int idx_deliverylimitdate = dSet.indexOfColumn("deliverylimitdate");
   	int idx_deliverycondition = dSet.indexOfColumn("deliverycondition");
   	int idx_paymentmethod = dSet.indexOfColumn("paymentmethod");
   	int idx_remark1 = dSet.indexOfColumn("remark1");
   	int idx_requestseq = dSet.indexOfColumn("requestseq");
   	int idx_owner = dSet.indexOfColumn("owner");
   	int idx_check_method = dSet.indexOfColumn("check_method");
   	int idx_order_class = dSet.indexOfColumn("order_class");
   	int idx_estimateyymm = dSet.indexOfColumn("estimateyymm");
   	int idx_estimateseq = dSet.indexOfColumn("estimateseq");
   	int idx_price_class = dSet.indexOfColumn("price_class");
   	int idx_price_sup_class = dSet.indexOfColumn("price_sup_class");
   	int idx_price_rt = dSet.indexOfColumn("price_rt");
   	int idx_chg_class = dSet.indexOfColumn("chg_class");
   	int idx_pre_pay_dat = dSet.indexOfColumn("pre_pay_dat");
   	int idx_const_guar_amt = dSet.indexOfColumn("const_guar_amt");
   	int idx_as_guar_amt = dSet.indexOfColumn("as_guar_amt");
   	int idx_as_term = dSet.indexOfColumn("as_term");
   	int idx_delay_amt = dSet.indexOfColumn("delay_amt");
   	int idx_const_class = dSet.indexOfColumn("const_class");
   	int idx_process_tag = dSet.indexOfColumn("process_tag");
   	int idx_const_no = dSet.indexOfColumn("const_no");
   	int idx_remark2 = dSet.indexOfColumn("remark2");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_APPROVAL ( dept_code," + 
                    "approym," + 
                    "approseq," + 
                    "chg_cnt," + 
                    "approdate," + 
                    "approtitle," + 
                    "app_tag," + 
                    "charge," + 
                    "vattag," + 
                    "amt," + 
                    "vatamt," + 
                    "cash_rt," + 
                    "bill_rt," + 
                    "prepayment," + 
                    "deliverymethod," + 
                    "deliverylimitdate," + 
                    "deliverycondition," + 
                    "paymentmethod," + 
                    "remark1," + 
                    "requestseq, owner,check_method,order_class,estimateyymm,estimateseq, " +
                    "price_class,price_sup_class,price_rt,chg_class,pre_pay_dat,const_guar_amt,as_guar_amt,as_term,delay_amt,const_class,process_tag,const_no,remark2 )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21,:22,:23,:24,:25,:26,:27,:28,:29 ,:30,:31,:32,:33,:34,:35,:36,:37,:38) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_approym);
      gpstatement.bindColumn(3, idx_approseq);
      gpstatement.bindColumn(4, idx_chg_cnt);
      gpstatement.bindColumn(5, idx_approdate);
      gpstatement.bindColumn(6, idx_approtitle);
      gpstatement.bindColumn(7, idx_app_tag);
      gpstatement.bindColumn(8, idx_charge);
      gpstatement.bindColumn(9, idx_vattag);
      gpstatement.bindColumn(10, idx_amt);
      gpstatement.bindColumn(11, idx_vatamt);
      gpstatement.bindColumn(12, idx_cash_rt);
      gpstatement.bindColumn(13, idx_bill_rt);
      gpstatement.bindColumn(14, idx_prepayment);
      gpstatement.bindColumn(15, idx_deliverymethod);
      gpstatement.bindColumn(16, idx_deliverylimitdate);
      gpstatement.bindColumn(17, idx_deliverycondition);
      gpstatement.bindColumn(18, idx_paymentmethod);
      gpstatement.bindColumn(19, idx_remark1);
      gpstatement.bindColumn(20, idx_requestseq);
      gpstatement.bindColumn(21, idx_owner);
      gpstatement.bindColumn(22, idx_check_method);
      gpstatement.bindColumn(23, idx_order_class);
      gpstatement.bindColumn(24, idx_estimateyymm);
      gpstatement.bindColumn(25, idx_estimateseq);
      gpstatement.bindColumn(26, idx_price_class);
      gpstatement.bindColumn(27, idx_price_sup_class);
      gpstatement.bindColumn(28, idx_price_rt);
      gpstatement.bindColumn(29, idx_chg_class);
      gpstatement.bindColumn(30, idx_pre_pay_dat);
      gpstatement.bindColumn(31, idx_const_guar_amt);
      gpstatement.bindColumn(32, idx_as_guar_amt);
      gpstatement.bindColumn(33, idx_as_term);
      gpstatement.bindColumn(34, idx_delay_amt);
      gpstatement.bindColumn(35, idx_const_class);
      gpstatement.bindColumn(36, idx_process_tag);
      gpstatement.bindColumn(37, idx_const_no);
      gpstatement.bindColumn(38, idx_remark2);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_approval set " + 
                            "dept_code=?,  " + 
                            "approym=?,  " + 
                            "approseq=?,  " + 
                            "chg_cnt=?,  " + 
                            "approdate=?,  " + 
                            "approtitle=?,  " + 
                            "app_tag=?,  " + 
                            "charge=?,  " + 
                            "vattag=?,  " + 
                            "amt=?,  " + 
                            "vatamt=?,  " + 
                            "cash_rt=?,  " + 
                            "bill_rt=?,  " + 
                            "prepayment=?,  " + 
                            "deliverymethod=?,  " + 
                            "deliverylimitdate=?,  " + 
                            "deliverycondition=?,  " + 
                            "paymentmethod=?,  " + 
                            "remark1=?,  " + 
                            "requestseq=?, owner=?,check_method=?,order_class=?, " +
                            "estimateyymm=?,estimateseq=?, " +
                            "price_class=?,price_sup_class=?,price_rt=?,chg_class=?,pre_pay_dat=?,const_guar_amt=?,as_guar_amt=?,as_term=?,delay_amt=?,const_class=?,process_tag=?,const_no=?,remark2=? " +
                            " where dept_code=? " +
                            " and approym=?  " + 
                            " and approseq=?  " + 
                            " and chg_cnt=?  ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_approym);
      gpstatement.bindColumn(3, idx_approseq);
      gpstatement.bindColumn(4, idx_chg_cnt);
      gpstatement.bindColumn(5, idx_approdate);
      gpstatement.bindColumn(6, idx_approtitle);
      gpstatement.bindColumn(7, idx_app_tag);
      gpstatement.bindColumn(8, idx_charge);
      gpstatement.bindColumn(9, idx_vattag);
      gpstatement.bindColumn(10, idx_amt);
      gpstatement.bindColumn(11, idx_vatamt);
      gpstatement.bindColumn(12, idx_cash_rt);
      gpstatement.bindColumn(13, idx_bill_rt);
      gpstatement.bindColumn(14, idx_prepayment);
      gpstatement.bindColumn(15, idx_deliverymethod);
      gpstatement.bindColumn(16, idx_deliverylimitdate);
      gpstatement.bindColumn(17, idx_deliverycondition);
      gpstatement.bindColumn(18, idx_paymentmethod);
      gpstatement.bindColumn(19, idx_remark1);
      gpstatement.bindColumn(20, idx_requestseq);
      gpstatement.bindColumn(21, idx_owner);
      gpstatement.bindColumn(22, idx_check_method);
      gpstatement.bindColumn(23, idx_order_class);
      gpstatement.bindColumn(24, idx_estimateyymm);
      gpstatement.bindColumn(25, idx_estimateseq);
      gpstatement.bindColumn(26, idx_price_class);
      gpstatement.bindColumn(27, idx_price_sup_class);
      gpstatement.bindColumn(28, idx_price_rt);
      gpstatement.bindColumn(29, idx_chg_class);
      gpstatement.bindColumn(30, idx_pre_pay_dat);
      gpstatement.bindColumn(31, idx_const_guar_amt);
      gpstatement.bindColumn(32, idx_as_guar_amt);
      gpstatement.bindColumn(33, idx_as_term);
      gpstatement.bindColumn(34, idx_delay_amt);
      gpstatement.bindColumn(35, idx_const_class);
      gpstatement.bindColumn(36, idx_process_tag);
      gpstatement.bindColumn(37, idx_const_no);
      gpstatement.bindColumn(38, idx_remark2);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(39, idx_dept_code);
      gpstatement.bindColumn(40, idx_approym);
      gpstatement.bindColumn(41, idx_approseq);
      gpstatement.bindColumn(42, idx_chg_cnt);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_approval where dept_code=? " +
                            " and approym=?  " + 
                            " and approseq=?  " + 
                            " and chg_cnt=?  ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_approym);
      gpstatement.bindColumn(3, idx_approseq);
      gpstatement.bindColumn(4, idx_chg_cnt);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
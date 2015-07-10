<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_price_month_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymmdd = dSet.indexOfColumn("yymmdd");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_input_unq_num = dSet.indexOfColumn("input_unq_num");
   	int idx_month = dSet.indexOfColumn("month");
   	int idx_basic_date = dSet.indexOfColumn("basic_date");
   	int idx_qty = dSet.indexOfColumn("qty");
   	int idx_unitprice = dSet.indexOfColumn("unitprice");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_vatamt = dSet.indexOfColumn("vatamt");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
   	int idx_invoice_num = dSet.indexOfColumn("invoice_num");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_TMAT_PROJ_RENT ( dept_code," + 
                    "yymmdd," + 
                    "seq," + 
                    "input_unq_num," + 
                    "month," + 
                    "basic_date," + 
                    "qty," + 
                    "unitprice," + 
                    "amt," + 
                    "vatamt," + 
                    "spec_no_seq," + 
                    "spec_unq_num," + 
                    "invoice_num )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_input_unq_num);
      gpstatement.bindColumn(5, idx_month);
      gpstatement.bindColumn(6, idx_basic_date);
      gpstatement.bindColumn(7, idx_qty);
      gpstatement.bindColumn(8, idx_unitprice);
      gpstatement.bindColumn(9, idx_amt);
      gpstatement.bindColumn(10, idx_vatamt);
      gpstatement.bindColumn(11, idx_spec_no_seq);
      gpstatement.bindColumn(12, idx_spec_unq_num);
      gpstatement.bindColumn(13, idx_invoice_num);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_tmat_proj_rent set " + 
                            "dept_code=?,  " + 
                            "yymmdd=?,  " + 
                            "seq=?,  " + 
                            "input_unq_num=?,  " + 
                            "month=?,  " + 
                            "basic_date=?,  " + 
                            "qty=?,  " + 
                            "unitprice=?,  " + 
                            "amt=?,  " + 
                            "vatamt=?,  " + 
                            "spec_no_seq=?,  " + 
                            "spec_unq_num=?,  " + 
                            "invoice_num=?  where dept_code=? " +
                            "                 and yymmdd=? " +
                            "                 and seq=? " +
                            "                 and input_unq_num=? " +
                            "                 and month=? " +
                            "                 and degree=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_input_unq_num);
      gpstatement.bindColumn(5, idx_month);
      gpstatement.bindColumn(6, idx_basic_date);
      gpstatement.bindColumn(7, idx_qty);
      gpstatement.bindColumn(8, idx_unitprice);
      gpstatement.bindColumn(9, idx_amt);
      gpstatement.bindColumn(10, idx_vatamt);
      gpstatement.bindColumn(11, idx_spec_no_seq);
      gpstatement.bindColumn(12, idx_spec_unq_num);
      gpstatement.bindColumn(13, idx_invoice_num);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(14, idx_dept_code);
      gpstatement.bindColumn(15, idx_yymmdd);
      gpstatement.bindColumn(16, idx_seq);
      gpstatement.bindColumn(17, idx_input_unq_num);
      gpstatement.bindColumn(18, idx_month);
      gpstatement.bindColumn(19, idx_degree);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_tmat_proj_rent where dept_code=? " + 
                            "                 and yymmdd=? " ;
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
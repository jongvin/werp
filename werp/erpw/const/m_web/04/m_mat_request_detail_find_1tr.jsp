<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_mat_request_detail_find_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymmdd = dSet.indexOfColumn("yymmdd");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_input_unq_num = dSet.indexOfColumn("input_unq_num");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_ssize = dSet.indexOfColumn("ssize");
   	int idx_unitcode = dSet.indexOfColumn("unitcode");
   	int idx_ditag = dSet.indexOfColumn("ditag");
   	int idx_qty = dSet.indexOfColumn("qty");
   	int idx_unitprice = dSet.indexOfColumn("unitprice");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_vatamt = dSet.indexOfColumn("vatamt");
   	int idx_vat_unq_num = dSet.indexOfColumn("vat_unq_num");
   	int idx_vattag = dSet.indexOfColumn("vattag");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
  if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_input_detail set " + 
                            "dept_code=?,  " + 
                            "yymmdd=?,  " + 
                            "seq=?,  " + 
                            "input_unq_num=?,  " + 
                            "name=?,  " + 
                            "ssize=?,  " + 
                            "unitcode=?,  " + 
                            "ditag=?,  " + 
                            "qty=?,  " + 
                            "unitprice=?,  " + 
                            "amt=?,  " + 
                            "vatamt=?,  " + 
                            "vat_unq_num=?,  " + 
                            "vattag=?  where dept_code=? " +
                            "            and yymmdd=? " +
                            "            and seq=? " +
                            "            and input_unq_num=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_input_unq_num);
      gpstatement.bindColumn(5, idx_name);
      gpstatement.bindColumn(6, idx_ssize);
      gpstatement.bindColumn(7, idx_unitcode);
      gpstatement.bindColumn(8, idx_ditag);
      gpstatement.bindColumn(9, idx_qty);
      gpstatement.bindColumn(10, idx_unitprice);
      gpstatement.bindColumn(11, idx_amt);
      gpstatement.bindColumn(12, idx_vatamt);
      gpstatement.bindColumn(13, idx_vat_unq_num);
      gpstatement.bindColumn(14, idx_vattag);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(15, idx_dept_code);
      gpstatement.bindColumn(16, idx_yymmdd);
      gpstatement.bindColumn(17, idx_seq);
      gpstatement.bindColumn(18, idx_input_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
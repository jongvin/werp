<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_invest_list_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymmdd = dSet.indexOfColumn("yymmdd");
   	int idx_mtrcode = dSet.indexOfColumn("mtrcode");
   	int idx_ditag = dSet.indexOfColumn("ditag");
   	int idx_qty = dSet.indexOfColumn("qty");
   	int idx_unitprice = dSet.indexOfColumn("unitprice");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_process_yn = dSet.indexOfColumn("process_yn");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_INVEST_PARENT ( dept_code," + 
                    "yymmdd," + 
                    "mtrcode," + 
                    "ditag," + 
                    "qty," + 
                    "unitprice," + 
                    "amt," + 
                    "process_yn )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_mtrcode);
      gpstatement.bindColumn(4, idx_ditag);
      gpstatement.bindColumn(5, idx_qty);
      gpstatement.bindColumn(6, idx_unitprice);
      gpstatement.bindColumn(7, idx_amt);
      gpstatement.bindColumn(8, idx_process_yn);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_invest_parent set " + 
                            "dept_code=?,  " + 
                            "yymmdd=?,  " + 
                            "mtrcode=?,  " + 
                            "ditag=?,  " + 
                            "qty=?,  " + 
                            "unitprice=?,  " + 
                            "amt=?,  " + 
                            "process_yn=?  where dept_code=? " +
                            "                and yymmdd=?" +
                            "                and mtrcode=?" +
                            "                and ditag=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_mtrcode);
      gpstatement.bindColumn(4, idx_ditag);
      gpstatement.bindColumn(5, idx_qty);
      gpstatement.bindColumn(6, idx_unitprice);
      gpstatement.bindColumn(7, idx_amt);
      gpstatement.bindColumn(8, idx_process_yn);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(9, idx_dept_code);
      gpstatement.bindColumn(10, idx_yymmdd);
      gpstatement.bindColumn(11, idx_mtrcode);
      gpstatement.bindColumn(12, idx_ditag);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_invest_parent where dept_code=? " +
                            "                and yymmdd=?" +
                            "                and mtrcode=?" +  
                            "                and ditag=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_mtrcode);
      gpstatement.bindColumn(4, idx_ditag);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
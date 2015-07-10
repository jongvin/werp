<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("y_stand_detail_acntcode_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_high_detail_code = dSet.indexOfColumn("high_detail_code");
   	int idx_detail_code = dSet.indexOfColumn("detail_code");
   	int idx_acnt_code = dSet.indexOfColumn("acnt_code");
	int idx_acnt_code_key = dSet.indexOfColumn("acnt_code_key");
   	int idx_acnt_name = dSet.indexOfColumn("acnt_name");
   	int idx_input_dt = dSet.indexOfColumn("input_dt");
   	int idx_input_name = dSet.indexOfColumn("input_name");
   	int idx_attrib1 = dSet.indexOfColumn("attrib1");
   	int idx_attrib2 = dSet.indexOfColumn("attrib2");
   	int idx_attrib3 = dSet.indexOfColumn("attrib3");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO y_stand_detail_acntcode ( high_detail_code," + 
                    "detail_code," + 
		" 			 acnt_code,"   +
		" 			 acnt_name,"   +
		" 			 input_dt,"   +
		" 			 input_name,"   +
		" 			 attrib1,"   +
		" 			 attrib2,"   +
		" 			 attrib3 )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_high_detail_code);
      gpstatement.bindColumn(2, idx_detail_code);
      gpstatement.bindColumn(3, idx_acnt_code);
      gpstatement.bindColumn(4, idx_acnt_name);
      gpstatement.bindColumn(5, idx_input_dt);
      gpstatement.bindColumn(6, idx_input_name);
      gpstatement.bindColumn(7, idx_attrib1);
      gpstatement.bindColumn(8, idx_attrib2);
      gpstatement.bindColumn(9, idx_attrib3);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update y_stand_detail_acntcode set " + 
                            "high_detail_code=?,  " + 
							"detail_code=?,  " + 
                 " 			 acnt_code=?,"   +
				" 			 acnt_name=?,"   +
				" 			 input_dt=?,"   +
				" 			 input_name=?,"   +
				" 			 attrib1=?,"   +
				" 			 attrib2=?,"   +
				" 			 attrib3=?  where (high_detail_code=? and detail_code=? and acnt_code=?)";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_high_detail_code);
      gpstatement.bindColumn(2, idx_detail_code);
      gpstatement.bindColumn(3, idx_acnt_code);
      gpstatement.bindColumn(4, idx_acnt_name);
      gpstatement.bindColumn(5, idx_input_dt);
      gpstatement.bindColumn(6, idx_input_name);
      gpstatement.bindColumn(7, idx_attrib1);
      gpstatement.bindColumn(8, idx_attrib2);
      gpstatement.bindColumn(9, idx_attrib3);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(10, idx_high_detail_code);
      gpstatement.bindColumn(11, idx_detail_code);
	  gpstatement.bindColumn(12, idx_acnt_code_key);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from y_stand_detail_acntcode where (high_detail_code=? and detail_code=? and acnt_code=?)"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_high_detail_code);
      gpstatement.bindColumn(2, idx_detail_code);
	  gpstatement.bindColumn(3, idx_acnt_code_key);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
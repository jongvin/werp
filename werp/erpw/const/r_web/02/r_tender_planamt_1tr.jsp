<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("r_tender_planamt_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_receive_code = dSet.indexOfColumn("receive_code");
   	int idx_comp_date = dSet.indexOfColumn("comp_date");
   	int idx_key_comp_date = dSet.indexOfColumn("key_comp_date");
   	int idx_plan_amt01 = dSet.indexOfColumn("plan_amt01");
   	int idx_plan_amt02 = dSet.indexOfColumn("plan_amt02");
   	int idx_plan_amt03 = dSet.indexOfColumn("plan_amt03");
   	int idx_plan_amt04 = dSet.indexOfColumn("plan_amt04");
   	int idx_plan_amt05 = dSet.indexOfColumn("plan_amt05");
   	int idx_plan_amt06 = dSet.indexOfColumn("plan_amt06");
   	int idx_plan_amt07 = dSet.indexOfColumn("plan_amt07");
   	int idx_plan_amt08 = dSet.indexOfColumn("plan_amt08");
   	int idx_plan_amt09 = dSet.indexOfColumn("plan_amt09");
   	int idx_plan_amt10 = dSet.indexOfColumn("plan_amt10");
   	int idx_plan_amt11 = dSet.indexOfColumn("plan_amt11");
   	int idx_plan_amt12 = dSet.indexOfColumn("plan_amt12");
   	int idx_plan_amt13 = dSet.indexOfColumn("plan_amt13");
   	int idx_plan_amt14 = dSet.indexOfColumn("plan_amt14");
   	int idx_plan_amt15 = dSet.indexOfColumn("plan_amt15");
   	int idx_choice_tag01 = dSet.indexOfColumn("choice_tag01");
   	int idx_choice_tag02 = dSet.indexOfColumn("choice_tag02");
   	int idx_choice_tag03 = dSet.indexOfColumn("choice_tag03");
   	int idx_choice_tag04 = dSet.indexOfColumn("choice_tag04");
   	int idx_choice_tag05 = dSet.indexOfColumn("choice_tag05");
   	int idx_choice_tag06 = dSet.indexOfColumn("choice_tag06");
   	int idx_choice_tag07 = dSet.indexOfColumn("choice_tag07");
   	int idx_choice_tag08 = dSet.indexOfColumn("choice_tag08");
   	int idx_choice_tag09 = dSet.indexOfColumn("choice_tag09");
   	int idx_choice_tag10 = dSet.indexOfColumn("choice_tag10");
   	int idx_choice_tag11 = dSet.indexOfColumn("choice_tag11");
   	int idx_choice_tag12 = dSet.indexOfColumn("choice_tag12");
   	int idx_choice_tag13 = dSet.indexOfColumn("choice_tag13");
   	int idx_choice_tag14 = dSet.indexOfColumn("choice_tag14");
   	int idx_choice_tag15 = dSet.indexOfColumn("choice_tag15");
   	int idx_rate = dSet.indexOfColumn("rate");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO R_TENDER_PLANAMT ( receive_code," + 
                    "comp_date," + 
                    "plan_amt01," + 
                    "plan_amt02," + 
                    "plan_amt03," + 
                    "plan_amt04," + 
                    "plan_amt05," + 
                    "plan_amt06," + 
                    "plan_amt07," + 
                    "plan_amt08," + 
                    "plan_amt09," + 
                    "plan_amt10," + 
                    "plan_amt11," + 
                    "plan_amt12," + 
                    "plan_amt13," + 
                    "plan_amt14," + 
                    "plan_amt15," + 
                    "choice_tag01," + 
                    "choice_tag02," + 
                    "choice_tag03," + 
                    "choice_tag04," + 
                    "choice_tag05," + 
                    "choice_tag06," + 
                    "choice_tag07," + 
                    "choice_tag08," + 
                    "choice_tag09," + 
                    "choice_tag10," + 
                    "choice_tag11," + 
                    "choice_tag12," + 
                    "choice_tag13," + 
                    "choice_tag14," + 
                    "choice_tag15," + 
                    "rate )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26, :27, :28, :29, :30, :31, :32, :33 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_receive_code);
      gpstatement.bindColumn(2, idx_comp_date);
      gpstatement.bindColumn(3, idx_plan_amt01);
      gpstatement.bindColumn(4, idx_plan_amt02);
      gpstatement.bindColumn(5, idx_plan_amt03);
      gpstatement.bindColumn(6, idx_plan_amt04);
      gpstatement.bindColumn(7, idx_plan_amt05);
      gpstatement.bindColumn(8, idx_plan_amt06);
      gpstatement.bindColumn(9, idx_plan_amt07);
      gpstatement.bindColumn(10, idx_plan_amt08);
      gpstatement.bindColumn(11, idx_plan_amt09);
      gpstatement.bindColumn(12, idx_plan_amt10);
      gpstatement.bindColumn(13, idx_plan_amt11);
      gpstatement.bindColumn(14, idx_plan_amt12);
      gpstatement.bindColumn(15, idx_plan_amt13);
      gpstatement.bindColumn(16, idx_plan_amt14);
      gpstatement.bindColumn(17, idx_plan_amt15);
      gpstatement.bindColumn(18, idx_choice_tag01);
      gpstatement.bindColumn(19, idx_choice_tag02);
      gpstatement.bindColumn(20, idx_choice_tag03);
      gpstatement.bindColumn(21, idx_choice_tag04);
      gpstatement.bindColumn(22, idx_choice_tag05);
      gpstatement.bindColumn(23, idx_choice_tag06);
      gpstatement.bindColumn(24, idx_choice_tag07);
      gpstatement.bindColumn(25, idx_choice_tag08);
      gpstatement.bindColumn(26, idx_choice_tag09);
      gpstatement.bindColumn(27, idx_choice_tag10);
      gpstatement.bindColumn(28, idx_choice_tag11);
      gpstatement.bindColumn(29, idx_choice_tag12);
      gpstatement.bindColumn(30, idx_choice_tag13);
      gpstatement.bindColumn(31, idx_choice_tag14);
      gpstatement.bindColumn(32, idx_choice_tag15);
      gpstatement.bindColumn(33, idx_rate);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update r_tender_planamt set " + 
                            "receive_code=?,  " + 
                            "comp_date=?,  " + 
                            "plan_amt01=?,  " + 
                            "plan_amt02=?,  " + 
                            "plan_amt03=?,  " + 
                            "plan_amt04=?,  " + 
                            "plan_amt05=?,  " + 
                            "plan_amt06=?,  " + 
                            "plan_amt07=?,  " + 
                            "plan_amt08=?,  " + 
                            "plan_amt09=?,  " + 
                            "plan_amt10=?,  " + 
                            "plan_amt11=?,  " + 
                            "plan_amt12=?,  " + 
                            "plan_amt13=?,  " + 
                            "plan_amt14=?,  " + 
                            "plan_amt15=?,  " + 
                            "choice_tag01=?,  " + 
                            "choice_tag02=?,  " + 
                            "choice_tag03=?,  " + 
                            "choice_tag04=?,  " + 
                            "choice_tag05=?,  " + 
                            "choice_tag06=?,  " + 
                            "choice_tag07=?,  " + 
                            "choice_tag08=?,  " + 
                            "choice_tag09=?,  " + 
                            "choice_tag10=?,  " + 
                            "choice_tag11=?,  " + 
                            "choice_tag12=?,  " + 
                            "choice_tag13=?,  " + 
                            "choice_tag14=?,  " + 
                            "choice_tag15=?,  " + 
                            "rate=?  where receive_code=? " +
                            " and comp_date=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_receive_code);
      gpstatement.bindColumn(2, idx_comp_date);
      gpstatement.bindColumn(3, idx_plan_amt01);
      gpstatement.bindColumn(4, idx_plan_amt02);
      gpstatement.bindColumn(5, idx_plan_amt03);
      gpstatement.bindColumn(6, idx_plan_amt04);
      gpstatement.bindColumn(7, idx_plan_amt05);
      gpstatement.bindColumn(8, idx_plan_amt06);
      gpstatement.bindColumn(9, idx_plan_amt07);
      gpstatement.bindColumn(10, idx_plan_amt08);
      gpstatement.bindColumn(11, idx_plan_amt09);
      gpstatement.bindColumn(12, idx_plan_amt10);
      gpstatement.bindColumn(13, idx_plan_amt11);
      gpstatement.bindColumn(14, idx_plan_amt12);
      gpstatement.bindColumn(15, idx_plan_amt13);
      gpstatement.bindColumn(16, idx_plan_amt14);
      gpstatement.bindColumn(17, idx_plan_amt15);
      gpstatement.bindColumn(18, idx_choice_tag01);
      gpstatement.bindColumn(19, idx_choice_tag02);
      gpstatement.bindColumn(20, idx_choice_tag03);
      gpstatement.bindColumn(21, idx_choice_tag04);
      gpstatement.bindColumn(22, idx_choice_tag05);
      gpstatement.bindColumn(23, idx_choice_tag06);
      gpstatement.bindColumn(24, idx_choice_tag07);
      gpstatement.bindColumn(25, idx_choice_tag08);
      gpstatement.bindColumn(26, idx_choice_tag09);
      gpstatement.bindColumn(27, idx_choice_tag10);
      gpstatement.bindColumn(28, idx_choice_tag11);
      gpstatement.bindColumn(29, idx_choice_tag12);
      gpstatement.bindColumn(30, idx_choice_tag13);
      gpstatement.bindColumn(31, idx_choice_tag14);
      gpstatement.bindColumn(32, idx_choice_tag15);
      gpstatement.bindColumn(33, idx_rate);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(34, idx_receive_code);
      gpstatement.bindColumn(35, idx_key_comp_date);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from r_tender_planamt where receive_code=? " +
                    " and comp_date=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_receive_code);
      gpstatement.bindColumn(2, idx_key_comp_date);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
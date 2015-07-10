<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_tmat_inout_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_month = dSet.indexOfColumn("month");
   	int idx_tmat_code = dSet.indexOfColumn("tmat_code");
   	int idx_in_class = dSet.indexOfColumn("in_class");
   	int idx_remaind_qty = dSet.indexOfColumn("remaind_qty");
   	int idx_in1 = dSet.indexOfColumn("in1");
   	int idx_in2 = dSet.indexOfColumn("in2");
   	int idx_in3 = dSet.indexOfColumn("in3");
   	int idx_in4 = dSet.indexOfColumn("in4");
   	int idx_in5 = dSet.indexOfColumn("in5");
   	int idx_in6 = dSet.indexOfColumn("in6");
   	int idx_in7 = dSet.indexOfColumn("in7");
   	int idx_in8 = dSet.indexOfColumn("in8");
   	int idx_in9 = dSet.indexOfColumn("in9");
   	int idx_in10 = dSet.indexOfColumn("in10");
   	int idx_in11 = dSet.indexOfColumn("in11");
   	int idx_in12 = dSet.indexOfColumn("in12");
   	int idx_in_next = dSet.indexOfColumn("in_next");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	 if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
	 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
	 		String str_yn;	      
    		str_yn = rows.getString(idx_in_class);
	      if (str_yn.equals("1")) {
		      String sSql = "update m_tmat_plan set " + 
		                            "dept_code=?,  " + 
		                            "month=?,  " + 
		                            "tmat_code=?,  " + 
		                            "remaind_qty=?,  " + 
		                            "in1=?,  " + 
		                            "in2=?,  " + 
		                            "in3=?,  " + 
		                            "in4=?,  " + 
		                            "in5=?,  " + 
		                            "in6=?,  " + 
		                            "in7=?,  " + 
		                            "in8=?,  " + 
		                            "in9=?,  " + 
		                            "in10=?,  " + 
		                            "in11=?,  " + 
		                            "in12=?,  " + 
		                            "in_next=?  where dept_code=? " +
		                            "             and month=? " +
		                            "             and tmat_code=? ";  
		      stmt = conn.prepareStatement(sSql); 
		      gpstatement.gp_stmt = stmt;
		      gpstatement.bindColumn(1, idx_dept_code);
		      gpstatement.bindColumn(2, idx_month);
		      gpstatement.bindColumn(3, idx_tmat_code);
		      gpstatement.bindColumn(4, idx_remaind_qty);
		      gpstatement.bindColumn(5, idx_in1);
		      gpstatement.bindColumn(6, idx_in2);
		      gpstatement.bindColumn(7, idx_in3);
		      gpstatement.bindColumn(8, idx_in4);
		      gpstatement.bindColumn(9, idx_in5);
		      gpstatement.bindColumn(10, idx_in6);
		      gpstatement.bindColumn(11, idx_in7);
		      gpstatement.bindColumn(12, idx_in8);
		      gpstatement.bindColumn(13, idx_in9);
		      gpstatement.bindColumn(14, idx_in10);
		      gpstatement.bindColumn(15, idx_in11);
		      gpstatement.bindColumn(16, idx_in12);
		      gpstatement.bindColumn(17, idx_in_next);
		 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
		      gpstatement.bindColumn(18, idx_dept_code);
		      gpstatement.bindColumn(19, idx_month);
		      gpstatement.bindColumn(20, idx_tmat_code);
		      stmt.executeUpdate();
		      stmt.close();
		   }
		   else {
		      String sSql = "update m_tmat_plan set " + 
		                            "dept_code=?,  " + 
		                            "month=?,  " + 
		                            "tmat_code=?,  " + 
		                            "remaind_qty=?,  " + 
		                            "out1=?,  " + 
		                            "out2=?,  " + 
		                            "out3=?,  " + 
		                            "out4=?,  " + 
		                            "out5=?,  " + 
		                            "out6=?,  " + 
		                            "out7=?,  " + 
		                            "out8=?,  " + 
		                            "out9=?,  " + 
		                            "out10=?,  " + 
		                            "out11=?,  " + 
		                            "out12=?,  " + 
		                            "out_next=?  where dept_code=? " +
		                            "          and month=? " +
		                            "          and tmat_code=? ";  
		      stmt = conn.prepareStatement(sSql); 
		      gpstatement.gp_stmt = stmt;
		      gpstatement.bindColumn(1, idx_dept_code);
		      gpstatement.bindColumn(2, idx_month);
		      gpstatement.bindColumn(3, idx_tmat_code);
		      gpstatement.bindColumn(4, idx_remaind_qty);
		      gpstatement.bindColumn(5, idx_in1);
		      gpstatement.bindColumn(6, idx_in2);
		      gpstatement.bindColumn(7, idx_in3);
		      gpstatement.bindColumn(8, idx_in4);
		      gpstatement.bindColumn(9, idx_in5);
		      gpstatement.bindColumn(10, idx_in6);
		      gpstatement.bindColumn(11, idx_in7);
		      gpstatement.bindColumn(12, idx_in8);
		      gpstatement.bindColumn(13, idx_in9);
		      gpstatement.bindColumn(14, idx_in10);
		      gpstatement.bindColumn(15, idx_in11);
		      gpstatement.bindColumn(16, idx_in12);
		      gpstatement.bindColumn(17, idx_in_next);
		 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
		      gpstatement.bindColumn(18, idx_dept_code);
		      gpstatement.bindColumn(19, idx_month);
		      gpstatement.bindColumn(20, idx_tmat_code);
		      stmt.executeUpdate();
		      stmt.close();
		   }
	   }
	}
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
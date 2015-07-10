<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_evl_proj_sbcrdetail_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_evl_year = dSet.indexOfColumn("evl_year");
   	int idx_degree = dSet.indexOfColumn("degree");
   	int idx_evl_class = dSet.indexOfColumn("evl_class");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_order_number = dSet.indexOfColumn("order_number");
   	int idx_class1 = dSet.indexOfColumn("class1");
   	int idx_mng_class = dSet.indexOfColumn("mng_class");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_b_score = dSet.indexOfColumn("b_score");
   	int idx_score1 = dSet.indexOfColumn("score1");
   	int idx_score2 = dSet.indexOfColumn("score2");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_EVL_PROJ_SBCRDETAIL ( evl_year," + 
                    "degree," + 
                    "evl_class," + 
                    "dept_code," + 
                    "order_number," + 
                    "class1," + 
                    "mng_class," + 
                    "seq," + 
                    "b_score," + 
                    "score1," + 
                    "score2 )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_evl_year);
      gpstatement.bindColumn(2, idx_degree);
      gpstatement.bindColumn(3, idx_evl_class);
      gpstatement.bindColumn(4, idx_dept_code);
      gpstatement.bindColumn(5, idx_order_number);
      gpstatement.bindColumn(6, idx_class1);
      gpstatement.bindColumn(7, idx_mng_class);
      gpstatement.bindColumn(8, idx_seq);
      gpstatement.bindColumn(9, idx_b_score);
      gpstatement.bindColumn(10, idx_score1);
      gpstatement.bindColumn(11, idx_score2);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_evl_proj_sbcrdetail set " + 
                            "evl_year=?,  " + 
                            "degree=?,  " + 
                            "evl_class=?,  " + 
                            "dept_code=?,  " + 
                            "order_number=?,  " + 
                            "class1=?,  " + 
                            "mng_class=?,  " + 
                            "seq=?,  " + 
                            "b_score=?,  " + 
                            "score1=?,  " + 
                            "score2=?  where evl_year=? " +
                            "            and degree=? " +
                            "            and evl_class=? " +
                            "            and dept_code=? " +
                            "            and order_number=? " +
                            "            and class1=? " +
                            "            and mng_class=? " +
                            "            and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_evl_year);
      gpstatement.bindColumn(2, idx_degree);
      gpstatement.bindColumn(3, idx_evl_class);
      gpstatement.bindColumn(4, idx_dept_code);
      gpstatement.bindColumn(5, idx_order_number);
      gpstatement.bindColumn(6, idx_class1);
      gpstatement.bindColumn(7, idx_mng_class);
      gpstatement.bindColumn(8, idx_seq);
      gpstatement.bindColumn(9, idx_b_score);
      gpstatement.bindColumn(10, idx_score1);
      gpstatement.bindColumn(11, idx_score2);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(12, idx_evl_year);
      gpstatement.bindColumn(13, idx_degree);
      gpstatement.bindColumn(14, idx_evl_class);
      gpstatement.bindColumn(15, idx_dept_code);
      gpstatement.bindColumn(16, idx_order_number);
      gpstatement.bindColumn(17, idx_class1);
      gpstatement.bindColumn(18, idx_mng_class);
      gpstatement.bindColumn(19, idx_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_evl_proj_sbcrdetail where evl_year=? " + 
                            "            and degree=? " +
                            "            and evl_class=? " +
                            "            and dept_code=? " +
                            "            and order_number=? " +
                            "            and class1=? " +
                            "            and mng_class=? " +
                            "            and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_evl_year);
      gpstatement.bindColumn(2, idx_degree);
      gpstatement.bindColumn(3, idx_evl_class);
      gpstatement.bindColumn(4, idx_dept_code);
      gpstatement.bindColumn(5, idx_order_number);
      gpstatement.bindColumn(6, idx_class1);
      gpstatement.bindColumn(7, idx_mng_class);
      gpstatement.bindColumn(8, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
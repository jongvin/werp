<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_evl_proj_evlsbcr_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_evl_year = dSet.indexOfColumn("evl_year");
   	int idx_degree = dSet.indexOfColumn("degree");
   	int idx_evl_class = dSet.indexOfColumn("evl_class");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_order_number = dSet.indexOfColumn("order_number");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_sbcr_name = dSet.indexOfColumn("sbcr_name");
   	int idx_evl_yn = dSet.indexOfColumn("evl_yn");
   	int idx_profession_wbs_code = dSet.indexOfColumn("profession_wbs_code");
   	int idx_profession_wbs_name = dSet.indexOfColumn("profession_wbs_name");
   	int idx_sbc_name = dSet.indexOfColumn("sbc_name");
   	int idx_order_class = dSet.indexOfColumn("order_class");
   	int idx_evl_id = dSet.indexOfColumn("evl_id");
   	int idx_evl_name = dSet.indexOfColumn("evl_name");
   	int idx_id2 = dSet.indexOfColumn("id2");
   	int idx_name2 = dSet.indexOfColumn("name2");
   	int idx_score1 = dSet.indexOfColumn("score1");
   	int idx_score2 = dSet.indexOfColumn("score2");
   	int idx_eva_score = dSet.indexOfColumn("eva_score");
   	int idx_add_score = dSet.indexOfColumn("add_score");
   	int idx_evl_desc1 = dSet.indexOfColumn("evl_desc1");
   	int idx_evl_desc2 = dSet.indexOfColumn("evl_desc2");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_EVL_PROJ_EVLSBCR ( evl_year," + 
                    "degree," + 
                    "evl_class," + 
                    "dept_code," + 
                    "order_number," + 
                    "sbcr_code," + 
                    "sbcr_name," + 
                    "evl_yn," + 
                    "profession_wbs_code," + 
                    "profession_wbs_name," + 
                    "sbc_name," + 
                    "order_class," + 
                    "evl_id," + 
                    "evl_name," + 
                    "id2," + 
                    "name2," + 
                    "score1," + 
                    "score2," + 
                    "eva_score," + 
                    "add_score," + 
                    "evl_desc1," + 
                    "evl_desc2 )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_evl_year);
      gpstatement.bindColumn(2, idx_degree);
      gpstatement.bindColumn(3, idx_evl_class);
      gpstatement.bindColumn(4, idx_dept_code);
      gpstatement.bindColumn(5, idx_order_number);
      gpstatement.bindColumn(6, idx_sbcr_code);
      gpstatement.bindColumn(7, idx_sbcr_name);
      gpstatement.bindColumn(8, idx_evl_yn);
      gpstatement.bindColumn(9, idx_profession_wbs_code);
      gpstatement.bindColumn(10, idx_profession_wbs_name);
      gpstatement.bindColumn(11, idx_sbc_name);
      gpstatement.bindColumn(12, idx_order_class);
      gpstatement.bindColumn(13, idx_evl_id);
      gpstatement.bindColumn(14, idx_evl_name);
      gpstatement.bindColumn(15, idx_id2);
      gpstatement.bindColumn(16, idx_name2);
      gpstatement.bindColumn(17, idx_score1);
      gpstatement.bindColumn(18, idx_score2);
      gpstatement.bindColumn(19, idx_eva_score);
      gpstatement.bindColumn(20, idx_add_score);
      gpstatement.bindColumn(21, idx_evl_desc1);
      gpstatement.bindColumn(22, idx_evl_desc2);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_evl_proj_evlsbcr set " + 
                            "evl_year=?,  " + 
                            "degree=?,  " + 
                            "evl_class=?,  " + 
                            "dept_code=?,  " + 
                            "order_number=?,  " + 
                            "sbcr_code=?,  " + 
                            "sbcr_name=?,  " + 
                            "evl_yn=?,  " + 
                            "profession_wbs_code=?,  " + 
                            "profession_wbs_name=?,  " + 
                            "sbc_name=?,  " + 
                            "order_class=?,  " + 
                            "evl_id=?,  " + 
                            "evl_name=?,  " + 
                            "id2=?,  " + 
                            "name2=?,  " + 
                            "score1=?,  " + 
                            "score2=?,  " + 
                            "eva_score=?,  " + 
                            "add_score=?,  " + 
                            "evl_desc1=?,  " + 
                            "evl_desc2=?  where evl_year=? " +
                            "               and degree=? " +
                            "               and evl_class=? " +
                            "               and dept_code=? " +
                            "               and order_number=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_evl_year);
      gpstatement.bindColumn(2, idx_degree);
      gpstatement.bindColumn(3, idx_evl_class);
      gpstatement.bindColumn(4, idx_dept_code);
      gpstatement.bindColumn(5, idx_order_number);
      gpstatement.bindColumn(6, idx_sbcr_code);
      gpstatement.bindColumn(7, idx_sbcr_name);
      gpstatement.bindColumn(8, idx_evl_yn);
      gpstatement.bindColumn(9, idx_profession_wbs_code);
      gpstatement.bindColumn(10, idx_profession_wbs_name);
      gpstatement.bindColumn(11, idx_sbc_name);
      gpstatement.bindColumn(12, idx_order_class);
      gpstatement.bindColumn(13, idx_evl_id);
      gpstatement.bindColumn(14, idx_evl_name);
      gpstatement.bindColumn(15, idx_id2);
      gpstatement.bindColumn(16, idx_name2);
      gpstatement.bindColumn(17, idx_score1);
      gpstatement.bindColumn(18, idx_score2);
      gpstatement.bindColumn(19, idx_eva_score);
      gpstatement.bindColumn(20, idx_add_score);
      gpstatement.bindColumn(21, idx_evl_desc1);
      gpstatement.bindColumn(22, idx_evl_desc2);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(23, idx_evl_year);
      gpstatement.bindColumn(24, idx_degree);
      gpstatement.bindColumn(25, idx_evl_class);
      gpstatement.bindColumn(26, idx_dept_code);
      gpstatement.bindColumn(27, idx_order_number);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_evl_proj_evlsbcr where evl_year=? " + 
                            "               and degree=? " +
                            "               and evl_class=? " +
                            "               and dept_code=? " +
                            "               and order_number=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_evl_year);
      gpstatement.bindColumn(2, idx_degree);
      gpstatement.bindColumn(3, idx_evl_class);
      gpstatement.bindColumn(4, idx_dept_code);
      gpstatement.bindColumn(5, idx_order_number);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_iron_order_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_month = dSet.indexOfColumn("month");
   	int idx_mtrcode = dSet.indexOfColumn("mtrcode");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_meta = dSet.indexOfColumn("meta");
   	int idx_remaind_qty = dSet.indexOfColumn("remaind_qty");
   	int idx_week1 = dSet.indexOfColumn("week1");
   	int idx_week2 = dSet.indexOfColumn("week2");
   	int idx_week3 = dSet.indexOfColumn("week3");
   	int idx_week4 = dSet.indexOfColumn("week4");
   	int idx_week_tot = dSet.indexOfColumn("week_tot");
   	int idx_mon_qty1 = dSet.indexOfColumn("mon_qty1");
   	int idx_mon_qty2 = dSet.indexOfColumn("mon_qty2");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_sbcr_name = dSet.indexOfColumn("sbcr_name");
   	int idx_proj_tel = dSet.indexOfColumn("proj_tel");
   	int idx_bigo = dSet.indexOfColumn("bigo");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_IRON_PLAN_DETAIL ( dept_code," + 
                    "month," + 
                    "mtrcode," + 
                    "seq," + 
                    "meta," + 
                    "remaind_qty," + 
                    "week1," + 
                    "week2," + 
                    "week3," + 
                    "week4," + 
                    "week_tot," + 
                    "mon_qty1," + 
                    "mon_qty2," + 
                    "sbcr_code," + 
                    "sbcr_name," + 
                    "proj_tel," + 
                    "bigo )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_month);
      gpstatement.bindColumn(3, idx_mtrcode);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_meta);
      gpstatement.bindColumn(6, idx_remaind_qty);
      gpstatement.bindColumn(7, idx_week1);
      gpstatement.bindColumn(8, idx_week2);
      gpstatement.bindColumn(9, idx_week3);
      gpstatement.bindColumn(10, idx_week4);
      gpstatement.bindColumn(11, idx_week_tot);
      gpstatement.bindColumn(12, idx_mon_qty1);
      gpstatement.bindColumn(13, idx_mon_qty2);
      gpstatement.bindColumn(14, idx_sbcr_code);
      gpstatement.bindColumn(15, idx_sbcr_name);
      gpstatement.bindColumn(16, idx_proj_tel);
      gpstatement.bindColumn(17, idx_bigo);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_iron_plan_detail set " + 
                            "dept_code=?,  " + 
                            "month=?,  " + 
                            "mtrcode=?,  " + 
                            "seq=?,  " + 
                            "meta=?,  " + 
                            "remaind_qty=?,  " + 
                            "week1=?,  " + 
                            "week2=?,  " + 
                            "week3=?,  " + 
                            "week4=?,  " + 
                            "week_tot=?,  " + 
                            "mon_qty1=?,  " + 
                            "mon_qty2=?,  " + 
                            "sbcr_code=?,  " + 
                            "sbcr_name=?,  " + 
                            "proj_tel=?,  " + 
                            "bigo=?  where dept_code=? " +
                            "          and month=? "  +
                            "          and mtrcode=? " +
                            "          and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_month);
      gpstatement.bindColumn(3, idx_mtrcode);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_meta);
      gpstatement.bindColumn(6, idx_remaind_qty);
      gpstatement.bindColumn(7, idx_week1);
      gpstatement.bindColumn(8, idx_week2);
      gpstatement.bindColumn(9, idx_week3);
      gpstatement.bindColumn(10, idx_week4);
      gpstatement.bindColumn(11, idx_week_tot);
      gpstatement.bindColumn(12, idx_mon_qty1);
      gpstatement.bindColumn(13, idx_mon_qty2);
      gpstatement.bindColumn(14, idx_sbcr_code);
      gpstatement.bindColumn(15, idx_sbcr_name);
      gpstatement.bindColumn(16, idx_proj_tel);
      gpstatement.bindColumn(17, idx_bigo);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(18, idx_dept_code);
      gpstatement.bindColumn(19, idx_month);
      gpstatement.bindColumn(20, idx_mtrcode);
      gpstatement.bindColumn(21, idx_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_iron_plan_detail where dept_code=? " +  
                            "          and month=? "  +
                            "          and mtrcode=? " +
                            "          and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_month);
      gpstatement.bindColumn(3, idx_mtrcode);
      gpstatement.bindColumn(4, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
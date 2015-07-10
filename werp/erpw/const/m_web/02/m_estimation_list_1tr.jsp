<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_estimation_list_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_estimateyymm = dSet.indexOfColumn("estimateyymm");
   	int idx_estimateseq = dSet.indexOfColumn("estimateseq");
   	int idx_estimatedate = dSet.indexOfColumn("estimatedate");
   	int idx_esttitle = dSet.indexOfColumn("esttitle");
   	int idx_vattag = dSet.indexOfColumn("vattag");
   	int idx_enddatetime = dSet.indexOfColumn("enddatetime");
   	int idx_estmethod1 = dSet.indexOfColumn("estmethod1");
   	int idx_estmethod2 = dSet.indexOfColumn("estmethod2");
   	int idx_paycondition = dSet.indexOfColumn("paycondition");
   	int idx_deliverycondition = dSet.indexOfColumn("deliverycondition");
   	int idx_selectcondition = dSet.indexOfColumn("selectcondition");
   	int idx_buytag = dSet.indexOfColumn("buytag");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_recommend = dSet.indexOfColumn("recommend");
   	int idx_deliverylimitdate = dSet.indexOfColumn("deliverylimitdate");
   	int idx_requestseq = dSet.indexOfColumn("requestseq");
   	int idx_ebid_yn = dSet.indexOfColumn("ebid_yn");
   	int idx_order_class = dSet.indexOfColumn("order_class");
   	int idx_bid_class = dSet.indexOfColumn("bid_class");
   	int idx_open_class = dSet.indexOfColumn("open_class");
   	int idx_const_guarantee_clasee = dSet.indexOfColumn("const_guarantee_clasee");
   	int idx_pre_amt_guarantee = dSet.indexOfColumn("pre_amt_guarantee");
   	int idx_as_guarantee = dSet.indexOfColumn("as_guarantee");
   	int idx_const_cond = dSet.indexOfColumn("const_cond");
   	int idx_sibangsoe = dSet.indexOfColumn("sibangsoe");
   	int idx_spec_cond = dSet.indexOfColumn("spec_cond");
   	int idx_etc_file = dSet.indexOfColumn("etc_file");
   	int idx_open_yn = dSet.indexOfColumn("open_yn");
   	int idx_open_dt = dSet.indexOfColumn("open_dt");
   	int idx_open_per = dSet.indexOfColumn("open_per");
   	int idx_tender_place = dSet.indexOfColumn("tender_place");
   	int idx_siteexplain_dt = dSet.indexOfColumn("siteexplain_dt");
   	int idx_siteexplain_place = dSet.indexOfColumn("siteexplain_place");
   	int idx_explain_per = dSet.indexOfColumn("explain_per");
   	int idx_join_per = dSet.indexOfColumn("join_per");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_ESTIMATION ( estimateyymm," + 
                    "estimateseq," + 
                    "estimatedate," + 
                    "esttitle," + 
                    "vattag," + 
                    "enddatetime," + 
                    "estmethod1," + 
                    "estmethod2," + 
                    "paycondition," + 
                    "deliverycondition," + 
                    "selectcondition," + 
                    "buytag," + 
                    "remark," + 
                    "recommend," + 
                    "deliverylimitdate," + 
                    "requestseq," + 
                    "ebid_yn," + 
                    "order_class," + 
                    "bid_class," + 
                    "open_class," + 
                    "const_guarantee_clasee," + 
                    "pre_amt_guarantee," + 
                    "as_guarantee," + 
                    "const_cond," + 
                    "sibangsoe," + 
                    "spec_cond," + 
                    "etc_file," + 
                    "open_yn," + 
                    "open_dt," + 
                    "open_per," +
                    "tender_place," +
                    "siteexplain_dt," +
                    "siteexplain_place," +
                    "explain_per, " +
                    "join_per )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, TO_DATE(:6,'yyyy.mm.dd hh24:mi'), :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26, :27, :28, TO_DATE(:29,'yyyy.mm.dd hh24:mi'), :30, :31, TO_DATE(:32,'yyyy.mm.dd hh24:mi'), :33, :34, :35 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_estimateyymm);
      gpstatement.bindColumn(2, idx_estimateseq);
      gpstatement.bindColumn(3, idx_estimatedate);
      gpstatement.bindColumn(4, idx_esttitle);
      gpstatement.bindColumn(5, idx_vattag);
      gpstatement.bindColumn(6, idx_enddatetime);
      gpstatement.bindColumn(7, idx_estmethod1);
      gpstatement.bindColumn(8, idx_estmethod2);
      gpstatement.bindColumn(9, idx_paycondition);
      gpstatement.bindColumn(10, idx_deliverycondition);
      gpstatement.bindColumn(11, idx_selectcondition);
      gpstatement.bindColumn(12, idx_buytag);
      gpstatement.bindColumn(13, idx_remark);
      gpstatement.bindColumn(14, idx_recommend);
      gpstatement.bindColumn(15, idx_deliverylimitdate);
      gpstatement.bindColumn(16, idx_requestseq);
      gpstatement.bindColumn(17, idx_ebid_yn);
      gpstatement.bindColumn(18, idx_order_class);
      gpstatement.bindColumn(19, idx_bid_class);
      gpstatement.bindColumn(20, idx_open_class);
      gpstatement.bindColumn(21, idx_const_guarantee_clasee);
      gpstatement.bindColumn(22, idx_pre_amt_guarantee);
      gpstatement.bindColumn(23, idx_as_guarantee);
      gpstatement.bindColumn(24, idx_const_cond);
      gpstatement.bindColumn(25, idx_sibangsoe);
      gpstatement.bindColumn(26, idx_spec_cond);
      gpstatement.bindColumn(27, idx_etc_file);
      gpstatement.bindColumn(28, idx_open_yn);
      gpstatement.bindColumn(29, idx_open_dt);
      gpstatement.bindColumn(30, idx_open_per);
      gpstatement.bindColumn(31, idx_tender_place);
      gpstatement.bindColumn(32, idx_siteexplain_dt);
      gpstatement.bindColumn(33, idx_siteexplain_place);
      gpstatement.bindColumn(34, idx_explain_per);
      gpstatement.bindColumn(35, idx_join_per);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_estimation set " + 
                            "estimateyymm=?,  " + 
                            "estimateseq=?,  " + 
                            "estimatedate=?,  " + 
                            "esttitle=?,  " + 
                            "vattag=?,  " + 
                            "enddatetime=TO_DATE(?,'yyyy.mm.dd hh24:mi'),  " + 
                            "estmethod1=?,  " + 
                            "estmethod2=?,  " + 
                            "paycondition=?,  " + 
                            "deliverycondition=?,  " + 
                            "selectcondition=?,  " + 
                            "buytag=?,  " + 
                            "remark=?,  " + 
                            "recommend=?,  " + 
                            "deliverylimitdate=?,  " + 
                            "requestseq=?,  " + 
                            "ebid_yn=?,  " + 
                            "order_class=?,  " + 
                            "bid_class=?,  " + 
                            "open_class=?,  " + 
                            "const_guarantee_clasee=?,  " + 
                            "pre_amt_guarantee=?,  " + 
                            "as_guarantee=?,  " + 
                            "const_cond=?,  " + 
                            "sibangsoe=?,  " + 
                            "spec_cond=?,  " + 
                            "etc_file=?,  " + 
                            "open_yn=?,  " + 
                            "open_dt=TO_DATE(?,'yyyy.mm.dd hh24:mi'),  " + 
                            "open_per=?,	" +                            
                    			 "tender_place=?," +
                    			 "siteexplain_dt=TO_DATE(?,'yyyy.mm.dd hh24:mi')," +
                    			 "siteexplain_place=?," +
                    			 "explain_per=?, " +
                    			 "join_per=?  where estimateyymm=? " +
                            "              and estimateseq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_estimateyymm);
      gpstatement.bindColumn(2, idx_estimateseq);
      gpstatement.bindColumn(3, idx_estimatedate);
      gpstatement.bindColumn(4, idx_esttitle);
      gpstatement.bindColumn(5, idx_vattag);
      gpstatement.bindColumn(6, idx_enddatetime);
      gpstatement.bindColumn(7, idx_estmethod1);
      gpstatement.bindColumn(8, idx_estmethod2);
      gpstatement.bindColumn(9, idx_paycondition);
      gpstatement.bindColumn(10, idx_deliverycondition);
      gpstatement.bindColumn(11, idx_selectcondition);
      gpstatement.bindColumn(12, idx_buytag);
      gpstatement.bindColumn(13, idx_remark);
      gpstatement.bindColumn(14, idx_recommend);
      gpstatement.bindColumn(15, idx_deliverylimitdate);
      gpstatement.bindColumn(16, idx_requestseq);
      gpstatement.bindColumn(17, idx_ebid_yn);
      gpstatement.bindColumn(18, idx_order_class);
      gpstatement.bindColumn(19, idx_bid_class);
      gpstatement.bindColumn(20, idx_open_class);
      gpstatement.bindColumn(21, idx_const_guarantee_clasee);
      gpstatement.bindColumn(22, idx_pre_amt_guarantee);
      gpstatement.bindColumn(23, idx_as_guarantee);
      gpstatement.bindColumn(24, idx_const_cond);
      gpstatement.bindColumn(25, idx_sibangsoe);
      gpstatement.bindColumn(26, idx_spec_cond);
      gpstatement.bindColumn(27, idx_etc_file);
      gpstatement.bindColumn(28, idx_open_yn);
      gpstatement.bindColumn(29, idx_open_dt);
      gpstatement.bindColumn(30, idx_open_per);
      gpstatement.bindColumn(31, idx_tender_place);
      gpstatement.bindColumn(32, idx_siteexplain_dt);
      gpstatement.bindColumn(33, idx_siteexplain_place);
      gpstatement.bindColumn(34, idx_explain_per);
      gpstatement.bindColumn(35, idx_join_per);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(36, idx_estimateyymm);
      gpstatement.bindColumn(37, idx_estimateseq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_estimation where estimateyymm=? " +
                            "              and estimateseq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_estimateyymm);
      gpstatement.bindColumn(2, idx_estimateseq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
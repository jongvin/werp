<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("r_const_inform_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_date_year = dSet.indexOfColumn("date_year");
   	int idx_no = dSet.indexOfColumn("no");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_const_shortname = dSet.indexOfColumn("const_shortname");
   	int idx_receive_code = dSet.indexOfColumn("receive_code");
   	int idx_order_no = dSet.indexOfColumn("order_no");
   	int idx_order_no1 = dSet.indexOfColumn("order_no1");
   	int idx_region_code = dSet.indexOfColumn("region_code");
   	int idx_const_position = dSet.indexOfColumn("const_position");
   	int idx_constkind_tag = dSet.indexOfColumn("constkind_tag");
   	int idx_pq_tag = dSet.indexOfColumn("pq_tag");
   	int idx_join_cont_tag = dSet.indexOfColumn("join_cont_tag");
   	int idx_receive_tag = dSet.indexOfColumn("receive_tag");
   	int idx_receive_process_class = dSet.indexOfColumn("receive_process_class");
   	int idx_tender_tag = dSet.indexOfColumn("tender_tag");
   	int idx_order_tag = dSet.indexOfColumn("order_tag");
   	int idx_input_date = dSet.indexOfColumn("input_date");
   	int idx_notice_date = dSet.indexOfColumn("notice_date");
   	int idx_order_time = dSet.indexOfColumn("order_time");
   	int idx_field_explan_date = dSet.indexOfColumn("field_explan_date");
   	int idx_pq_code = dSet.indexOfColumn("pq_code");
   	int idx_pq_limit_date = dSet.indexOfColumn("pq_limit_date");
   	int idx_tender_date = dSet.indexOfColumn("tender_date");
   	int idx_const_from = dSet.indexOfColumn("const_from");
   	int idx_const_to = dSet.indexOfColumn("const_to");
   	int idx_presume_price = dSet.indexOfColumn("presume_price");
   	int idx_presume_amt = dSet.indexOfColumn("presume_amt");
   	int idx_const_outline1 = dSet.indexOfColumn("const_outline1");
   	int idx_const_outline2 = dSet.indexOfColumn("const_outline2");
   	int idx_limit_contents1 = dSet.indexOfColumn("limit_contents1");
   	int idx_limit_contents2 = dSet.indexOfColumn("limit_contents2");
   	int idx_notice_material = dSet.indexOfColumn("notice_material");
   	int idx_year_area = dSet.indexOfColumn("year_area");
   	int idx_year_area_unit = dSet.indexOfColumn("year_area_unit");
   	int idx_volume_rt = dSet.indexOfColumn("volume_rt");
   	int idx_bulid_rt = dSet.indexOfColumn("bulid_rt");
   	int idx_const_area = dSet.indexOfColumn("const_area");
   	int idx_const_area_unit = dSet.indexOfColumn("const_area_unit");
   	int idx_comp_size = dSet.indexOfColumn("comp_size");
   	int idx_floor = dSet.indexOfColumn("floor");
   	int idx_approve_cond = dSet.indexOfColumn("approve_cond");
   	int idx_before_opinion = dSet.indexOfColumn("before_opinion");
   	int idx_after_opinion = dSet.indexOfColumn("after_opinion");
   	int idx_remark = dSet.indexOfColumn("remark");
	int idx_input_emp_no = dSet.indexOfColumn("input_emp_no");
	int idx_input_name = dSet.indexOfColumn("input_name");
	int idx_masterdept_tag = dSet.indexOfColumn("masterdept_tag");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO R_RECEIVED_CONSTRUCTION ( date_year," + 
                    "no, " + 
                    "name, " + 
                    "const_shortname, " + 
                    "receive_code, " + 
                    "order_no, " + 
                    "order_no1, " + 
                    "region_code, " + 
                    "const_position, " + 
                    "constkind_tag, " + 
                    "pq_tag, " + 
                    "join_cont_tag, " + 
                    "receive_tag, " + 
                    "receive_process_class, " + 
                    "tender_tag, " + 
                    "order_tag, " + 
                    "input_date, " + 
                    "notice_date, " + 
                    "order_time, " + 
                    "field_explan_date, " + 
                    "pq_code, " + 
                    "pq_limit_date, " + 
                    "tender_date, " + 
                    "const_from, " + 
                    "const_to, " + 
                    "presume_price, " + 
                    "presume_amt, " + 
                    "const_outline1, " + 
                    "const_outline2, " + 
                    "limit_contents1, " + 
                    "limit_contents2, " + 
                    "notice_material, " + 
                    "year_area, " + 
                    "year_area_unit, " + 
                    "volume_rt, " + 
                    "bulid_rt, " + 
                    "const_area, " + 
                    "const_area_unit, " + 
                    "comp_size, " + 
                    "floor, " + 
                    "approve_cond, " + 
                    "before_opinion, " + 
                    "after_opinion, " + 
                    "remark," +
			        "input_emp_no,"+
			        "input_name, " +
			        "masterdept_tag )      ";
      sSql = sSql + " VALUES ( :1, (select max(no) +1  from r_received_construction where date_year = :1) "+
		                     ",  :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26, :27, :28, :29, :30, :31, :32, :33, :34, :35, :36, :37, :38, :39, :40, :41, :42, :43, :44, :45, :46, :47 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_date_year);
      gpstatement.bindColumn(2, idx_date_year);
      gpstatement.bindColumn(3, idx_name);
      gpstatement.bindColumn(4, idx_const_shortname);
      gpstatement.bindColumn(5, idx_receive_code);
      gpstatement.bindColumn(6, idx_order_no);
      gpstatement.bindColumn(7, idx_order_no1);
      gpstatement.bindColumn(8, idx_region_code);
      gpstatement.bindColumn(9, idx_const_position);
      gpstatement.bindColumn(10, idx_constkind_tag);
      gpstatement.bindColumn(11, idx_pq_tag);
      gpstatement.bindColumn(12, idx_join_cont_tag);
      gpstatement.bindColumn(13, idx_receive_tag);
      gpstatement.bindColumn(14, idx_receive_process_class);
      gpstatement.bindColumn(15, idx_tender_tag);
      gpstatement.bindColumn(16, idx_order_tag);
      gpstatement.bindColumn(17, idx_input_date);
      gpstatement.bindColumn(18, idx_notice_date);
      gpstatement.bindColumn(19, idx_order_time);
      gpstatement.bindColumn(20, idx_field_explan_date);
      gpstatement.bindColumn(21, idx_pq_code);
      gpstatement.bindColumn(22, idx_pq_limit_date);
      gpstatement.bindColumn(23, idx_tender_date);
      gpstatement.bindColumn(24, idx_const_from);
      gpstatement.bindColumn(25, idx_const_to);
      gpstatement.bindColumn(26, idx_presume_price);
      gpstatement.bindColumn(27, idx_presume_amt);
      gpstatement.bindColumn(28, idx_const_outline1);
      gpstatement.bindColumn(29, idx_const_outline2);
      gpstatement.bindColumn(30, idx_limit_contents1);
      gpstatement.bindColumn(31, idx_limit_contents2);
      gpstatement.bindColumn(32, idx_notice_material);
      gpstatement.bindColumn(33, idx_year_area);
      gpstatement.bindColumn(34, idx_year_area_unit);
      gpstatement.bindColumn(35, idx_volume_rt);
      gpstatement.bindColumn(36, idx_bulid_rt);
      gpstatement.bindColumn(37, idx_const_area);
      gpstatement.bindColumn(38, idx_const_area_unit);
      gpstatement.bindColumn(39, idx_comp_size);
      gpstatement.bindColumn(40, idx_floor);
      gpstatement.bindColumn(41, idx_approve_cond);
      gpstatement.bindColumn(42, idx_before_opinion);
      gpstatement.bindColumn(43, idx_after_opinion);
      gpstatement.bindColumn(44, idx_remark);
	  gpstatement.bindColumn(45, idx_input_emp_no);
	  gpstatement.bindColumn(46, idx_input_name);
	  gpstatement.bindColumn(47, idx_masterdept_tag);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update r_received_construction set " + 
                            "date_year=?,  " + 
                            "no=?,  " + 
                            "name=?,  " + 
                            "const_shortname=?,  " + 
                            "receive_code=?,  " + 
                            "order_no=?,  " + 
                            "order_no1=?,  " + 
                            "region_code=?,  " + 
                            "const_position=?,  " + 
                            "constkind_tag=?,  " + 
                            "pq_tag=?,  " + 
                            "join_cont_tag=?,  " + 
                            "receive_tag=?,  " + 
                            "receive_process_class=?,  " + 
                            "tender_tag=?,  " + 
                            "order_tag=?,  " + 
                            "input_date=?,  " + 
                            "notice_date=?,  " + 
                            "order_time=?,  " + 
                            "field_explan_date=?,  " + 
                            "pq_code=?,  " + 
                            "pq_limit_date=?,  " + 
                            "tender_date=?,  " + 
                            "const_from=?,  " + 
                            "const_to=?,  " + 
                            "presume_price=?,  " + 
                            "presume_amt=?,  " + 
                            "const_outline1=?,  " + 
                            "const_outline2=?,  " + 
                            "limit_contents1=?,  " + 
                            "limit_contents2=?,  " + 
                            "notice_material=?,  " + 
                            "year_area=?,  " + 
                            "year_area_unit=?,  " + 
                            "volume_rt=?,  " + 
                            "bulid_rt=?,  " + 
                            "const_area=?,  " + 
                            "const_area_unit=?,  " + 
                            "comp_size=?,  " + 
                            "floor=?,  " + 
                            "approve_cond=?,  " + 
                            "before_opinion=?,  " + 
                            "after_opinion=?,  " + 
                            "remark=?, " +
                            "masterdept_tag=?  where date_year=? " +
                            " and no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_date_year);
      gpstatement.bindColumn(2, idx_no);
      gpstatement.bindColumn(3, idx_name);
      gpstatement.bindColumn(4, idx_const_shortname);
      gpstatement.bindColumn(5, idx_receive_code);
      gpstatement.bindColumn(6, idx_order_no);
      gpstatement.bindColumn(7, idx_order_no1);
      gpstatement.bindColumn(8, idx_region_code);
      gpstatement.bindColumn(9, idx_const_position);
      gpstatement.bindColumn(10, idx_constkind_tag);
      gpstatement.bindColumn(11, idx_pq_tag);
      gpstatement.bindColumn(12, idx_join_cont_tag);
      gpstatement.bindColumn(13, idx_receive_tag);
      gpstatement.bindColumn(14, idx_receive_process_class);
      gpstatement.bindColumn(15, idx_tender_tag);
      gpstatement.bindColumn(16, idx_order_tag);
      gpstatement.bindColumn(17, idx_input_date);
      gpstatement.bindColumn(18, idx_notice_date);
      gpstatement.bindColumn(19, idx_order_time);
      gpstatement.bindColumn(20, idx_field_explan_date);
      gpstatement.bindColumn(21, idx_pq_code);
      gpstatement.bindColumn(22, idx_pq_limit_date);
      gpstatement.bindColumn(23, idx_tender_date);
      gpstatement.bindColumn(24, idx_const_from);
      gpstatement.bindColumn(25, idx_const_to);
      gpstatement.bindColumn(26, idx_presume_price);
      gpstatement.bindColumn(27, idx_presume_amt);
      gpstatement.bindColumn(28, idx_const_outline1);
      gpstatement.bindColumn(29, idx_const_outline2);
      gpstatement.bindColumn(30, idx_limit_contents1);
      gpstatement.bindColumn(31, idx_limit_contents2);
      gpstatement.bindColumn(32, idx_notice_material);
      gpstatement.bindColumn(33, idx_year_area);
      gpstatement.bindColumn(34, idx_year_area_unit);
      gpstatement.bindColumn(35, idx_volume_rt);
      gpstatement.bindColumn(36, idx_bulid_rt);
      gpstatement.bindColumn(37, idx_const_area);
      gpstatement.bindColumn(38, idx_const_area_unit);
      gpstatement.bindColumn(39, idx_comp_size);
      gpstatement.bindColumn(40, idx_floor);
      gpstatement.bindColumn(41, idx_approve_cond);
      gpstatement.bindColumn(42, idx_before_opinion);
      gpstatement.bindColumn(43, idx_after_opinion);
      gpstatement.bindColumn(44, idx_remark);
      gpstatement.bindColumn(45, idx_masterdept_tag);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(46, idx_date_year);
      gpstatement.bindColumn(47, idx_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from r_received_construction where date_year=? " +
      			" and no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_date_year);
      gpstatement.bindColumn(2, idx_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
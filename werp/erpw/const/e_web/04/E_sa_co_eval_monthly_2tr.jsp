<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("e_sa_co_eval_monthly_2tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_order_number = dSet.indexOfColumn("order_number");
   	int idx_yymm = dSet.indexOfColumn("yymm");
   	int idx_profession_wbs_code = dSet.indexOfColumn("profession_wbs_code");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_sbc_name = dSet.indexOfColumn("sbc_name");
   	int idx_sbcr_name = dSet.indexOfColumn("sbcr_name");
   	int idx_start_date = dSet.indexOfColumn("start_date");
   	int idx_end_date = dSet.indexOfColumn("end_date");
   	int idx_ex_point = dSet.indexOfColumn("ex_point");
   	int idx_approve_class = dSet.indexOfColumn("approve_class");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO e_comp_opinion ( dept_code," + 
                    "order_number," + 
                    "yymm," + 
                    "profession_wbs_code," + 
                    "sbcr_code," + 
                    "sbc_name," + 
                    "sbcr_name," + 
                    "start_date," + 
                    "end_date," + 
                    "ex_point," + 
                    "approve_class," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2 , :3, :4, :5, :6, :7, :8, :9, :10, :11, :12 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_yymm);
      gpstatement.bindColumn(4, idx_profession_wbs_code);
      gpstatement.bindColumn(5, idx_sbcr_code);
      gpstatement.bindColumn(6, idx_sbc_name);
      gpstatement.bindColumn(7, idx_sbcr_name);
      gpstatement.bindColumn(8, idx_start_date);
      gpstatement.bindColumn(9, idx_end_date);
      gpstatement.bindColumn(10, idx_ex_point);
      gpstatement.bindColumn(11, idx_approve_class);
      gpstatement.bindColumn(12, idx_remark);
      stmt.executeUpdate();
      stmt.close();

//---- e_comp_pinion_list 추가 쿼리 --------------------- 
	  String ls_dept_code = rows.getString(idx_dept_code);
	  String ls_order_number = rows.getString(idx_order_number);
	  String ls_yymm = rows.getString(idx_yymm);
      sSql = " insert into e_comp_opinion_list	            							   " +
			 "	   ( select	                                                               " +
			 "       '"+ls_dept_code+"',											       " +
			 "       '"+ls_order_number+"',											       " +
			 "       '"+ls_yymm+"',													       " +
			 "		 a.part_code ,									                       " +
			 "		 a.item_code ,									                       " +
			 "		 a.seq ,										                       " +
			 "		 ( select child_name from e_safety_code_child where class_tag = '079'  " +
			 "		 and safety_code = a.PART_CODE  ),									   " +	
			 "		 ( select child_name from e_safety_code_child where class_tag = '080'  " +
			 "		 and safety_code = a.item_CODE  ),									   " +
			 "			 a.or_item,														   " +
			 "			 a.or_point,													   " +   
			 "			 '',															   " + // ol_point
			 "			 ''																   " + // remark
			 "		from e_opinion_register a											   " +
			 "		where opinion_type = '2' and a.or_item is not null					   " +
			 "		)																	   " ;
		  stmt = conn.prepareStatement(sSql);
		  gpstatement.gp_stmt = stmt;
		  stmt.executeUpdate();
		  stmt.close();

//---- e_comp_pinion_detail 추가 쿼리 --------------------- 
      sSql = " insert into e_comp_opinion_detail										" +
	 	 	 "	   ( select	                                                            " +
			 "           '" + ls_dept_code + "',                                        " +
			 "           '"+ls_order_number+"',		        						    " +
			 "           '" + ls_yymm + "',                                             " +
			 "			 part_code ,								                    " +
			 "			 item_code ,													" +
			 "			 seq ,															" +
			 "           d_seq,															" +
			 "			 contents,														" +
			 "			 or_point,														" +   
			 "			 '0',															" + // ol_point
			 "			 ''																" + // remark
			 "		from e_opinion_register_detail										" +
			 "		where opinion_type = '2'											" +
			 "		)																		                        " ;
      stmt = conn.prepareStatement(sSql);
	  gpstatement.gp_stmt = stmt;
      stmt.executeUpdate();
      stmt.close();
	  
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update e_comp_opinion set " + 
                            "end_date=sysdate,  " + 
                            "approve_class=?,  " + 
                            "remark=?  where dept_code=? and "+
							"order_number=? and sbcr_code=? and "+
							"to_char(yymm,'yyyymm')=? " ;
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
//      gpstatement.bindColumn(9, idx_end_date);
      gpstatement.bindColumn(1, idx_approve_class);
      gpstatement.bindColumn(2, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(3, idx_dept_code);
      gpstatement.bindColumn(4, idx_order_number);
      gpstatement.bindColumn(5, idx_sbcr_code);
      gpstatement.bindColumn(6, idx_yymm);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
//------- detail 삭제 --------------
/* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from e_comp_opinion_detail where dept_code=? and order_number=? and to_char(yymm,'yyyymm')=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_yymm);
      stmt.executeUpdate();
      stmt.close();
//------ list 삭제 ----------------
/* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      sSql = "delete from e_comp_opinion_list where dept_code=? and order_number=? and to_char(yymm,'yyyymm')=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_yymm);
      stmt.executeUpdate();
      stmt.close();
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      sSql = "delete from e_comp_opinion where dept_code=? and order_number=? and sbcr_code=? and to_char(yymm,'yyyymm')=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_sbcr_code);
      gpstatement.bindColumn(4, idx_yymm);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
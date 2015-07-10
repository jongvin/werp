<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("e_sa_eval_monthly_1tr");
     
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymm = dSet.indexOfColumn("yymm");
   	int idx_key_yymm = dSet.indexOfColumn("key_yymm");
   	int idx_start_date = dSet.indexOfColumn("start_date");
   	int idx_end_date = dSet.indexOfColumn("end_date");
   	int idx_reform_part = dSet.indexOfColumn("reform_part");
   	int idx_reform_order = dSet.indexOfColumn("reform_order");
   	int idx_reform_order_date = dSet.indexOfColumn("reform_order_date");
   	int idx_reform_measures = dSet.indexOfColumn("reform_measures");
   	int idx_reform_measures_date = dSet.indexOfColumn("reform_measures_date");
   	int idx_reform_measures_check = dSet.indexOfColumn("reform_measures_check");
   	int idx_reform_result = dSet.indexOfColumn("reform_result");
   	int idx_reform_result_date = dSet.indexOfColumn("reform_result_date");
   	int idx_checker_name = dSet.indexOfColumn("checker_name");
   	int idx_remark = dSet.indexOfColumn("remark");
    	int  rowCnt = dSet.getDataRowCnt();
    	
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){		
  	   String ls_yymm = rows.getString(idx_yymm) + "01" ;
		String sSql = " INSERT INTO e_opinion ( dept_code," + 
                    "yymm," + 
                    "start_date," + 
                    "end_date," + 
                    "reform_part," + 
                    "reform_order," + 
                    "reform_order_date," + 
                    "reform_measures," + 
                    "reform_measures_date," + 
                    "reform_measures_check," + 
                    "reform_result," + 
                    "reform_result_date," + 
                    "checker_name," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, '" + ls_yymm + "', '" + ls_yymm + "', :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12 ) ";
      try
		{
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_end_date);
      gpstatement.bindColumn(3, idx_reform_part);
      gpstatement.bindColumn(4, idx_reform_order);
      gpstatement.bindColumn(5, idx_reform_order_date);
      gpstatement.bindColumn(6, idx_reform_measures);
      gpstatement.bindColumn(7, idx_reform_measures_date);
      gpstatement.bindColumn(8, idx_reform_measures_check);
      gpstatement.bindColumn(9, idx_reform_result);
      gpstatement.bindColumn(10, idx_reform_result_date);
      gpstatement.bindColumn(11, idx_checker_name);
      gpstatement.bindColumn(12, idx_remark);
      stmt.executeUpdate();
      stmt.close();
      }
		catch (Exception ex)
		{
			res.writeException("AA", "99999", "Query1 : " + ex.getMessage() + "\n쿼리:" + sSql);
		}

//   추가 e_opinion_list insert
  		
     	PreparedStatement opinion_stmt = null;     
     	PreparedStatement o_detail_stmt = null;
     	PreparedStatement m_detail_stmt = null;   	
 
  	   String ls_dept_code = rows.getString(idx_dept_code);

      String opinion_sql = " insert into e_opinion_list													" +
	 	 	 "	   ( select	                                                                     " +
			 "             '" + ls_dept_code + "',                                              " +
			 "             '" + ls_yymm + "',                                                   " +
			 "			 a.part_code ,														                     " +
			 "			 a.item_code ,														                     " +
			 "			 a.seq ,															                        " +
			 "			 ( select child_name from e_safety_code_child where class_tag = '077'         " +
			 "			 and safety_code = a.PART_CODE  ),										               " +						
			 "			 ( select child_name from e_safety_code_child where class_tag = '078'         " +
			 "			 and safety_code = a.item_CODE  ),										               " +
			 "			 a.or_item,															                     " +
			 "			 a.or_point,														                     " +   
			 "			 '',																                        " + // ol_point
			 "			 ''																	                     " + // remark
			 "		from e_opinion_register a												                  " +
			 "		where opinion_type = '1'						            " +
			 "		)																		                        " ;
      opinion_stmt = conn.prepareStatement(opinion_sql);
      opinion_stmt.executeUpdate();
      opinion_stmt.close();

//   추가 e_opinion_detail insert 
      String o_detail_sql = " insert into e_opinion_detail												" +
	 	 	 "	   ( select	                                                                     " +
			  "           '" + ls_dept_code + "',                                               " +
			"             '" + ls_yymm + "',                                                    " +
			 "			 part_code ,														                     " +
			 "			 item_code ,														                     " +
			 "			 seq ,															                        " +
			 "        1,																							" +
			 "			 '',															                     " +
			 "			 0,														                        " +   
			 "			 '',																                        " + // select_type
			 "			 '',																	                     " + // remark
			 "        '', 					" + //N_A
			 "        '',					" + //POINT_2
			 "        '',					" + //POINT_1
			 "        '',					" + //POINT_0
			 "        ''					" + //P_COUNT
			 "		from e_opinion_register												            " +
			 "		where opinion_type = '1'														            " +
			 "		)																		                        " ;
      o_detail_stmt = conn.prepareStatement(o_detail_sql);
      o_detail_stmt.executeUpdate();
      o_detail_stmt.close();

//   추가 e_opinion_minus_detail insert 
      String m_detail_sql = " insert into e_opinion_minus_detail										" +
	 	 	 "	   ( select	                                                                     " +
			  "       '" + ls_dept_code + "',					                                    " +
			 "        '" + ls_yymm + "',								                                 " +
			 "			 1 ,																					         " +
			 "        '',																								" +
			 "        0 ,																								" +
			 "        null 																							" +
			 "		from dual																			            " +
          "  union all																								" +
		    "	 select										                                             " +
			 "       '" + ls_dept_code + "',						                                    " +
			 "        '" + ls_yymm + "',								                                 " +
			 "			 2 ,																					         " +
			 "        '',																								" +
			 "        0 ,																								" +
			 "        null 																							" +
			 "		from dual																			            " +
			 "		)																		                        " ;
      m_detail_stmt = conn.prepareStatement(m_detail_sql);
      m_detail_stmt.executeUpdate();
      m_detail_stmt.close();	 
	
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update e_opinion set " + 
	                        "yymm=?, " +
                            "end_date=?,  " + 
                            "reform_part=?,  " + 
                            "reform_order=?,  " + 
                            "reform_order_date=?,  " + 
                            "reform_measures=?,  " + 
                            "reform_measures_date=?,  " + 
                            "reform_measures_check=?,  " + 
                            "reform_result=?,  " + 
                            "reform_result_date=?,  " + 
                            "checker_name=?,  " + 
                            "remark=?  where dept_code=? and yymm=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
	   gpstatement.bindColumn(1, idx_key_yymm);
      gpstatement.bindColumn(2, idx_end_date);
      gpstatement.bindColumn(3, idx_reform_part);
      gpstatement.bindColumn(4, idx_reform_order);
      gpstatement.bindColumn(5, idx_reform_order_date);
      gpstatement.bindColumn(6, idx_reform_measures);
      gpstatement.bindColumn(7, idx_reform_measures_date);
      gpstatement.bindColumn(8, idx_reform_measures_check);
      gpstatement.bindColumn(9, idx_reform_result);
      gpstatement.bindColumn(10, idx_reform_result_date);
      gpstatement.bindColumn(11, idx_checker_name);
      gpstatement.bindColumn(12, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(13, idx_dept_code);
      gpstatement.bindColumn(14, idx_key_yymm);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
 		PreparedStatement opinion_stmt = null;     
     	PreparedStatement o_detail_stmt = null;
     	PreparedStatement m_detail_stmt = null;   	

		String opinion_sql = "delete from e_opinion_detail where dept_code=? and yymm=? "; 
      opinion_stmt = conn.prepareStatement(opinion_sql); 
      gpstatement.gp_stmt = opinion_stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_key_yymm);
      opinion_stmt.executeUpdate();
      opinion_stmt.close();
		
      String o_detail_sql = "delete from e_opinion_list where dept_code=? and yymm=? "; 
      o_detail_stmt = conn.prepareStatement(o_detail_sql); 
      gpstatement.gp_stmt = o_detail_stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_key_yymm);
      o_detail_stmt.executeUpdate();
      o_detail_stmt.close();

      String m_detail_sql = "delete from e_opinion_minus_detail where dept_code=? and yymm=? "; 
      m_detail_stmt = conn.prepareStatement(m_detail_sql); 
      gpstatement.gp_stmt = m_detail_stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_key_yymm);
      m_detail_stmt.executeUpdate();
      m_detail_stmt.close();
		
      String sSql = "delete from e_opinion where dept_code=? and yymm=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_key_yymm);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
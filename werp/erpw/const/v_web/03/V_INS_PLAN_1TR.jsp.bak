<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("V_INS_PLAN_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_YEAR = dSet.indexOfColumn("YEAR");
   	int idx_QUARTER_YEAR = dSet.indexOfColumn("QUARTER_YEAR");
   	int idx_DEPT_CODE = dSet.indexOfColumn("DEPT_CODE");
   	int idx_DEPT_NAME = dSet.indexOfColumn("DEPT_NAME");
		int idx_QUALITY_SECTION = dSet.indexOfColumn("QUALITY_SECTION");
   	int idx_SEQ = dSet.indexOfColumn("SEQ");
		int idx_SCHEDULE_START_DT = dSet.indexOfColumn("SCHEDULE_START_DT");
   	int idx_SCHEDULE_END_DT = dSet.indexOfColumn("SCHEDULE_END_DT");
   	int idx_RESULT_START_DT = dSet.indexOfColumn("RESULT_START_DT");
   	int idx_RESULT_END_DT = dSet.indexOfColumn("RESULT_END_DT");
   	int idx_REMARK = dSet.indexOfColumn("REMARK");


		int  rowCnt = dSet.getDataRowCnt();
		for(int i=0; i< rowCnt; i++)
		{
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
		String ls_QUALITY_SECTION = rows.getString(idx_QUALITY_SECTION);
		String ls_DEPT_CODE = rows.getString(idx_DEPT_CODE);
		String ls_DEPT_NAME = rows.getString(idx_DEPT_NAME);
		String ls_YEAR = rows.getString(idx_YEAR);
		String ls_QUARTER_YEAR = rows.getString(idx_QUARTER_YEAR);
		String ls_SEQ = rows.getString(idx_SEQ);

			if ( Integer.parseInt(ls_QUALITY_SECTION) < 3 ) 
			{
/* ---------------------------------------------------------------------------- */
/* 품질평가 저장부분                                   */
/* ---------------------------------------------------------------------------- */

				if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
					String sSql = "insert into v_ins_point_master " +
									" (  select a.quality_ins_code , " +
									"		a.quality_section ,  " +
									"		'"+ls_DEPT_CODE+"' ,   " +
									"		'"+ls_YEAR+"' ,   " +
									"		'"+ls_QUARTER_YEAR+"' ,   " +
									"		(select quality_ins_name from V_INS_ITEM_REG_MASTER " +
									"		where quality_ins_code = a.quality_ins_code and "+
									"		quality_section= '"+ls_QUALITY_SECTION+"') ,   " +
									"		(select WEIGHT_POINT from V_INS_ITEM_REG_MASTER " +
									"		where quality_ins_code = a.quality_ins_code and "+
									"		quality_section= '"+ls_QUALITY_SECTION+"') ,   " +
									"		''," +
									"		''," +
									"		''," +
									"		''," +
									"		''," +
									"     a.COLUMN_SIZE ,  " +
									" 		a.WEIGHT_POINT1 , " +
									" 		a.WEIGHT_POINT2 ,  " +   
						         "     '', " +
						         "     '', " +
						         "     ''  " +
									" from " +
									" (	  select " +
									"    	  quality_ins_code , " + 
									"		  quality_section   ,  " +
									"       COLUMN_SIZE  ,  " +
			  						"       WEIGHT_POINT1 , " +
									"       WEIGHT_POINT2  " +
									"	  from v_ins_item_reg_master  " +
									"	  where quality_section = '"+ls_QUALITY_SECTION+"' ) A  " +
									") " ;
					try
					{
					  stmt = conn.prepareStatement(sSql);
					  gpstatement.gp_stmt = stmt;
					  stmt.executeUpdate();
					  stmt.close();
					}
						catch (Exception ex)
					{
						res.writeException("AA", "99999", "Query1 : " + ex.getMessage() + "\n쿼리:" + sSql);
					}

						sSql = "insert into v_ins_point   " +
										"( select    " +
										" 		a.quality_ins_code ,   " +
										"		a.quality_section ,    " +
										"		'"+ls_DEPT_CODE+"' ,   " +
										"		'"+ls_YEAR+"' ,   " +
										"		'"+ls_QUARTER_YEAR+"' ,   " +
										"		a.seq, " +
										"		a.part_code, " +
										"		a.wbs_code, " +
										"		a.section, " +
										"		a.ins_item, " +
										"		a.place , " +
										"		a.remark  " +
										"from  " +
										"( select  " +
										" 		  quality_ins_code ,  " +
										"		  quality_section,  " +
										"		  seq ,  " +
										"		  part_code , " +
										"		  wbs_code ,  " +
										"		  section ,  " +
										"		  ins_item ,  " +
										"		  place , " +
										"		  remark  " +
										"   from v_ins_item_reg where quality_section = '"+ls_QUALITY_SECTION+"' ) A  " +
										")  " ;
					 try
						{
						  stmt = conn.prepareStatement(sSql);
						  gpstatement.gp_stmt = stmt;
						  stmt.executeUpdate();
						  stmt.close();
						}
						catch (Exception ex)
						{
							res.writeException("AA", "99999", "Query1 : " + ex.getMessage() + "\n쿼리:" + sSql);
						}

						sSql = " insert into v_ins_point_detail  " +
										 "( select  " +
										 "   		  a.quality_ins_code ,  " +
										 "		  a.quality_section ,  " + 
										 "		'"+ls_DEPT_CODE+"' ,   " +
										 "		'"+ls_YEAR+"' ,   " +
										 "		'"+ls_QUARTER_YEAR+"' ,   " +
										 "		  a.seq , " +
										 "		  a.d_seq , " +
										 "		  a.contents,  " +
										 "		  a.point,  " +
										 "		  ''  " +
										 "   from   " +
										 " ( select " +
										 "  		  quality_ins_code ,  " +
										 "		  quality_section,  " +
										 "		  seq , " +
										 "		  d_seq ,  " +
										 "		  contents ,  " +
										 "		  point  " +
										 "   from v_ins_item_reg_detail where quality_section = '"+ls_QUALITY_SECTION+"' ) A  " +
										 ") " ;
				 
					 try
						{
						  stmt = conn.prepareStatement(sSql);
						  gpstatement.gp_stmt = stmt;
						  stmt.executeUpdate();
						  stmt.close();
						}
						catch (Exception ex)
						{
							res.writeException("AA", "99999", "Query1 : " + ex.getMessage() + "\n쿼리:" + sSql);
						}
						
						sSql = " INSERT INTO V_INS_PLAN ( YEAR," + 
										  "QUARTER_YEAR, " +
										  "DEPT_CODE, " +
										  "QUALITY_SECTION, " +
										  "SEQ, " +
										  "SCHEDULE_START_DT, " +
										  "SCHEDULE_END_DT, " +
										  "RESULT_START_DT, " +
										  "RESULT_END_DT, " +
										  "REMARK ) " ;
						sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ,:7 ,:8, :9, :10 ) ";
						stmt = conn.prepareStatement(sSql);
						gpstatement.gp_stmt = stmt;
						gpstatement.bindColumn(1, idx_YEAR);
						gpstatement.bindColumn(2, idx_QUARTER_YEAR);
						gpstatement.bindColumn(3, idx_DEPT_CODE);
						gpstatement.bindColumn(4, idx_QUALITY_SECTION);
						gpstatement.bindColumn(5, idx_SEQ);
						gpstatement.bindColumn(6, idx_SCHEDULE_START_DT);
						gpstatement.bindColumn(7, idx_SCHEDULE_END_DT);
						gpstatement.bindColumn(8, idx_RESULT_START_DT);
						gpstatement.bindColumn(9, idx_RESULT_END_DT);
						gpstatement.bindColumn(10, idx_REMARK);
						stmt.executeUpdate();
						stmt.close();		

					}else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
				 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
						String sSql = "update V_INS_PLAN set " + 
												  " DEPT_CODE=?, " +
												  " SCHEDULE_START_DT=?, " +
												  " SCHEDULE_END_DT=?, " +
												  " RESULT_START_DT=?, " +
												  " RESULT_END_DT=?, " +
												  " REMARK=?   " +
												  " WHERE  TO_CHAR(YEAR,'YYYY')=? " + 
												  " AND QUARTER_YEAR=? " +
												  " AND QUALITY_SECTION=? " + 
												  " AND SEQ=? " ;  
						stmt = conn.prepareStatement(sSql); 
						gpstatement.gp_stmt = stmt;
						gpstatement.bindColumn(1, idx_DEPT_CODE);
						gpstatement.bindColumn(2, idx_SCHEDULE_START_DT);
						gpstatement.bindColumn(3, idx_SCHEDULE_END_DT);
						gpstatement.bindColumn(4, idx_RESULT_START_DT);
						gpstatement.bindColumn(5, idx_RESULT_END_DT);
						gpstatement.bindColumn(6, idx_REMARK);
				 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
						gpstatement.bindColumn(7, idx_YEAR);
						gpstatement.bindColumn(8, idx_QUARTER_YEAR);
						gpstatement.bindColumn(9, idx_QUALITY_SECTION);
						gpstatement.bindColumn(10, idx_SEQ);

						stmt.executeUpdate();
						stmt.close();
					}else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
				 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
						String ls_QUALITY_SECTION2 = rows.getString(idx_QUALITY_SECTION);
						String ls_DEPT_CODE2 = rows.getString(idx_DEPT_CODE);
						String ls_YEAR2 = rows.getString(idx_YEAR);
						String ls_QUARTER_YEAR2 = rows.getString(idx_QUARTER_YEAR);

						String sSql = "delete from v_ins_point_detail " +
												  " WHERE  TO_CHAR(YEAR,'YYYY')= '"+ ls_YEAR2+ "'" + 
												  " AND QUARTER_YEAR= '" +ls_QUARTER_YEAR2+ "'" +
												  " AND QUALITY_SECTION= '"+ls_QUALITY_SECTION2+ "'" + 
												  " AND DEPT_CODE = '" +ls_DEPT_CODE2+ "'";    
					 try
						{
						stmt = conn.prepareStatement(sSql); 
						gpstatement.gp_stmt = stmt;
				 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
						stmt.executeUpdate();
						stmt.close();
						}
						catch (Exception ex)
						{
							res.writeException("AA", "99999", "Query1 : " + ex.getMessage() + "\n쿼리:" + sSql);
						}

						sSql = "delete from v_ins_point " +
												  " WHERE  TO_CHAR(YEAR,'YYYY')= '"+ ls_YEAR2+ "'" + 
												  " AND QUARTER_YEAR= '" +ls_QUARTER_YEAR2+ "'" +
												  " AND QUALITY_SECTION= '"+ls_QUALITY_SECTION2+ "'" + 
												  " AND DEPT_CODE = '" +ls_DEPT_CODE2+ "'";    
					 try
						{
						stmt = conn.prepareStatement(sSql); 
						gpstatement.gp_stmt = stmt;
				 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
						stmt.executeUpdate();
						stmt.close();
						}
						catch (Exception ex)
						{
							res.writeException("AA", "99999", "Query1 : " + ex.getMessage() + "\n쿼리:" + sSql);
						}

						sSql = "delete from v_ins_point_master " +
												  " WHERE  TO_CHAR(YEAR,'YYYY')= '"+ ls_YEAR2+ "'" + 
												  " AND QUARTER_YEAR= '" +ls_QUARTER_YEAR2+ "'" +
												  " AND QUALITY_SECTION= '"+ls_QUALITY_SECTION2+ "'" + 
												  " AND DEPT_CODE = '" +ls_DEPT_CODE2+ "'";    
					 try
						{
						stmt = conn.prepareStatement(sSql); 
						gpstatement.gp_stmt = stmt;
				 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
						stmt.executeUpdate();
						stmt.close();
						}
						catch (Exception ex)
						{
							res.writeException("AA", "99999", "Query1 : " + ex.getMessage() + "\n쿼리:" + sSql);
						}

						sSql = "delete from V_INS_PLAN " +
												  " WHERE  TO_CHAR(YEAR,'YYYY')=? " + 
												  " AND QUARTER_YEAR=? " +
												  " AND QUALITY_SECTION=? " + 
												  " AND SEQ=? " ;  
						stmt = conn.prepareStatement(sSql); 
						gpstatement.gp_stmt = stmt;
				 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
						gpstatement.bindColumn(1, idx_YEAR);
						gpstatement.bindColumn(2, idx_QUARTER_YEAR);
						gpstatement.bindColumn(3, idx_QUALITY_SECTION);
						gpstatement.bindColumn(4, idx_SEQ);
						stmt.executeUpdate();
						stmt.close();
					}
				}
				else if ( Integer.parseInt(ls_QUALITY_SECTION) == 3 )
/* ---------------------------------------------------------------------------- */
/* 내부감사 저장부분                                   */
/* ---------------------------------------------------------------------------- */
				{
				if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
					String sSql = "insert into V_INTER_AUDIT_RESULT_MASTER  " +
										"(   " +
										"	select   " + 
										"		'"+ls_DEPT_CODE+"' ,   " +
										"		'"+ls_YEAR+"' ,   " +
										"		'"+ls_QUARTER_YEAR+"' ,   " +
										"		'"+ls_DEPT_NAME+"' , " +					
										"		   '' , " +
										"		   '' , " +
										"		   '' , " +
										"		   ''   " +
										"	 from  dual   " +
										")   " ;
					try
					{
					  stmt = conn.prepareStatement(sSql);
					  gpstatement.gp_stmt = stmt;
					  stmt.executeUpdate();
					  stmt.close();
					}
						catch (Exception ex)
					{
						res.writeException("AA", "99999", "Query1 : " + ex.getMessage() + "\n쿼리:" + sSql);
					}

					sSql = "insert into V_INTER_AUDIT_RESULT_ITEM  " +
							"(   " +
							"	select   " + 
							"		'"+ls_DEPT_CODE+"' ,   " +
							"		'"+ls_YEAR+"' ,   " +
							"		'"+ls_QUARTER_YEAR+"' ,   " +
							"		   a.part_code ,   " +
							"		   a.seq , " +
							"		   a.section , " +
							"		   a.ins_contents , " +
							"		   a.ins_basis ,  " +
							"		   a.weight_point ,  " +
						   "        ''   " +
							"	 from  V_INTER_AUDIT_ITEM a  " +
							"   where part_code in ( '"+ls_DEPT_CODE+"', '0' ) " +
							")   " ;
					 try
						{
						  stmt = conn.prepareStatement(sSql);
						  gpstatement.gp_stmt = stmt;
						  stmt.executeUpdate();
						  stmt.close();
						}
						catch (Exception ex)
						{
							res.writeException("AA", "99999", "Query1 : " + ex.getMessage() + "\n쿼리:" + sSql);
						}

					 sSql = "insert into V_INTER_AUDIT_RESULT_DETAIL  " +
								"(   " +
								"	select   " + 
								"		'"+ls_DEPT_CODE+"' ,   " +
								"		'"+ls_YEAR+"' ,   " +
								"		'"+ls_QUARTER_YEAR+"' ,   " +
								"		   a.part_code ,   " +
								 "			a.seq , " +
								"		   a.d_seq , " +
								"		   a.contents , " +
								"		   a.point ,  " +
								"		   'F'   " +
								"	 from  V_INTER_AUDIT_DETAIL a  " +
								"   where part_code in ( '"+ls_DEPT_CODE+"', '0' ) " +
								")   " ;
				 
					 try
						{
						  stmt = conn.prepareStatement(sSql);
						  gpstatement.gp_stmt = stmt;
						  stmt.executeUpdate();
						  stmt.close();
						}
						catch (Exception ex)
						{
							res.writeException("AA", "99999", "Query1 : " + ex.getMessage() + "\n쿼리:" + sSql);
						}
						
						sSql = " INSERT INTO V_INS_PLAN ( YEAR," + 
										  "QUARTER_YEAR, " +
										  "DEPT_CODE, " +
										  "QUALITY_SECTION, " +
										  "SEQ, " +
										  "SCHEDULE_START_DT, " +
										  "SCHEDULE_END_DT, " +
										  "RESULT_START_DT, " +
										  "RESULT_END_DT, " +
										  "REMARK ) " ;
						sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ,:7 ,:8, :9, :10 ) ";
						stmt = conn.prepareStatement(sSql);
						gpstatement.gp_stmt = stmt;
						gpstatement.bindColumn(1, idx_YEAR);
						gpstatement.bindColumn(2, idx_QUARTER_YEAR);
						gpstatement.bindColumn(3, idx_DEPT_CODE);
						gpstatement.bindColumn(4, idx_QUALITY_SECTION);
						gpstatement.bindColumn(5, idx_SEQ);
						gpstatement.bindColumn(6, idx_SCHEDULE_START_DT);
						gpstatement.bindColumn(7, idx_SCHEDULE_END_DT);
						gpstatement.bindColumn(8, idx_RESULT_START_DT);
						gpstatement.bindColumn(9, idx_RESULT_END_DT);
						gpstatement.bindColumn(10, idx_REMARK);
						stmt.executeUpdate();
						stmt.close();		

					}else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
				 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
						String sSql = "update V_INS_PLAN set " + 
												  " DEPT_CODE=?, " +
												  " SCHEDULE_START_DT=?, " +
												  " SCHEDULE_END_DT=?, " +
												  " RESULT_START_DT=?, " +
												  " RESULT_END_DT=?, " +
												  " REMARK=?   " +
												  " WHERE  TO_CHAR(YEAR,'YYYY')=? " + 
												  " AND QUARTER_YEAR=? " +
												  " AND QUALITY_SECTION=? " + 
												  " AND SEQ=? " ;  
						stmt = conn.prepareStatement(sSql); 
						gpstatement.gp_stmt = stmt;
						gpstatement.bindColumn(1, idx_DEPT_CODE);
						gpstatement.bindColumn(2, idx_SCHEDULE_START_DT);
						gpstatement.bindColumn(3, idx_SCHEDULE_END_DT);
						gpstatement.bindColumn(4, idx_RESULT_START_DT);
						gpstatement.bindColumn(5, idx_RESULT_END_DT);
						gpstatement.bindColumn(6, idx_REMARK);
				 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
						gpstatement.bindColumn(7, idx_YEAR);
						gpstatement.bindColumn(8, idx_QUARTER_YEAR);
						gpstatement.bindColumn(9, idx_QUALITY_SECTION);
						gpstatement.bindColumn(10, idx_SEQ);

						stmt.executeUpdate();
						stmt.close();
					}else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
				 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
						String ls_QUALITY_SECTION2 = rows.getString(idx_QUALITY_SECTION);
						String ls_DEPT_CODE2 = rows.getString(idx_DEPT_CODE);
						String ls_YEAR2 = rows.getString(idx_YEAR);
						String ls_QUARTER_YEAR2 = rows.getString(idx_QUARTER_YEAR);

						String sSql = "delete from V_INTER_AUDIT_RESULT_DETAIL " +
												  " WHERE  TO_CHAR(YEAR,'YYYY')= '"+ ls_YEAR2+ "'" + 
												  " AND HALF_YEAR= '" +ls_QUARTER_YEAR2+ "'" +
												  " AND PART_CODE = '" +ls_DEPT_CODE2+ "'";     
					 try
						{
						stmt = conn.prepareStatement(sSql); 
						gpstatement.gp_stmt = stmt;
				 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
						stmt.executeUpdate();
						stmt.close();
						}
						catch (Exception ex)
						{
							res.writeException("AA", "99999", "Query1 : " + ex.getMessage() + "\n쿼리:" + sSql);
						}

						sSql = "delete from V_INTER_AUDIT_RESULT_ITEM " +
												  " WHERE  TO_CHAR(YEAR,'YYYY')= '"+ ls_YEAR2+ "'" + 
												  " AND HALF_YEAR= '" +ls_QUARTER_YEAR2+ "'" +
												  " AND PART_CODE = '" +ls_DEPT_CODE2+ "'";    
					 try
						{
						stmt = conn.prepareStatement(sSql); 
						gpstatement.gp_stmt = stmt;
				 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
						stmt.executeUpdate();
						stmt.close();
						}
						catch (Exception ex)
						{
							res.writeException("AA", "99999", "Query1 : " + ex.getMessage() + "\n쿼리:" + sSql);
						}

						sSql = "delete from V_INTER_AUDIT_RESULT_MASTER " +
												  " WHERE  TO_CHAR(YEAR,'YYYY')= '"+ ls_YEAR2+ "'" + 
												  " AND HALF_YEAR= '" +ls_QUARTER_YEAR2+ "'" +
												  " AND PART_CODE = '" +ls_DEPT_CODE2+ "'";    
					 try
						{
						stmt = conn.prepareStatement(sSql); 
						gpstatement.gp_stmt = stmt;
				 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
						stmt.executeUpdate();
						stmt.close();
						}
						catch (Exception ex)
						{
							res.writeException("AA", "99999", "Query1 : " + ex.getMessage() + "\n쿼리:" + sSql);
						}

						sSql = "delete from V_INS_PLAN " +
												  " WHERE  TO_CHAR(YEAR,'YYYY')=? " + 
												  " AND QUARTER_YEAR=? " +
												  " AND QUALITY_SECTION=? " + 
												  " AND SEQ=? " ;  
						stmt = conn.prepareStatement(sSql); 
						gpstatement.gp_stmt = stmt;
				 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
						gpstatement.bindColumn(1, idx_YEAR);
						gpstatement.bindColumn(2, idx_QUARTER_YEAR);
						gpstatement.bindColumn(3, idx_QUALITY_SECTION);
						gpstatement.bindColumn(4, idx_SEQ);
						stmt.executeUpdate();
						stmt.close();
						}
					
				
			}
	  }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
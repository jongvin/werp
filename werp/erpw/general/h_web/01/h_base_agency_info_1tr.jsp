<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet	= req.getGauceDataSet("h_base_agency_info_1tr"); gpstatement.gp_dataset = dSet;
	int idx_dept_code		= dSet.indexOfColumn("dept_code");
	int idx_sell_code			= dSet.indexOfColumn("sell_code");
    int idx_reg_no				= dSet.indexOfColumn("reg_no");
    int idx_reg_no_org		= dSet.indexOfColumn("reg_no_org");
	int idx_comp_name		= dSet.indexOfColumn("comp_name");
	int idx_biz_cat				= dSet.indexOfColumn("biz_cat");
	int idx_biz_itm				= dSet.indexOfColumn("biz_itm");
	int idx_main_tag			= dSet.indexOfColumn("main_tag");
	int idx_app_date			= dSet.indexOfColumn("app_date");
	int idx_end_date			= dSet.indexOfColumn("end_date");
	int idx_rep_name			= dSet.indexOfColumn("rep_name");
	int idx_rep_no				= dSet.indexOfColumn("rep_no");
	int idx_rep_cell				= dSet.indexOfColumn("rep_cell");
	int idx_rep_email			= dSet.indexOfColumn("rep_email");
	int idx_comp_phone	= dSet.indexOfColumn("comp_phone");
	int idx_comp_fax			= dSet.indexOfColumn("comp_fax");
	int idx_co_op_rate		= dSet.indexOfColumn("co_op_rate");
	int idx_comp_zipcode	= dSet.indexOfColumn("comp_zipcode");
	int idx_comp_addr1		= dSet.indexOfColumn("comp_addr1");
	int idx_comp_addr2		= dSet.indexOfColumn("comp_addr2");
	int idx_attrib1				= dSet.indexOfColumn("attrib1");
	int idx_attrib2				= dSet.indexOfColumn("attrib2");
	int idx_attrib3				= dSet.indexOfColumn("attrib3");
   	
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_agency_info ( dept_code, "   +
								" 			 sell_code, "   +
								" 			 reg_no, "   +
								" 			 comp_name, "   +
								" 			 biz_cat, "   +
								" 			 biz_itm, "   +
								" 			 main_tag,"   +
								"			 app_date, "   +
								" 			 end_date, "   +
								" 			 rep_name, "   +
								" 			 rep_no, "   +
								" 			 rep_cell, "   +
								" 			 rep_email, "   +
								" 			 comp_phone,"   +
								"            comp_fax, "   +
								" 			 co_op_rate, "   +
								" 			 comp_zipcode, "   +
								" 			 comp_addr1, "   +
								" 			 comp_addr2, "   +
								" 			 attrib1,"   +
								"            attrib2, "   +
								" 			 attrib3   )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9,:10, :11, :12, :13, :14, :15, :16, :17, :18, :19,:20, :21, :22) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
	  gpstatement.bindColumn(1 , idx_dept_code		);
      gpstatement.bindColumn(2 , idx_sell_code			);
      gpstatement.bindColumn(3 , idx_reg_no				);
      gpstatement.bindColumn(4 , idx_comp_name		);
      gpstatement.bindColumn(5 , idx_biz_cat				);
      gpstatement.bindColumn(6 , idx_biz_itm				);
      gpstatement.bindColumn(7 , idx_main_tag			);
      gpstatement.bindColumn(8 , idx_app_date			);
      gpstatement.bindColumn(9 , idx_end_date			);
      gpstatement.bindColumn(10, idx_rep_name			);
      gpstatement.bindColumn(11, idx_rep_no				);
      gpstatement.bindColumn(12, idx_rep_cell				);
      gpstatement.bindColumn(13, idx_rep_email			);
      gpstatement.bindColumn(14, idx_comp_phone	);
      gpstatement.bindColumn(15, idx_comp_fax			);
      gpstatement.bindColumn(16, idx_co_op_rate		);
      gpstatement.bindColumn(17, idx_comp_zipcode	);
      gpstatement.bindColumn(18, idx_comp_addr1		);
      gpstatement.bindColumn(19, idx_comp_addr2		);
      gpstatement.bindColumn(20, idx_attrib1	);			
      gpstatement.bindColumn(21, idx_attrib2	);			
	  gpstatement.bindColumn(22, idx_attrib3	);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_agency_info set " + 
                                "            dept_code=?, "   +
								" 			 sell_code=?, "   +
								" 			 reg_no=?, "   +
								" 			 comp_name=?, "   +
								" 			 biz_cat=?, "   +
								" 			 biz_itm=?, "   +
								" 			 main_tag=?,"   +
								"			 app_date=?, "   +
								" 			 end_date=?, "   +
								" 			 rep_name=?, "   +
								" 			 rep_no=?, "   +
								" 			 rep_cell=?, "   +
								" 			 rep_email=?, "   +
								" 			 comp_phone=?,"   +
								"            comp_fax=?, "   +
								" 			 co_op_rate=?, "   +
								" 			 comp_zipcode=?, "   +
								" 			 comp_addr1=?, "   +
								" 			 comp_addr2=?, "   +
								" 			 attrib1=?,"   +
								"            attrib2=?, "   +
								" 			 attrib3=?         where dept_code=?  and sell_code=?  and reg_no =?" ;  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
	  gpstatement.bindColumn(1 , idx_dept_code		);
      gpstatement.bindColumn(2 , idx_sell_code			);
      gpstatement.bindColumn(3 , idx_reg_no				);
      gpstatement.bindColumn(4 , idx_comp_name		);
      gpstatement.bindColumn(5 , idx_biz_cat				);
      gpstatement.bindColumn(6 , idx_biz_itm				);
      gpstatement.bindColumn(7 , idx_main_tag			);
      gpstatement.bindColumn(8 , idx_app_date			);
      gpstatement.bindColumn(9, idx_end_date			);
      gpstatement.bindColumn(10, idx_rep_name			);
      gpstatement.bindColumn(11, idx_rep_no				);
      gpstatement.bindColumn(12, idx_rep_cell				);
      gpstatement.bindColumn(13, idx_rep_email			);
      gpstatement.bindColumn(14, idx_comp_phone	);
      gpstatement.bindColumn(15, idx_comp_fax			);
      gpstatement.bindColumn(16, idx_co_op_rate		);
      gpstatement.bindColumn(17, idx_comp_zipcode	);
      gpstatement.bindColumn(18, idx_comp_addr1		);
      gpstatement.bindColumn(19, idx_comp_addr2		);
      gpstatement.bindColumn(20, idx_attrib1	);			
      gpstatement.bindColumn(21, idx_attrib2	);			
	  gpstatement.bindColumn(22,  idx_attrib3	);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(23 , idx_dept_code		);
      gpstatement.bindColumn(24 , idx_sell_code			);
      gpstatement.bindColumn(25 , idx_reg_no_org			);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_agency_info where dept_code=?  and sell_code=? and reg_no=? " ;  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_reg_no_org);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("e_sa_co_eval_monthly_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymmdd = dSet.indexOfColumn("yymmdd");
   	int idx_yymm = dSet.indexOfColumn("yymm");
   	int idx_approve_class = dSet.indexOfColumn("approve_class");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO e_comp_opinion_header " + 
					" ( dept_code, " + 
                    "yymm, " + 
                    "approve_class, " + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2 , :3, :4 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_approve_class);
      gpstatement.bindColumn(4, idx_remark);
      stmt.executeUpdate();
      stmt.close();
// e_comp_opinion insert 추가
	  String ls_dept_code = rows.getString(idx_dept_code);
	  String ls_yymm = rows.getString(idx_yymmdd);
	  sSql = " insert into e_comp_opinion						" +
			 " ( SELECT											" +						 
			 "   a.dept_code dept_code,							" +						 
			 "   a.order_number order_number,					" +	
 			 "   '"+ls_yymm +"' ,								" +
			 "	c.profession_wbs_code,							" +						 
			 "	a.sbcr_code,									" +						 	
			 "	b.sbcr_name sbcr_name,							" +						 		
			 "	a.order_name  sbc_name,							" +
			 "   '"+ls_yymm +"', 								" +
			 "   sysdate 	,									" +
		 	 "   '',											" +
 			 "   '1',											" +								
 			 "   ''												" +							 
 			 " FROM												" +	
			 "	s_cn_list a,									" +											 
			 "	s_sbcr b,										" +										 
			 "	s_order_list c									" +									 
 			 " where											" +								 		
			 "	a.sbcr_code = b.sbcr_code and					" +							 
			 "	c.dept_code = a.DEPT_CODE and					" +						 
			 "	c.order_number = a.order_number and				" +						 
			 "	a.dept_code ='"+ls_dept_code +"' )				" ;
	  stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      stmt.executeUpdate();
      stmt.close();
// e_comp_opinion_list insert 추가
	  sSql = " insert into e_comp_opinion_list							" +
			" (select													" +
			"	a.dept_code ,											" +
			"	a.order_number,											" +
			"	a.yymm,													" +
			"	b.part_code,											" +
			"	b.item_code,											" +
			"	b.SEQ,													" +
			"	b.part_name,											" +
			"	b.item_name,											" +
			"	b.or_item,												" +
			"	b.OR_POINT,												" +
			"	'',														" +
			"	''														" +
			" from e_comp_opinion a,									" +
			"	( select 												" +
			"	 a.part_code ,											" +
			"	 a.item_code ,											" +		
			"	 a.seq ,												" +	
			"	 ( select child_name from e_safety_code_child 			" +
			"      where class_tag = '079'   							" +
			"	 and safety_code = a.PART_CODE  ) part_name,			" +								    
			"	 ( select child_name from e_safety_code_child 			" +
			"	   where class_tag = '080'   							" +
			"	 and safety_code = a.item_CODE  ) item_name,			" +								    
			"	 a.or_item,												" +					    
			"	 a.or_point												" +				       
			"	from e_opinion_register a								" +							    
			"	where opinion_type = '2' and a.or_item is not null ) b	" +
			" where a.dept_code = '"+ls_dept_code +"' and				" +
			"	  a.yymm = '"+ls_yymm +"'	)							" ;
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      stmt.executeUpdate();
      stmt.close();
// e_comp_opinion_detail insert 추가
	  sSql = " insert into E_comp_opinion_detail			" +
			" (select										" +
			"	a.dept_code , 								" +
			"	a.order_number,								" +
			"	a.yymm,										" +
			"	a.part_code,								" +
			"	a.item_code,								" +
			"	a.seq,										" +
			"	b.d_seq,									" +
			"	b.CONTENTS,									" +
			"	b.OR_POINT,									" +
			"	'0',										" +
			"	''											" +
			" from 											" +
			"	e_comp_opinion_list a,						" +
			"	(select          							" +
			"		part_code ,								" +						                     
			"		item_code ,								" +											 
			"		seq ,									" +
			"		d_seq,									" +												
			"		contents,								" +												
			"		or_point								" +												
			"	from e_opinion_register_detail				" +										 
			"	where opinion_type = '2'	) b				" +										 
			" where 										" +
			"	 a.dept_code = '"+ls_dept_code +"'	 and	" +
			"	 a.yymm = '"+ls_yymm +"' and				" +   
			"	 a.item_code = b.item_code and				" +
			"	 a.seq = b.seq and							" +
			"	 a.part_code = b.part_code ) 				" ;
	  stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update e_comp_opinion_header set " + 
                    " yymm =?, " + 
                    " approve_class=?, " + 
                    " remark=? " + 
					" where	  " +
					" dept_code=? and " +
					" yymm=? " ;
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_yymmdd);
      gpstatement.bindColumn(2, idx_approve_class);
      gpstatement.bindColumn(3, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(4, idx_dept_code);
      gpstatement.bindColumn(5, idx_yymmdd);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
//------- detail 삭제 --------------
/* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
	  String ls_dept_code = rows.getString(idx_dept_code);
	  String ls_yymm = rows.getString(idx_yymmdd);
	  String sSql = "delete from e_comp_opinion_detail where dept_code='"+ls_dept_code +"' and yymm='"+ls_yymm +"'"; 
	  stmt = conn.prepareStatement(sSql); 
	  gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
	  stmt.executeUpdate();
      stmt.close();
//------- list 삭제 --------------
      sSql = "delete from e_comp_opinion_list where dept_code='"+ls_dept_code +"' and yymm='"+ls_yymm +"'";  
	  stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
	  stmt.executeUpdate();
      stmt.close();
//------- opinion 삭제 --------------
      sSql = "delete from e_comp_opinion where dept_code='"+ls_dept_code +"' and yymm='"+ls_yymm +"'";  
	  stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      stmt.executeUpdate();
      stmt.close();
//------- header 삭제 --------------
      sSql = "delete from e_comp_opinion_header where dept_code='"+ls_dept_code +"' and yymm='"+ls_yymm +"' ";  
	  stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
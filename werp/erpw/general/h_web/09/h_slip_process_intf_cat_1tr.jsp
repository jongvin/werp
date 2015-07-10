<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_slip_process_intf_cat_1tr"); 
	 gpstatement.gp_dataset = dSet;
	
	int idx_cat_unq				= dSet.indexOfColumn("cat_unq");
	int idx_intf_key1				= dSet.indexOfColumn("intf_key1");
	int idx_intf_key2				= dSet.indexOfColumn("intf_key2");
	int idx_intf_key3				= dSet.indexOfColumn("intf_key3");
	int idx_job_cat1				= dSet.indexOfColumn("job_cat1");
	int idx_job_cat2				= dSet.indexOfColumn("job_cat2");
	int idx_job_cat3				= dSet.indexOfColumn("job_cat3");
	int idx_title						= dSet.indexOfColumn("title");
	int idx_work_dt					= dSet.indexOfColumn("work_dt");
	int idx_cat_from_dt			= dSet.indexOfColumn("cat_from_dt");
	int idx_cat_to_dt				= dSet.indexOfColumn("cat_to_dt");
	int idx_work_dept_code	= dSet.indexOfColumn("work_dept_code");
	int idx_work_sell_code		= dSet.indexOfColumn("work_sell_code");
	int idx_work_comp_code	= dSet.indexOfColumn("work_comp_code");
	int idx_work_empno			= dSet.indexOfColumn("work_empno");
	int idx_work_emp_name	= dSet.indexOfColumn("work_emp_name");
	int idx_work_status			= dSet.indexOfColumn("work_status");
	int idx_memo       			= dSet.indexOfColumn("memo");
   	
	int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_slip_cat_intf "+
			        "				(cat_unq,	"+
					"				 intf_key1, "+
					"				 intf_key2, "+
					"				 intf_key3, "+
					"				 job_cat1, "+
					"				 job_cat2, "+
					"				 job_cat3, "+
					"				 title, "+
					"				 work_dt, "+
					"				 cat_from_dt, "+
					"				 cat_to_dt, "+
					"				 work_dept_code, "+
					"				 work_sell_code, "+
					"				 work_comp_code, "+
					"				 work_empno, "+	
					"				 work_emp_name, "+
					"				 work_status, "+
					"				memo)";
      sSql = sSql + " VALUES ( h_slip_cat_seq.nextval , :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn( 1, idx_intf_key1);
      gpstatement.bindColumn( 2, idx_intf_key2);
	  gpstatement.bindColumn( 3, idx_intf_key3);
	  gpstatement.bindColumn( 4, idx_job_cat1);
	  gpstatement.bindColumn( 5, idx_job_cat2);
	  gpstatement.bindColumn( 6, idx_job_cat3);
	  gpstatement.bindColumn( 7, idx_title);
	  gpstatement.bindColumn( 8, idx_work_dt);
	  gpstatement.bindColumn( 9, idx_cat_from_dt);
	  gpstatement.bindColumn(10,idx_cat_to_dt);
	  gpstatement.bindColumn(11,idx_work_dept_code);
	  gpstatement.bindColumn(12,idx_work_sell_code);
	  gpstatement.bindColumn(13,idx_work_comp_code);
	  gpstatement.bindColumn(14,idx_work_empno);
	  gpstatement.bindColumn(15,idx_work_emp_name);
	  gpstatement.bindColumn(16,idx_work_status);
	  gpstatement.bindColumn(17,idx_memo);
      stmt.executeUpdate();	
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_slip_cat_intf set " +
					"				 cat_unq=?,"+
					"				 intf_key1	=?,				"+			
					"				 intf_key2	=?,				"+			
					"				 intf_key3	=?,				"+			
					"				 job_cat1=?,				"+				
					"				 job_cat2=?,				"+				
					"				 job_cat3=?,				"+				
					"				 title=?,						"+						
					"				 work_dt=?,					"+					
					"				 cat_from_dt=?,			"+			
					"				 cat_to_dt=?,				"+				
					"				 work_dept_code=?,	"+	
					"				 work_sell_code=?,		"+	
					"				 work_comp_code=?,	"+	
					"				 work_empno=?,			"+			
					"				 work_emp_name=?,	"+	
					"				 work_status=?,			"+
					"				 memo=?			"+
                    "	 where cat_unq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
	  gpstatement.bindColumn(1, idx_cat_unq);
      gpstatement.bindColumn(2, idx_intf_key1				);
      gpstatement.bindColumn(3, idx_intf_key2				);
	  gpstatement.bindColumn(4, idx_intf_key3				);
	  gpstatement.bindColumn(5, idx_job_cat1				);
	  gpstatement.bindColumn(6, idx_job_cat2				);
	  gpstatement.bindColumn(7, idx_job_cat3				);
	  gpstatement.bindColumn(8, idx_title						);
	  gpstatement.bindColumn(9, idx_work_dt					);
	  gpstatement.bindColumn(10, idx_cat_from_dt				);
	  gpstatement.bindColumn(11,idx_cat_to_dt					);
	  gpstatement.bindColumn(12,idx_work_dept_code		);
	  gpstatement.bindColumn(13,idx_work_sell_code		);
	  gpstatement.bindColumn(14,idx_work_comp_code	);
	  gpstatement.bindColumn(15,idx_work_empno				);
	  gpstatement.bindColumn(16,idx_work_emp_name		);
	  gpstatement.bindColumn(17,idx_work_status				);
	  gpstatement.bindColumn(18,idx_memo				);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(19, idx_cat_unq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_slip_cat_intf where cat_unq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn( 1, idx_cat_unq				);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
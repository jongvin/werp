<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("A_AS_REQUEST_PROC_1tr");
     gpstatement.gp_dataset = dSet;

		int idx_REQ_USEQ = dSet.indexOfColumn("REQ_USEQ");
   	int idx_PROC_CODE = dSet.indexOfColumn("PROC_CODE");
   	int idx_DEPT_CODE = dSet.indexOfColumn("DEPT_CODE");
   	int idx_LOC_USEQ = dSet.indexOfColumn("LOC_USEQ");
   	int idx_DONG = dSet.indexOfColumn("DONG");
   	int idx_HO = dSet.indexOfColumn("HO");
   	int idx_FLOOR = dSet.indexOfColumn("FLOOR");
   	int idx_PROG_ST = dSet.indexOfColumn("PROG_ST");
		int idx_REQ_DATE = dSet.indexOfColumn("REQ_DATE");
   	int idx_REQ_NAME = dSet.indexOfColumn("REQ_NAME");
		int idx_REQ_PHONE = dSet.indexOfColumn("REQ_PHONE");
		int idx_REQ_DESC = dSet.indexOfColumn("REQ_DESC");
		int idx_CODE_POS = dSet.indexOfColumn("CODE_POS");
		int idx_CODE_WBS = dSet.indexOfColumn("CODE_WBS");
		int idx_CODE_CAT = dSet.indexOfColumn("CODE_CAT");
		int idx_CODE_CAU = dSet.indexOfColumn("CODE_CAU");
		int idx_PROC_STATUS = dSet.indexOfColumn("PROC_STATUS");
		int idx_PLAN_VISIT_DATE = dSet.indexOfColumn("PLAN_VISIT_DATE");
		int idx_PLAN_PROC_CAT = dSet.indexOfColumn("PLAN_PROC_CAT");
		int idx_PLAN_PROC_DATE = dSet.indexOfColumn("PLAN_PROC_DATE");
		int idx_PLAN_PROC_METHOD = dSet.indexOfColumn("PLAN_PROC_METHOD");
		int idx_SBCR_USEQ = dSet.indexOfColumn("SBCR_USEQ");
		int idx_SBCR_USEQ_AS = dSet.indexOfColumn("SBCR_USEQ_AS");
		int idx_SBCR_CHRG_NAME = dSet.indexOfColumn("SBCR_CHRG_NAME");
		int idx_SBCR_CHRG_PHONE = dSet.indexOfColumn("SBCR_CHRG_PHONE");
		int idx_RES_COMP_DATE = dSet.indexOfColumn("RES_COMP_DATE");
		int idx_RES_INSU_YN = dSet.indexOfColumn("RES_INSU_YN");
		int idx_RES_DESC = dSet.indexOfColumn("RES_DESC");
		int idx_RES_COST = dSet.indexOfColumn("RES_COST");
		int idx_RES_COST_VAT = dSet.indexOfColumn("RES_COST_VAT");
		int idx_INSERT_DATE = dSet.indexOfColumn("INSERT_DATE");
		int idx_UPDATE_DATE = dSet.indexOfColumn("UPDATE_DATE");
		int idx_INSERT_USER = dSet.indexOfColumn("INSERT_USER");
		int idx_UPDATE_USER = dSet.indexOfColumn("UPDATE_USER");
		int idx_ATTRIB1 = dSet.indexOfColumn("ATTRIB1");
		int idx_ATTRIB2 = dSet.indexOfColumn("ATTRIB2");
		int idx_REMARK = dSet.indexOfColumn("REMARK");
		int idx_CONTRACT_NAME = dSet.indexOfColumn("CONTRACT_NAME");


      int  rowCnt = dSet.getDataRowCnt();
      for(int i=0; i< rowCnt; i++){
     	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
		if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
/*
			String sSql = " insert into A_AS_REQ_MASTER								" +
						  " (																		" +
 						  " REQ_USEQ     ,   												" +  
						  "  PROC_CODE    ,  												" +   
						  "  DEPT_CODE    ,   												" +  
						  "  LOC_USEQ     ,   												" +  
						  "  DONG         ,   												" +  
						  "  HO           ,   												" +  
						  "  FLOOR        ,   												" +  
						  "  PROG_ST      ,   												" +  
						  "  REQ_DATE     ,   												" + 
						  "  REQ_NAME     ,   												" +  
						  "  REQ_PHONE    ,   												" +  
						  "  REQ_DESC     ,   												" +  
						  "  CODE_POS     ,   												" +  
						  "  CODE_WBS     ,   												" +  
						  "  CODE_CAT     ,   												" +  
						  "  CODE_CAU     ,   												" +
						  "  PROC_STATUS  ,     											" +
						  "  PLAN_VISIT_DATE  , 											" +
						  "  PLAN_PROC_CAT    ,												" +
						  "  PLAN_PROC_DATE   , 											" +
						  "  PLAN_PROC_METHOD ,												" +
						  "  SBCR_USEQ        ,												" +
						  "  SBCR_USEQ_AS     ,												" +
						  "  SBCR_CHRG_NAME   , 											" +
						  "  SBCR_CHRG_PHONE  , 											" +
						  "  RES_COMP_DATE    , 											" +
						  "  RES_INSU_YN      , 											" +
						  "  RES_DESC         , 											" +
						  "  RES_COST         , 											" +
						  "  RES_COST_VAT     , 											" +
						  "  INSERT_DATE      , 											" +
						  "  UPDATE_DATE      ,												" +
						  "  INSERT_USER      , 											" +
						  "  UPDATE_USER      , 											" +
						  "  ATTRIB1          , 											" +
						  "  ATTRIB2          , 											" +
						  "	  )																" ;
			sSql = sSql + " VALUES (														" +
						  "   :1, :2, :3, :4, :5, :6, :7, :8 ,:9 ,:10,				" +
						  "   :11, :12, :13, :14, :15, :16, :17, :18 ,:19 ,:20,	" +
						  "   :21, :22, :23, :24, :25, :26, :27, :28 ,:29 ,:30,	" +
						  "   :31, :32, :33, :34, :35, :36 )							" ;
			stmt = conn.prepareStatement(sSql);
			gpstatement.gp_stmt = stmt;
			gpstatement.bindColumn(1, idx_REQ_USEQ  );       
			gpstatement.bindColumn(2, idx_PROC_CODE );     
			gpstatement.bindColumn(3, idx_DEPT_CODE );     
			gpstatement.bindColumn(4, idx_LOC_USEQ  );     
			gpstatement.bindColumn(5, idx_DONG      );     
			gpstatement.bindColumn(6, idx_HO        );      
			gpstatement.bindColumn(7, idx_FLOOR     );     
			gpstatement.bindColumn(8, idx_PROG_ST   );     
			gpstatement.bindColumn(9, idx_REQ_DATE  );    
			gpstatement.bindColumn(10, idx_REQ_NAME  );     
			gpstatement.bindColumn(11, idx_REQ_PHONE );     
			gpstatement.bindColumn(12, idx_REQ_DESC  );     
			gpstatement.bindColumn(13, idx_CODE_POS  );     
			gpstatement.bindColumn(14, idx_CODE_WBS  );     
			gpstatement.bindColumn(15, idx_CODE_CAT  );     
			gpstatement.bindColumn(16, idx_CODE_CAU  );   
			gpstatement.bindColumn(17, idx_PROC_STATUS  );     
			gpstatement.bindColumn(18, idx_PLAN_VISIT_DATE  ); 
			gpstatement.bindColumn(19, idx_PLAN_PROC_CAT    );
			gpstatement.bindColumn(20, idx_PLAN_PROC_DATE   ); 
			gpstatement.bindColumn(21, idx_PLAN_PROC_METHOD );
			gpstatement.bindColumn(22, idx_SBCR_USEQ        );
			gpstatement.bindColumn(23, idx_SBCR_USEQ_AS     );
			gpstatement.bindColumn(24, idx_SBCR_CHRG_NAME   );
			gpstatement.bindColumn(25, idx_SBCR_CHRG_PHONE  ); 
			gpstatement.bindColumn(26, idx_RES_COMP_DATE    ); 
			gpstatement.bindColumn(27, idx_RES_INSU_YN      ); 
			gpstatement.bindColumn(28, idx_RES_DESC         ); 
			gpstatement.bindColumn(29, idx_RES_COST         ); 
			gpstatement.bindColumn(30, idx_RES_COST_VAT     ); 
			gpstatement.bindColumn(31, idx_INSERT_DATE      ); 
			gpstatement.bindColumn(32, idx_UPDATE_DATE      );
			gpstatement.bindColumn(33, idx_INSERT_USER      ); 
			gpstatement.bindColumn(34, idx_UPDATE_USER      ); 
			gpstatement.bindColumn(35, idx_ATTRIB1          ); 
			gpstatement.bindColumn(36, idx_ATTRIB2          ); 
			stmt.executeUpdate();
			stmt.close();
*/
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
 	  String ls_PLAN_VISIT_DATE = rows.getString(idx_PLAN_VISIT_DATE);
	  String sSql = "update A_AS_REQ_MASTER set																" + 
						  "  PROC_CODE=?    ,  																		" +   
						  "  DEPT_CODE=?    ,   																	" +  
						  "  LOC_USEQ=?     ,   																	" +  
 	 					  "  DONG=?         ,   																	" +  
						  "  HO=?           ,   																	" +  
						  "  FLOOR=?        ,   																	" +  
						  "  REQ_DATE=?     ,   																	" + 
						  "  REQ_NAME=?     ,   																	" +  
						  "  REQ_PHONE=?    ,   																	" +  
						  "  REQ_DESC=?     ,   																	" +  
						  "  CODE_POS=?     ,   																	" +  
						  "  CODE_WBS=?     ,   																	" +  
						  "  CODE_CAT=?     ,   																	" +  
						  "  CODE_CAU=?     ,   																	" +
						  "  PROC_STATUS=?  ,     																	" +
						  "  PLAN_VISIT_DATE= TO_DATE ('"+ls_PLAN_VISIT_DATE+ "','YYYYmmddHH24mi') ,	" +
						  "  PLAN_PROC_CAT=?    ,																	" +
						  "  PLAN_PROC_DATE=?   , 																	" +
						  "  PLAN_PROC_METHOD=? ,																	" +
						  "  SBCR_USEQ=?        ,																	" +
						  "  SBCR_USEQ_AS=?     ,																	" +
						  "  SBCR_CHRG_NAME=?   , 																	" +
						  "  SBCR_CHRG_PHONE=?  , 																	" +
						  "  RES_COMP_DATE=?    , 																	" +
						  "  RES_INSU_YN=?      , 																	" +
						  "  RES_DESC=?         , 																	" +
						  "  RES_COST=?         , 																	" +
						  "  RES_COST_VAT=?     , 																	" +
						  "  UPDATE_DATE=sysdate,																	" +
						  "  UPDATE_USER= ( select name from z_authority_user where empno =? ) ,	" +				  
						  "  ATTRIB1=?          , 																	" +
						  "  ATTRIB2=?          , 																	" +
						  "  PROG_ST=?		      ,																	" +  
						  "  REMARK=?				,																	" +
						  "  CONTRACT_NAME=?																			" +
					  "  where REQ_USEQ=?																			" ;  
	      stmt = conn.prepareStatement(sSql);  					  
			gpstatement.gp_stmt = stmt;
			gpstatement.bindColumn(1, idx_PROC_CODE );     
			gpstatement.bindColumn(2, idx_DEPT_CODE );     
			gpstatement.bindColumn(3, idx_LOC_USEQ  );     
			gpstatement.bindColumn(4, idx_DONG      );     
			gpstatement.bindColumn(5, idx_HO        );      
			gpstatement.bindColumn(6, idx_FLOOR     );     
			gpstatement.bindColumn(7, idx_REQ_DATE  );    
			gpstatement.bindColumn(8, idx_REQ_NAME  );
			gpstatement.bindColumn(9, idx_REQ_PHONE );     
			gpstatement.bindColumn(10, idx_REQ_DESC  );     
			gpstatement.bindColumn(11, idx_CODE_POS  );     
			gpstatement.bindColumn(12, idx_CODE_WBS  );     
			gpstatement.bindColumn(13, idx_CODE_CAT  );     
			gpstatement.bindColumn(14, idx_CODE_CAU  );   
			gpstatement.bindColumn(15, idx_PROC_STATUS  );     
//			gpstatement.bindColumn(16, idx_PLAN_VISIT_DATE  ); 
			gpstatement.bindColumn(16, idx_PLAN_PROC_CAT    );
			gpstatement.bindColumn(17, idx_PLAN_PROC_DATE   ); 
			gpstatement.bindColumn(18, idx_PLAN_PROC_METHOD );
			gpstatement.bindColumn(19, idx_SBCR_USEQ        );
			gpstatement.bindColumn(20, idx_SBCR_USEQ_AS     );
			gpstatement.bindColumn(21, idx_SBCR_CHRG_NAME   );
			gpstatement.bindColumn(22, idx_SBCR_CHRG_PHONE  ); 
			gpstatement.bindColumn(23, idx_RES_COMP_DATE    ); 
			gpstatement.bindColumn(24, idx_RES_INSU_YN      ); 
			gpstatement.bindColumn(25, idx_RES_DESC         ); 
			gpstatement.bindColumn(26, idx_RES_COST         ); 
			gpstatement.bindColumn(27, idx_RES_COST_VAT     ); 
			gpstatement.bindColumn(28, idx_UPDATE_USER      ); 
			gpstatement.bindColumn(29, idx_ATTRIB1          ); 
			gpstatement.bindColumn(30, idx_ATTRIB2          ); 
			gpstatement.bindColumn(31, idx_PROG_ST   );     
			gpstatement.bindColumn(32, idx_REMARK          ); 
			gpstatement.bindColumn(33, idx_CONTRACT_NAME         ); 
  /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
		   gpstatement.bindColumn(34, idx_REQ_USEQ  );    
			stmt.executeUpdate();
			stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
	   String sSql = "delete from A_AS_REQ_MASTER where REQ_USEQ=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_REQ_USEQ);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("q_code_eqp_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_equp_code = dSet.indexOfColumn("equp_code");
   	int idx_regist_no = dSet.indexOfColumn("regist_no");
   	int idx_eqp_name = dSet.indexOfColumn("eqp_name");
   	int idx_eqp_size = dSet.indexOfColumn("eqp_size");
   	int idx_own_hire_tag = dSet.indexOfColumn("own_hire_tag");
   	int idx_price_method = dSet.indexOfColumn("price_method");
   	int idx_unit_price = dSet.indexOfColumn("unit_price");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO Q_CODE_EQUIPMENT ( dept_code," + 
                    "equp_code," + 
                    "regist_no," + 
                    "eqp_name," + 
                    "eqp_size," + 
                    "own_hire_tag," + 
                    "price_method," + 
                    "unit_price )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_equp_code);
      gpstatement.bindColumn(3, idx_regist_no);
      gpstatement.bindColumn(4, idx_eqp_name);
      gpstatement.bindColumn(5, idx_eqp_size);
      gpstatement.bindColumn(6, idx_own_hire_tag);
      gpstatement.bindColumn(7, idx_price_method);
      gpstatement.bindColumn(8, idx_unit_price);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update q_code_equipment set " + 
                            "dept_code=?,  " + 
                            "equp_code=?,  " + 
                            "regist_no=?,  " + 
                            "eqp_name=?,  " + 
                            "eqp_size=?,  " + 
                            "own_hire_tag=?,  " + 
                            "price_method=?,  " + 
                            "unit_price=?  where dept_code=? " +
                            "and equp_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_equp_code);
      gpstatement.bindColumn(3, idx_regist_no);
      gpstatement.bindColumn(4, idx_eqp_name);
      gpstatement.bindColumn(5, idx_eqp_size);
      gpstatement.bindColumn(6, idx_own_hire_tag);
      gpstatement.bindColumn(7, idx_price_method);
      gpstatement.bindColumn(8, idx_unit_price);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(9, idx_dept_code);
      gpstatement.bindColumn(10, idx_equp_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from q_code_equipment where dept_code=? " +
                    "and equp_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_equp_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
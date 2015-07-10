<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_base_option_detail_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_cls_code = dSet.indexOfColumn("cls_code");
   	int idx_elem_code = dSet.indexOfColumn("elem_code");
   	int idx_elem_name = dSet.indexOfColumn("elem_name");
   	int idx_base_yn = dSet.indexOfColumn("base_yn");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_old_elem_code = dSet.indexOfColumn("old_elem_code");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_base_option_detail ( dept_code," + 
                    "cls_code," + 
                    "elem_code," + 
                    "elem_name," + 
                    "base_yn," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_cls_code);
      gpstatement.bindColumn(3, idx_elem_code);
      gpstatement.bindColumn(4, idx_elem_name);
      gpstatement.bindColumn(5, idx_base_yn);
      gpstatement.bindColumn(6, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_base_option_detail set " + 
                            "dept_code=?,  " + 
                            "cls_code=?,  " + 
                            "elem_code=?,  " + 
                            "elem_name=?,  " + 
                            "base_yn=?,  " + 
                            "remark=?  where dept_code=? and cls_code=? and elem_code=?  ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_cls_code);
      gpstatement.bindColumn(3, idx_elem_code);
      gpstatement.bindColumn(4, idx_elem_name);
      gpstatement.bindColumn(5, idx_base_yn);
      gpstatement.bindColumn(6, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(7, idx_dept_code);
      gpstatement.bindColumn(8, idx_cls_code);
      gpstatement.bindColumn(9, idx_old_elem_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_base_option_detail where dept_code=? and cls_code=? and elem_code=?  "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_cls_code);
      gpstatement.bindColumn(3, idx_old_elem_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
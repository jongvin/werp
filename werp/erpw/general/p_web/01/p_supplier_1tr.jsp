<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_supplier_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
   	int idx_inco_name = dSet.indexOfColumn("inco_name");
   	int idx_inco_num = dSet.indexOfColumn("inco_num");
   	int idx_resi_name = dSet.indexOfColumn("resi_name");
   	int idx_resi_num = dSet.indexOfColumn("resi_num");
   	int idx_pens_name = dSet.indexOfColumn("pens_name");
   	int idx_pens_num = dSet.indexOfColumn("pens_num");
   	int idx_medi_name = dSet.indexOfColumn("medi_name");
   	int idx_medi_num = dSet.indexOfColumn("medi_num");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_code_supplier ( comp_code," + 
                    "inco_name," + 
                    "inco_num," + 
                    "resi_name," + 
                    "resi_num," + 
                    "pens_name," + 
                    "pens_num," + 
                    "medi_name," + 
                    "medi_num )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_comp_code);
      gpstatement.bindColumn(2, idx_inco_name);
      gpstatement.bindColumn(3, idx_inco_num);
      gpstatement.bindColumn(4, idx_resi_name);
      gpstatement.bindColumn(5, idx_resi_num);
      gpstatement.bindColumn(6, idx_pens_name);
      gpstatement.bindColumn(7, idx_pens_num);
      gpstatement.bindColumn(8, idx_medi_name);
      gpstatement.bindColumn(9, idx_medi_num);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_code_supplier set " + 
                            "comp_code=?,  " + 
                            "inco_name=?,  " + 
                            "inco_num=?,  " + 
                            "resi_name=?,  " + 
                            "resi_num=?,  " + 
                            "pens_name=?,  " + 
                            "pens_num=?,  " + 
                            "medi_name=?,  " + 
                            "medi_num=?  where comp_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_comp_code);
      gpstatement.bindColumn(2, idx_inco_name);
      gpstatement.bindColumn(3, idx_inco_num);
      gpstatement.bindColumn(4, idx_resi_name);
      gpstatement.bindColumn(5, idx_resi_num);
      gpstatement.bindColumn(6, idx_pens_name);
      gpstatement.bindColumn(7, idx_pens_num);
      gpstatement.bindColumn(8, idx_medi_name);
      gpstatement.bindColumn(9, idx_medi_num);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(10, idx_comp_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_code_supplier where comp_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_comp_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
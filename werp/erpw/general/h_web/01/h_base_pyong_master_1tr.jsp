<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_base_pyong_master_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
   	int idx_pyong = dSet.indexOfColumn("pyong");
   	int idx_style = dSet.indexOfColumn("style");
   	int idx_class = dSet.indexOfColumn("class");
   	int idx_option_code = dSet.indexOfColumn("option_code");
   	int idx_vat_yn = dSet.indexOfColumn("vat_yn");
   	int idx_private_square = dSet.indexOfColumn("private_square");
   	int idx_common_square = dSet.indexOfColumn("common_square");
   	int idx_etc_square = dSet.indexOfColumn("etc_square");
   	int idx_parking_square = dSet.indexOfColumn("parking_square");
   	int idx_service_square = dSet.indexOfColumn("service_square");
   	int idx_grand_square = dSet.indexOfColumn("grand_square");
   	int idx_represent_pyong = dSet.indexOfColumn("represent_pyong");
   	int idx_land_amt = dSet.indexOfColumn("land_amt");
   	int idx_build_amt = dSet.indexOfColumn("build_amt");
   	int idx_vat_amt = dSet.indexOfColumn("vat_amt");
   	int idx_sell_amt = dSet.indexOfColumn("sell_amt");
	int idx_lease_supply = dSet.indexOfColumn("lease_supply");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_BASE_PYONG_MASTER ( dept_code," + 
                    "sell_code," + 
                    "spec_unq_num," + 
                    "pyong," + 
                    "style," + 
                    "class," + 
                    "option_code," + 
                    "vat_yn," + 
                    "private_square," + 
                    "common_square," + 
                    "etc_square," + 
                    "parking_square," + 
                    "service_square," + 
                    "grand_square," + 
                    "represent_pyong," + 
                    "land_amt," + 
                    "build_amt," + 
                    "vat_amt," + 
                    "sell_amt,"+
			        "lease_supply)      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_spec_unq_num);
      gpstatement.bindColumn(4, idx_pyong);
      gpstatement.bindColumn(5, idx_style);
      gpstatement.bindColumn(6, idx_class);
      gpstatement.bindColumn(7, idx_option_code);
      gpstatement.bindColumn(8, idx_vat_yn);
      gpstatement.bindColumn(9, idx_private_square);
      gpstatement.bindColumn(10, idx_common_square);
      gpstatement.bindColumn(11, idx_etc_square);
      gpstatement.bindColumn(12, idx_parking_square);
      gpstatement.bindColumn(13, idx_service_square);
      gpstatement.bindColumn(14, idx_grand_square);
      gpstatement.bindColumn(15, idx_represent_pyong);
      gpstatement.bindColumn(16, idx_land_amt);
      gpstatement.bindColumn(17, idx_build_amt);
      gpstatement.bindColumn(18, idx_vat_amt);
      gpstatement.bindColumn(19, idx_sell_amt);
	  gpstatement.bindColumn(20, idx_lease_supply);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_base_pyong_master set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "spec_unq_num=?,  " + 
                            "pyong=?,  " + 
                            "style=?,  " + 
                            "class=?,  " + 
                            "option_code=?,  " + 
                            "vat_yn=?,  " + 
                            "private_square=?,  " + 
                            "common_square=?,  " + 
                            "etc_square=?,  " + 
                            "parking_square=?,  " + 
                            "service_square=?,  " + 
                            "grand_square=?,  " + 
                            "represent_pyong=?,  " + 
                            "land_amt=?,  " + 
                            "build_amt=?,  " + 
                            "vat_amt=?,  " + 
                            "sell_amt=?, "+
                            "lease_supply=? where dept_code=? " + 
                            " and sell_code=? " +
                            " and spec_unq_num=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_spec_unq_num);
      gpstatement.bindColumn(4, idx_pyong);
      gpstatement.bindColumn(5, idx_style);
      gpstatement.bindColumn(6, idx_class);
      gpstatement.bindColumn(7, idx_option_code);
      gpstatement.bindColumn(8, idx_vat_yn);
      gpstatement.bindColumn(9, idx_private_square);
      gpstatement.bindColumn(10, idx_common_square);
      gpstatement.bindColumn(11, idx_etc_square);
      gpstatement.bindColumn(12, idx_parking_square);
      gpstatement.bindColumn(13, idx_service_square);
      gpstatement.bindColumn(14, idx_grand_square);
      gpstatement.bindColumn(15, idx_represent_pyong);
      gpstatement.bindColumn(16, idx_land_amt);
      gpstatement.bindColumn(17, idx_build_amt);
      gpstatement.bindColumn(18, idx_vat_amt);
      gpstatement.bindColumn(19, idx_sell_amt);
	  gpstatement.bindColumn(20, idx_lease_supply);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(21, idx_dept_code);
      gpstatement.bindColumn(22, idx_sell_code);
      gpstatement.bindColumn(23, idx_spec_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_base_pyong_master where dept_code=? " +
                                                     " and sell_code=? " +
                                                     " and spec_unq_num=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_spec_unq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_code_dept_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_long_name = dSet.indexOfColumn("long_name");
   	int idx_phone = dSet.indexOfColumn("phone");
   	int idx_fax = dSet.indexOfColumn("fax");
   	int idx_zip_code = dSet.indexOfColumn("zip_code");
   	int idx_addr1 = dSet.indexOfColumn("addr1");
   	int idx_addr2 = dSet.indexOfColumn("addr2");
   	int idx_m_h_phone = dSet.indexOfColumn("m_h_phone");
   	int idx_area = dSet.indexOfColumn("area");
   	int idx_roof = dSet.indexOfColumn("roof");
   	int idx_str = dSet.indexOfColumn("str"); gpstatement.gp_dataset = dSet;
   	int idx_service = dSet.indexOfColumn("service");
   	int idx_field = dSet.indexOfColumn("field");
   	int idx_tot_square = dSet.indexOfColumn("tot_square");
   	int idx_tot_pyong = dSet.indexOfColumn("tot_pyong");
   	int idx_tot_sell_price = dSet.indexOfColumn("tot_sell_price");
   	int idx_apt_square = dSet.indexOfColumn("apt_square");
   	int idx_downtown_square = dSet.indexOfColumn("downtown_square");
   	int idx_road_backdown_square = dSet.indexOfColumn("road_backdown_square");
   	int idx_project_div = dSet.indexOfColumn("project_div");
   	int idx_lease_yn = dSet.indexOfColumn("lease_yn");
   	int idx_ontime_deposit_no = dSet.indexOfColumn("ontime_deposit_no");
   	int idx_print_order = dSet.indexOfColumn("print_order");
   	int idx_print_yn = dSet.indexOfColumn("print_yn");
   	int idx_sell_zip_code = dSet.indexOfColumn("sell_zip_code");
   	int idx_sell_addr1 = dSet.indexOfColumn("sell_addr1");
   	int idx_sell_addr2 = dSet.indexOfColumn("sell_addr2");
   	int idx_sell_comp_name = dSet.indexOfColumn("sell_comp_name");
   	int idx_sell_represent = dSet.indexOfColumn("sell_represent");
   	int idx_process_code = dSet.indexOfColumn("process_code");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_CODE_DEPT ( dept_code," + 
                    "long_name," + 
                    "phone," + 
                    "fax," + 
                    "zip_code," + 
                    "addr1," + 
                    "addr2," + 
                    "m_h_phone," + 
                    "area," + 
                    "roof," + 
                    "str," + 
                    "service," + 
                    "field," + 
                    "tot_square," + 
                    "tot_pyong," + 
                    "tot_sell_price," + 
                    "apt_square," + 
                    "downtown_square," + 
                    "road_backdown_square," + 
                    "project_div," + 
                    "lease_yn," + 
                    "ontime_deposit_no," + 
                    "print_order," + 
                    "print_yn," + 
                    "sell_zip_code," + 
                    "sell_addr1," + 
                    "sell_addr2," + 
                    "sell_comp_name," + 
                    "sell_represent," + 
                    "process_code," +
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26, :27, :28, :29, :30, :31 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_long_name);
      gpstatement.bindColumn(3, idx_phone);
      gpstatement.bindColumn(4, idx_fax);
      gpstatement.bindColumn(5, idx_zip_code);
      gpstatement.bindColumn(6, idx_addr1);
      gpstatement.bindColumn(7, idx_addr2);
      gpstatement.bindColumn(8, idx_m_h_phone);
      gpstatement.bindColumn(9, idx_area);
      gpstatement.bindColumn(10, idx_roof);
      gpstatement.bindColumn(11, idx_str);
      gpstatement.bindColumn(12, idx_service);
      gpstatement.bindColumn(13, idx_field);
      gpstatement.bindColumn(14, idx_tot_square);
      gpstatement.bindColumn(15, idx_tot_pyong);
      gpstatement.bindColumn(16, idx_tot_sell_price);
      gpstatement.bindColumn(17, idx_apt_square);
      gpstatement.bindColumn(18, idx_downtown_square);
      gpstatement.bindColumn(19, idx_road_backdown_square);
      gpstatement.bindColumn(20, idx_project_div);
      gpstatement.bindColumn(21, idx_lease_yn);
      gpstatement.bindColumn(22, idx_ontime_deposit_no);
      gpstatement.bindColumn(23, idx_print_order);
      gpstatement.bindColumn(24, idx_print_yn);
      gpstatement.bindColumn(25, idx_sell_zip_code);
      gpstatement.bindColumn(26, idx_sell_addr1);
      gpstatement.bindColumn(27, idx_sell_addr2);
      gpstatement.bindColumn(28, idx_sell_comp_name);
      gpstatement.bindColumn(29, idx_sell_represent);
      gpstatement.bindColumn(30, idx_process_code);
      gpstatement.bindColumn(31, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_code_dept set " + 
                            "dept_code=?,  " + 
                            "long_name=?,  " + 
                            "phone=?,  " + 
                            "fax=?,  " + 
                            "zip_code=?,  " + 
                            "addr1=?,  " + 
                            "addr2=?,  " + 
                            "m_h_phone=?,  " + 
                            "area=?,  " + 
                            "roof=?,  " + 
                            "str=?,  " + 
                            "service=?,  " + 
                            "field=?,  " + 
                            "tot_square=?,  " + 
                            "tot_pyong=?,  " + 
                            "tot_sell_price=?,  " + 
                            "apt_square=?,  " + 
                            "downtown_square=?,  " + 
                            "road_backdown_square=?,  " + 
                            "project_div=?,  " + 
                            "lease_yn=?,  " + 
                            "ontime_deposit_no=?,  " + 
                            "print_order=?,  " + 
                            "print_yn=?,  " + 
                            "sell_zip_code=?,  " + 
                            "sell_addr1=?,  " + 
                            "sell_addr2=?,  " + 
                            "sell_comp_name=?,  " + 
                            "sell_represent=?,  " + 
                            "process_code=?,   " +
                            "remark=?  where dept_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_long_name);
      gpstatement.bindColumn(3, idx_phone);
      gpstatement.bindColumn(4, idx_fax);
      gpstatement.bindColumn(5, idx_zip_code);
      gpstatement.bindColumn(6, idx_addr1);
      gpstatement.bindColumn(7, idx_addr2);
      gpstatement.bindColumn(8, idx_m_h_phone);
      gpstatement.bindColumn(9, idx_area);
      gpstatement.bindColumn(10, idx_roof);
      gpstatement.bindColumn(11, idx_str);
      gpstatement.bindColumn(12, idx_service);
      gpstatement.bindColumn(13, idx_field);
      gpstatement.bindColumn(14, idx_tot_square);
      gpstatement.bindColumn(15, idx_tot_pyong);
      gpstatement.bindColumn(16, idx_tot_sell_price);
      gpstatement.bindColumn(17, idx_apt_square);
      gpstatement.bindColumn(18, idx_downtown_square);
      gpstatement.bindColumn(19, idx_road_backdown_square);
      gpstatement.bindColumn(20, idx_project_div);
      gpstatement.bindColumn(21, idx_lease_yn);
      gpstatement.bindColumn(22, idx_ontime_deposit_no);
      gpstatement.bindColumn(23, idx_print_order);
      gpstatement.bindColumn(24, idx_print_yn);
      gpstatement.bindColumn(25, idx_sell_zip_code);
      gpstatement.bindColumn(26, idx_sell_addr1);
      gpstatement.bindColumn(27, idx_sell_addr2);
      gpstatement.bindColumn(28, idx_sell_comp_name);
      gpstatement.bindColumn(29, idx_sell_represent);
      gpstatement.bindColumn(30, idx_process_code);
      gpstatement.bindColumn(31, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(32, idx_dept_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_code_dept where dept_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
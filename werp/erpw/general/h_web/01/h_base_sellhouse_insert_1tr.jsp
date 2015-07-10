<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_base_sellhouse_insert_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_pyong = dSet.indexOfColumn("pyong");
   	int idx_style = dSet.indexOfColumn("style");
   	int idx_class = dSet.indexOfColumn("class");
   	int idx_s_dong = dSet.indexOfColumn("s_dong");
   	int idx_s_ho = dSet.indexOfColumn("s_ho");
   	int idx_e_ho = dSet.indexOfColumn("e_ho");
   	int idx_option_code = dSet.indexOfColumn("option_code");
   	int idx_union_yn = dSet.indexOfColumn("union_yn");
   	int idx_house_cnt = dSet.indexOfColumn("house_cnt");
   	int idx_contract_code = dSet.indexOfColumn("contract_code");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_BASE_SELLHOUSE ( dept_code," + 
                    "sell_code," + 
                    "seq," + 
                    "pyong," + 
                    "style," + 
                    "class," + 
                    "s_dong," + 
                    "s_ho," + 
                    "e_ho," + 
                    "option_code," + 
                    "union_yn," + 
                    "house_cnt," +
                    "contract_code )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_pyong);
      gpstatement.bindColumn(5, idx_style);
      gpstatement.bindColumn(6, idx_class);
      gpstatement.bindColumn(7, idx_s_dong);
      gpstatement.bindColumn(8, idx_s_ho);
      gpstatement.bindColumn(9, idx_e_ho);
      gpstatement.bindColumn(10, idx_option_code);
      gpstatement.bindColumn(11, idx_union_yn);
      gpstatement.bindColumn(12, idx_house_cnt);
      gpstatement.bindColumn(13, idx_contract_code);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_base_sellhouse set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "seq=?,  " + 
                            "pyong=?,  " + 
                            "style=?,  " + 
                            "class=?,  " + 
                            "s_dong=?,  " + 
                            "s_ho=?,  " + 
                            "e_ho=?,  " + 
                            "option_code=?,  " + 
                            "union_yn=?,  " + 
                            "house_cnt=?, " +
                            "contract_code=?  where dept_code=? " +
                            "               and sell_code=? " +
                            "               and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_pyong);
      gpstatement.bindColumn(5, idx_style);
      gpstatement.bindColumn(6, idx_class);
      gpstatement.bindColumn(7, idx_s_dong);
      gpstatement.bindColumn(8, idx_s_ho);
      gpstatement.bindColumn(9, idx_e_ho);
      gpstatement.bindColumn(10, idx_option_code);
      gpstatement.bindColumn(11, idx_union_yn);
      gpstatement.bindColumn(12, idx_house_cnt);
      gpstatement.bindColumn(13, idx_contract_code);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(14, idx_dept_code);
      gpstatement.bindColumn(15, idx_sell_code);
      gpstatement.bindColumn(16, idx_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_base_sellhouse where dept_code=? " +
                            "               and sell_code=? " +
                            "               and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>
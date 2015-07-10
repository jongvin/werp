<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
//     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("fax",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("zip_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("addr1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("addr2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("m_h_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("area",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("roof",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("str",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("service",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("field",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_square",GauceDataColumn.TB_DECIMAL,18,4));
     dSet.addDataColumn(new GauceDataColumn("tot_pyong",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("tot_sell_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("apt_square",GauceDataColumn.TB_DECIMAL,18,4));
     dSet.addDataColumn(new GauceDataColumn("downtown_square",GauceDataColumn.TB_DECIMAL,18,4));
     dSet.addDataColumn(new GauceDataColumn("road_backdown_square",GauceDataColumn.TB_DECIMAL,18,4));
     dSet.addDataColumn(new GauceDataColumn("project_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("lease_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("ontime_deposit_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("print_order",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("print_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("sell_zip_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_addr1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("sell_addr2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sell_comp_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("sell_represent",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("process_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,120));
	  dSet.addDataColumn(new GauceDataColumn("complete_date",GauceDataColumn.TB_STRING,10));
    String query = "  SELECT A.DEPT_CODE,   " + 
     "         A.LONG_NAME,   " + 
     "         A.PHONE,   " + 
     "         A.FAX,   " + 
     "         A.ZIP_CODE,   " + 
     "         A.ADDR1,   " + 
     "         A.ADDR2,   " + 
     "         A.M_H_PHONE,   " + 
     "         A.AREA,   " + 
     "         A.ROOF,   " + 
     "         A.STR,   " + 
     "         A.SERVICE,   " + 
     "         A.FIELD,   " + 
     "         A.TOT_SQUARE,   " + 
     "         A.TOT_PYONG,   " + 
     "         A.TOT_SELL_PRICE,   " + 
     "         A.APT_SQUARE,   " + 
     "         A.DOWNTOWN_SQUARE,   " + 
     "         A.ROAD_BACKDOWN_SQUARE,   " + 
     "         A.PROJECT_DIV,   " + 
     "         A.LEASE_YN,   " + 
     "         A.ONTIME_DEPOSIT_NO,   " + 
     "         A.PRINT_ORDER,   " + 
     "         A.PRINT_YN,   " + 
     "         A.SELL_ZIP_CODE,   " + 
     "         A.SELL_ADDR1,   " + 
     "         A.SELL_ADDR2,   " + 
     "         A.SELL_COMP_NAME,   " + 
     "         A.SELL_REPRESENT,   " + 
     "         A.PROCESS_CODE,     " +
     "         A.REMARK,  " + 
	  "         to_char(B.complete_date, 'yyyy.mm.dd') complete_date  " + 
     "    FROM H_CODE_DEPT A, "+
	  "                 Z_CODE_DEPT B" +
	  "    where a.dept_code = b.dept_code(+) "+
     " ORDER BY a.long_name ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>
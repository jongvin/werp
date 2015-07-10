<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_dongho = req.getParameter("arg_dongho");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cls_code",GauceDataColumn.TB_STRING,2));
	  dSet.addDataColumn(new GauceDataColumn("cls_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("elem_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("key_cls_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("key_elem_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,120));
     dSet.addDataColumn(new GauceDataColumn("elem_name",GauceDataColumn.TB_STRING,30));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "                       a.SELL_CODE,   " + 
     "                       a.DONGHO,   " + 
     "                       a.SEQ,   " + 
     "                       a.CLS_CODE,   " + 
	  "                       C.CLS_NAME,   " + 
     "                       a.ELEM_CODE,   " + 
     "                       a.CLS_CODE    key_cls_code,   " + 
     "                       a.ELEM_CODE   key_elem_code,   " + 
     "                       a.REMARK,   " + 
     "                       b.ELEM_NAME  " + 
     "                  FROM H_SALE_OPTION a,   " + 
     "                       H_BASE_OPTION_DETAIL b, " + 
	  "                       H_BASE_OPTION_MASTER C " + 
     "                 WHERE a.dept_code = b.dept_code (+)" + 
     "                   AND a.cls_code  = b.cls_code (+)" + 
     "                   AND a.elem_code = b.elem_code (+)" + 
	  "                   and a.dept_code = c.dept_code (+)"+ 
	  "                   AND a.cls_code  = C.cls_code (+)"+
     "                   AND a.DEPT_CODE = " + "'" + arg_dept_code + "'" + 
     "                   AND a.SELL_CODE = " + "'" + arg_sell_code + "'" + 
     "                   AND a.DONGHO = " + "'" + arg_dongho + "'" + 
     "                   AND a.SEQ = " + "'" + arg_seq + "'" + 
     "              ORDER BY a.CLS_CODE ASC,   " + 
     "                       a.ELEM_CODE ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>
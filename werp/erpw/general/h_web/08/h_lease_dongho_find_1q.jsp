<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%

// 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     
String arg_dept_code = req.getParameter("arg_dept_code");
     
String arg_sell_code = req.getParameter("arg_sell_code");

 //---------------------------------------------------------- 
     
dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     
dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     
dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     
dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     
dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_STRING,10));
     
dSet.addDataColumn(new GauceDataColumn("style",GauceDataColumn.TB_STRING,2));
     
dSet.addDataColumn(new GauceDataColumn("class",GauceDataColumn.TB_STRING,2));
     
dSet.addDataColumn(new GauceDataColumn("option_code",GauceDataColumn.TB_STRING,2));
     
dSet.addDataColumn(new GauceDataColumn("class_name",GauceDataColumn.TB_STRING,20));
     
dSet.addDataColumn(new GauceDataColumn("option_name",GauceDataColumn.TB_STRING,20));

String query = "  SELECT  a.DEPT_CODE,  " +    
     "                       a.SELL_CODE,  " +    
     "                       a.DONGHO,  " +    
     "                       a.SEQ,  " +    
     "                       a.PYONG,  " +    
     "                       a.STYLE,  " +    
     "                       a.CLASS,  " +    
     "                       a.OPTION_CODE,  " + 
     "                       c.class_name,  " + 
     "                       d.option_name  " + 
     "                  FROM H_SALE_MASTER a,  " + 
     "                       h_code_class  c,  " + 
     "                       h_code_option d,  " + 
     "                       (select max(dongho) dongho,max(seq) seq  " + 
     "                          from h_sale_master  " + 
     "                         where dept_code = " + "'" + arg_dept_code + "'" + 
     "                           and sell_code = " + "'" + arg_sell_code + "'" +
	 "                         group by dept_code,sell_code,dongho ) b  " + 
     "              WHERE a.dongho = b.dongho  " + 
     "                and a.seq = b.seq  " + 
     "                and a.dept_code = c.dept_code  " + 
     "                and a.sell_code = c.sell_code  " + 
     "                and a.class     = c.class  " + 
     "                and a.dept_code = d.dept_code  " + 
     "                and a.sell_code = d.sell_code  " + 
     "                and a.option_code = d.option_code  " + 
     "                and a.DEPT_CODE = " + "'" + arg_dept_code + "'" + 
     "                and a.SELL_CODE = " + "'" + arg_sell_code + "'" + 
	  "                and a.contract_code = '03'   "+
     "                and a.contract_yn = 'N'  " + 
	 "                ORDER BY a.DONGHO ASC   ";     
	 
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>
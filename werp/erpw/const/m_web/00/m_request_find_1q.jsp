<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_class = req.getParameter("arg_class");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("requestseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approtitle",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("requestdate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("receipdate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("proj_content",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("head_content",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("chg_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_chk",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "         a.REQUESTSEQ,   " + 
     "         a.APPROTITLE,   " + 
     "         to_char(a.REQUESTDATE,'YYYY.MM.DD') REQUESTDATE,   " + 
     "         to_char(a.RECEIPDATE,'YYYY.MM.DD') RECEIPDATE,   " + 
     "         a.PROJ_CONTENT,   " + 
     "         a.HEAD_CONTENT,  " + 
     "         c.long_name, " +
     "         a.chg_cnt, " +
     "         '' comp_chk " +
     "    FROM M_REQUEST  a," + 
     "			(select max(dept_code) dept_code,max(REQUESTSEQ) requestseq, max(chg_cnt) chg_cnt" + 
     "				from m_request_detail" + 
     "			  where nappr_qty <> 0 " + 
     "             and chg_cnt = 1 " +
     "			 group by dept_code,REQUESTSEQ,CHG_CNT) b," + 
     "          z_code_dept c " +
     "   WHERE ( a.dept_code = c.dept_code ) and " +
     "         ( a.dept_code  = b.dept_code ) and" + 
     "  			( a.REQUESTSEQ = b.REQUESTSEQ ) and" + 
     "         ( a.chg_cnt    = b.chg_cnt) and " +
     "         ( a.order_class = '" + arg_class + "' ) and " +
     "         ( a.chg_cnt = 1 ) and " +
     "			( a.approve_class > '3')" + 
     "ORDER BY a.DEPT_CODE ASC,   " + 
     "         a.REQUESTSEQ ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>
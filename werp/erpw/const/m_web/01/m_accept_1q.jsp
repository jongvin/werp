<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_date = req.getParameter("arg_date");
     String arg_to_date = req.getParameter("arg_to_date");
     String arg_name = '%' + req.getParameter("arg_name") + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("requestseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approtitle",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("requestdate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("receipdate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("proj_content",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("head_content",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("order_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("owner",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT a.DEPT_CODE," + 
					    " 		  b.long_name," + 
					    "         a.REQUESTSEQ," + 
					    "         a.chg_cnt," +
					    "         a.APPROTITLE," + 
					    "         to_char(a.REQUESTDATE,'yyyy.mm.dd') REQUESTDATE," + 
					    "         to_char(a.RECEIPDATE,'yyyy.mm.dd') RECEIPDATE," + 
     					 "         a.PROJ_CONTENT," + 
     					 "         a.HEAD_CONTENT, " +
     					 "         a.approve_class, " +
     					 "         a.order_class ," + 
     					 "         a.owner " +
     					 "    FROM M_REQUEST  a," + 
     					 "         Z_CODE_DEPT b " +
     					 "   WHERE a.DEPT_CODE = b.DEPT_CODE " +
     					 "     and a.requestdate >= '" + arg_date + "'" + 
     					 "     and a.requestdate <= '" + arg_to_date + "'" + 
     					 "		 and a.REQUESTDATE is not null " +
     					 "     and b.long_name like '" + arg_name + "'" +
     					 "ORDER BY a.DEPT_CODE ASC," + 
     					 "         a.REQUESTSEQ DESC         ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>
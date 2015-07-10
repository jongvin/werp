<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("requestseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approtitle",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("requestdate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("receipdate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("proj_content",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("head_content",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("order_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("owner",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("check_method",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("chg_cnt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT DEPT_CODE,   " + 
                   "         REQUESTSEQ,   " + 
                   "         APPROTITLE,   " + 
                   "         to_char(REQUESTDATE,'yyyy.mm.dd') REQUESTDATE,   " + 
                   "         to_char(RECEIPDATE,'yyyy.mm.dd') RECEIPDATE,   " + 
                   "         PROJ_CONTENT,   " + 
                   "         HEAD_CONTENT,  " + 
                   "         APPROVE_CLASS,  " + 
                   "         order_class, " +
                   "         owner, " +
                   "         check_method , " +
                   "         chg_cnt " +
                   "    FROM M_REQUEST  " + 
                   "   WHERE DEPT_CODE = " + "'" + arg_dept_code + "'" + 
                   " ORDER BY DEPT_CODE ASC,   " + 
                   "          REQUESTSEQ DESC,        " +
                   "          chg_cnt desc ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>
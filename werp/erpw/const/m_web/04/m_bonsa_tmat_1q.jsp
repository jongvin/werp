
<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_name = '%' + req.getParameter("arg_name") + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_gubun",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("input_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("detailseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tmat_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("proc_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  decode(substr(a.dept_code,0,2),'A0','본사자재창고','건설산업') dept_gubun, " +
    					 "			   to_char(a.yymmdd,'yyyy.mm.dd') yymmdd ," + 
     					 "          a.seq ," + 
     					 "          a.input_unq_num, " +
     					 "          a.detailseq ," + 
     					 "          a.tmat_unq_num, " +
     					 "          a.mtrcode ," + 
     					 "          a.name ," + 
     					 "          a.ssize ," + 
     					 "          a.unitcode ," + 
     					 "          a.qty ," + 
     					 "          a.proc_yn," + 
     					 "          d.long_name " +
     					 "     FROM m_tmat_stock a," + 
     					 "          z_code_dept d, " +
     					 "          m_input_detail b, " +
     					 "          m_input c " +
     					 "    WHERE a.dept_code = b.dept_code " +
     					 "      and a.input_unq_num = b.input_unq_num " +
     					 "      and b.dept_code = c.dept_code(+) " +
     					 "      and b.yymmdd    = c.yymmdd (+) " +
     					 "      and b.seq       = c.seq (+) " +
     					 "      and c.relative_proj_code = d.dept_code " +
     					 "      and a.DEPT_CODE in ('A05263','B05040')" +
     					 "      And a.qty > 0 " +
     					 "      and a.name like '" + arg_name + "'" +
     					 " ORDER BY a.dept_code       asc," +
     					 "          a.yymmdd          desc," + 
     					 "          a.seq          desc," + 
     					 "          a.detailseq          desc      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>